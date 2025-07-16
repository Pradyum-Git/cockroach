package workload_generator

import (
	"bufio"
	"fmt"
	"os"
	"path/filepath"
	"regexp"
	"strconv"
	"strings"
)

func GenerateWorkload(
	debugZip string,
	allSchemas map[string]*TableSchema,
	dbName, sqlLocation string,
) error {
	// --- 1) Prepare grouping structures ---
	txnOrder := []string{}              // first-seen txn IDs
	txnMap := make(map[string][]string) // txnID → []SQL statements

	// --- 2) Iterate node directories (nodes/1, nodes/2, …) ---
	nodesRoot := filepath.Join(debugZip, "nodes")
	for node := 1; ; node++ {
		nodeDir := filepath.Join(nodesRoot, strconv.Itoa(node))
		if fi, err := os.Stat(nodeDir); err != nil || !fi.IsDir() {
			break
		}

		// --- 3) Open the statistics TSV ---
		statsPath := filepath.Join(nodeDir,
			"crdb_internal.node_statement_statistics.txt")
		f, err := os.Open(statsPath)
		if err != nil {
			return fmt.Errorf("opening %s: %w", statsPath, err)
		}
		scanner := bufio.NewScanner(f)

		// --- 4) Read header row and map column→index ---
		if !scanner.Scan() {
			f.Close()
			continue
		}
		header := strings.Split(scanner.Text(), "\t")
		idx := make(map[string]int, len(header))
		for i, col := range header {
			idx[col] = i
		}
		// required columns
		for _, want := range []string{
			"database_name", "application_name",
			"txn_fingerprint_id", "key",
		} {
			if _, ok := idx[want]; !ok {
				f.Close()
				return fmt.Errorf("missing column %q in %s", want, statsPath)
			}
		}

		// --- 5) Scan each data row ---
		for scanner.Scan() {
			row := strings.Split(scanner.Text(), "\t")
			// 5a) filter by database_name
			if row[idx["database_name"]] != dbName {
				continue
			}
			// 5b) skip internal “job id=” lines
			app := row[idx["application_name"]]
			if strings.Contains(app, "job id=") {
				continue
			}
			// 5c) extract txnID and raw SQL
			txnID := row[idx["txn_fingerprint_id"]]
			rawSQL := row[idx["key"]]

			var skipRE = regexp.MustCompile(`\b(DEALLOCATE|WHEN)\b`)
			if skipRE.MatchString(rawSQL) {
				continue // drop any statement containing DEALLOCATE or WHEN
			}
			// Un-quote the TSV’s string literal if present:
			if len(rawSQL) >= 2 && rawSQL[0] == '"' && rawSQL[len(rawSQL)-1] == '"' {
				// Strip outer quotes…
				rawSQL = rawSQL[1 : len(rawSQL)-1]
				// …and turn every "" into "
				rawSQL = strings.ReplaceAll(rawSQL, `""`, `"`)
			}

			// 5d) placeholder-process
			rewritten, err := ReplacePlaceholders(rawSQL, allSchemas)
			if err != nil {
				f.Close()
				return fmt.Errorf("rewriting SQL %q: %w", rawSQL, err)
			}

			// 5e) group into txnMap, tracking first-seen order
			if _, seen := txnMap[txnID]; !seen {
				txnOrder = append(txnOrder, txnID)
			}
			txnMap[txnID] = append(txnMap[txnID], rewritten)
		}
		f.Close()
		if err := scanner.Err(); err != nil {
			return fmt.Errorf("scanning %s: %w", statsPath, err)
		}
	}

	// --- 6) Write out <sqlLocation>/<dbName>.sql ---
	outPath := sqlLocation
	if fi, err := os.Stat(sqlLocation); err == nil && fi.IsDir() {
		outPath = filepath.Join(sqlLocation, dbName+".sql")
	}
	outFile, err := os.Create(outPath)
	if err != nil {
		return fmt.Errorf("creating %s: %w", outPath, err)
	}
	defer outFile.Close()

	for _, txnID := range txnOrder {
		stmts := txnMap[txnID]
		fmt.Fprintln(outFile, "-------Begin Transaction------")
		fmt.Fprintln(outFile, "BEGIN;")
		for _, stmt := range stmts {
			fmt.Fprintf(outFile, "%s;\n", stmt)
		}
		fmt.Fprintln(outFile, "COMMIT;")
		fmt.Fprintln(outFile, "-------End Transaction-------")
	}

	return nil
}
