package bankPradyum

import (
	"context"
	gosql "database/sql"
	"fmt"
	"math/rand/v2"
	"strings"

	"github.com/cockroachdb/cockroach/pkg/util/timeutil"
	"github.com/cockroachdb/cockroach/pkg/workload"
	"github.com/cockroachdb/cockroach/pkg/workload/histogram"
	"github.com/cockroachdb/errors"
	"github.com/spf13/pflag"
)

const bankSchema = `(
	id   INT PRIMARY KEY,
	val  TEXT NOT NULL
)`

var RandomSeed = workload.NewUint64RandomSeed()

type bank struct {
	flags     workload.Flags
	connFlags *workload.ConnFlags
	rows      int
}

func init() { workload.Register(bankMeta) }

var bankMeta = workload.Meta{
	Name:        `bank_pradyum`,
	Description: `bank is a simple test workload`,
	Version:     `1.0.0`,
	RandomSeed:  RandomSeed,
	New: func() workload.Generator {
		g := &bank{}
		g.flags.FlagSet = pflag.NewFlagSet(`bank_pradyum`, pflag.ContinueOnError)
		g.flags.IntVar(&g.rows, `rows`, 1000, `Number of initial rows`)
		RandomSeed.AddFlag(&g.flags)
		g.connFlags = workload.NewConnFlags(&g.flags)
		return g
	},
}

// Meta implements the Generator interface.
func (*bank) Meta() workload.Meta { return bankMeta }

// Flags implements the Flagser interface.
func (g *bank) Flags() workload.Flags { return g.flags }

// ConnFlags implements the ConnFlagser interface.
func (g *bank) ConnFlags() *workload.ConnFlags { return g.connFlags }

// Hooks implements the Hookser interface.
func (g *bank) Hooks() workload.Hooks {
	// No validation hooks in this minimal workload.
	return workload.Hooks{}
}

// Tables implements the Generator interface.
func (g *bank) Tables() []workload.Table {
	table := workload.Table{
		Name:   `bank`,
		Schema: bankSchema,
		InitialRows: workload.Tuples(
			g.rows,
			func(rowIdx int) []interface{} {
				return []interface{}{rowIdx, fmt.Sprintf("value-%d", rowIdx)}
			},
		),
	}
	return []workload.Table{table}
}

// Ops implements the Opser interface.
func (g *bank) Ops(
	ctx context.Context, urls []string, reg *histogram.Registry,
) (workload.QueryLoad, error) {
	db, err := gosql.Open(`cockroach`, strings.Join(urls, ` `))
	if err != nil {
		return workload.QueryLoad{}, err
	}
	db.SetMaxOpenConns(g.connFlags.Concurrency + 1)
	db.SetMaxIdleConns(g.connFlags.Concurrency + 1)

	readStmt, err := db.Prepare(`SELECT val FROM bank WHERE id = $1`)
	if err != nil {
		return workload.QueryLoad{}, errors.CombineErrors(err, db.Close())
	}
	insertStmt, err := db.Prepare(`INSERT INTO bank (id, val) VALUES ($1, $2)`)
	if err != nil {
		return workload.QueryLoad{}, errors.CombineErrors(err, db.Close())
	}

	ql := workload.QueryLoad{
		Close: func(_ context.Context) error { return db.Close() },
	}
	for i := 0; i < g.connFlags.Concurrency; i++ {
		rng := rand.New(rand.NewPCG(RandomSeed.Seed(), uint64(i)))
		hists := reg.GetHandle()
		ql.WorkerFns = append(ql.WorkerFns, func(ctx context.Context) error {
			id := rng.IntN(g.rows)
			if rng.Float32() < 0.5 {
				start := timeutil.Now()
				_, err := readStmt.Exec(id)
				hists.Get(`read`).Record(timeutil.Since(start))
				return err
			}
			val := fmt.Sprintf("val-%d", id)
			start := timeutil.Now()
			_, err := insertStmt.Exec(id, val)
			hists.Get(`insert`).Record(timeutil.Since(start))
			return err
		})
	}
	return ql, nil
}
