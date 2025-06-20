package dbworkloadgo

import (
	"bufio"
	"encoding/csv"
	"errors"
	"fmt"
	"os"
	"path/filepath"
	"regexp"
	"strings"
)

// Column mirrors the Python Column class
// Only fields required for DDL parsing are included
// (anonymization is omitted for now)
type Column struct {
	Name         string
	ColType      string
	IsNullable   bool
	IsPrimaryKey bool
	Default      string
	IsUnique     bool
	FKTable      string
	FKColumn     string
	InlineCheck  string
}

type TableSchema struct {
	TableName         string
	Columns           map[string]*Column
	PrimaryKeys       []string
	UniqueConstraints [][]string
	ForeignKeys       [][3]interface{} // (local cols []string, table string, foreign cols []string)
	CheckConstraints  []string
	OriginalTable     string
}

func NewTableSchema(name string, original string) *TableSchema {
	return &TableSchema{
		TableName:     name,
		Columns:       make(map[string]*Column),
		OriginalTable: original,
	}
}

func (c *Column) String() string {
	parts := []string{c.Name, c.ColType}
	if c.IsNullable {
		parts = append(parts, "NULL")
	} else {
		parts = append(parts, "NOT NULL")
	}
	if c.IsPrimaryKey {
		parts = append(parts, "PRIMARY KEY")
	}
	if c.Default != "" {
		parts = append(parts, "DEFAULT "+c.Default)
	}
	if c.IsUnique {
		parts = append(parts, "UNIQUE")
	}
	if c.FKTable != "" && c.FKColumn != "" {
		parts = append(parts, fmt.Sprintf("FK→%s.%s", c.FKTable, c.FKColumn))
	}
	if c.InlineCheck != "" {
		parts = append(parts, fmt.Sprintf("CHECK(%s)", c.InlineCheck))
	}
	return strings.Join(parts, " ")
}

func (ts *TableSchema) String() string {
	out := []string{fmt.Sprintf("Table: %s", ts.TableName), " Columns:"}
	for _, col := range ts.Columns {
		out = append(out, "  "+col.String())
	}
	if len(ts.PrimaryKeys) > 0 {
		out = append(out, " PKs: "+strings.Join(ts.PrimaryKeys, ", "))
	}
	if len(ts.UniqueConstraints) > 0 {
		tmp := []string{}
		for _, u := range ts.UniqueConstraints {
			tmp = append(tmp, "("+strings.Join(u, ",")+")")
		}
		out = append(out, " UNIQUE: "+strings.Join(tmp, "; "))
	}
	if len(ts.ForeignKeys) > 0 {
		tmp := []string{}
		for _, fk := range ts.ForeignKeys {
			l := fk[0].([]string)
			t := fk[1].(string)
			f := fk[2].([]string)
			tmp = append(tmp, fmt.Sprintf("(%s)→%s(%s)", strings.Join(l, ","), t, strings.Join(f, ",")))
		}
		out = append(out, " FKs: "+strings.Join(tmp, "; "))
	}
	if len(ts.CheckConstraints) > 0 {
		out = append(out, " CHECKs: "+strings.Join(ts.CheckConstraints, "; "))
	}
	return strings.Join(out, "\n") + "\n"
}

func (ts *TableSchema) AddColumn(c *Column) {
	ts.Columns[c.Name] = c
}

func (ts *TableSchema) SetPrimaryKeys(pks []string) {
	ts.PrimaryKeys = pks
	single := len(pks) == 1
	for _, pk := range pks {
		if col, ok := ts.Columns[pk]; ok {
			col.IsPrimaryKey = true
			col.IsNullable = false
			if single {
				col.IsUnique = true
			}
		}
	}
}

