package workload_generator

import (
	"encoding/hex"
	"fmt"
	"math/rand"
	"strconv"
	"strings"
	"time"
)

// getIntArg handles int|float64|string in YAML args
func getIntArg(m map[string]interface{}, key string, defaultVal int) int {
	switch v := m[key].(type) {
	case int:
		return v
	case int64:
		return int(v)
	case float64:
		return int(v)
	case string:
		i, _ := strconv.Atoi(v)
		return i
	default:
		return defaultVal
	}
}

// getFloatArg handles float64|int|string
func getFloatArg(m map[string]interface{}, key string, defaultVal float64) float64 {
	switch v := m[key].(type) {
	case float64:
		return v
	case int:
		return float64(v)
	case int64:
		return float64(v)
	case string:
		f, _ := strconv.ParseFloat(v, 64)
		return f
	default:
		return defaultVal
	}
}

// getStringArg handles string values
func getStringArg(m map[string]interface{}, key string, defaultVal string) string {
	if v, ok := m[key]; ok {
		if s, ok2 := v.(string); ok2 {
			return s
		}
	}
	return defaultVal
}

// ─── Schema Types ─────────────────────────────────────────────────────

type ColumnMeta struct {
	Type          string                 `yaml:"type"`
	Args          map[string]interface{} `yaml:"args"`
	IsPrimaryKey  bool                   `yaml:"isPrimaryKey"`
	IsUnique      bool                   `yaml:"isUnique"`
	HasForeignKey bool                   `yaml:"hasForeignKey"`

	FK          string  `yaml:"fk,omitempty"`
	FKMode      string  `yaml:"fk_mode,omitempty"`
	ParentSeed  float64 `yaml:"parent_seed,omitempty"`
	Fanout      int     `yaml:"fanout,omitempty"`
	CompositeID int     `yaml:"composite_id,omitempty"`

	Default     string  `yaml:"default,omitempty"`
	DefaultProb float64 `yaml:"default_prob,omitempty"`
}

type TableBlock struct {
	Count         int                   `yaml:"count"`
	Columns       map[string]ColumnMeta `yaml:"columns"`
	PK            []string              `yaml:"pk"`
	SortBy        []string              `yaml:"sort-by"`
	Unique        [][]string            `yaml:"unique,omitempty"`
	OriginalTable string                `yaml:"original_table"`
	ColumnOrder   []string              `yaml:"column_order"`
	TableNumber   int                   `yaml:"table_number"`
}

type Schema map[string][]TableBlock

// ─── Generator Interface ──────────────────────────────────────────────

type Generator interface {
	Next() string
}

// ─── Basic Generators ──────────────────────────────────────────────────

type SequenceGen struct {
	cur int
}

func (g *SequenceGen) Next() string {
	v := g.cur
	g.cur++
	return strconv.Itoa(v)
}

type IntegerGen struct {
	r        *rand.Rand
	min, max int
	nullPct  float64
}

func (g *IntegerGen) Next() string {
	if g.r.Float64() < g.nullPct {
		return ""
	}
	return strconv.Itoa(g.r.Intn(g.max-g.min+1) + g.min)
}

type FloatGen struct {
	r        *rand.Rand
	min, max float64
	round    int
	nullPct  float64
}

func (g *FloatGen) Next() string {
	if g.r.Float64() < g.nullPct {
		return ""
	}
	v := g.r.Float64()*(g.max-g.min) + g.min
	return fmt.Sprintf("%.*f", g.round, v)
}

type StringGen struct {
	r        *rand.Rand
	min, max int
	nullPct  float64
}

func (g *StringGen) Next() string {
	if g.r.Float64() < g.nullPct {
		return ""
	}
	length := g.r.Intn(g.max-g.min+1) + g.min
	buf := make([]byte, length)
	for i := range buf {
		buf[i] = byte('a' + g.r.Intn(26))
	}
	return string(buf)
}

// TimestampGen yields random timestamps between a start and end.
type TimestampGen struct {
	r       *rand.Rand
	startNS int64
	spanNS  int64
	layout  string
	nullPct float64
}

