package workload_generator

import (
	"context"
	"database/sql"
	gosql "database/sql"
	"fmt"
	"github.com/cockroachdb/cockroach-go/v2/crdb"
	"github.com/cockroachdb/cockroach/pkg/col/coldata"
	"github.com/cockroachdb/cockroach/pkg/sql/types"
	"github.com/cockroachdb/cockroach/pkg/util/bufalloc"
	"github.com/cockroachdb/cockroach/pkg/util/timeutil"
	"github.com/cockroachdb/cockroach/pkg/workload"
	"github.com/cockroachdb/cockroach/pkg/workload/histogram"
	"github.com/cockroachdb/errors"
	"github.com/lib/pq"
	"github.com/spf13/pflag"
	"gopkg.in/yaml.v3"
	"math/rand/v2"
	"os"
	"strconv"
	"strings"
	"sync"
	"time"
)

// runtimeColumn holds a generator and a cache of prior values.
type runtimeColumn struct {
	gen        Generator
	mu         sync.Mutex // protects gen and cache
	cache      []string   // ring buffer of recent values
	columnMeta ColumnMeta // metadata for this column
}

const (
	// Length of each field
	fieldLength   = 100
	baseBatchSize = 100
	maxCacheSize  = 100_000 // max size of the cache for each column
)

var simpleTableTypes = []*types.T{
	types.Int, types.String, types.String, types.String,
}

func init() {
	workload.Register(dbworkloadMeta)
}

var dbworkloadMeta = workload.Meta{
	Name:        "workload_generator",
	Description: "dbworkload tries to generate workloads from debug zip",
	Version:     "1.0.0",
	New: func() workload.Generator {
		g := &dbworkload{}
		g.flags.FlagSet = pflag.NewFlagSet("db_workload", pflag.ContinueOnError)
		g.flags.StringVar(&g.debugZip, "debug-zip", "",
			"path to unzipped debug zip")
		g.flags.StringVar(&g.dbName, "db-name", "", "database name")
		g.flags.IntVar(&g.rowCount, "rows", 1000,
			"base number of rows per table before FK‐depth scaling")
		g.flags.Meta = map[string]workload.FlagMeta{}
		g.connFlags = workload.NewConnFlags(&g.flags)
		return g
	},
}

type dbworkload struct {
	flags     workload.Flags
	connFlags *workload.ConnFlags
	debugZip  string
	dbName    string
	rowCount  int

	allSchema      map[string]*TableSchema
	createStmts    map[string]string
	workloadSchema Schema
	yamlFile       string
	columnGens     map[string]*runtimeColumn // table.col → runtimeColumn

}

// Meta implements the Generator interface.
func (*dbworkload) Meta() workload.Meta { return dbworkloadMeta }

// Flags implements the Flagser interface.
func (s *dbworkload) Flags() workload.Flags {
	return workload.Flags{
		FlagSet: s.flags.FlagSet,
	}
}

// ConnFlags implements the ConnFlagser interface.
func (s *dbworkload) ConnFlags() *workload.ConnFlags {
	return s.connFlags
}

func (s *dbworkload) Hooks() workload.Hooks {
	return workload.Hooks{
		PreCreate: func(db *gosql.DB) error {
			// TODO:
			// 1. generate the DDLs
			// 2.

			// Example of how to access the --db flag value:
			// The --db flag value is stored in the DBOverride field of the connFlags struct.
			// If this field is not empty, it should be used as the database name;
			// otherwise, the default database name (which is the generator's name) should be used.
			//
			// For example:
			// dbName := s.Meta().Name
			// if s.connFlags.DBOverride != "" {
			//     dbName = s.connFlags.DBOverride
			// }
			// Now dbName would contain the value of the --db flag, or the default if not specified
			dbName := s.Meta().Name
			//if s.dbName != "" {
			//	dbName = s.dbName
			//}
			if s.connFlags.DBOverride != "" {
				dbName = s.connFlags.DBOverride
			}
			debug := s.debugZip
			schemas, createStmts, errDDL := GenerateDDLs(debug, dbName, false)
			s.allSchema = schemas
			s.createStmts = createStmts
			//yamlOut, errYaml := ddlToYamlCA(schemas, dbName)
			//s.yamlFile = yamlOut
			if errDDL != nil {
				return errors.Wrap(errDDL, "failed to generate DDLs")
			}
			// and similarly for errYaml
			//if errYaml != nil {
			//	return errors.Wrap(errYaml, "failed converting DDL to YAML")
			//}
			//print the yaml for now
			s.workloadSchema = buildWorkloadSchema(s.allSchema, dbName, s.rowCount)
			data, err := yaml.Marshal(s.workloadSchema)
			if err != nil {
				return errors.Wrap(err, "couldn't marshal workload schema to YAML")
			}
			if err := os.WriteFile("schema.yaml", data, 0644); err != nil {
				return errors.Wrap(err, "couldn't write schema.yaml")
			}
			//err := os.WriteFile("/Users/pradyumagarwal/go/src/github.com/cockroachdb/cockroach/pkg/workload/workload_generator/test_output.yaml", []byte(yamlOut), 0644)
			//if err != nil {
			//	return err
			//}
			return nil
		},
	}
}

