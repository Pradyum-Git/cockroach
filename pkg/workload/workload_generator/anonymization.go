package workload_generator

import (
	"fmt"
	"regexp"
	"sort"
	"strings"
)

// buildMapping assigns each table in allSchemas an anonymized name t1, t2, …,
// and each of its columns c1, c2, …, returning the two maps.
func buildMapping(allSchemas map[string]*TableSchema) Mapping {
	// 1) Collect table names with their TableNumber for deterministic ordering
	type tbl struct {
		name   string
		number int
	}
	tbls := make([]tbl, 0, len(allSchemas))
	for tblName, schema := range allSchemas {
		tbls = append(tbls, tbl{tblName, schema.TableNumber})
	}
	sort.Slice(tbls, func(i, j int) bool {
		return tbls[i].number < tbls[j].number
	})

	// 2) Build the mapping
	m := Mapping{
		Tables:  make(map[string]string, len(tbls)),
		Columns: make(map[string]map[string]string, len(tbls)),
	}
	for i, t := range tbls {
		anonTable := fmt.Sprintf("db.public.t%d", i+1)
		m.Tables[t.name] = anonTable

		// NEW: iterate ColumnOrder for stable numbering
		colMap := make(map[string]string, len(allSchemas[t.name].ColumnOrder))
		for j, origCol := range allSchemas[t.name].ColumnOrder {
			colMap[origCol] = fmt.Sprintf("t%d_c%d", i+1, j+1)
		}
		m.Columns[t.name] = colMap
	}
	return m
}

func applySchemaMapping(
	allSchemas map[string]*TableSchema,
	mapping Mapping,
) map[string]*TableSchema {
	anon := make(map[string]*TableSchema, len(allSchemas))

	for origTbl, schema := range allSchemas {
		// 1. Deep-copy the schema
		clone := deepCopyTableSchema(schema)

		// 2. Rename the table
		fqTbl := mapping.Tables[origTbl] // e.g. "db.public.t1"
		parts := strings.Split(fqTbl, ".")
		bareTbl := parts[len(parts)-1] // "t1"
		clone.OriginalTable = fqTbl
		clone.TableName = bareTbl

		// 2b. Rename columns
		colMap := mapping.Columns[origTbl]
		for i, colName := range clone.ColumnOrder {
			newName := colMap[colName]
			clone.ColumnOrder[i] = newName
			col := clone.Columns[colName]
			delete(clone.Columns, colName)
			col.Name = newName
			clone.Columns[newName] = col
		}

		// 3. Update primary keys
		for i, pk := range clone.PrimaryKeys {
			clone.PrimaryKeys[i] = colMap[pk]
		}

		// 4. Update foreign keys
		for i, fk := range clone.ForeignKeys {
			localCols := fk[0].([]string)
			refTableFQ := fk[1].(string) // e.g. "tpcc.public.warehouse"
			refParts := strings.Split(refTableFQ, ".")
			origRef := refParts[len(refParts)-1] // "warehouse"
			refCols := fk[2].([]string)

			// a) map local columns
			for j, c := range localCols {
				localCols[j] = colMap[c]
			}

			// b) determine bare alias for referenced table
			fqAlias := mapping.Tables[origRef] // "db.public.tX"
			aliasParts := strings.Split(fqAlias, ".")
			bareRef := aliasParts[len(aliasParts)-1] // "tX"

			// c) map referenced columns
			for j, c := range refCols {
				refCols[j] = mapping.Columns[origRef][c]
			}

			clone.ForeignKeys[i] = [3]interface{}{localCols, bareRef, refCols}
		}

		// 5. Store under the bare anonymized table name
		anon[bareTbl] = clone
	}

	return anon
}

// deepCopyColumn makes a copy of a Column.
func deepCopyColumn(c *Column) *Column {
	return &Column{
		Name:         c.Name,
		ColType:      c.ColType,
		IsNullable:   c.IsNullable,
		IsPrimaryKey: c.IsPrimaryKey,
		Default:      c.Default,
		IsUnique:     c.IsUnique,
		FKTable:      c.FKTable,
		FKColumn:     c.FKColumn,
		InlineCheck:  c.InlineCheck,
	}
}

