// sqlConvert.go
package workload_generator

import (
	"bufio"
	"fmt"
	"io"
	"os"
	"regexp"
	"strings"
)

type FKRef struct {
	Table  string
	Column string
}

type Placeholder struct {
	Name         string
	ColType      string
	IsNullable   bool
	IsPrimaryKey bool
	Default      *string
	IsUnique     bool
	FKReference  *FKRef
	InlineCheck  *string
	Clause       string // e.g. "WHERE", "INSERT", "UPDATE"
	Position     int    // $1, $2, ...
}

type SQLQuery struct {
	SQL          string
	Placeholders []Placeholder
}

type Transaction struct {
	Queries []SQLQuery
}

// ReadTPCC reads tpcc.sql and returns a slice of Transactions.
func ReadTPCC(path string) ([]Transaction, error) {
	f, err := os.Open(path)
	if err != nil {
		return nil, fmt.Errorf("open file: %w", err)
	}
	defer f.Close()

	// read entire file
	data, err := io.ReadAll(bufio.NewReader(f))
	if err != nil {
		return nil, fmt.Errorf("read file: %w", err)
	}
	text := string(data)

	// split on transaction markers
	blocks := regexp.MustCompile(`(?m)^-------Begin Transaction------\s*([\s\S]*?)-------End Transaction-------`).FindAllStringSubmatch(text, -1)
	var txns []Transaction

	// placeholder regex
	phRe := regexp.MustCompile(`:-:\|(.+?)\|:-:`)

	for _, blk := range blocks {
		body := blk[1]
		lines := strings.Split(body, "\n")
		var curr SQLQuery
		var txn Transaction
		posCounter := 1

		for _, line := range lines {
			line = strings.TrimSpace(line)
			if line == "" || line == "BEGIN;" || line == "COMMIT;" {
				continue
			}
			// accumulate statement until it ends with ";"
			curr.SQL += line + " "
			if strings.HasSuffix(line, ";") {
				// process placeholders
				placeholders := []Placeholder{}
				sqlOut := phRe.ReplaceAllStringFunc(curr.SQL, func(match string) string {
					// extract inner
					inner := phRe.FindStringSubmatch(match)[1]
					// split fields: they were quoted ','-sep
					parts := splitQuoted(inner)

					// map parts
					var p Placeholder
					p.Name = trimQuotes(parts[0])
					p.ColType = trimQuotes(parts[1])
					p.IsNullable = trimQuotes(parts[2]) == "NULL"
					p.IsPrimaryKey = strings.Contains(trimQuotes(parts[3]), "PRIMARY KEY")
					if d := trimQuotes(parts[4]); d != "" {
						p.Default = &d
					}
					p.IsUnique = trimQuotes(parts[5]) == "UNIQUE"
					if fk := trimQuotes(parts[6]); fk != "" {
						// form: FK→table.column
						parts := strings.Split(strings.TrimPrefix(fk, "FK→"), ".")
						p.FKReference = &FKRef{Table: parts[0], Column: parts[1]}
					}
					if chk := trimQuotes(parts[7]); chk != "" {
						p.InlineCheck = &chk
					}
					// last part is clause
					p.Clause = trimQuotes(parts[8])
					p.Position = posCounter
					placeholders = append(placeholders, p)
					posCounter++
					return fmt.Sprintf("$%d", p.Position)
				})

				curr.SQL = strings.TrimSpace(sqlOut)
				curr.Placeholders = placeholders
				txn.Queries = append(txn.Queries, curr)

				// reset for next
				curr = SQLQuery{}
			}
		}
		txns = append(txns, txn)
	}
	return txns, nil
}

// splitQuoted splits a string like "'a','b','c'" into ["'a'", "'b'", "'c'"].
func splitQuoted(s string) []string {
	var out []string
	buf := ""
	inQuote := false
	for _, r := range s {
		switch r {
		case '\'':
			inQuote = !inQuote
			buf += string(r)
		case ',':
			if inQuote {
				buf += string(r)
			} else {
				out = append(out, strings.TrimSpace(buf))
				buf = ""
			}
		default:
			buf += string(r)
		}
	}
	if buf != "" {
		out = append(out, strings.TrimSpace(buf))
	}
	return out
}

// trimQuotes removes leading/trailing single-quotes.
func trimQuotes(s string) string {
	return strings.Trim(s, "'")
}
