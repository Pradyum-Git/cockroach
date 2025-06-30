package workload_generator

import (
	"context"
	gosql "database/sql"
	"fmt"
	"github.com/cockroachdb/cockroach/pkg/col/coldata"
	"github.com/cockroachdb/cockroach/pkg/sql/types"
	"github.com/cockroachdb/cockroach/pkg/util/bufalloc"
	"github.com/cockroachdb/cockroach/pkg/workload"
	"github.com/cockroachdb/cockroach/pkg/workload/histogram"
	"github.com/cockroachdb/errors"
	"github.com/spf13/pflag"
	"math/rand/v2"
	"strconv"
	"strings"
)

const (
	// Length of each field
	fieldLength   = 100
	baseBatchSize = 100
)

var simpleTableTypes = []*types.T{
	types.Int, types.String, types.String, types.String,
}

func init() {
	workload.Register(dbworkloadMeta)
}

var dbworkloadMeta = workload.Meta{
	Name:        "db_workload",
	Description: "dbworklaod tries to generate workloads from debig zip",
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
			//err := os.WriteFile("/Users/pradyumagarwal/go/src/github.com/cockroachdb/cockroach/pkg/workload/workload_generator/test_output.yaml", []byte(yamlOut), 0644)
			//if err != nil {
			//	return err
			//}
			return nil
		},
	}
}

// Tables implements workload.Generator.Tables
func (s *dbworkload) Tables() []workload.Table {
	// 1) Load the YAML schema once

	tableOrder := getTableOrder(s.workloadSchema)
	maxRows := 0
	for _, tblBlocks := range s.workloadSchema {
		if tblBlocks[0].Count > maxRows {
			maxRows = tblBlocks[0].Count
		}
	}
	globalNumBatches := (maxRows + baseBatchSize - 1) / baseBatchSize
	var tables []workload.Table
	for _, tableName := range tableOrder {
		blocks := s.workloadSchema[tableName]
		block := blocks[0]
		total := block.Count
		batch_size_i := total / globalNumBatches

		tables = append(tables, workload.Table{
			Name:   tableName,
			Schema: generateSchema(s.createStmts[tableName]), // your short DDL string
			InitialRows: workload.BatchedTuples{
				NumBatches: globalNumBatches,
				FillBatch:  generateBatch(tableName, block, s.workloadSchema, batch_size_i),
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

func (s *dbworkload) Ops(
	ctx context.Context, urls []string, reg *histogram.Registry,
) (workload.QueryLoad, error) {
	sqlDatabase, err := gosql.Open("postgres", urls[0])
	if err != nil {
		return workload.QueryLoad{}, err
	}

	db := sqlDatabase

	readStmt, err := db.Prepare("SELECT field1, field2, field3 FROM simple WHERE id = $1")
	if err != nil {
		return workload.QueryLoad{}, err
	}

	updateStmt, err := db.Prepare("UPDATE simple SET field1 = $1, field2 = $2, field3 = $3 WHERE id = $4")
	if err != nil {
		return workload.QueryLoad{}, err
	}

	ql := workload.QueryLoad{
		WorkerFns: make([]func(context.Context) error, 8),
	}
	initialRowCount := int64(10)
	for i := range ql.WorkerFns {
		workerID := i
		rng := rand.New(rand.NewPCG(uint64(workerID), 0))
		ql.WorkerFns[i] = func(ctx context.Context) error {
			// 50% reads, 50% updates
			if rng.IntN(2) == 0 {
				// Read operation
				id := rng.Int64N(initialRowCount)
				var field1, field2, field3 string
				if err := readStmt.QueryRowContext(ctx, id).Scan(&field1, &field2, &field3); err != nil {
					return err
				}
			} else {
				// Update operation
				id := rng.Int64N(initialRowCount)
				field1 := randString(rng, fieldLength)
				field2 := randString(rng, fieldLength)
				field3 := randString(rng, fieldLength)
				if _, err := updateStmt.ExecContext(ctx, field1, field2, field3, id); err != nil {
					return err
				}
			}
			return nil
		}
	}

	// Close statements and database when the workload finishes
	ql.Close = func(context.Context) error {
		readStmt.Close()
		updateStmt.Close()
		return sqlDatabase.Close()
	}

	return ql, nil
}

func randString(rng *rand.Rand, length int) []byte {
	const letters = alphaLetters
	result := make([]byte, length)
	for i := range result {
		result[i] = letters[rng.IntN(len(letters))]
	}
	return result
}