// ParseDDL converts a CREATE TABLE statement into a TableSchema
func ParseDDL(ddl string) (*TableSchema, error) {
	ident := `(?:"[^"]+"|[A-Za-z_][\w]*)`
	fullIdent := fmt.Sprintf(`(%s(?:\.%s){0,2})`, ident, ident)
	tablePattern := regexp.MustCompile(`(?i)CREATE\s+TABLE(?:\s+IF\s+NOT\s+EXISTS)?\s+` + fullIdent)
	m := tablePattern.FindStringSubmatch(ddl)
	if m == nil {
		return nil, errors.New("no table name")
	}
	tableName := m[1]
	parts := strings.Split(tableName, ".")
	for i := range parts {
		parts[i] = strings.Trim(parts[i], `"`)
	}
	rawName := tableName
	tableName = strings.Join(parts, ".")
	ts := NewTableSchema(tableName, rawName)

	bodyRe := regexp.MustCompile(`(?s)\((.*)\)\s*([^)]*)$`)
	bodyMatch := bodyRe.FindStringSubmatch(ddl)
	if bodyMatch == nil {
		return nil, errors.New("no column block")
	}
	body := bodyMatch[1]

	// top-level comma split
	var partsList []string
	buf := ""
	depth := 0
	for _, ch := range body {
		switch ch {
		case '(':
			depth++
			buf += string(ch)
		case ')':
			depth--
			buf += string(ch)
		case ',':
			if depth == 0 {
				partsList = append(partsList, strings.TrimSpace(buf))
				buf = ""
			} else {
				buf += string(ch)
			}
		default:
			buf += string(ch)
		}
	}
	if strings.TrimSpace(buf) != "" {
		partsList = append(partsList, strings.TrimSpace(buf))
	}

	var colDefs, tableConstraints []string
	for _, p := range partsList {
		up := strings.ToUpper(strings.TrimSpace(p))
		if strings.HasPrefix(up, "CONSTRAINT") || strings.HasPrefix(up, "PRIMARY KEY") || strings.HasPrefix(up, "UNIQUE") || strings.HasPrefix(up, "FOREIGN KEY") || strings.HasPrefix(up, "CHECK") || strings.HasPrefix(up, "INDEX") {
			tableConstraints = append(tableConstraints, p)
		} else {
			colDefs = append(colDefs, p)
		}
	}

	colPattern := regexp.MustCompile(`(?i)^\s*("?[^"]+"|[\w-]+)"?\s+([^\s]+)(?:\s+(NOT\s+NULL|NULL))?(?:\s+DEFAULT\s+((?:\([^\)]*\)|[^\s,]+)))?(?:\s+PRIMARY\s+KEY)?(?:\s+UNIQUE)?(?:\s+REFERENCES\s+([\w\.]+)\s*\(\s*([\w]+)\s*\))?(?:\s+CHECK\s*\(\s*(.*?)\s*\))?`)
	inlinePKCols := []string{}
	for _, cd := range colDefs {
		m := colPattern.FindStringSubmatch(cd)
		if m == nil {
			continue
		}
		name := m[1]
		ctype := m[2]
		nullSpec := m[3]
		defVal := m[4]
		fkTable := m[5]
		fkCol := m[6]

		inlineCheck := ""
		checkIdx := regexp.MustCompile(`(?i)\bCHECK\s*\(`).FindStringIndex(cd)
		if checkIdx != nil {
			start := checkIdx[1]
			depth := 1
			i := start
			for i < len(cd) && depth > 0 {
				switch cd[i] {
				case '(':
					depth++
				case ')':
					depth--
				}
				i++
			}
			inlineCheck = strings.TrimSpace(cd[start : i-1])
		}

		isNullable := nullSpec == "" || strings.ToUpper(nullSpec) == "NULL"
		isUnique := regexp.MustCompile(`(?i)\bUNIQUE\b`).MatchString(cd)
		isPK := regexp.MustCompile(`(?i)\bPRIMARY\s+KEY\b`).MatchString(cd)

		if isPK {
			inlinePKCols = append(inlinePKCols, strings.Trim(name, `"`))
			isNullable = false
			isUnique = true
		}

		col := &Column{
			Name:         strings.Trim(name, `"`),
			ColType:      ctype,
			IsNullable:   isNullable,
			IsPrimaryKey: isPK,
			Default:      strings.TrimSpace(defVal),
			IsUnique:     isUnique,
		}
		if fkTable != "" {
			col.FKTable = fkTable
			col.FKColumn = fkCol
		}
		if inlineCheck != "" {
			col.InlineCheck = inlineCheck
			ts.CheckConstraints = append(ts.CheckConstraints, inlineCheck)
		}
		ts.AddColumn(col)
	}

	if len(inlinePKCols) > 0 {
		ts.SetPrimaryKeys(inlinePKCols)
	}

	for _, tc := range tableConstraints {
		up := strings.ToUpper(tc)
		if strings.Contains(up, "PRIMARY KEY") {
			raw := regexp.MustCompile(`\((.*?)\)`).FindStringSubmatch(tc)
			if raw != nil {
				cols := []string{}
				for _, col := range strings.Split(raw[1], ",") {
					cols = append(cols, strings.Split(strings.TrimSpace(strings.Trim(col, `"`)), " ")[0])
				}
				ts.SetPrimaryKeys(cols)
			}
			continue
		}
		if strings.Contains(up, "UNIQUE") {
			raw := regexp.MustCompile(`\((.*?)\)`).FindStringSubmatch(tc)
			if raw != nil {
				cols := []string{}
				for _, col := range strings.Split(raw[1], ",") {
					cols = append(cols, strings.Split(strings.TrimSpace(strings.Trim(col, `"`)), " ")[0])
				}
				ts.UniqueConstraints = append(ts.UniqueConstraints, cols)
				isComposite := len(cols) > 1
				for _, c := range cols {
					if !isComposite {
						if col, ok := ts.Columns[c]; ok {
							col.IsUnique = true
						}
					}
				}
			}
			continue
		}
		if strings.Contains(up, "FOREIGN KEY") {
			fkRe := regexp.MustCompile(`(?i)FOREIGN\s+KEY\s*\(([^\)]*)\)\s+REFERENCES\s+((?:"[^"]+"|[\w]+)(?:\.(?:"[^"]+"|[\w]+))*)\s*\(([^\)]*)\)`)
			m2 := fkRe.FindStringSubmatch(tc)
			if m2 != nil {
				local := []string{}
				for _, c := range strings.Split(m2[1], ",") {
					local = append(local, strings.TrimSpace(c))
				}
				tbl := strings.TrimSpace(m2[2])
				tblRaw := strings.ReplaceAll(tbl, "\"", "")
				foreign := []string{}
				for _, c := range strings.Split(m2[3], ",") {
					foreign = append(foreign, strings.TrimSpace(c))
				}
				ts.ForeignKeys = append(ts.ForeignKeys, [3]interface{}{local, tblRaw, foreign})
			}
			continue
		}
		if strings.Contains(up, "CHECK") {
			m2 := regexp.MustCompile(`CHECK\s*\((.*)\)`).FindStringSubmatch(tc)
			if m2 != nil {
				ts.CheckConstraints = append(ts.CheckConstraints, strings.TrimSpace(m2[1]))
			}
			continue
		}
		if strings.HasPrefix(up, "INDEX") {
			// skip
			continue
		}
	}

	return ts, nil
}