// deepCopyTableSchema makes a full deep copy of a TableSchema.
func deepCopyTableSchema(ts *TableSchema) *TableSchema {
	// Copy primitive fields
	copyTS := &TableSchema{
		rowCount:    ts.rowCount,
		TableName:   ts.TableName,
		PrimaryKeys: append([]string{}, ts.PrimaryKeys...),
		UniqueConstraints: func() [][]string {
			uq := make([][]string, len(ts.UniqueConstraints))
			for i, cols := range ts.UniqueConstraints {
				uq[i] = append([]string{}, cols...)
			}
			return uq
		}(),
		ForeignKeys: func() [][3]interface{} {
			fks := make([][3]interface{}, len(ts.ForeignKeys))
			copy(fks, ts.ForeignKeys)
			return fks
		}(),
		CheckConstraints: append([]string{}, ts.CheckConstraints...),
		OriginalTable:    ts.OriginalTable,
		ColumnOrder:      append([]string{}, ts.ColumnOrder...),
		TableNumber:      ts.TableNumber,
		Columns:          make(map[string]*Column, len(ts.Columns)),
	}

	// Copy columns
	for origName, col := range ts.Columns {
		copyTS.Columns[origName] = deepCopyColumn(col)
	}

	return copyTS
}

// anonymizeCreateStatements applies the Mapping to every DDL string,
// dropping the original “tpcc.public.” prefix and rewriting both
// local and referenced columns.
func anonymizeCreateStatements(
	createStmts map[string]string,
	mapping Mapping,
	origDBName string,
) map[string]string {
	anonStmts := make(map[string]string, len(createStmts))

	// 1) Sort original table names by length descending to avoid partial matches
	tblNames := make([]string, 0, len(mapping.Tables))
	for orig := range mapping.Tables {
		tblNames = append(tblNames, orig)
	}
	sort.Slice(tblNames, func(i, j int) bool {
		return len(tblNames[i]) > len(tblNames[j])
	})

	// 2) Build a global column map and sort column names by length descending
	globalCols := make(map[string]string, 0)
	for _, cols := range mapping.Columns {
		for origCol, anonCol := range cols {
			globalCols[origCol] = anonCol
		}
	}
	origCols := make([]string, 0, len(globalCols))
	for origCol := range globalCols {
		origCols = append(origCols, origCol)
	}
	sort.Slice(origCols, func(i, j int) bool {
		return len(origCols[i]) > len(origCols[j])
	})

	// 3) Rewrite each CREATE TABLE statement
	for origTbl, stmt := range createStmts {
		newStmt := stmt

		// Compute anonymized names
		fq := mapping.Tables[origTbl] // e.g. "db.public.t3"
		parts := strings.Split(fq, ".")
		bareTbl := parts[len(parts)-1] // e.g. "t3"

		// a) Replace fully-qualified original table references with each table’s own bare alias
		for _, orig := range tblNames {
			// look up full alias for this orig
			fqAlias := mapping.Tables[orig] // "db.public.tN"
			parts := strings.Split(fqAlias, ".")
			bareAlias := parts[len(parts)-1] // "tN"

			// pattern: tpcc.public.orig → tN
			reUnq := regexp.MustCompile(
				fmt.Sprintf(`\b%s\.public\.%s\b`,
					regexp.QuoteMeta(origDBName),
					regexp.QuoteMeta(orig),
				),
			)
			newStmt = reUnq.ReplaceAllString(newStmt, bareAlias)

			// pattern: tpcc.public."orig" → tN
			reQ := regexp.MustCompile(
				fmt.Sprintf(`%s\.public\."%s"`,
					regexp.QuoteMeta(origDBName),
					regexp.QuoteMeta(orig),
				),
			)
			newStmt = reQ.ReplaceAllString(newStmt, bareAlias)
		}

		// b) Replace bare original table names with each table’s own bare alias
		for _, orig := range tblNames {
			fqAlias := mapping.Tables[orig]
			parts := strings.Split(fqAlias, ".")
			bareAlias := parts[len(parts)-1]

			reBare := regexp.MustCompile(
				fmt.Sprintf(`\b%s\b`, regexp.QuoteMeta(orig)),
			)
			newStmt = reBare.ReplaceAllString(newStmt, bareAlias)
		}

		// c) Replace any original column names with anonymized column names
		for _, origCol := range origCols {
			anonCol := globalCols[origCol]
			colRe := regexp.MustCompile(
				fmt.Sprintf(`\b%s\b`, regexp.QuoteMeta(origCol)),
			)
			newStmt = colRe.ReplaceAllString(newStmt, anonCol)
		}

		// d) Store under the bare anonymized table key
		anonStmts[bareTbl] = newStmt
	}

	return anonStmts
}

