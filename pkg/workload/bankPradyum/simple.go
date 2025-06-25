// Copyright 2023 The Cockroach Authors.
//
// Use of this software is governed by the Business Source License
// included in the file licenses/BSL.txt.
//
// As of the Change Date specified in that file, in accordance with
// the Business Source License, use of this software will be governed
// by the Apache License, Version 2.0, included in the file
// licenses/APL.txt.

// Package simple implements a simple workload similar to YCSB but with no flags.
package bankPradyum

import (
	"context"
	gosql "database/sql"
	"math/rand/v2"
	"strings"

	"github.com/cockroachdb/cockroach/pkg/col/coldata"
	"github.com/cockroachdb/cockroach/pkg/sql/types"
	"github.com/cockroachdb/cockroach/pkg/util/bufalloc"
	"github.com/cockroachdb/cockroach/pkg/workload"
	"github.com/cockroachdb/cockroach/pkg/workload/histogram"
	"github.com/spf13/pflag"
)

const (
	// Length of each field
	fieldLength = 100
)

var simpleTableTypes = []*types.T{
	types.Int, types.String, types.String, types.String,
}

func init() {
	workload.Register(simpleMeta)
}

var simpleMeta = workload.Meta{
	Name:        "simple",
	Description: "Simple is a basic workload similar to YCSB but with no flags",
	Version:     "1.0.0",
	New: func() workload.Generator {
		g := &simple{}
		g.flags.FlagSet = pflag.NewFlagSet(`simple`, pflag.ContinueOnError)
		g.flags.Meta = map[string]workload.FlagMeta{}
		g.connFlags = workload.NewConnFlags(&g.flags)
		return g
	},
}

type Column struct {
	name         string
	colType      string
	isNull       bool
	isPrimaryKey bool
}
type TableSchema struct {
	tableName string
	rowCount  int
	columns   map[string]Column
}

// simple implements the Generator interface.
type simple struct {
	flags     workload.Flags
	connFlags *workload.ConnFlags

	allSchema        map[string]TableSchema
	yamlFileLocation string

	// Number of rows in the usertable
	rowCount int
}

// Meta implements the Generator interface.
func (*simple) Meta() workload.Meta { return simpleMeta }

// Flags implements the Flagser interface.
func (s *simple) Flags() workload.Flags {
	return workload.Flags{
		FlagSet: s.flags.FlagSet,
	}
}

// ConnFlags implements the ConnFlagser interface.
func (s *simple) ConnFlags() *workload.ConnFlags {
	return s.connFlags
}

func (s *simple) Hooks() workload.Hooks {
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

			return nil
		},
	}
}

// Tables implements the Generator interface.
func (s *simple) Tables() []workload.Table {
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
	for columnName, column := range tableSchema.columns {
		builder.WriteString("    ")
		builder.WriteString(columnName)
		builder.WriteString(" ")
		builder.WriteString(column.colType)
		if column.isPrimaryKey {
			builder.WriteString(" PRIMARY KEY")
		}
		if column.isNull {
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

// Ops implements the Opser interface.
func (s *simple) Ops(
	ctx context.Context, urls []string, reg *histogram.Registry,
) (workload.QueryLoad, error) {
	//sqlDatabase, err := gosql.Open("postgres", urls[0])
	//if err != nil {
	//	return workload.QueryLoad{}, err
	//}
	//
	//db := sqlDatabase
	//
	//readStmt, err := db.Prepare(`SELECT field1, field2, field3 FROM simple WHERE id = $1`)
	//if err != nil {
	//	return workload.QueryLoad{}, err
	//}
	//
	//updateStmt, err := db.Prepare(`UPDATE simple SET field1 = $1, field2 = $2, field3 = $3 WHERE id = $4`)
	//if err != nil {
	//	return workload.QueryLoad{}, err
	//}
	//
	//ql := workload.QueryLoad{
	//	WorkerFns: make([]func(context.Context) error, 8),
	//}
	//
	//for i := range ql.WorkerFns {
	//	workerID := i
	//	rng := rand.New(rand.NewPCG(uint64(workerID), 0))
	//	ql.WorkerFns[i] = func(ctx context.Context) error {
	//		// 50% reads, 50% updates
	//		if rng.IntN(2) == 0 {
	//			// Read operation
	//			id := rng.Int64N(initialRowCount)
	//			var field1, field2, field3 string
	//			if err := readStmt.QueryRowContext(ctx, id).Scan(&field1, &field2, &field3); err != nil {
	//				return err
	//			}
	//		} else {
	//			// Update operation
	//			id := rng.Int64N(initialRowCount)
	//			field1 := randString(rng, fieldLength)
	//			field2 := randString(rng, fieldLength)
	//			field3 := randString(rng, fieldLength)
	//			if _, err := updateStmt.ExecContext(ctx, field1, field2, field3, id); err != nil {
	//				return err
	//			}
	//		}
	//		return nil
	//	}
	//}
	//
	//// Close statements and database when the workload finishes
	//ql.Close = func(context.Context) error {
	//	readStmt.Close()
	//	updateStmt.Close()
	//	return sqlDatabase.Close()
	//}

	//return ql, nil
	return workload.QueryLoad{}, nil
}

// randString generates a random string of the specified length.
func randString(rng *rand.Rand, length int) []byte {
	const letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
	result := make([]byte, length)
	for i := range result {
		result[i] = letters[rng.IntN(len(letters))]
	}
	return result
}
