package workload_generator

import (
	"fmt"
	"math/rand"
	"strings"
	"testing"

	"github.com/cockroachdb/cockroach/pkg/sql/parser"
	"github.com/cockroachdb/cockroach/pkg/sql/sem/tree"
	"github.com/cockroachdb/cockroach/pkg/sql/sem/tree/treecmp"
)

// placeholderRewriter handles both simple comparisons and IN-lists.
type placeholderRewriter struct{}

// VisitPre rewrites any ComparisonExpr for =,>,<,… and IN.
func (v *placeholderRewriter) VisitPre(expr tree.Expr) (bool, tree.Expr) {
	//handle BETWEEN … AND …
	if rc, ok := expr.(*tree.RangeCond); ok {
		if newExpr := handleRangeCondition(rc); newExpr != nil {
			return false, newExpr
		}
	}

	cmp, ok := expr.(*tree.ComparisonExpr)
	if !ok {
		return true, expr
	}
	// ── First: handle IN operator ───────────────────────────────────────
	if cmp.Operator.Symbol == treecmp.In {
		if newTuple := handleInOperator(cmp); newTuple != nil {
			cmp.Right = newTuple
			// Don’t recurse further into the old RHS
			return false, cmp
		}
	}

	if lt, lok := cmp.Left.(*tree.Tuple); lok {
		if rt, rok := cmp.Right.(*tree.Tuple); rok {
			if newRt := handleTupleComparison(lt, rt); newRt != nil {
				cmp.Right = newRt
				return false, cmp
			}
		}
	}

	// ── Fallback: simple one-column comparisons as before ───────────────
	b, t, done := handleComparisonOperator(cmp)
	if done {
		return b, t
	}

	return true, expr
}

// handleRangeCondition rewrites any RangeCond (a BETWEEN b AND c or NOT BETWEEN)
// where b and/or c are "_" or "__more__". Supports both single-col and tuple-col.
func handleRangeCondition(rc *tree.RangeCond) tree.Expr {
	// Single-col: rc.Left is UnresolvedName
	if col, ok := rc.Left.(*tree.UnresolvedName); ok {
		parts := getFieldColParts(col)
		// optional: only rewrite if at least one bound is a placeholder
		rewrote := false

		// rewrite rc.From if needed
		if u, ok := rc.From.(*tree.UnresolvedName); ok {
			if n := reconstructName(u); n == "_" || n == "__more__" {
				var np tree.NameParts
				for i, p := range parts {
					np[i] = p
				}
				u.NumParts = len(parts)
				u.Parts = np
				rewrote = true
			}
		}
		// rewrite rc.To if needed
		if u, ok := rc.To.(*tree.UnresolvedName); ok {
			if n := reconstructName(u); n == "_" || n == "__more__" {
				var np tree.NameParts
				for i, p := range parts {
					np[i] = p
				}
				u.NumParts = len(parts)
				u.Parts = np
				rewrote = true
			}
		}
		if rewrote {
			return rc
		}
		return nil
	}

	// Tuple-col: rc.Left is a Tuple of columns, rc.From/To should be tuples of placeholders
	lt, lok := rc.Left.(*tree.Tuple)
	rf, rfok := rc.From.(*tree.Tuple)
	rt, rtok := rc.To.(*tree.Tuple)
	if !lok || !rfok || !rtok {
		return nil
	}
	// verify both bounds are tuples of placeholders
	for _, tup := range []*tree.Tuple{rf, rt} {
		for _, e := range tup.Exprs {
			u, ok := e.(*tree.UnresolvedName)
			if !ok {
				return nil
			}
			n := reconstructName(u)
			if n != "_" && n != "__more__" {
				return nil
			}
		}
	}
	// extract columns
	cols := make([]*tree.UnresolvedName, len(lt.Exprs))
	for i, e := range lt.Exprs {
		cols[i] = e.(*tree.UnresolvedName)
	}
	// build new bound tuples
	build := func() *tree.Tuple {
		t := &tree.Tuple{Exprs: make(tree.Exprs, len(cols))}
		for j, col := range cols {
			parts := getFieldColParts(col)
			var np tree.NameParts
			for k, p := range parts {
				np[k] = p
			}
			t.Exprs[j] = &tree.UnresolvedName{
				NumParts: len(parts),
				Parts:    np,
			}
		}
		return t
	}
	rc.From = build()
	rc.To = build()
	return rc

}

func handleComparisonOperator(cmp *tree.ComparisonExpr) (bool, tree.Expr, bool) {
	lhs, lok := cmp.Left.(*tree.UnresolvedName)
	rhs, rok := cmp.Right.(*tree.UnresolvedName)
	if lok && rok {
		rhsName := reconstructName(rhs)
		if rhsName == "_" || rhsName == "__more__" {
			//colName := reconstructName(lhs)
			parts := getFieldColParts(lhs)
			//if len(parts) != 4 {
			//	panic(fmt.Sprintf("getFieldColParts(%q) → %d parts, want 4", colName, len(parts)))
			//}
			rhs.NumParts = len(parts)
			var np tree.NameParts
			for i, p := range parts {
				np[i] = p
			}
			rhs.Parts = np
			// Don’t recurse inside this placeholder node
			return false, cmp, true
		}
	}
	return false, nil, false
}