// Tables implements workload.Generator.Tables
func (d *dbworkload) Tables() []workload.Table {
	// 1) Load the YAML schema once

	tableOrder := getTableOrder(d.workloadSchema)
	maxRows := 0
	for _, tblBlocks := range d.workloadSchema {
		if tblBlocks[0].Count > maxRows {
			maxRows = tblBlocks[0].Count
		}
	}
	globalNumBatches := (maxRows + baseBatchSize - 1) / baseBatchSize
	var tables []workload.Table
	for _, tableName := range tableOrder {
		blocks := d.workloadSchema[tableName]
		block := blocks[0]
		total := block.Count
		batch_size_i := total / globalNumBatches

		tables = append(tables, workload.Table{
			Name:   tableName,
			Schema: generateSchema(d.createStmts[tableName]), // your short DDL string
			InitialRows: workload.BatchedTuples{
				NumBatches: globalNumBatches,
				FillBatch:  generateBatch(tableName, block, d.workloadSchema, batch_size_i, d),
			},
		})
	}
	return tables
}

func getTableOrder(rawSchema Schema) []string {
	tableOrder := make([]string, len(rawSchema))
	for tableName, blocks := range rawSchema {
		block := blocks[0]
		tableOrder[block.TableNumber] = tableName
	}
	return tableOrder
}

func generateSchema(createStmt string) string {
	// find the first '('
	start := strings.Index(createStmt, "(")
	if start < 0 {
		return "" // or panic/empty, as you prefer
	}
	// walk forward, counting nested parens until we close the top‐level one
	depth := 0
	var end int
	for i := start; i < len(createStmt); i++ {
		switch createStmt[i] {
		case '(':
			depth++
		case ')':
			depth--
			if depth == 0 {
				end = i
				// once we've closed the top‐level '(', we're done
				return createStmt[start : end+1]
			}
		}
	}
	// if we get here, the DDL was malformed (unbalanced parens)
	return createStmt[start:]
}

// generateBatch returns the FillBatch func for one table
func generateBatch(
	tableName string,
	block TableBlock,
	fullSchema Schema,
	batchSize int,
	d *dbworkload,
) func(batchIdx int, cb coldata.Batch, _ *bufalloc.ByteAllocator) {
	// determine the Cockroach columnar types and a stable column order
	colOrder := block.ColumnOrder
	// build Cockroach types in that order:
	cdTypes := make([]*types.T, len(colOrder))
	for i, colName := range colOrder {
		meta := block.Columns[colName]
		switch meta.Type {
		case "integer", "sequence":
			cdTypes[i] = types.Int
		case "float":
			cdTypes[i] = types.Float
		default:
			cdTypes[i] = types.Bytes
		}
	}

	return func(batchIdx int, cb coldata.Batch, _ *bufalloc.ByteAllocator) {
		total := block.Count
		start := batchIdx * batchSize
		end := start + batchSize
		if end > total {
			end = total
		}
		n := end - start

		// reset the vector; n rows, cdTypes[i] per column
		cb.Reset(cdTypes, n, coldata.StandardColumnFactory)

		// 2) instantiate one Generator per column, seeded by batchIdx
		gens := make([]Generator, len(colOrder))
		for i, colName := range colOrder {
			meta := block.Columns[colName]
			gens[i] = makeGenerator(meta, batchIdx, baseBatchSize, fullSchema)
		}

		// 3) fill row-by-row
		for row := 0; row < n; row++ {
			for i, cdType := range cdTypes {
				raw := gens[i].Next()

				key := fmt.Sprintf("%s", colOrder[i])
				if rc, ok := d.columnGens[key]; ok {
					rc.mu.Lock()
					if len(rc.cache) < maxCacheSize {
						rc.cache = append(rc.cache, raw)
					} else {
						rc.cache[rand.IntN(len(rc.cache))] = raw
					}
					rc.mu.Unlock()
				}
				vec := cb.ColVec(i)
				nulls := vec.Nulls()
				if raw == "" {
					nulls.SetNull(row)
					continue
				}
				switch cdType.Family() {
				case types.IntFamily:
					// sequences & integers
					iv, err := strconv.ParseInt(raw, 10, 64)
					if err != nil {
						panic(fmt.Sprintf("parse int: %v", err))
					}
					vec.Int64()[row] = iv

				case types.FloatFamily:
					fv, err := strconv.ParseFloat(raw, 64)
					if err != nil {
						panic(fmt.Sprintf("parse float: %v", err))
					}
					vec.Float64()[row] = fv

				default:
					// strings, json, uuid, timestamp → bytes
					bytesVec := vec.Bytes()
					bytesVec.Set(row, []byte(raw))
				}
			}
		}
	}
}

