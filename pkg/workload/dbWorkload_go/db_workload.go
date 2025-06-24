package dbworkloadgo

import (
	"context"
	gosql "database/sql"
	"github.com/cockroachdb/cockroach/pkg/col/coldata"
	"github.com/cockroachdb/cockroach/pkg/sql/types"
	"github.com/cockroachdb/cockroach/pkg/util/bufalloc"
	"github.com/cockroachdb/cockroach/pkg/workload"
	"github.com/cockroachdb/cockroach/pkg/workload/histogram"
	"github.com/cockroachdb/errors"
	"github.com/spf13/pflag"
	"math/rand/v2"
	"os"
	"strings"
)

const (
	// Length of each field
	fieldLength = 100
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

	allSchema        map[string]TableSchema
	yamlFileLocation string

	// Number of rows in the usertable
	rowCount int
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
			if s.dbName != "" {
				dbName = s.dbName
			}
			debug := s.debugZip
			schemas, errDDL := GenerateDDLs(debug, dbName, "/Users/pradyumagarwal/go/src/github.com/cockroachdb/cockroach/pkg/workload/dbWorkload_go", "test_schema.ddl", false)
			yamlOut, errYaml := ddlToYamlCA(schemas, dbName)
			if errDDL != nil {
				return errors.Wrap(errDDL, "failed to generate DDLs")
			}
			// and similarly for errYaml
			if errYaml != nil {
				return errors.Wrap(errYaml, "failed converting DDL to YAML")
			}
			//print the yaml for now
			err := os.WriteFile("/Users/pradyumagarwal/go/src/github.com/cockroachdb/cockroach/pkg/workload/dbWorkload_go/test_output.yaml", []byte(yamlOut), 0644)
			if err != nil {
				return err
			}
			return nil
		},
	}
}

func (s *dbworkload) Tables() []workload.Table {
	tables := make([]workload.Table, 0)
	for tableNme, tableSchema := range s.allSchema {
		tables = append(tables, workload.Table{
			Name:   tableNme,
			Schema: generateTableSchema(tableSchema),
			InitialRows: workload.BatchedTuples{
				NumBatches: tableSchema.rowCount,
				FillBatch:  generateBatch(tableNme, tableSchema, s.yamlFileLocation),
			},
		})

	}
	return tables
}

func generateTableSchema(tableSchema TableSchema) string {
	builder := strings.Builder{}
	builder.WriteString("(\n")
	for columnName, column := range tableSchema.Columns {
		builder.WriteString("    ")
		builder.WriteString(columnName)
		builder.WriteString(" ")
		builder.WriteString(column.ColType)
		if column.IsPrimaryKey {
			builder.WriteString(" PRIMARY KEY")
		}
		if column.IsNullable {
			builder.WriteString(" NULL")
		} else {
			builder.WriteString(" NOT NULL")
		}
		builder.WriteString(",\n")
	}
	builder.WriteString(")\n")
	return builder.String()
}

func generateBatch(
	tableName string, schema TableSchema, yamlFile string,
) func(int, coldata.Batch, *bufalloc.ByteAllocator) {
	return func(batchIdx int, cb coldata.Batch, _ *bufalloc.ByteAllocator) {
		rng := rand.New(rand.NewPCG(0, uint64(batchIdx)))

		cb.Reset(simpleTableTypes, 1, coldata.StandardColumnFactory)

		id := cb.ColVec(0).Int64()
		field1 := cb.ColVec(1).Bytes()
		field2 := cb.ColVec(2).Bytes()
		field3 := cb.ColVec(3).Bytes()

		// Reset bytes columns
		field1.Reset()
		field2.Reset()
		field3.Reset()

		id[0] = int64(batchIdx)

		field1.Set(0, randString(rng, fieldLength))
		field2.Set(0, randString(rng, fieldLength))
		field3.Set(0, randString(rng, fieldLength))
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
	const letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
	result := make([]byte, length)
	for i := range result {
		result[i] = letters[rng.IntN(len(letters))]
	}
	return result
}
