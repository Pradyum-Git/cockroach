package workload_generator

import (
	"fmt"
	"os"
	"reflect"
	"strings"
	"testing"

	"github.com/cockroachdb/cockroach/pkg/sql/parser"
	"github.com/cockroachdb/cockroach/pkg/sql/sem/tree"
	"github.com/cockroachdb/cockroach/pkg/sql/sem/tree/treecmp"
)

func dumpAST(w *os.File, node interface{}, indent string) {
	if node == nil {
		fmt.Fprintf(w, "%s<nil>\n", indent)
		return
	}
	// print identifier for UnresolvedName
	if unresolved, ok := node.(*tree.UnresolvedName); ok {
		var parts []string
		for _, part := range unresolved.Parts {
			if part != "" {
				parts = append(parts, part)
			}
		}
		fmt.Fprintf(w, "%sUnresolvedName: \"%s\"\n", indent, strings.Join(parts, "."))
		return
	}

	val := reflect.ValueOf(node)
	typ := reflect.TypeOf(node)
	if val.Kind() == reflect.Ptr {
		val = val.Elem()
		typ = typ.Elem()
	}
	fmt.Fprintf(w, "%s%s\n", indent, typ.Name())

	if val.Kind() == reflect.Struct {
		for i := 0; i < val.NumField(); i++ {
			field := val.Field(i)
			fieldType := typ.Field(i)
			if !field.CanInterface() {
				continue
			}
			fv := field.Interface()
			name := fieldType.Name

			// special-case ComparisonOperator
			if op, ok := fv.(treecmp.ComparisonOperator); ok {
				fmt.Fprintf(w, "%s  %s: %s (Explicit: %t)\n",
					indent, name, op.Symbol.String(), op.IsExplicitOperator)
				continue
			}

			fmt.Fprintf(w, "%s  %s: ", indent, name)
			switch fv := fv.(type) {
			case tree.NodeFormatter:
				fmt.Fprintln(w)
				dumpAST(w, fv, indent+"    ")
			case []interface{}:
				fmt.Fprintln(w)
				for _, child := range fv {
					dumpAST(w, child, indent+"    ")
				}
			default:
				fmt.Fprintf(w, "%#v\n", fv)
			}
		}
	}
}

func TestPain(t *testing.T) {
	// list of SQLs to parse
	sqls := []string{
		`UPDATE customer SET c_delivery_cnt = c_delivery_cnt + _, c_balance = c_balance + CASE c_d_id WHEN _ THEN _ WHEN _ THEN _ WHEN _ THEN _ WHEN _ THEN _ WHEN _ THEN _ WHEN _ THEN _ WHEN _ THEN _ WHEN _ THEN _ WHEN _ THEN _ WHEN _ THEN _ END WHERE (c_w_id = _) AND ((c_d_id, c_id) IN ((_, __more__), __more__))`,
		`UPDATE stock SET s_quantity = CASE (s_i_id, s_w_id) WHEN (_, __more__) THEN _ WHEN (_, __more__) THEN _ WHEN (_, __more__) THEN _ WHEN (_, __more__) THEN _ WHEN (_, __more__) THEN _ WHEN (_, __more__) THEN _ WHEN (_, __more__) THEN _ WHEN (_, __more__) THEN _ ELSE crdb_internal.force_error(_, _) END, s_ytd = CASE (s_i_id, s_w_id) WHEN (_, __more__) THEN _ WHEN (_, __more__) THEN _ WHEN (_, __more__) THEN _ WHEN (_, __more__) THEN _ WHEN (_, __more__) THEN _ WHEN (_, __more__) THEN _ WHEN (_, __more__) THEN _ END, s_order_cnt = CASE (s_i_id, s_w_id) WHEN (_, __more__) THEN _ WHEN (_, __more__) THEN _ WHEN (_, __more__) THEN _ WHEN (_, __more__) THEN _ WHEN (_, __more__) THEN _ WHEN (_, __more__) THEN _ WHEN (_, __more__) THEN _ END, s_remote_cnt = CASE (s_i_id, s_w_id) WHEN (_, __more__) THEN _ WHEN (_, __more__) THEN _ WHEN (_, __more__) THEN _ WHEN (_, __more__) THEN _ WHEN (_, __more__) THEN _ WHEN (_, __more__) THEN _ END WHERE (s_i_id, s_w_id) IN ((_, __more__), __more__)`,
		`SELECT o_id, o_entry_d, o_carrier_id FROM "order" WHERE ((o_w_id = _) AND (o_d_id = _)) AND (o_c_id = _) ORDER BY o_id DESC LIMIT _`,
		`SELECT i_price, i_name, i_data FROM item WHERE i_id IN (_, __more__) ORDER BY i_id`,
		`SELECT s_quantity, s_ytd, s_order_cnt, s_remote_cnt, s_data, s_dist_02 FROM stock WHERE (s_i_id, s_w_id) IN ((_, __more__), __more__) ORDER BY s_i_id FOR UPDATE`,
		`UPDATE customer SET (c_balance, c_ytd_payment, c_payment_cnt, c_data) = (c_balance - (_:::FLOAT8)::DECIMAL, c_ytd_payment + (_:::FLOAT8)::DECIMAL, c_payment_cnt + _, CASE c_credit WHEN _ THEN left((((((c_id::STRING || c_d_id::STRING) || c_w_id::STRING) || (_:::INT8)::STRING) || (_:::INT8)::STRING) || (_:::FLOAT8)::STRING) || c_data, _) ELSE c_data END) WHERE ((c_w_id = _) AND (c_d_id = _)) AND (c_id = _) RETURNING c_first, c_middle, c_last, c_street_1, c_street_2, c_city, c_state, c_zip, c_phone, c_since, c_credit, c_credit_lim, c_discount, c_balance, CASE c_credit WHEN _ THEN left(c_data, _) ELSE _ END`,
		`INSERT INTO history(h_c_id, h_c_d_id, h_c_w_id, h_d_id, h_w_id, h_amount, h_date, h_data) VALUES (_, __more__)`,
		`INSERT INTO order_line(ol_o_id, ol_d_id, ol_w_id, ol_number, ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_dist_info) VALUES (_, __more__), (__more__)`,
		// … add the rest of your SQL strings here …
	}

	f, err := os.Create("parserOutput.txt")
	if err != nil {
		t.Fatalf("failed to create output file: %v", err)
	}
	defer f.Close()

	for idx, sql := range sqls {
		fmt.Fprintf(f, "=== SQL %d ===\n%s\n", idx+1, sql)
		stmts, err := parser.Parse(sql)
		if err != nil {
			fmt.Fprintf(f, "Parse error: %v\n\n", err)
			continue
		}
		for i, stmt := range stmts {
			fmt.Fprintf(f, "--- Statement %d AST ---\n", i+1)
			dumpAST(f, stmt.AST, "")
		}
		fmt.Fprintln(f) // blank line between SQLs
	}
}
