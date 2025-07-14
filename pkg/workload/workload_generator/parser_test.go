package workload_generator

import (
	"fmt"
	"github.com/cockroachdb/cockroach/pkg/sql/sem/tree/treecmp"
	"os"
	"reflect"
	"strings"
	"testing"

	"github.com/cockroachdb/cockroach/pkg/sql/parser"
	"github.com/cockroachdb/cockroach/pkg/sql/sem/tree"
)

func dumpAST(w *os.File, node interface{}, indent string) {
	if node == nil {
		fmt.Fprintf(w, "%s<nil>\n", indent)
		return
	}

	// Special-case: print identifier for *tree.UnresolvedName
	if unresolved, ok := node.(*tree.UnresolvedName); ok {
		var parts []string
		for _, part := range unresolved.Parts {
			if part != "" {
				parts = append(parts, part)
			}
		}
		name := strings.Join(parts, ".")
		fmt.Fprintf(w, "%sUnresolvedName: \"%s\"\n", indent, name)
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
			fieldValue := field.Interface()
			fieldName := fieldType.Name
			if fieldVal, ok := fieldValue.(treecmp.ComparisonOperator); ok {
				// Special case for ComparisonOperator
				fmt.Fprintf(w, "%s  %s: %s (Explicit: %t)\n", indent, fieldName, fieldVal.Symbol.String(), fieldVal.IsExplicitOperator)
				continue
			}

			fmt.Fprintf(w, "%s  %s: ", indent, fieldName)
			// Recursively walk child nodes/interfaces
			if _, ok := fieldValue.(tree.NodeFormatter); ok {
				fmt.Fprintln(w)
				dumpAST(w, fieldValue, indent+"    ")
			} else if field.Type().Kind() == reflect.Slice {
				fmt.Fprintln(w)
				for j := 0; j < field.Len(); j++ {
					dumpAST(w, field.Index(j).Interface(), indent+"    ")
				}
			} else {
				// Print simple value for non-tree fields
				fmt.Fprintf(w, "%#s\n", fieldValue)
			}
		}
	}
}

// To run
func TestPain(t *testing.T) {
	f, err := os.Create("parserOutput.txt")
	if err != nil {
		t.Fatalf("failed to create output file: %v", err)
	}
	defer f.Close()
	//making an sqls string array, each of whos eelements will get called again and again
	sqls := []string{
		`SELECT ol_i_id, ol_supply_w_id, ol_quantity, ol_amount, ol_delivery_d FROM order_line WHERE ((ol_w_id > _) AND (ol_d_id = _)) AND (ol_o_id = _)`,
		`INSERT into order_line values (_,__more__)`,
	}
	for _, sql := range sqls {
		stmts, err := parser.Parse(sql)
		if err != nil {
			fmt.Fprintf(f, "Parse error: %v\n", err)
			return
		}
		for i, stmt := range stmts {
			fmt.Fprintf(f, "=== Statement %d ===\n SQL :  %s\n", i+1, sql)
			dumpAST(f, stmt.AST, "")
		}
	}
	//tree.From
}
