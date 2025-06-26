package workload_generator

import (
	"fmt"
	"math"
	"math/rand"
	"regexp"
	"strconv"
	"strings"
	"time"

	"gopkg.in/yaml.v3"
)

// canonical replaces "." with "__" to match the legacy YAML format.
func canonical(name string) string { return strings.ReplaceAll(name, ".", "__") }

// decanonical undoes canonical() for at most two components.
func decanonical(name string) string { return strings.Replace(name, "__", ".", 2) }

var (
	// Regular expressions used to interpret SQL column types in the
	// DDL and map them to workload generator types.
	decimalRe = regexp.MustCompile(`(?i)^(?:decimal|numeric)\s*(?:\(\s*(\d+)\s*,\s*(\d+)\s*\))?$`)
	numericRe = regexp.MustCompile(`(?i)^(decimal|numeric|float|double|real)`)
	varcharRe = regexp.MustCompile(`(?i)^(varchar|character varying)\((\d+)\)`)
	charRe    = regexp.MustCompile(`(?i)^char\((\d+)\)$`)
	bitRe     = regexp.MustCompile(`(?i)^(bit|varbit)(?:\((\d+)\))?`)
	byteRe    = regexp.MustCompile(`(?i)^(bytea|blob|bytes)$`)
)

func setArgsRange(args map[string]any, min, max int) {
	args["min"] = min
	args["max"] = max
}

// mapSQLType maps a SQL column type to the workload generator type and
// argument set expected by cockroach workloads. The returned map may
// include bounds, formatting information or other hints used by the
// data generators.
func mapSQLType(sql string, col *Column, rng *rand.Rand) (string, map[string]any) {
	sql = strings.ToLower(sql)
	args := map[string]any{"seed": rng.Intn(100)}

	switch {
	case strings.HasPrefix(sql, "int") ||
		sql == "integer" || sql == "bigint" || sql == "smallint" || sql == "serial":
		if col.IsPrimaryKey || col.IsUnique {
			return "sequence", map[string]any{"start": 1, "seed": args["seed"]}
		}
		setArgsRange(args, -(1 << 31), (1<<31)-1)
		return "integer", args

	case sql == "uuid":
		return "uuid", args

	case bitRe.MatchString(sql):
		m := bitRe.FindStringSubmatch(sql)
		size := 1
		if m[2] != "" {
			size = atoi(m[2])
		}
		args["size"] = size
		return "bit", args

	case byteRe.MatchString(sql):
		m := byteRe.FindStringSubmatch(sql)
		size := 1
		if m[2] != "" {
			size = atoi(m[2])
		}
		args["size"] = size
		return "bytes", args

	case varcharRe.MatchString(sql):
		m := varcharRe.FindStringSubmatch(sql)
		length := atoi(m[2])
		setArgsRange(args, 1, length)
		return "string", args

	case charRe.MatchString(sql):
		n := atoi(charRe.FindStringSubmatch(sql)[1])
		setArgsRange(args, n, n)
		return "string", args

	case sql == "text" || sql == "clob" || sql == "string":
		setArgsRange(args, 5, 30)
		return "string", args

	case decimalRe.MatchString(sql):
		m := decimalRe.FindStringSubmatch(sql)
		if m[1] != "" {
			precision := atoi(m[1])
			scale := atoi(m[2])
			intDigits := precision - scale

			// smallest fractional step: 10^(–scale)
			fracUnit := math.Pow10(-scale)

			var minVal, maxVal float64
			if intDigits > 0 {
				// e.g. p=6,s=4 ⇒ intDigits=2 ⇒ base=99
				base := float64(int(math.Pow10(intDigits)) - 1)
				maxVal = base + (1.0 - fracUnit) // 99.9999
				minVal = -maxVal
			} else {
				// p==s ⇒ only fractional digits, e.g. 0.9999
				maxVal = 1.0 - fracUnit
				minVal = -maxVal
			}

			setArgsRange(args, minVal, maxVal)
			args["round"] = scale
		} else {
			// fallback for DECIMAL without precision
			args["min"] = 0.0
			args["max"] = 1.0
			args["round"] = 2
		}
		return "float", args

	case numericRe.MatchString(sql):
		args["min"] = 0
		args["max"] = 1
		args["round"] = 2
		return "float", args

	case sql == "date":
		args["start"] = "2000-01-01"
		args["end"] = "2025-01-01"
		args["format"] = "%Y-%m-%d"
		return "date", args

	case sql == "timestamp" || sql == "timestamptz":
		args["start"] = "2000-01-01"
		args["end"] = "2025-01-01"
		args["format"] = "%Y-%m-%d %H:%M:%S.%f"
		return "timestamp", args

	case sql == "bool" || sql == "boolean":
		return "bool", args
	}
	args["min"] = 5
	args["max"] = 30
	return "string", args
}