// initGenerators seeds d.columnGens with both fresh generators and a cache
// of real values pulled from the live database.
func (d *dbworkload) initGenerators(db *sql.DB) error {
	// 1) Build the generator + empty cache for every table.col
	d.columnGens = make(map[string]*runtimeColumn)
	for _, blocks := range d.workloadSchema {
		block := blocks[0]
		for colName, meta := range block.Columns {
			key := fmt.Sprintf("%s", colName)
			gen := makeGenerator(meta, block.Count/baseBatchSize, baseBatchSize, d.workloadSchema)
			d.columnGens[key] = &runtimeColumn{
				gen:        gen,
				cache:      make([]string, 0, maxCacheSize),
				columnMeta: meta,
			}
		}
	}

	// 2) Prime each cache by selecting up to maxInitialCacheSize existing rows.
	//    We do this column-by-column to keep it simple.
	for tableName, blocks := range d.workloadSchema {
		block := blocks[0]
		for _, colName := range block.ColumnOrder {
			key := fmt.Sprintf("%s", colName)
			rc := d.columnGens[key]

			// build a query like: SELECT colName FROM tableName LIMIT maxInitialCacheSize
			q := fmt.Sprintf(`SELECT %s FROM %s LIMIT %d`,
				pq.QuoteIdentifier(colName), pq.QuoteIdentifier(tableName), maxCacheSize)
			rows, err := db.QueryContext(context.Background(), q)
			if err != nil {
				return fmt.Errorf("priming cache for %s: %w", key, err)
			}

			for rows.Next() {
				var raw sql.NullString
				if err := rows.Scan(&raw); err != nil {
					rows.Close()
					return fmt.Errorf("scanning cache row for %s: %w", key, err)
				}
				if raw.Valid {
					rc.cache = append(rc.cache, raw.String)
				}
				if len(rc.cache) >= maxCacheSize {
					break
				}
			}
			rows.Close()
		}
	}

	return nil
}

func (d *dbworkload) Ops(
	ctx context.Context, urls []string, reg *histogram.Registry,
) (workload.QueryLoad, error) {
	raw, err := os.ReadFile("schema.yaml")
	if err != nil {
		return workload.QueryLoad{}, errors.Wrap(err, "couldn't read schema.yaml")
	}
	if err := yaml.Unmarshal(raw, &d.workloadSchema); err != nil {
		return workload.QueryLoad{}, errors.Wrap(err, "couldn't unmarshal schema.yaml")
	}
	// Parse transactions from the tpcc file.
	txns, err := ReadTPCC("pkg/workload/workload_generator/tpcc.sql")
	if err != nil {
		return workload.QueryLoad{}, err
	}

	db, err := gosql.Open("postgres", strings.Join(urls, " "))
	if err != nil {
		return workload.QueryLoad{}, err
	}
	db.SetMaxOpenConns(d.connFlags.Concurrency + 1)
	db.SetMaxIdleConns(d.connFlags.Concurrency + 1)

	if err := d.initGenerators(db); err != nil {
		return workload.QueryLoad{}, err
	}

	ql := workload.QueryLoad{}
	for i := 0; i < d.connFlags.Concurrency; i++ {
		worker := &txnWorker{
			db:    db,
			txns:  txns,
			rng:   rand.New(rand.NewPCG(uint64(time.Now().UnixNano()), uint64(i))),
			hists: reg.GetHandle(),
			d:     d, // reference to the dbworkload for generators
		}
		ql.WorkerFns = append(ql.WorkerFns, worker.run)
	}
	ql.Close = func(context.Context) error { return db.Close() }
	return ql, nil
}

