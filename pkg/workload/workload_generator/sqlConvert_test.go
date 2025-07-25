package workload_generator

import (
	"fmt"
	"os"
	"testing"
)

func TestReadTPCCAndWriteConvertedSQL(t *testing.T) {
	// 1. Read and parse the tpcc.sql file
	txns, err := readSQL("tpcc.sql", "idc")
	if err != nil {
		t.Fatalf("readSQL failed: %v", err)
	}

	// 2. Create the output file
	out, err := os.Create("convertedPy.sql")
	if err != nil {
		t.Fatalf("could not create converted.sql: %v", err)
	}
	defer out.Close()

	// 3. Write each transaction's SQL to the file
	for ti, txn := range txns {
		fmt.Fprintf(out, "-- Transaction %d --\n", ti+1)
		for _, q := range txn.Queries {
			// 1) write the SQL
			if _, err := out.WriteString(q.SQL + "\n"); err != nil {
				t.Fatalf("writing SQL failed: %v", err)
			}

			// 2) write its placeholders
			if len(q.Placeholders) > 0 {
				out.WriteString("  Placeholders:\n")
				for _, ph := range q.Placeholders {
					// $<Position> : <Name> (<ColType>), nullable=<IsNullable>, pk=<IsPrimaryKey>, unique=<IsUnique>, clause=<Clause>
					line := fmt.Sprintf(
						"    $%d: %s (%s), nullable=%t, pk=%t, unique=%t, clause=%s\n",
						ph.Position,
						ph.Name,
						ph.ColType,
						ph.IsNullable,
						ph.IsPrimaryKey,
						ph.IsUnique,
						ph.Clause,
					)
					if _, err := out.WriteString(line); err != nil {
						t.Fatalf("writing placeholder failed: %v", err)
					}
				}
			}

			// blank line between statements
			out.WriteString("\n")
		}
		out.WriteString("COMMIT;\n\n")
	}

	t.Logf("wrote %d transactions to converted.sql", len(txns))
}
