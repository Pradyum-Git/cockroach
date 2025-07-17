package workload_generator

import (
	"bufio"
	"os"
	"path/filepath"
	"regexp"
	"strconv"
	"strings"

	"github.com/cockroachdb/cockroach/pkg/sql/parser"
	"github.com/cockroachdb/cockroach/pkg/sql/sem/tree"
	"github.com/pkg/errors"
)

func GenerateWorkload(
	debugZip string,
	allSchemas map[string]*TableSchema,
	dbName, sqlLocation string,
) error {
	// 1) Prepare grouping structures
	txnOrder := make([]string, 0)       // first-seen txn IDs
	txnMap := make(map[string][]string) // txnID → []SQL statements

	// 2) Iterate node directories (nodes/1, nodes/2, …)
	nodesRoot := filepath.Join(debugZip, "nodes")
	for node := 1; ; node++ {
		nodeDir := filepath.Join(nodesRoot, strconv.Itoa(node))
		if fi, err := os.Stat(nodeDir); err != nil || !fi.IsDir() {
			break
		}

		// 3) Open the statistics TSV
		statsPath := filepath.Join(nodeDir, "crdb_internal.node_statement_statistics.txt")
		f, err := os.Open(statsPath)
		if err != nil {
			return errors.Wrapf(err, "opening %s", statsPath)
		}
		scanner := bufio.NewScanner(f)

		// 4) Read header row and map column→index
		if !scanner.Scan() {
			if err := f.Close(); err != nil {
				return err
			}
			continue
		}
		columnIndex, err := getColumnIndexes(scanner, f, statsPath)
		if err != nil {
			return err
		}

		// 5) Scan each data row
		for scanner.Scan() {
			row := strings.Split(scanner.Text(), "\t")
			// 5a) filter by database_name
			if row[columnIndex["database_name"]] != dbName {
				continue
			}
			// 5b) skip internal “job id=” lines
			app := row[columnIndex["application_name"]]
			if strings.Contains(app, "job id=") {
				continue
			}
			// 5c) extract txnID and raw SQL
			txnID := row[columnIndex["txn_fingerprint_id"]]
			rawSQL := row[columnIndex["key"]]
			// Unhandled clauses.
			var skipRE = regexp.MustCompile(`\b(DEALLOCATE|WHEN)\b`)
			if skipRE.MatchString(rawSQL) {
				continue // drop any statement containing DEALLOCATE or WHEN
			}
			// Un-quote the TSV’s string literal if present:
			if len(rawSQL) >= 2 && rawSQL[0] == '"' && rawSQL[len(rawSQL)-1] == '"' {
				rawSQL = rawSQL[1 : len(rawSQL)-1]             // Strip outer quotes
				rawSQL = strings.ReplaceAll(rawSQL, `""`, `"`) // …and turn every "" into "
			}

			// 5d) placeholder-process
			rewritten, err := ReplacePlaceholders(rawSQL, allSchemas)
			if err != nil {
				err := f.Close()
				if err != nil {
					return err
				}
				return errors.Wrapf(err, "rewriting SQL %q", rawSQL)
			}

			// 5e) group into txnMap, tracking first-seen order
			if _, seen := txnMap[txnID]; !seen {
				txnOrder = append(txnOrder, txnID)
			}
			txnMap[txnID] = append(txnMap[txnID], rewritten)
		}

		if err := f.Close(); err != nil {
			return err
		}
		if err := scanner.Err(); err != nil {
			return errors.Wrapf(err, "scanning %s", statsPath)
		}
	}

	// 6) Write out <sqlLocation>/<dbName>.sql
	outPath := sqlLocation
	if fi, err := os.Stat(sqlLocation); err == nil && fi.IsDir() {
		outPath = filepath.Join(sqlLocation, dbName+".sql")
	}
	outFile, err := os.Create(outPath)
	if err != nil {
		return errors.Wrapf(err, "creating %s", outPath)
	}
	defer outFile.Close()

	writeTransaction(txnOrder, txnMap, outFile)
	return nil
}

// ReplacePlaceholders parses the given SQL and locates all the _, __more__ placeholders.
// The placeholders are then matched to what column's data do they represent and are replaced with information about that column for data generation
func ReplacePlaceholders(
	rawSQL string,
	allSchemas map[string]*TableSchema,
) (string, error) {
	stmts, err := parser.Parse(rawSQL)
	if err != nil {
		return "", err
	}

	var out []string
	for _, stmt := range stmts {
		// statement-level INSERT…VALUES rewrite
		if ins, ok := stmt.AST.(*tree.Insert); ok {
			handleInsert(ins, allSchemas)
		}
		//update ... set rewrite
		if upd, ok := stmt.AST.(*tree.Update); ok {
			// 1) Rewrite everything in the SET clause.
			handleUpdateSet(upd, allSchemas)
		}
		// Handling limit _
		if sel, ok := stmt.AST.(*tree.Select); ok {
			handleSelectLimit(sel)
		}

		// Setting up the rewriter with the required table name and schemas.
		rewriter := getPlaceholderRewriter(stmt, allSchemas)
		// Wiring in for the join (col = __) case
		if sel, ok := stmt.AST.(*tree.Select); ok {
			// Unbox the SelectClause
			if sc, ok := sel.Select.(*tree.SelectClause); ok {
				for _, tbl := range sc.From.Tables {
					if j, ok := tbl.(*tree.JoinTableExpr); ok {
						// Only handle ON‐joins here
						if on, ok := j.Cond.(*tree.OnJoinCond); ok {
							tree.WalkExpr(rewriter, on.Expr)
						}
					}
				}
			}
		}
		//This covers all the expr relates nodes. So mostly all the where expressions.
		tree.WalkStmt(rewriter, stmt.AST)

		// pretty-print
		fmtCtx := tree.NewFmtCtx(tree.FmtSimple)
		stmt.AST.Format(fmtCtx)
		out = append(out, fmtCtx.CloseAndGetString())
	}
	// join multiple statements with newline
	return strings.Join(out, "\n"), nil
}
