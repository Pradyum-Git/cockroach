package workload_generator

import (
	"fmt"
	"github.com/cockroachdb/cockroach/pkg/sql/parser"
	"github.com/cockroachdb/cockroach/pkg/sql/sem/tree"
	"github.com/cockroachdb/cockroach/pkg/sql/sem/tree/treecmp"
	"go/constant"
	"math/rand"
	"strings"
)

// placeholderRewriter handles both simple comparisons and IN-lists.
type placeholderRewriter struct {
	schemas map[string]*TableSchema
}

// VisitPre rewrites any ComparisonExpr for =,>,<,… and IN.
func (v *placeholderRewriter) VisitPre(expr tree.Expr) (bool, tree.Expr) {
	//handle BETWEEN … AND …
	if ce, ok := expr.(*tree.CaseExpr); ok {
		switch key := ce.Expr.(type) {

		// ── scalar CASE: CASE col WHEN _ THEN _ …
		case *tree.UnresolvedName:
			rewriteCaseExpr(
				ce,
				reconstructName(key), // e.g. "c_credit"
				v.schemas,
			)

		// ── tuple CASE: CASE (col1,col2) WHEN … THEN …
		case *tree.Tuple:
			// rewriteCaseExpr’s tuple‐branch ignores the target string,
			// it uses the Tuple directly to regenerate each WHEN/THEN.
			rewriteCaseExpr(
				ce,
				"", // unused for tuple‐mode
				v.schemas,
			)

		default:
			// neither a scalar nor tuple key, skip
		}

		// don’t descend into the old CASE again
		return false, ce
	}

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
// where b and/or c embed "_" or "__more__" placeholders. Supports both single-col
// and tuple-col BETWEEN.
func handleRangeCondition(rc *tree.RangeCond) tree.Expr {
	// --- single-column BETWEEN a AND b ---
	if colUn, ok := rc.Left.(*tree.UnresolvedName); ok {
		//targetCol := reconstructName(colUn)
		// Helper to rewrite any placeholder inside an Expr:
		var rewriteBound func(tree.Expr) tree.Expr
		rewriteBound = func(e tree.Expr) tree.Expr {
			switch t := e.(type) {
			case *tree.UnresolvedName:
				// direct "_" or "__more__"
				if n := reconstructName(t); n == "_" || n == "__more__" {
					parts := getFieldColParts(colUn)
					t.NumParts = len(parts)
					for i, p := range parts {
						t.Parts[i] = p
					}
				}
				return t

			case *tree.ParenExpr:
				// unwrap parentheses
				t.Expr = rewriteBound(t.Expr)
				return t

			case *tree.BinaryExpr:
				// recurse into both sides of any arithmetic
				t.Left = rewriteBound(t.Left)
				t.Right = rewriteBound(t.Right)
				return t

			default:
				return t
			}
		}

		// rewrite both ends
		rc.From = rewriteBound(rc.From)
		rc.To = rewriteBound(rc.To)
		// we always return rc since we may have rewritten
		return rc
	}

	// --- tuple-column BETWEEN (a,b) AND (c,d) ---
	lt, lok := rc.Left.(*tree.Tuple)
	rf, rfok := rc.From.(*tree.Tuple)
	rt, rtok := rc.To.(*tree.Tuple)
	if !lok || !rfok || !rtok {
		return nil
	}
	// verify both bounds are tuples of "_" / "__more__"
	for _, tup := range []*tree.Tuple{rf, rt} {
		for _, e := range tup.Exprs {
			if u, ok := e.(*tree.UnresolvedName); !ok {
				return nil
			} else if n := reconstructName(u); n != "_" && n != "__more__" {
				return nil
			}
		}
	}
	// extract the key columns
	cols := make([]*tree.UnresolvedName, len(lt.Exprs))
	for i, e := range lt.Exprs {
		cols[i] = e.(*tree.UnresolvedName)
	}
	// build a new placeholder tuple for each bound
	build := func() *tree.Tuple {
		out := &tree.Tuple{Exprs: make(tree.Exprs, len(cols))}
		for j, colNode := range cols {
			//colName := reconstructName(colNode)
			parts := getFieldColParts(colNode)
			var np tree.NameParts
			for k, p := range parts {
				np[k] = p
			}
			out.Exprs[j] = &tree.UnresolvedName{
				NumParts: len(parts),
				Parts:    np,
			}
		}
		return out
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

func getFieldCol(col string, clause string) []string {
	numParts := 1
	parts := make([]string, numParts)
	parts[0] = fmt.Sprintf(":-:'%s','%s':-:", col, clause)
	return parts
}

func handleInsert(ins *tree.Insert, allSchemas map[string]*TableSchema) {
	// Only handle raw VALUES clauses (not INSERT … SELECT)
	sel := ins.Rows
	switch vals := sel.Select.(type) {
	case *tree.ValuesClause:
		rewriteValuesClause(ins, vals, allSchemas)
	case *tree.LiteralValuesClause:
		// rewriteLiteralValuesClause(ins, vals)  // if you need it
	default:
		// not a VALUES, leave it alone
	}
}

// rewriteValuesClause now produces one output tuple per input row.
func rewriteValuesClause(ins *tree.Insert, vals *tree.ValuesClause, allSchemas map[string]*TableSchema) {
	// 1) Figure out column names in order.
	var cols []string
	if len(ins.Columns) > 0 {
		for _, n := range ins.Columns {
			cols = append(cols, string(n))
		}
	} else {
		// ==== no explicit cols: look up table in allSchemas ====
		var tblName string
		switch t := ins.Table.(type) {
		case *tree.TableName:
			// t.String() will give you something like `order_line` (with
			// quoting preserved). Trim any double-quotes so it matches
			// your map keys.
			tblName = strings.Trim(t.String(), `"`)

		case *tree.AliasedTableExpr:
			if tn, ok := t.Expr.(*tree.TableName); ok {
				tblName = strings.Trim(tn.String(), `"`)
			}

		default:
			// fallback if it's some other TableExpr (JOIN, sub-query, etc.)
			tblName = ""
		}

		if ts, ok := allSchemas[tblName]; ok {
			// now collect all the column names from that TableSchema
			for col := range ts.Columns {
				cols = append(cols, col)
			}
		} else {
			// table not found in schema map; you could error or leave cols empty
		}

	}

	// 2) For each original row, emit exactly one mutated tuple:
	newRows := make([]tree.Exprs, 0, len(vals.Rows))
	for range vals.Rows {
		// build one placeholder tuple of length len(cols)
		base := make(tree.Exprs, len(cols))
		for i, col := range cols {
			parts := getFieldCol(col, "INSERT")
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
	//tree.Update{}
}

func rewriteUpdateSet(upd *tree.Update, allSchemas map[string]*TableSchema) {
	for _, setExpr := range upd.Exprs {
		if !setExpr.Tuple {
			// single‐column SET: "col = …"
			targetCol := string(setExpr.Names[0])
			setExpr.Expr = rewriteSetRHS(setExpr.Expr, targetCol, allSchemas)
		} else {
			// tuple‐form SET: "(a,b,…) = (…)"
			// Build a new RHS tuple, one placeholder per LHS column.
			cols := setExpr.Names
			newTuple := &tree.Tuple{Exprs: make(tree.Exprs, len(cols))}
			for i, name := range cols {
				col := string(name)
				parts := getFieldCol(col, "UPDATE")
				var np tree.NameParts
				for j, p := range parts {
					np[j] = p
				}
				newTuple.Exprs[i] = &tree.UnresolvedName{
					NumParts: len(parts),
					Parts:    np,
				}
			}
			setExpr.Expr = newTuple
		}
	}
}

func rewriteSetRHS(
	expr tree.Expr,
	targetCol string,
	allSchemas map[string]*TableSchema,
) tree.Expr {
	switch t := expr.(type) {
	case *tree.UnresolvedName:
		// placeholder "_" or "__more__"
		name := reconstructName(t)
		if name == "_" || name == "__more__" {
			parts := getFieldCol(targetCol, "UPDATE")
			t.NumParts = len(parts)
			for i, p := range parts {
				t.Parts[i] = p
			}
		}

	case *tree.BinaryExpr:
		// e.g. col + _  or deeper nested
		t.Left = rewriteSetRHS(t.Left, targetCol, allSchemas)
		t.Right = rewriteSetRHS(t.Right, targetCol, allSchemas)

	case *tree.Tuple:
		// e.g. CASE tuple‐arm might embed a Tuple
		for i, elt := range t.Exprs {
			t.Exprs[i] = rewriteSetRHS(elt, targetCol, allSchemas)
		}

	case *tree.CaseExpr:
		// handle both tuple‐CASE and scalar‐CASE
		rewriteCaseExpr(t, targetCol, allSchemas)
	}
	return expr
}

// rewriteCaseExpr tags every WHEN … THEN … and the final ELSE if it’s
// an UnresolvedName placeholder. You may already have a
// placeholderRewriter for WHERE/IN/BETWEEN—this is just the SET‐specific
// pass so you know the targetCol.
func rewriteCaseExpr(
	c *tree.CaseExpr,
	targetCol string,
	allSchemas map[string]*TableSchema,
) {
	// Detect tuple‐CASE if c.Expr is a Tuple of key columns
	if keyTpl, ok := c.Expr.(*tree.Tuple); ok {
		// Gather the key column names
		var keyCols []string
		for _, ke := range keyTpl.Exprs {
			if un, ok := ke.(*tree.UnresolvedName); ok {
				keyCols = append(keyCols, reconstructName(un))
			}
		}
		// For each WHEN arm: rewrite both Cond (tuple) and Val
		for _, arm := range c.Whens {
			if _, ok := arm.Cond.(*tree.Tuple); ok {
				// rebuild cond tuple with placeholders per keyCol
				newCond := &tree.Tuple{Exprs: make(tree.Exprs, len(keyCols))}
				for i, col := range keyCols {
					parts := getFieldCol(col, "WHERE")
					var np tree.NameParts
					for j, p := range parts {
						np[j] = p
					}
					newCond.Exprs[i] = &tree.UnresolvedName{
						NumParts: len(parts),
						Parts:    np,
					}
				}
				arm.Cond = newCond
			}
			// THEN arm.Val → placeholder for targetCol
			if u, ok := arm.Val.(*tree.UnresolvedName); ok {
				if name := reconstructName(u); name == "_" || name == "__more__" {
					parts := getFieldCol(targetCol, "INSERT")
					u.NumParts = len(parts)
					for i, p := range parts {
						u.Parts[i] = p
					}
				}
			}
		}
		// ELSE branch can be a placeholder or force_error; handle simple placeholder
		if u, ok := c.Else.(*tree.UnresolvedName); ok {
			if name := reconstructName(u); name == "_" || name == "__more__" {
				parts := getFieldCol(targetCol, "INSERT")
				u.NumParts = len(parts)
				for i, p := range parts {
					u.Parts[i] = p
				}
			}
		}
		return
	}

	// ── scalar‐CASE fallback ─────────────────────────────────────
	for _, arm := range c.Whens {
		// WHEN
		if u, ok := arm.Cond.(*tree.UnresolvedName); ok {
			if reconstructName(u) == "_" || reconstructName(u) == "__more__" {
				parts := getFieldColPartsFor(targetCol, allSchemas)
				u.NumParts = len(parts)
				for i, p := range parts {
					u.Parts[i] = p
				}
			}
		}
		// THEN
		if u, ok := arm.Val.(*tree.UnresolvedName); ok {
			if reconstructName(u) == "_" || reconstructName(u) == "__more__" {
				parts := getFieldColPartsFor(targetCol, allSchemas)
				u.NumParts = len(parts)
				for i, p := range parts {
					u.Parts[i] = p
				}
			}
		}
	}
	// ELSE
	if u, ok := c.Else.(*tree.UnresolvedName); ok {
		if reconstructName(u) == "_" || reconstructName(u) == "__more__" {
			parts := getFieldColPartsFor(targetCol, allSchemas)
			u.NumParts = len(parts)
			for i, p := range parts {
				u.Parts[i] = p
			}
		}
	}
}

// getFieldColPartsFor returns the placeholder parts for a given column name.
// Replace the stub below with your real lookup into allSchemas[col].
func getFieldColPartsFor(
	col string,
	allSchemas map[string]*TableSchema,
) []string {
	// STUB: single‐part placeholder.  In your real code, look up:
	//    meta := allSchemas[<table>].Columns[col]
	//    return []string{
	//       meta.Name, meta.Type, meta.Nullable, meta.Desc,
	//    }
	return []string{fmt.Sprintf(":-:%s:-:", col)}
}

func rewriteSelectLimit(sel *tree.Select) {
	if sel.Limit == nil || sel.Limit.Count == nil {
		return
	}
	if u, ok := sel.Limit.Count.(*tree.UnresolvedName); ok && reconstructName(u) == "_" {
		// Pick a random 1–100
		n := rand.Intn(100) + 1
		lit := fmt.Sprintf("%d", n)
		// Build a constant.Value and swap in a NumVal node
		sel.Limit.Count = tree.NewNumVal(
			constant.MakeInt64(int64(n)), // the constant.Value
			lit,                          // original string
			false,                        // not negative
		)
	}
}

// ReplacePlaceholders parses the given SQL, applies both the INSERT-VALUES
// expansion and the expression-level placeholder rewrites, and returns the
// resulting SQL (or an error).
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
			rewriteUpdateSet(upd, allSchemas)
		}

		//handling limit _
		if sel, ok := stmt.AST.(*tree.Select); ok {
			rewriteSelectLimit(sel)
		}
		// expression-level rewrites (WHERE, IN, BETWEEN, comparisons)
		rw := &placeholderRewriter{schemas: allSchemas}
		if sel, ok := stmt.AST.(*tree.Select); ok {
			// Unbox the SelectClause
			if sc, ok := sel.Select.(*tree.SelectClause); ok {
				for _, tbl := range sc.From.Tables {
					if j, ok := tbl.(*tree.JoinTableExpr); ok {
						// Only handle ON‐joins here
						if on, ok := j.Cond.(*tree.OnJoinCond); ok {
							tree.WalkExpr(rw, on.Expr)
						}
					}
				}
			}
		}
		tree.WalkStmt(rw, stmt.AST)

		// pretty-print
		fmtCtx := tree.NewFmtCtx(tree.FmtSimple)
		stmt.AST.Format(fmtCtx)
		out = append(out, fmtCtx.CloseAndGetString())
	}
	// join multiple statements with newline
	return strings.Join(out, "\n"), nil
}
