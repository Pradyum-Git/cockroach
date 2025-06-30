package workload_generator

import (
	"encoding/json"
	"fmt"
	"os"
	"testing"

	co "github.com/cockroachdb/cockroach/pkg/sql/parser"
	"github.com/cockroachdb/cockroach/pkg/sql/sem/tree"
	"github.com/cockroachdb/cockroachdb-parser/pkg/sql/scanner"
	"github.com/davecgh/go-spew/spew"
	"github.com/muir/sqltoken"
	pg "github.com/pganalyze/pg_query_go/v6"
)

func TestParser(t *testing.T) {
	sql := `
      SELECT i_price, i_name, i_data
      FROM item
      WHERE i_id IN (_, __more__)
      ORDER BY i_id;
    `

	// Open parse_output.txt for writing
	f, err := os.Create("parse_output.txt")
	if err != nil {
		t.Fatalf("failed to create output file: %v", err)
	}
	defer f.Close()

	// 1) sqltoken → flat list of tokens
	fmt.Fprintln(f, "=== sqltoken tokens ===")
	for _, tok := range sqltoken.TokenizePostgreSQL(sql) {
		fmt.Fprintf(f, "%-15q  %-10v\n", tok.Text, tok.Type)
	}

	// 2) pg_query_go → pretty-printed JSON AST
	fmt.Fprintln(f, "\n=== pg_query_go JSON AST (pretty) ===")
	rawJSON, err := pg.ParseToJSON(sql)
	if err != nil {
		t.Fatalf("pg_query_go parse error: %v", err)
	}
	var obj interface{}
	if err := json.Unmarshal([]byte(rawJSON), &obj); err != nil {
		t.Fatalf("json unmarshal error: %v", err)
	}
	prettyJSON, _ := json.MarshalIndent(obj, "", "  ")
	fmt.Fprintln(f, string(prettyJSON))

	// 3) CockroachDB AST → formatted SQL
	fmt.Fprintln(f, "\n=== Cockroach formatted SQL from AST ===")
	stmt, err := co.ParseOne(sql)
	if err != nil {
		t.Fatalf("cockroach parser error: %v", err)
	}
	fmtCtx := tree.NewFmtCtx(tree.FmtSimple)
	stmt.AST.Format(fmtCtx)
	fmt.Fprintln(f, fmtCtx.CloseAndGetString())

	// 4) CockroachDB AST → deep-dump Go struct
	fmt.Fprintln(f, "\n=== Cockroach AST struct dump (spew) ===")
	spew.Config.Indent = "  "
	spew.Fdump(f, stmt.AST)

	// 5) Cockroach’s internal scanner tokens
	fmt.Fprintln(f, "\n=== Cockroach scanner.Inspect tokens ===")
	inspectTokens := scanner.Inspect(sql)
	for _, it := range inspectTokens {
		// ID is the numeric token code (see sql.y), Str is the raw text slice
		fmt.Fprintf(f, "ID=%3d  MaybeID=%3d  [%2d:%2d]  %q  Quoted=%v\n",
			it.ID, it.MaybeID, it.Start, it.End, it.Str, it.Quoted)
	}
	fmt.Fprintln(f, "\n=== End of parse output ===")
}