func (v *placeholderRewriter) VisitPost(expr tree.Expr) tree.Expr {
	return expr
}

// handleTupleComparison rewrites ANY tuple-vs-tuple ComparisonExpr
// whose RHS is all "_" or "__more__", remapping it to a new tuple
// with exactly one placeholder per LHS column.
func handleTupleComparison(lt, rt *tree.Tuple) *tree.Tuple {
	// 1) Verify RHS is purely placeholders (any length)
	for _, e := range rt.Exprs {
		u, ok := e.(*tree.UnresolvedName)
		if !ok {
			return nil
		}
		if n := reconstructName(u); n != "_" && n != "__more__" {
			return nil
		}
	}

	// 2) Build a new RHS with one placeholder per LHS column
	newExprs := make(tree.Exprs, len(lt.Exprs))
	for i, colExpr := range lt.Exprs {
		col, ok := colExpr.(*tree.UnresolvedName)
		if !ok {
			return nil // safety, though LHS should always be a tuple of names
		}
		// Build tagged placeholder for this column
		parts := getFieldColParts(col) // preserves qualifiers, wraps part0
		var np tree.NameParts
		for j, p := range parts {
			np[j] = p
		}
		newExprs[i] = &tree.UnresolvedName{
			NumParts: len(parts),
			Parts:    np,
		}
	}

	// 3) Splice it back into the existing rt node
	rt.Exprs = newExprs
	return rt
}

// handleInOperator dispatches single-col vs multi-col IN (…) cases.
func handleInOperator(cmp *tree.ComparisonExpr) *tree.Tuple {
	orig, ok := cmp.Right.(*tree.Tuple)
	if !ok {
		return nil
	}

	switch lhs := cmp.Left.(type) {
	case *tree.UnresolvedName:
		// single-col IN: require every orig.Exprs[i] be an UnresolvedName
		return handleSingleColIn(lhs, orig)

	case *tree.Tuple:
		// multi-col IN: require every orig.Exprs[i] be a *tree.Tuple of UnresolvedNames
		return handleMultiColIn(lhs, orig)

	default:
		return nil
	}
}

// handleSingleColIn rebuilds “col IN (_,__more__)” → col IN (p, p, …)
func handleSingleColIn(
	col *tree.UnresolvedName, orig *tree.Tuple,
) *tree.Tuple {

	// 1) Verify each element is an UnresolvedName placeholder
	for _, e := range orig.Exprs {
		u, ok := e.(*tree.UnresolvedName)
		if !ok || (reconstructName(u) != "_" && reconstructName(u) != "__more__") {
			return nil
		}
	}

	parts := getFieldColParts(col) // wraps part0, preserves qualifiers
	// Build new flat list of placeholders
	var newExprs tree.Exprs
	for _, e := range orig.Exprs {
		uOld := e.(*tree.UnresolvedName)
		name := reconstructName(uOld)

		// 1) one copy for every original placeholder
		var np tree.NameParts
		for i, p := range parts {
			np[i] = p
		}
		newExprs = append(newExprs, &tree.UnresolvedName{
			NumParts: len(parts),
			Parts:    np,
		})

		// 2) if it was "__more__", add 1–3 extra copies
		if name == "__more__" {
			extra := rand.Intn(3) + 1
			for i := 0; i < extra; i++ {
				var np2 tree.NameParts
				for j, p := range parts {
					np2[j] = p
				}
				newExprs = append(newExprs, &tree.UnresolvedName{
					NumParts: len(parts),
					Parts:    np2,
				})
			}
		}
	}
	return &tree.Tuple{Exprs: newExprs}
}

// handleMultiColIn rebuilds “(a,b,…) IN ((_,__more__), __more__)” →
// (a,b,…) IN ((p_a,p_b,…), (p_a,p_b,…), …)
func handleMultiColIn(lhs *tree.Tuple, orig *tree.Tuple) *tree.Tuple {
	// 1) Must have at least one tuple‐row
	if len(orig.Exprs) == 0 {
		return nil
	}
	// 2) First element must be a tuple of placeholders
	firstRow, ok := orig.Exprs[0].(*tree.Tuple)
	if !ok {
		return nil
	}
	for _, e := range firstRow.Exprs {
		u, ok := e.(*tree.UnresolvedName)
		if !ok {
			return nil
		}
		name := reconstructName(u)
		if name != "_" && name != "__more__" {
			return nil
		}
	}
	// 3) Any further elements must be single "__more__" markers
	for i := 1; i < len(orig.Exprs); i++ {
		u, ok := orig.Exprs[i].(*tree.UnresolvedName)
		if !ok || reconstructName(u) != "__more__" {
			return nil
		}
	}

	// 4) Extract the LHS columns to tag
	cols := make([]*tree.UnresolvedName, len(lhs.Exprs))
	for i, e := range lhs.Exprs {
		cols[i] = e.(*tree.UnresolvedName)
	}

	// 5) Decide how many rows to generate: 3-6
	rowCount := rand.Intn(4) + 3

	// 6) Build the new outer tuple
	rows := make(tree.Exprs, rowCount)
	for i := 0; i < rowCount; i++ {
		tpl := &tree.Tuple{Exprs: make(tree.Exprs, len(cols))}
		for j, col := range cols {
			parts := getFieldColParts(col)
			var np tree.NameParts
			for k, p := range parts {
				np[k] = p
			}
			tpl.Exprs[j] = &tree.UnresolvedName{
				NumParts: len(parts),
				Parts:    np,
			}
		}
		rows[i] = tpl
	}
	return &tree.Tuple{Exprs: rows}
}