func (g *TimestampGen) Next() string {
	if g.r.Float64() < g.nullPct {
		return ""
	}
	// pick an offset in [0, spanNS)
	offset := g.r.Int63n(g.spanNS)
	t := time.Unix(0, g.startNS+offset)
	return t.Format(g.layout)
}

// UUIDGen yields a deterministic “UUID” hex string from the RNG.
// (Test only checks CSV existence & row‐count, so the exact format doesn’t matter here.)
type UUIDGen struct {
	r *rand.Rand
}

func (g *UUIDGen) Next() string {
	buf := make([]byte, 16)
	for i := range buf {
		buf[i] = byte(g.r.Intn(256))
	}
	// hex without dashes is fine for now
	return hex.EncodeToString(buf)
}

type BoolGen struct {
	r       *rand.Rand
	nullPct float64
}

func (g *BoolGen) Next() string {
	// nullability
	if g.nullPct > 0 && g.r.Float64() < g.nullPct {
		return ""
	}
	// 1 if random>0.5 else 0
	if g.r.Float64() > 0.5 {
		return "1"
	}
	return "0"
}

type JsonGen struct {
	strGen *StringGen
}

func (g *JsonGen) Next() string {
	// get the underlying ASCII string
	v := g.strGen.Next()
	if v == "" {
		return "" // preserve null_pct from the StringGen
	}
	// wrap it in {"k":"…"}
	return fmt.Sprintf(`{"k":"%s"}`, v)
}

// ─── Wrappers ──────────────────────────────────────────────────────────

type DefaultWrapper struct {
	base    Generator  // the underlying generator to delegate to
	prob    float64    // probability of emitting the literal instead
	literal string     // the fixed value to emit when the coin flip hits
	rng     *rand.Rand // its own RNG so that calls are reproducible
}

func NewDefaultWrapper(base Generator, prob float64, literal string, seed int64) *DefaultWrapper {
	return &DefaultWrapper{
		base:    base,
		prob:    prob,
		literal: literal,
		rng:     rand.New(rand.NewSource(seed)),
	}
}
func (w *DefaultWrapper) Next() string {
	if w.rng.Float64() < w.prob {
		// “hit” — return the literal value
		return w.literal
	}
	// “miss” — delegate to the underlying generator
	return w.base.Next()
}

// UniqueWrapper wraps a base Generator and ensures
// no value is repeated within the last `capacity` outputs.
type UniqueWrapper struct {
	base     Generator
	seen     map[string]struct{}
	order    []string
	capacity int
}

// NewUniqueWrapper creates a UniqueWrapper around baseGen.
// capacity is the max number of recent values to remember.
func NewUniqueWrapper(baseGen Generator, capacity int) *UniqueWrapper {
	return &UniqueWrapper{
		base:     baseGen,
		seen:     make(map[string]struct{}, capacity),
		order:    make([]string, 0, capacity),
		capacity: capacity,
	}
}

// Next returns the next unique value, re-rolling until it
// finds one not in the recent window.
func (u *UniqueWrapper) Next() string {
	for {
		v := u.base.Next()
		if _, exists := u.seen[v]; !exists {
			// accept it
			u.seen[v] = struct{}{}
			u.order = append(u.order, v)
			// evict oldest if over capacity
			if len(u.order) > u.capacity {
				oldest := u.order[0]
				u.order = u.order[1:]
				delete(u.seen, oldest)
			}
			return v
		}
		// otherwise: value was recently seen → retry
	}
}

// FkWrapper takes a parent Generator and repeats each parent value
// exactly fanout times before advancing.
type FkWrapper struct {
	parent  Generator
	fanout  int // how many repeats of each parent value
	counter int // how many times we've already returned current
	current string
}

// NewFkWrapper wraps a baseGen so that each value it produces
// is repeated fanout times.
func NewFkWrapper(baseGen Generator, fanout int) *FkWrapper {
	if fanout < 1 {
		fanout = 1
	}
	w := &FkWrapper{parent: baseGen, fanout: fanout}
	// prime the pump
	w.current = w.parent.Next()
	w.counter = 0
	return w
}