// Helper numeric functions
func atoi(s string) int {
	n, _ := strconv.Atoi(s)
	return n
}
func pow10(n int) int {
	v := 1
	for i := 0; i < n; i++ {
		v *= 10
	}
	return v
}

// columnYAML converts a Column definition into the map structure used
// when serialising workload YAML. The returned map includes the
// generator type, arguments and various metadata flags.
//
// defaultProb controls the probability with which literal default
// values are emitted in the YAML output.l
func columnYAML(col *Column, rng *rand.Rand, defaultProb float64) map[string]any {
	d := map[string]any{}
	typ, args := mapSQLType(col.ColType, col, rng)
	d["type"] = typ
	d["args"] = args

	if col.IsNullable && !col.IsPrimaryKey {
		args["null_pct"] = 0.1
	} else {
		args["null_pct"] = 0.0
	}

	if col.FKTable != "" {
		parentTbl := col.FKTable
		if !strings.Contains(parentTbl, ".") {
			parentTbl = "public." + parentTbl
		}
		d["fk"] = fmt.Sprintf("%s.%s", canonical(parentTbl), col.FKColumn)
		d["hasForeignKey"] = true
	} else {
		d["hasForeignKey"] = false
	}

	if col.IsPrimaryKey {
		d["isPrimaryKey"] = true
		d["isUnique"] = true
	} else {
		d["isPrimaryKey"] = false
		d["isUnique"] = col.IsUnique
	}

	if col.Default != "" && isLiteralDefault(col.Default) {
		d["default_prob"] = defaultProb
		d["default"] = strings.TrimSpace(col.Default)
	}
	return d
}

var (
	simpleNum = regexp.MustCompile(`^[+-]?\d+(?:\.\d+)?$`)
	quotedStr = regexp.MustCompile(`^'.*'$`)
	boolLit   = regexp.MustCompile(`^(?i:true|false)$`)
)

// isLiteralDefault determines whether a column default expression is a
// simple literal that can be reproduced by the workload generator.
// Complex expressions are ignored.
func isLiteralDefault(expr string) bool {
	txt := strings.TrimSpace(strings.TrimRight(strings.TrimLeft(expr, "("), ")"))
	return simpleNum.MatchString(txt) ||
		quotedStr.MatchString(txt) ||
		boolLit.MatchString(txt)
}