// anonymiseSQL applies a simple regex‐only pass over rawSQL,
// replacing every occurrence of each orig table and column with its bare alias.
//
// Note: this is a quick PoC for TPCC‐style DML. It does:
//  1. Fully‐qualified tables: tpcc.public.<orig> → tN
//  2. Quoted‐qualified tables: tpcc.public."<orig>" → tN
//  3. Bare table names: "<orig>" → tN
//  4. Columns: "origCol" → cM
//
// It does **not** use the AST parser—if this works end‐to‐end, you can
// later swap in the AST‐based pass for bulletproof correctness.
func anonymiseSQL(rawSQL string, mapping Mapping, origDBName string) string {
	sql := rawSQL

	// 1) Sort table names longest‐first to avoid partials (e.g. "order" vs "order_line")
	tbls := make([]string, 0, len(mapping.Tables))
	for orig := range mapping.Tables {
		tbls = append(tbls, orig)
	}
	sort.Slice(tbls, func(i, j int) bool { return len(tbls[i]) > len(tbls[j]) })

	// 2) Replace table names
	for _, orig := range tbls {
		// lookup bare alias
		fq := mapping.Tables[orig] // "db.public.t5"
		parts := strings.Split(fq, ".")
		bare := parts[len(parts)-1] // "t5"

		// a) fully‐qualified unquoted: tpcc.public.order → t5
		reFQ := regexp.MustCompile(
			fmt.Sprintf(`\b%s\.public\.%s\b`,
				regexp.QuoteMeta(origDBName),
				regexp.QuoteMeta(orig),
			),
		)
		sql = reFQ.ReplaceAllString(sql, bare)

		// b) fully‐qualified quoted: tpcc.public."order" → t5
		reQ := regexp.MustCompile(
			fmt.Sprintf(`%s\.public\."%s"`,
				regexp.QuoteMeta(origDBName),
				regexp.QuoteMeta(orig),
			),
		)
		sql = reQ.ReplaceAllString(sql, bare)

		// c) bare table name: order → t5
		reBare := regexp.MustCompile(
			fmt.Sprintf(`\b%s\b`, regexp.QuoteMeta(orig)),
		)
		sql = reBare.ReplaceAllString(sql, bare)
	}

	// 3) Replace columns (longest‐first)
	cols := make([]string, 0, len(mapping.Columns))
	for _, colmap := range mapping.Columns {
		for origCol := range colmap {
			cols = append(cols, origCol)
		}
	}
	sort.Slice(cols, func(i, j int) bool { return len(cols[i]) > len(cols[j]) })

	for _, origCol := range cols {
		// get any one anonCol (they’re globally unique within the mapping)
		var anonCol string
		for _, colmap := range mapping.Columns {
			if ac, ok := colmap[origCol]; ok {
				anonCol = ac
				break
			}
		}
		reCol := regexp.MustCompile(
			fmt.Sprintf(`\b%s\b`, regexp.QuoteMeta(origCol)),
		)
		sql = reCol.ReplaceAllString(sql, anonCol)
	}

	return sql
}