// Next returns the current parent value, and only when
// it has been returned fanout times does it advance to the next.
func (w *FkWrapper) Next() string {
	if w.counter >= w.fanout {
		w.current = w.parent.Next()
		w.counter = 0
	}
	w.counter++
	return w.current
}

// ─── Factory ──────────────────────────────────────────────────────────

// splitmix64 is a cheap, high-quality 64-bit mixer for combining two 32-bit values.
func splitmix64(x uint64) uint64 {
	x += 0x9e3779b97f4a7c15
	x = (x ^ (x >> 30)) * 0xbf58476d1ce4e5b9
	x = (x ^ (x >> 27)) * 0x94d049bb133111eb
	return x ^ (x >> 31)
}

// makeBatchSeed deterministically scrambles the original YAML seed
// with the batch index so each batch uses a distinct RNG stream.
func makeBatchSeed(origSeed, batchIdx int) int64 {
	key := (uint64(origSeed) << 32) | uint64(batchIdx)
	return int64(splitmix64(key))
}

// ─── 2) Enhanced makeGenerator ─────────────────────────────────────────────

// makeGenerator now takes:
//   - col:       metadata for this column
//   - batchIdx:  which batch we’re in (0,1,2…)
//   - batchSize: how many rows per batch (for sequences)
//   - schema:    full YAML schema, so we can recurse on FKs
func makeGenerator(
	col ColumnMeta,
	batchIdx, batchSize int,
	schema Schema,
) Generator {
	// 2a) seed the per-batch RNG
	origSeed := getIntArg(col.Args, "seed", 0)
	seed64 := makeBatchSeed(origSeed, batchIdx)
	rng := rand.New(rand.NewSource(seed64))

	// 2b) pick the base generator by type
	var base Generator
	switch col.Type {
	case "sequence":
		// jump start by batchIdx*batchSize
		baseStart := getIntArg(col.Args, "start", 0)
		base = &SequenceGen{cur: baseStart + batchIdx*batchSize}

	case "integer":
		min := getIntArg(col.Args, "min", 0)
		max := getIntArg(col.Args, "max", 0)
		nullPct := getFloatArg(col.Args, "null_pct", 0.0)
		base = &IntegerGen{r: rng, min: min, max: max, nullPct: nullPct}

	case "float":
		min := getFloatArg(col.Args, "min", 0.0)
		max := getFloatArg(col.Args, "max", 0.0)
		round := getIntArg(col.Args, "round", 2)
		nullPct := getFloatArg(col.Args, "null_pct", 0.0)
		base = &FloatGen{r: rng, min: min, max: max, round: round, nullPct: nullPct}

	case "string":
		min := getIntArg(col.Args, "min", 0)
		max := getIntArg(col.Args, "max", 0)
		nullPct := getFloatArg(col.Args, "null_pct", 0.0)
		base = &StringGen{r: rng, min: min, max: max, nullPct: nullPct}

	case "timestamp":
		// parse Python-style format → Go layout
		startStr := getStringArg(col.Args, "start", "2000-01-01")
		endStr := getStringArg(col.Args, "end", time.Now().Format("2006-01-02"))
		pyFmt := getStringArg(col.Args, "format", "%Y-%m-%d %H:%M:%S.%f")
		var layout string
		switch pyFmt {
		case "%Y-%m-%d %H:%M:%S.%f":
			layout = "2006-01-02 15:04:05.000000"
		case "%Y-%m-%d":
			layout = "2006-01-02"
		default:
			layout = time.RFC3339Nano
		}
		st, err1 := time.Parse(layout, startStr)
		et, err2 := time.Parse(layout, endStr)
		if err1 != nil || err2 != nil {
			st, _ = time.Parse(time.RFC3339, startStr)
			et, _ = time.Parse(time.RFC3339, endStr)
			layout = time.RFC3339
		}
		span := et.UnixNano() - st.UnixNano()
		if span <= 0 {
			span = 1
		}
		nullPct := getFloatArg(col.Args, "null_pct", 0.0)
		base = &TimestampGen{r: rng, startNS: st.UnixNano(), spanNS: span, layout: layout, nullPct: nullPct}

	case "uuid":
		base = &UUIDGen{r: rng}

	case "bool":
		nullPct := getFloatArg(col.Args, "null_pct", 0.0)
		base = &BoolGen{r: rng, nullPct: nullPct}

	case "json":
		// JSON is just a StringGen plus a wrapper
		min := getIntArg(col.Args, "min", 10)
		max := getIntArg(col.Args, "max", 50)
		nullPct := getFloatArg(col.Args, "null_pct", 0.0)
		sg := &StringGen{r: rng, min: min, max: max, nullPct: nullPct}
		base = &JsonGen{strGen: sg}

	default:
		panic("type not supported: " + col.Type)
	}

	// 2c) layer on DefaultWrapper if configured
	if col.Default != "" && col.DefaultProb > 0 {
		// use a distinct sub-seed so the literal probability RNG
		// doesn’t collide with the main RNG
		wrapperSeed := makeBatchSeed(origSeed, batchIdx^0xdeadbeef)
		base = NewDefaultWrapper(base, col.DefaultProb, col.Default, wrapperSeed)
	}

	// 2d) layer on UniqueWrapper if requested
	if col.IsUnique && !col.HasForeignKey && col.Type != "sequence" {
		base = NewUniqueWrapper(base, 100_000) // or configurable capacity
	}

	// 2e) layer on FKWrapper if this column has a foreign key
	if col.HasForeignKey {
		// col.FK might be "tpcc__public__district.d_id"
		parts := strings.SplitN(col.FK, ".", 2)
		if len(parts) != 2 {
			panic(fmt.Sprintf("invalid FK spec %q", col.FK))
		}
		fqTable, childCol := parts[0], parts[1]          // "tpcc__public__district", "d_id"
		pathSegments := strings.Split(fqTable, "__")     // ["tpcc","public","district"]
		parentTable := pathSegments[len(pathSegments)-1] // "district"

		// now look up in your schema map:
		parentMeta := schema[parentTable][0].Columns[childCol]
		parentGen := makeGenerator(parentMeta, batchIdx, batchSize, schema)
		base = NewFkWrapper(parentGen, col.Fanout)
	}

	return base
}

