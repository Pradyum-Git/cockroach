package workload_generator

import (
	"fmt"
	"strings"
	"testing"

	"github.com/cockroachdb/cockroach/pkg/sql/parser"
	"github.com/cockroachdb/cockroach/pkg/sql/sem/tree"
)

// placeholderRewriter walks the AST and, for every “col OP _” or “col OP __more__”,
// replaces the RHS UnresolvedName.Parts with the four values returned by getFieldColParts.
type placeholderRewriter struct {
	// You’ll need a map from table → schema here if you want to look up types, etc.
	//schemas map[string]YourTableSchema
}

// VisitPre is called before descending into children.
func (v *placeholderRewriter) VisitPre(expr tree.Expr) (recurse bool, newExpr tree.Expr) {
	cmp, ok := expr.(*tree.ComparisonExpr)
	if !ok {
		return true, expr
	}

	// Both sides must be simple UnresolvedName
	lhs, lok := cmp.Left.(*tree.UnresolvedName)
	rhs, rok := cmp.Right.(*tree.UnresolvedName)
	if !lok || !rok {
		return true, expr
	}

	// Helper to join name parts back into "schema.table.col" or just "col"
	nameToString := func(n *tree.UnresolvedName) string {
		var parts []string
		for _, p := range n.Parts {
			if p != "" {
				parts = append(parts, p)
			}
		}
		return strings.Join(parts, ".")
	}

	rhsText := nameToString(rhs)
	if rhsText == "_" || rhsText == "__more__" {
		colName := nameToString(lhs)
		// Fetch exactly four placeholder values for this column:
		parts := getFieldColParts(colName)

		if len(parts) != 4 {
			panic(fmt.Sprintf("getFieldColParts(%q) returned %d parts, want 4", colName, len(parts)))
		}

		// Assign them into the NameParts slice
		rhs.Parts = tree.NameParts(parts)
	}

	// Continue recursing (in case there are nested comparisons)
	return true, expr
}

// VisitPost is no-op
func (v *placeholderRewriter) VisitPost(expr tree.Expr) tree.Expr {
	return expr
}

// getFieldColParts is your custom helper that, given a column name,
// returns exactly the four strings you want to use as the placeholder parts.
// For example, you might look up your in-memory schema map,
// format the Column object into its four attributes,
// and return them here.
func getFieldColParts(col string) []string {
	// TODO: replace this stub with your real logic.
	// For example:
	//   colMeta := yourSchemaMap["order_line"].Columns[col]
	//   // colMeta.String() might be ":'ol_w_id','INT8',...,|:-:"
	//   // so you’d parse out the four fields into a slice.
	//
	// Here’s just a dummy:
	return []string{
		":-:|'" + col + "'", // part1
		"'INT8'",            // part2
		"'<other_attr>'",    // part3
		"|:-:",              // part4
	}
}

func TestPlaceholder(t *testing.T) {
	sql := `SELECT * FROM order_line WHERE ((ol_w_id >= _) AND (ol_d_id = _)) AND (ol_o_id != _)`
	stmts, err := parser.Parse(sql)
	if err != nil {
		t.Fatalf("parse error: %v", err)
	}

	for _, stmt := range stmts {
		tree.WalkStmt(&placeholderRewriter{}, stmt.AST)
		fmtCtx := tree.NewFmtCtx(tree.FmtSimple)
		stmt.AST.Format(fmtCtx)
		fmt.Println(fmtCtx.CloseAndGetString())
	}
}
