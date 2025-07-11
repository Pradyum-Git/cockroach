package workload_generator

import (
	"fmt"
	"github.com/cockroachdb/cockroach/pkg/sql/sem/tree/treecmp"
	"reflect"
	"strings"
	"testing"

	"github.com/cockroachdb/cockroach/pkg/sql/parser"
	"github.com/cockroachdb/cockroach/pkg/sql/sem/tree"
)

func dumpAST(node interface{}, indent string) {
	if node == nil {
		fmt.Printf("%s<nil>\n", indent)
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
		fmt.Printf("%sUnresolvedName: \"%s\"\n", indent, name)
		return
	}

	//special case for teh opertaors
	//if operator, ok := node.(*treecmp.ComparisonOperator); ok {
	//	symbol := operator.Symbol
	//	isExplicit := operator.IsExplicitOperator
	//	strSymbol := symbol.String()
	//	fmt.Printf("%sUnresolvedName: \"%s %t\"\n", indent, strSymbol, isExplicit)
	//}

	val := reflect.ValueOf(node)
	typ := reflect.TypeOf(node)

	if val.Kind() == reflect.Ptr {
		val = val.Elem()
		typ = typ.Elem()
	}

	fmt.Printf("%s%s\n", indent, typ.Name())

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
				fmt.Printf("%s  %s: %s (Explicit: %t)\n", indent, fieldName, fieldVal.Symbol.String(), fieldVal.IsExplicitOperator)
				continue
			}

			fmt.Printf("%s  %s: ", indent, fieldName)
			// Recursively walk child nodes/interfaces
			if _, ok := fieldValue.(tree.NodeFormatter); ok {
				fmt.Println()
				dumpAST(fieldValue, indent+"    ")
			} else if field.Type().Kind() == reflect.Slice {
				fmt.Println()
				for j := 0; j < field.Len(); j++ {
					dumpAST(field.Index(j).Interface(), indent+"    ")
				}
			} else {
				// Print simple value for non-tree fields
				fmt.Printf("%#v\n", fieldValue)
			}
		}
	}
}

// To run
func TestPain(t *testing.T) {
	sql := "SELECT a, caer FROM tbl WHERE (s_i_id, s_w_id) IN ((_, __more__), __more__)"
	stmts, err := parser.Parse(sql)
	if err != nil {
		fmt.Println("Parse error:", err)
		return
	}
	for i, stmt := range stmts {
		fmt.Printf("=== Statement %d ===\n", i+1)
		dumpAST(stmt.AST, "")
	}
}
