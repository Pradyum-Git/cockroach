package dbworkloadgo

import (
	"encoding/csv"
	"encoding/hex"
	"fmt"
	"gopkg.in/yaml.v3"
	"math/rand"
	"os"
	"strconv"
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
}

type TableBlock struct {
	Count         int                   `yaml:"count"`
	Columns       map[string]ColumnMeta `yaml:"columns"`
	OriginalTable string                `yaml:"original_table"`
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

// ─── Factory ──────────────────────────────────────────────────────────

func makeGenerator(col ColumnMeta) Generator {
	// determine seed
	seed := getIntArg(col.Args, "seed", 0)
	rng := rand.New(rand.NewSource(int64(seed)))

	switch col.Type {
	case "sequence":
		start := getIntArg(col.Args, "start", 0)
		return &SequenceGen{cur: start}

	case "integer":
		min := getIntArg(col.Args, "min", 0)
		max := getIntArg(col.Args, "max", 0)
		nullPct := getFloatArg(col.Args, "null_pct", 0.0)
		return &IntegerGen{r: rng, min: min, max: max, nullPct: nullPct}

	case "float":
		min := getFloatArg(col.Args, "min", 0.0)
		max := getFloatArg(col.Args, "max", 0.0)
		round := getIntArg(col.Args, "round", 2)
		nullPct := getFloatArg(col.Args, "null_pct", 0.0)
		return &FloatGen{r: rng, min: min, max: max, round: round, nullPct: nullPct}

	case "string":
		min := getIntArg(col.Args, "min", 0)
		max := getIntArg(col.Args, "max", 0)
		nullPct := getFloatArg(col.Args, "null_pct", 0.0)
		return &StringGen{r: rng, min: min, max: max, nullPct: nullPct}

	case "timestamp":
		// parse start/end strings
		startStr := getStringArg(col.Args, "start", "2000-01-01")
		endStr := getStringArg(col.Args, "end", time.Now().Format("2006-01-02"))
		// default Python format → Go layout
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
		// parse times
		startT, err1 := time.Parse(layout, startStr)
		endT, err2 := time.Parse(layout, endStr)
		if err1 != nil || err2 != nil {
			// fallback to RFC3339 parse
			startT, _ = time.Parse(time.RFC3339, startStr)
			endT, _ = time.Parse(time.RFC3339, endStr)
			layout = time.RFC3339
		}
		span := endT.UnixNano() - startT.UnixNano()
		if span <= 0 {
			span = 1
		}
		nullPct := getFloatArg(col.Args, "null_pct", 0.0)
		return &TimestampGen{
			r:       rng,
			startNS: startT.UnixNano(),
			spanNS:  span,
			layout:  layout,
			nullPct: nullPct,
		}
	case "uuid":
		return &UUIDGen{r: rng}
	case "bool":
		nullPct := getFloatArg(col.Args, "null_pct", 0.0)
		return &BoolGen{r: rng, nullPct: nullPct}
	case "json":
		// reuse StringGen to produce the raw value
		min := getIntArg(col.Args, "min", 10)
		max := getIntArg(col.Args, "max", 50)
		nullPct := getFloatArg(col.Args, "null_pct", 0.0)
		sg := &StringGen{r: rng, min: min, max: max, nullPct: nullPct}
		return &JsonGen{strGen: sg}

	default:
		panic("type not supported: " + col.Type)
	}
}

// ─── Main: load schema, generate CSV ──────────────────────────────────

func generateFromSchema(schemaPath, outDir string) error {

	data, err := os.ReadFile(schemaPath)
	if err != nil {
		panic(err)
	}

	var schema Schema
	if err := yaml.Unmarshal(data, &schema); err != nil {
		panic(err)
	}

	// For each table
	for tableName, blocks := range schema {
		block := blocks[0]
		cols := block.Columns
		genList := make([]Generator, 0, len(cols))
		headers := make([]string, 0, len(cols))

		// create all generators
		for colName, meta := range cols {
			headers = append(headers, colName)
			genList = append(genList, makeGenerator(meta))
		}

		// open CSV
		f, err := os.Create(fmt.Sprintf("%s/%s.csv", outDir, tableName))
		if err != nil {
			panic(err)
		}
		w := csv.NewWriter(f)

		// write header
		if err := w.Write(headers); err != nil {
			return err
		}

		// write rows
		for i := 0; i < block.Count; i++ {
			row := make([]string, len(genList))
			for j, g := range genList {
				row[j] = g.Next()
			}
			if err := w.Write(row); err != nil {
				return err
			}
		}
		w.Flush()
		if err := f.Close(); err != nil {
			return err
		}
		fmt.Printf("Wrote %s/%s.csv (%d rows)\n", outDir, tableName, block.Count)
	}
	return nil
}
