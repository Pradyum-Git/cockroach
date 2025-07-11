package workload_generator

//
//import (
//	"fmt"
//	"reflect"
//
//	"github.com/cockroachdb/cockroach/pkg/sql/parser"
//	"github.com/cockroachdb/cockroach/pkg/sql/sem/tree"
//)
//
//// Recursively print AST nodes with indentation.
//func dumpAST(node interface{}, indent string) {
//	if node == nil {
//		fmt.Printf("%s<nil>\n", indent)
//		return
//	}
//	val := reflect.ValueOf(node)
//	typ := reflect.TypeOf(node)
//
//	// If it's a pointer, dereference
//	if val.Kind() == reflect.Ptr {
//		val = val.Elem()
//		typ = typ.Elem()
//	}
//
//	fmt.Printf("%s%s\n", indent, typ.Name())
//
//	// Print struct fields recursively
//	if val.Kind() == reflect.Struct {
//		for i := 0; i < val.NumField(); i++ {
//			field := val.Field(i)
//			fieldType := typ.Field(i)
//			if !field.CanInterface() {
//				continue
//			}
//			fieldValue := field.Interface()
//			fieldName := fieldType.Name
//			fmt.Printf("%s  %s: ", indent, fieldName)
//			// If it's a tree node, recurse
//			if _, ok := fieldValue.(tree.NodeFormatter); ok {
//				fmt.Println()
//				dumpAST(fieldValue, indent+"    ")
//			} else {
//				// Print simple value
//				fmt.Printf("%#v\n", fieldValue)
//			}
//		}
//	}
//}
//
//// Example usage
//func main() {
//	sql := "SELECT a, b FROM tbl WHERE c > 3"
//	stmts, err := parser.Parse(sql)
//	if err != nil {
//		fmt.Println("Parse error:", err)
//		return
//	}
//	for i, stmt := range stmts {
//		fmt.Printf("=== Statement %d ===\n", i+1)
//		dumpAST(stmt.AST, "")
//	}
//}