// GenerateDDLs replicates the Python generate_ddls function (without anonymization)
func GenerateDDLs(zipDir, dbName, outputDir, clusterURL, outputFileName string, anonymize bool) (map[string]*TableSchema, error) {
	filePath := filepath.Join(zipDir, "crdb_internal.create_statements.txt")
	if _, err := os.Stat(filePath); err != nil {
		return nil, fmt.Errorf("could not find TSV file: %v", err)
	}

	f, err := os.Open(filePath)
	if err != nil {
		return nil, err
	}
	defer f.Close()

	reader := csv.NewReader(bufio.NewReader(f))
	reader.Comma = '\t'
	reader.LazyQuotes = true

	header, err := reader.Read()
	if err != nil {
		return nil, err
	}
	colIndex := map[string]int{}
	for i, col := range header {
		colIndex[col] = i
	}
	req := []string{"database_name", "create_statement", "schema_name", "descriptor_type", "descriptor_name"}
	for _, c := range req {
		if _, ok := colIndex[c]; !ok {
			return nil, fmt.Errorf("missing column %s", c)
		}
	}

	tableStatements := make(map[string]string)
	order := []string{}
	seen := map[string]bool{}
	schemaReCache := map[string]*regexp.Regexp{}

	for {
		rec, err := reader.Read()
		if err != nil {
			if errors.Is(err, os.ErrClosed) {
				break
			}
			if err.Error() == "EOF" {
				break
			}
			if len(rec) == 0 {
				break
			}
		}
		if len(rec) == 0 {
			break
		}
		if rec[colIndex["database_name"]] == dbName && rec[colIndex["descriptor_type"]] == "table" && rec[colIndex["schema_name"]] == "public" {
			schemaName := rec[colIndex["schema_name"]]
			stmt := rec[colIndex["create_statement"]]
			tableName := rec[colIndex["descriptor_name"]]
			fullTable := fmt.Sprintf("%s.%s.%s", dbName, schemaName, tableName)
			pattern, ok := schemaReCache[schemaName]
			if !ok {
				pattern = regexp.MustCompile(`\b` + regexp.QuoteMeta(schemaName) + `\.`)
				schemaReCache[schemaName] = pattern
			}
			stmt = pattern.ReplaceAllString(stmt, dbName+"."+schemaName+".")
			if !regexp.MustCompile(`(?i)IF\s+NOT\s+EXISTS`).MatchString(stmt) {
				stmt = regexp.MustCompile(`(?i)^(CREATE\s+TABLE\s+)`).ReplaceAllString(stmt, "${1}IF NOT EXISTS ")
			}
			if !seen[fullTable] {
				order = append(order, fullTable)
				seen[fullTable] = true
			}
			tableStatements[fullTable] = stmt
		}
	}

	statements := []string{}
	for _, t := range order {
		statements = append(statements, tableStatements[t])
	}

	if outputDir == "" {
		outputDir = "."
	}
	outputPath := filepath.Join(outputDir, outputFileName)
	out, err := os.Create(outputPath)
	if err != nil {
		return nil, err
	}
	defer out.Close()

	fmt.Fprintf(out, "create database if not exists %s;\n\n", dbName)
	allSchemas := map[string]*TableSchema{}

	for _, stmt := range statements {
		fmt.Fprintln(out, stmt+";")
		fmt.Fprintln(out)
		schema, err := ParseDDL(stmt)
		if err == nil {
			tableName := schema.TableName[strings.LastIndex(schema.TableName, ".")+1:]
			allSchemas[tableName] = schema
		}
	}

	if clusterURL != "" {
		// attempt to execute via cockroach sql
		_ = clusterURL // placeholder, execution skipped
	}

	return allSchemas, nil
}