// getValueSmart picks values from the generator or cache.
func (d *dbworkload) getValueSmart(p Placeholder, idx int) string {
	key := fmt.Sprintf("%s", p.Name)
	//fmt.Printf("looking for key: %s\n", key)
	rc := d.columnGens[key]
	rc.mu.Lock()
	defer rc.mu.Unlock()

	// choose old or new depending on clause.
	if p.Clause == "WHERE" || rc.columnMeta.HasForeignKey == true {
		if len(rc.cache) > 0 {
			return rc.cache[idx]
		}
	}
	v := rc.gen.Next()
	if len(rc.cache) < maxCacheSize {
		rc.cache = append(rc.cache, v)
	} else {
		rc.cache[rand.IntN(len(rc.cache))] = v
	}
	return v
}

type txnWorker struct {
	db    *gosql.DB
	txns  []Transaction
	rng   *rand.Rand
	hists *histogram.Histograms
	d     *dbworkload // reference to the dbworkload for generators
}

func (w *txnWorker) run(ctx context.Context) error {
	idx := w.rng.IntN(len(w.txns))
	txn := w.txns[idx]
	d := w.d // reference to the dbworkload for generators
	start := timeutil.Now()
	err := crdb.ExecuteTx(ctx, w.db, nil, func(tx *gosql.Tx) error {
		for _, q := range txn.Queries {
			args := make([]interface{}, len(q.Placeholders))
			// 1) pick a single fkIdx for ALL FK placeholders (or -1 if none)
			fkIdx := -1
			for _, p := range q.Placeholders {
				if w.d.columnGens[p.Name].columnMeta.HasForeignKey {
					cacheLen := len(w.d.columnGens[p.Name].cache)
					if cacheLen > 0 {
						fkIdx = w.rng.IntN(cacheLen)
					}
					break
				}
			}

			// 2) build per-placeholder indexes
			indexes := make([]int, len(q.Placeholders))
			for i, p := range q.Placeholders {
				if w.d.columnGens[p.Name].columnMeta.HasForeignKey {
					indexes[i] = fkIdx
				} else {
					cacheLen := len(w.d.columnGens[p.Name].cache)
					indexes[i] = w.rng.IntN(cacheLen)
				}
			}
			for i, p := range q.Placeholders {
				raw := d.getValueSmart(p, indexes[i])
				var arg interface{}

				// If we got an empty string and this column is nullable, emit a SQL NULL.
				if raw == "" && p.IsNullable {
					switch t := strings.ToUpper(p.ColType); {
					case strings.HasPrefix(t, "INT"):
						arg = sql.NullInt64{Valid: false}
					case strings.HasPrefix(t, "FLOAT"), strings.HasPrefix(t, "DECIMAL"), strings.HasPrefix(t, "NUMERIC"), strings.HasPrefix(t, "DOUBLE"):
						arg = sql.NullFloat64{Valid: false}
					case t == "BOOL", t == "BOOLEAN":
						arg = sql.NullBool{Valid: false}
					default:
						arg = sql.NullString{Valid: false}
					}
				} else {
					// Otherwise parse the raw string into the right Go/sql type
					switch t := strings.ToUpper(p.ColType); {
					case strings.HasPrefix(t, "INT"):
						iv, err := strconv.ParseInt(raw, 10, 64)
						if err != nil {
							return err
						}
						arg = sql.NullInt64{Int64: iv, Valid: true}

					case strings.HasPrefix(t, "FLOAT"), strings.HasPrefix(t, "DECIMAL"), strings.HasPrefix(t, "NUMERIC"), strings.HasPrefix(t, "DOUBLE"):
						fv, err := strconv.ParseFloat(raw, 64)
						if err != nil {
							return err
						}
						arg = sql.NullFloat64{Float64: fv, Valid: true}

					case t == "BOOL", t == "BOOLEAN":
						bv, err := strconv.ParseBool(raw)
						if err != nil {
							return err
						}
						arg = sql.NullBool{Bool: bv, Valid: true}

					default:
						// treat everything else as text/varchar/etc.
						arg = sql.NullString{String: raw, Valid: raw != ""}
					}
				}

				args[i] = arg
			}

			if _, err := tx.ExecContext(ctx, q.SQL, args...); err != nil {
				return err
			}
		}
		return nil
	})
	elapsed := timeutil.Since(start)
	w.hists.Get(fmt.Sprintf("txn_%d", idx)).Record(elapsed)
	return err
}