// ddlToYamlCA converts the map of table schemas produced by ParseDDL into
// the YAML representation understood by the workload tooling. Each table
// is translated into a single YAML block describing columns, primary
// keys, foreign keys and unique constraints.
//
// dbName is the name of the target database used when generating
// canonical identifiers inside the YAML.
//
// Parameters:
//   - allSchemas: map of table names to their TableSchema definitions.
//   - dbName: name of the database to use for canonical identifiers in the YAML output.
//
// Returns the YAML string or an error if the conversion fails.
func ddlToYamlCA(allSchemas map[string]*TableSchema, dbName string) (string, error) {
	fanout := 10
	yamlDoc := map[string][]map[string]any{}
	colSeedMap := map[[2]string]int{}
	rng := rand.New(rand.NewSource(time.Now().UnixNano()))

	for tblName, schema := range allSchemas {
		//setting initial table level block structure
		block := map[string]any{
			"count":          10000,                       // default row count. can be parameterized later
			"sort-by":        []string{},                  // optional sort keys. isn't in use yet
			"pk":             schema.PrimaryKeys,          // primary key columns
			"columns":        map[string]map[string]any{}, // column metadata filled below
			"original_table": schema.OriginalTable,        // original table name as seen in DDL
			"column_order":   schema.ColumnOrder,          // preserve column ordering
			"table_number":   schema.TableNumber,          // ordering used by workload tooling
		}
		if len(schema.UniqueConstraints) > 0 {
			block["unique"] = schema.UniqueConstraints
		}
		cols := block["columns"].(map[string]map[string]any)
		// populate column definitions
		for _, c := range schema.Columns {
			colInfo := columnYAML(c, rng, 0.2)
			cols[c.Name] = colInfo
			// remember the RNG seed so that dependent columns can
			// reference it when setting parent_seed.
			seed, _ := colInfo["args"].(map[string]any)["seed"].(int)
			colSeedMap[[2]string{tblName, c.Name}] = seed
			//multiple key formats because variance in DDL
			two := "public__" + canonical(tblName)
			three := dbName + "__" + canonical(two)
			colSeedMap[[2]string{two, c.Name}] = seed
			colSeedMap[[2]string{three, c.Name}] = seed
		}

		if len(schema.ForeignKeys) > 0 {
			// fkIDs assigns a stable ID to each foreign key
			// constraint so that composite keys can share a
			// composite_id across columns.
			fkIDs := map[string]int{}
			nextID := 1
			for _, fk := range schema.ForeignKeys {
				local := fk[0].([]string)
				parent := fk[1].(string)
				foreign := fk[2].([]string)
				// Normalise the referenced table and create an
				// identifier used in the YAML.
				if !strings.Contains(parent, ".") {
					parent = "public." + parent
				}
				parentCanon := canonical(parent)
				key := parentCanon + "|" + strings.Join(foreign, ",")
				// Ensure a deterministic composite_id per FK.
				// Have stopped using composite ids for now, still keeping for possible reuse in the future.
				cid, ok := fkIDs[key]
				if !ok {
					cid = nextID
					fkIDs[key] = cid
					nextID++
				}
				// Annotate each local column with fk metadata.
				for i, lc := range local {
					pc := foreign[i]
					colMeta := cols[lc]
					if _, ok := colMeta["fk"]; !ok {
						colMeta["fk"] = fmt.Sprintf("%s.%s", parentCanon, pc)
						colMeta["hasForeignKey"] = true
					}
					// composite_id groups multi-column FKs.
					if len(local) > 1 {
						colMeta["composite_id"] = cid
					}
				}
			}
		}
		yamlDoc[canonical(tblName)] = []map[string]any{block}
	}

	// second pass: fill in fk_mode/fanout/parent_seed using the
	// column seeds captured above.
	for _, tbl := range yamlDoc {
		block := tbl[0]
		cols := block["columns"].(map[string]map[string]any)
		for name, meta := range cols {
			fkInfo, ok := meta["fk"].(string)
			if !ok {
				continue
			}
			parts := strings.SplitN(fkInfo, ".", 2)
			if len(parts) != 2 {
				continue
			}
			// Look up the parent's seed so child rows reference
			// the same pseudo-random stream
			seed, ok := colSeedMap[[2]string{parts[0], parts[1]}]
			if ok {
				if _, ok := meta["fk_mode"]; !ok {
					meta["fk_mode"] = "block"
				}
				if _, ok := meta["fanout"]; !ok {
					meta["fanout"] = fanout
				}
				if _, ok := meta["parent_seed"]; !ok {
					meta["parent_seed"] = seed
				}
			}
			cols[name] = meta
		}
	}
	// Reduce fanout to 1 when every primary key column is also a
	// foreign key.
	for _, tbl := range yamlDoc {
		block := tbl[0]
		cols := block["columns"].(map[string]map[string]any)
		allPkFK := true
		for _, pk := range block["pk"].([]string) {
			if val, ok := cols[pk]["hasForeignKey"].(bool); !ok || !val {
				allPkFK = false
				break
			}
		}
		if allPkFK {
			for _, meta := range cols {
				if val, ok := meta["hasForeignKey"].(bool); ok && val {
					meta["fanout"] = 1
				}
			}
		}
	}

	out, err := yaml.Marshal(yamlDoc)
	if err != nil {
		return "", err
	}
	return string(out), nil
}
