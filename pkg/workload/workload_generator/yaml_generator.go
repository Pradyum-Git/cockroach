package workload_generator

//
//import (
//	"fmt"
//	"math/rand"
//	"strings"
//	"time"
//
//	"gopkg.in/yaml.v3"
//)
//
//
//
//// decanonical undoes canonical() for at most two components.
//func decanonical(name string) string { return strings.Replace(name, "__", ".", 2) }
//
//
//func pow10(n int) int {
//	v := 1
//	for i := 0; i < n; i++ {
//		v *= 10
//	}
//	return v
//}
//
//// columnYAML converts a Column definition into the map structure used
//// when serialising workload YAML. The returned map includes the
//// generator type, arguments and various metadata flags.
////
//// defaultProb controls the probability with which literal default
//// values are emitted in the YAML output.l
//func columnYAML(col *Column, rng *rand.Rand, defaultProb float64) map[string]any {
//	d := map[string]any{}
//	typ, args := mapSQLType(col.ColType, col, rng)
//	d["type"] = typ
//	d["args"] = args
//
//	if col.IsNullable && !col.IsPrimaryKey {
//		args["null_pct"] = 0.1
//	} else {
//		args["null_pct"] = 0.0
//	}
//
//	if col.FKTable != "" {
//		parentTbl := col.FKTable
//		if !strings.Contains(parentTbl, ".") {
//			parentTbl = "public." + parentTbl
//		}
//		d["fk"] = fmt.Sprintf("%s.%s", canonical(parentTbl), col.FKColumn)
//		d["hasForeignKey"] = true
//	} else {
//		d["hasForeignKey"] = false
//	}
//
//	if col.IsPrimaryKey {
//		d["isPrimaryKey"] = true
//		d["isUnique"] = true
//	} else {
//		d["isPrimaryKey"] = false
//		d["isUnique"] = col.IsUnique
//	}
//
//	if col.Default != "" && isLiteralDefault(col.Default) {
//		d["default_prob"] = defaultProb
//		d["default"] = strings.TrimSpace(col.Default)
//	}
//	return d
//}
//
//var (
//
//)
//
//
//
//// ddlToYamlCA converts the map of table schemas produced by ParseDDL into
//// the YAML representation understood by the workload tooling. Each table
//// is translated into a single YAML block describing columns, primary
//// keys, foreign keys and unique constraints.
////
//// dbName is the name of the target database used when generating
//// canonical identifiers inside the YAML.
////
//// Parameters:
////   - allSchemas: map of table names to their TableSchema definitions.
////   - dbName: name of the database to use for canonical identifiers in the YAML output.
////
//// Returns the YAML string or an error if the conversion fails.
//func ddlToYamlCA(allSchemas map[string]*TableSchema, dbName string) (string, error) {
//	fanout := 10
//	yamlDoc := map[string][]map[string]any{}
//	colSeedMap := map[[2]string]int{}
//	rng := rand.New(rand.NewSource(time.Now().UnixNano()))
//
//	for tblName, schema := range allSchemas {
//		//setting initial table level block structure
//		block := map[string]any{
//			"count":          10000,                       // default row count. can be parameterized later
//			"sort-by":        []string{},                  // optional sort keys. isn't in use yet
//			"pk":             schema.PrimaryKeys,          // primary key columns
//			"columns":        map[string]map[string]any{}, // column metadata filled below
//			"original_table": schema.OriginalTable,        // original table name as seen in DDL
//			"column_order":   schema.ColumnOrder,          // preserve column ordering
//			"table_number":   schema.TableNumber,          // ordering used by workload tooling
//		}
//		if len(schema.UniqueConstraints) > 0 {
//			block["unique"] = schema.UniqueConstraints
//		}
//		cols := block["columns"].(map[string]map[string]any)
//		// populate column definitions
//		for _, c := range schema.Columns {
//			colInfo := columnYAML(c, rng, 0.2)
//			cols[c.Name] = colInfo
//			// remember the RNG seed so that dependent columns can
//			// reference it when setting parent_seed.
//			seed, _ := colInfo["args"].(map[string]any)["seed"].(int)
//			colSeedMap[[2]string{tblName, c.Name}] = seed
//			//multiple key formats because variance in DDL
//			two := "public__" + canonical(tblName)
//			three := dbName + "__" + canonical(two)
//			colSeedMap[[2]string{two, c.Name}] = seed
//			colSeedMap[[2]string{three, c.Name}] = seed
//		}
//
//		if len(schema.ForeignKeys) > 0 {
//			// fkIDs assigns a stable ID to each foreign key
//			// constraint so that composite keys can share a
//			// composite_id across columns.
//			fkIDs := map[string]int{}
//			nextID := 1
//			for _, fk := range schema.ForeignKeys {
//				local := fk[0].([]string)
//				parent := fk[1].(string)
//				foreign := fk[2].([]string)
//				// Normalise the referenced table and create an
//				// identifier used in the YAML.
//				if !strings.Contains(parent, ".") {
//					parent = "public." + parent
//				}
//				parentCanon := canonical(parent)
//				key := parentCanon + "|" + strings.Join(foreign, ",")
//				// Ensure a deterministic composite_id per FK.
//				// Have stopped using composite ids for now, still keeping for possible reuse in the future.
//				cid, ok := fkIDs[key]
//				if !ok {
//					cid = nextID
//					fkIDs[key] = cid
//					nextID++
//				}
//				// Annotate each local column with fk metadata.
//				for i, lc := range local {
//					pc := foreign[i]
//					colMeta := cols[lc]
//					if _, ok := colMeta["fk"]; !ok {
//						colMeta["fk"] = fmt.Sprintf("%s.%s", parentCanon, pc)
//						colMeta["hasForeignKey"] = true
//					}
//					// composite_id groups multi-column FKs.
//					if len(local) > 1 {
//						colMeta["composite_id"] = cid
//					}
//				}
//			}
//		}
//		yamlDoc[canonical(tblName)] = []map[string]any{block}
//	}
//
//	// second pass: fill in fk_mode/fanout/parent_seed using the
//	// column seeds captured above.
//	for _, tbl := range yamlDoc {
//		block := tbl[0]
//		cols := block["columns"].(map[string]map[string]any)
//		for name, meta := range cols {
//			fkInfo, ok := meta["fk"].(string)
//			if !ok {
//				continue
//			}
//			parts := strings.SplitN(fkInfo, ".", 2)
//			if len(parts) != 2 {
//				continue
//			}
//			// Look up the parent's seed so child rows reference
//			// the same pseudo-random stream
//			seed, ok := colSeedMap[[2]string{parts[0], parts[1]}]
//			if ok {
//				if _, ok := meta["fk_mode"]; !ok {
//					meta["fk_mode"] = "block"
//				}
//				if _, ok := meta["fanout"]; !ok {
//					meta["fanout"] = fanout
//				}
//				if _, ok := meta["parent_seed"]; !ok {
//					meta["parent_seed"] = seed
//				}
//			}
//			cols[name] = meta
//		}
//	}
//	// Reduce fanout to 1 when every primary key column is also a
//	// foreign key.
//	for _, tbl := range yamlDoc {
//		block := tbl[0]
//		cols := block["columns"].(map[string]map[string]any)
//		allPkFK := true
//		for _, pk := range block["pk"].([]string) {
//			if val, ok := cols[pk]["hasForeignKey"].(bool); !ok || !val {
//				allPkFK = false
//				break
//			}
//		}
//		if allPkFK {
//			for _, meta := range cols {
//				if val, ok := meta["hasForeignKey"].(bool); ok && val {
//					meta["fanout"] = 1
//				}
//			}
//		}
//	}
//
//	out, err := yaml.Marshal(yamlDoc)
//	if err != nil {
//		return "", err
//	}
//	return string(out), nil
//}