// reconstructName joins the first NumParts entries of an UnresolvedName.
func reconstructName(u *tree.UnresolvedName) string {
	parts := u.Parts[:u.NumParts]
	clean := parts[:0]
	for _, p := range parts {
		if p != "" {
			clean = append(clean, p)
		}
	}
	return strings.Join(clean, ".")
}

// getFieldColParts returns exactly four metadata strings for a column.
// (Stub—replace with your real schema lookup & formatting.)
func getFieldColParts(col *tree.UnresolvedName) []string {
	numParts := col.NumParts
	parts := make([]string, numParts)
	parts[0] = fmt.Sprintf(":-:%s:-:", col.Parts[0])
	for i := 1; i < numParts; i++ {
		parts[i] = col.Parts[i]
	}
	return parts
}

func getFieldCol(col string) []string {
	numParts := 1
	parts := make([]string, numParts)
	parts[0] = fmt.Sprintf(":-:%s:-:", col)
	return parts
}

func handleInsert(ins *tree.Insert) {
	// Only handle raw VALUES clauses (not INSERT … SELECT)
	sel := ins.Rows
	switch vals := sel.Select.(type) {
	case *tree.ValuesClause:
		rewriteValuesClause(ins, vals)
	case *tree.LiteralValuesClause:
		// rewriteLiteralValuesClause(ins, vals)  // if you need it
	default:
		// not a VALUES, leave it alone
	}
}

// rewriteValuesClause now produces one output tuple per input row.
func rewriteValuesClause(ins *tree.Insert, vals *tree.ValuesClause) {
	// 1) Figure out column names in order.
	var cols []string
	if len(ins.Columns) > 0 {
		for _, n := range ins.Columns {
			cols = append(cols, string(n))
		}
	} else {
		// stub: no‐columns case → assume table has 6 cols named col1…col6
		for i := 1; i <= 6; i++ {
			cols = append(cols, fmt.Sprintf("col%d", i))
		}
	}

	// 2) For each original row, emit exactly one mutated tuple:
	newRows := make([]tree.Exprs, 0, len(vals.Rows))
	for range vals.Rows {
		// build one placeholder tuple of length len(cols)
		base := make(tree.Exprs, len(cols))
		for i, col := range cols {
			parts := getFieldCol(col)
			var np tree.NameParts
			for j, p := range parts {
				np[j] = p
			}
			base[i] = &tree.UnresolvedName{
				NumParts: len(parts),
				Parts:    np,
			}
		}
		newRows = append(newRows, base)
	}

	// 3) Splice back in:
	vals.Rows = newRows
}

func TestPlaceholder(t *testing.T) {
	sqls := []string{
		`SELECT * FROM order_line WHERE ol_i_id IN (_,__more__)`,
		`SELECT * FROM order_line WHERE (ol_i_id, ol_d_id, ol_o_id) IN ((_,__more__),__more__)`,
		`SELECT * FROM order_line WHERE ((ol_w_id > _) AND (ol_d_id = _)) AND (ol_o_id = _)`,
		`SELECT * FROM order_line WHERE ((ol_w_id > _) AND ((ol_d_id,ol_o_id,ol_w_id) = (_,__more__))) AND (ol_o_id = _)`,
		`SELECT * FROM t WHERE price BETWEEN 100 AND _`,
		`SELECT * FROM t WHERE (price,mileage,age,kilometers) BETWEEN (_,__more__) AND (_,__more__)`,
		`INSERT INTO orders(acc_no, status, amount) VALUES (_, __more__) RETURNING id;`,
		`INSERT INTO orders(acc_no, status, amount) VALUES (_, __more__),(_, __more__),(_, __more__) RETURNING id;`,
	}
	for _, sql := range sqls {
		stmts, err := parser.Parse(sql)
		if err != nil {
			t.Fatalf("parse error: %v", err)
		}
		for _, stmt := range stmts {
			// ── Statement‐level: rewrite VALUES‐tuples in INSERTs ─────────
			if ins, ok := stmt.AST.(*tree.Insert); ok {
				handleInsert(ins)
			}

			// ── Expression‐level: handle WHERE, IN, BETWEEN, and any _/__more__ left
			tree.WalkStmt(&placeholderRewriter{}, stmt.AST)

			// ── Emit final SQL
			fmtCtx := tree.NewFmtCtx(tree.FmtSimple)
			stmt.AST.Format(fmtCtx)
			fmt.Println(fmtCtx.CloseAndGetString())
		}
	}

}
