package workload_generator

// workload_schema.go

import (
	"fmt"
	"math/rand"
	"strings"
	"time"
)

// ─── buildWorkloadSchema ──────────────────────────────────────────────

// buildWorkloadSchema converts your parsed allSchemas into the in-memory
// Schema needed by your data generator: map[tableName][]TableBlock.
func buildWorkloadSchema(
	allSchemas map[string]*TableSchema,
	dbName string,
	baseRowCount int,
) Schema {
	fanout := 10
	out := make(Schema, len(allSchemas))
	// capture seeds for foreign-key wiring
	fkSeed := make(map[[2]string]int, 256)
	rng := rand.New(rand.NewSource(time.Now().UnixNano()))

	// 1) first pass: build blocks, map columns → ColumnMeta
	for tblName, schema := range allSchemas {
		// single block for now:
		block := TableBlock{
			Count:         10000,
			Columns:       make(map[string]ColumnMeta, len(schema.Columns)),
			PK:            schema.PrimaryKeys,
			SortBy:        []string{},
			Unique:        schema.UniqueConstraints,
			OriginalTable: schema.OriginalTable,
			ColumnOrder:   schema.ColumnOrder,
			TableNumber:   schema.TableNumber,
		}

		if len(schema.UniqueConstraints) > 0 {
			// if there are unique constraints, we need to ensure the
			// workload generator can handle them.
			block.Unique = schema.UniqueConstraints
		}

		for _, col := range schema.Columns {
			// map SQL type → workload type + args
			typ, args := mapSQLType(col.ColType, col, rng)
			cm := ColumnMeta{
				Type:          typ,
				Args:          args,
				IsPrimaryKey:  col.IsPrimaryKey,
				IsUnique:      col.IsUnique,
				HasForeignKey: false,
			}
			if col.IsNullable && !col.IsPrimaryKey {
				cm.Args["null_pct"] = 0.1 // 20% chance of null
			} else {
				cm.Args["null_pct"] = 0.0 // no nulls for PK or non-nullable
			}

			if col.IsPrimaryKey {
				cm.IsPrimaryKey = true
				cm.IsUnique = true
			} else {
				cm.IsPrimaryKey = false
				cm.IsUnique = col.IsUnique
			}

			if col.Default != "" && isLiteralDefault(col.Default) {
				cm.DefaultProb = 0.2
				cm.Default = col.Default
			}

			block.Columns[col.Name] = cm

			// record seed for FK lookup
			if seed, ok := args["seed"].(int); ok {
				fkSeed[[2]string{tblName, col.Name}] = seed
				two := "public__" + canonical(tblName)
				three := dbName + "__" + two
				fkSeed[[2]string{two, col.Name}] = seed
				fkSeed[[2]string{three, col.Name}] = seed
			}
		}

		out[tblName] = []TableBlock{block}
	}

	// 2) second pass: wire up foreign keys
	for tblName, ts := range allSchemas {
		block := &out[tblName][0]
		for _, fk := range ts.ForeignKeys {
			locals := fk[0].([]string)
			parentTbl := fk[1].(string)
			parents := fk[2].([]string)

			// assign a composite ID if multi-col
			compositeID := 0
			if len(locals) > 1 {
				compositeID = rng.Intn(1 << 30) // or deterministic scheme
			}

			for i, lc := range locals {
				cm := block.Columns[lc]
				cm.HasForeignKey = true
				cm.FK = canonical(parentTbl) + "." + parents[i]
				cm.FKMode = "block"
				cm.Fanout = fanout
				cm.CompositeID = compositeID
				cm.ParentSeed = float64(fkSeed[[2]string{parentTbl, parents[i]}])
				block.Columns[lc] = cm
			}
		}
	}

	// 3) special case: if all of this table’s PK cols are FKs, drop fanout to 1
	for _, blocks := range out {
		blk := &blocks[0]
		allPKsAreFK := true
		for _, pkCol := range blk.PK {
			if !blk.Columns[pkCol].HasForeignKey {
				allPKsAreFK = false
				break
			}
		}
		if allPKsAreFK {
			for colName, cm := range blk.Columns {
				if cm.HasForeignKey {
					cm.Fanout = 1
					blk.Columns[colName] = cm
				}
			}
		}
	}

	for _, blocks := range out {
		block := &blocks[0]

		// 1) compute a fanout‐product only for columns that actually have FKs
		prods := make([]int, 0, len(block.Columns))
		for _, col := range block.Columns {
			if !col.HasForeignKey {
				continue
			}
			prods = append(prods, fanoutProduct(col, out))
		}

		// 2) if no FK columns, multiplier is 1; otherwise take the minimum
		tableMul := 1
		if len(prods) > 0 {
			tableMul = min(prods)
		}

		// 3) set your table’s row count
		block.Count = baseRowCount * tableMul
	}

	return out
}

func min(vals []int) int {
	if len(vals) == 0 {
		return 1
	}
	m := vals[0]
	for _, v := range vals[1:] {
		if v < m {
			m = v
		}
	}
	return m
}

func parseFK(fk string) (string, string) {
	parts := strings.SplitN(fk, ".", 2)
	if len(parts) != 2 {
		panic(fmt.Sprintf("invalid FK spec %q", fk))
	}
	return parts[0], parts[1]
}

func fanoutProduct(col ColumnMeta, schema Schema) int {
	prod := 1
	curr := col
	for curr.HasForeignKey {
		prod *= curr.Fanout
		rawTbl, parentCol := parseFK(curr.FK)

		// collapse "db__schema__table" → "table"
		tblParts := strings.Split(rawTbl, "__")
		simpleTbl := tblParts[len(tblParts)-1]

		blocks, ok := schema[simpleTbl]
		if !ok || len(blocks) == 0 {
			break
		}
		curr = blocks[0].Columns[parentCol]
	}
	return prod
}
