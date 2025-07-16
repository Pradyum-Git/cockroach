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
	typ     string // e.g. "read", "write", "update"
	Queries []SQLQuery
}

// readSQL reads tpcc.sql and returns a slice of Transactions.
// It will number placeholders $1…$N separately in each SQL statement.
func readSQL(path string) ([]Transaction, []Transaction, error) {
	f, err := os.Open(path)
	if err != nil {
		return nil, nil, fmt.Errorf("open file: %w", err)
	}
	defer f.Close()

	data, err := io.ReadAll(bufio.NewReader(f))
	if err != nil {
		return nil, nil, fmt.Errorf("read file: %w", err)
	}
	text := string(data)

	// Each transaction block
	txRe := regexp.MustCompile(
		`(?m)^-------Begin Transaction------\s*([\s\S]*?)-------End Transaction-------`)
	blocks := txRe.FindAllStringSubmatch(text, -1)

	// placeholder pattern
	phRe := regexp.MustCompile(`"?:-:\|(.+?)\|:-:"?`)

	var readTxns []Transaction
	var writeTxns []Transaction
	for _, blk := range blocks {
		body := blk[1]
		lines := strings.Split(body, "\n")
		var txn Transaction
		var curr SQLQuery

		for _, line := range lines {
			line = strings.TrimSpace(line)
			if line == "" || line == "BEGIN;" || line == "COMMIT;" {
				continue
			}
			// build up the SQL text
			curr.SQL += line + " "
			if strings.HasSuffix(line, ";") {
				// once we hit the end of a statement, re-number from $1
				stmtPos := 1
				var placeholders []Placeholder

				sqlOut := phRe.ReplaceAllStringFunc(curr.SQL, func(match string) string {
					inner := phRe.FindStringSubmatch(match)[1]
					parts := splitQuoted(inner)

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
						fkParts := strings.Split(strings.TrimPrefix(fk, "FK→"), ".")
						p.FKReference = &FKRef{Table: fkParts[0], Column: fkParts[1]}
					}
					if chk := trimQuotes(parts[7]); chk != "" {
						p.InlineCheck = &chk
					}
					p.Clause = trimQuotes(parts[8])
					p.Position = stmtPos
					stmtPos++

					placeholders = append(placeholders, p)
					return fmt.Sprintf("$%d", p.Position)
				})

				curr.SQL = strings.TrimSpace(sqlOut)
				curr.Placeholders = placeholders
				txn.Queries = append(txn.Queries, curr)

				// reset for next statement
				curr = SQLQuery{}
			}
		}
		setType(&txn)
		if txn.typ == "read" {
			readTxns = append(readTxns, txn)
		} else {
			writeTxns = append(writeTxns, txn)
		}
	}

	return readTxns, writeTxns, nil
}

func setType(txn *Transaction) {
	//set to read if all selects otehrwise write
	for _, q := range txn.Queries {
		if strings.HasPrefix(strings.ToLower(q.SQL), "insert ") ||
			strings.HasPrefix(strings.ToLower(q.SQL), "update ") ||
			strings.HasPrefix(strings.ToLower(q.SQL), "delete ") {
			txn.typ = "write"
			return
		}
	}
	//default to read if no insert update or delete found
	txn.typ = "read"
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