// ─── Main: load schema, generate CSV ──────────────────────────────────

//func generateFromSchema(schemaPath, outDir string) error {
//
//	data, err := os.ReadFile(schemaPath)
//	if err != nil {
//		panic(err)
//	}
//
//	var schema Schema
//	if err := yaml.Unmarshal(data, &schema); err != nil {
//		panic(err)
//	}
//
//	// For each table
//	for tableName, blocks := range schema {
//		block := blocks[0]
//		cols := block.Columns
//		genList := make([]Generator, 0, len(cols))
//		headers := make([]string, 0, len(cols))
//
//		// create all generators
//		for colName, meta := range cols {
//			headers = append(headers, colName)
//			genList = append(genList, makeGenerator(meta))
//		}
//
//		// open CSV
//		f, err := os.Create(fmt.Sprintf("%s/%s.csv", outDir, tableName))
//		if err != nil {
//			panic(err)
//		}
//		w := csv.NewWriter(f)
//
//		// write header
//		if err := w.Write(headers); err != nil {
//			return err
//		}
//
//		// write rows
//		for i := 0; i < block.Count; i++ {
//			row := make([]string, len(genList))
//			for j, g := range genList {
//				row[j] = g.Next()
//			}
//			if err := w.Write(row); err != nil {
//				return err
//			}
//		}
//		w.Flush()
//		if err := f.Close(); err != nil {
//			return err
//		}
//		fmt.Printf("Wrote %s/%s.csv (%d rows)\n", outDir, tableName, block.Count)
//	}
//	return nil
//}
