package workload_generator

import (
	"fmt"
	"os"
	"path/filepath"
	"regexp"
	"strings"
	"testing"
)

func TestReplacePlaceholders(t *testing.T) {
	// stub schema map for now; wire in your real allSchemas later
	// assume these types are already in scope:
	//   type TableSchema { … }
	//   type Column { … }

	schemas := make(map[string]*TableSchema)

	// Populate the "orders" table schema
	schemas["orders"] = &TableSchema{
		TableName: "orders",
		Columns: map[string]*Column{
			"orderinfo": {
				Name:         "orderinfo",
				ColType:      "TEXT", // or whatever your type system uses
				IsNullable:   false,
				IsPrimaryKey: false,
			},
			"orderamount": {
				Name:         "orderamount",
				ColType:      "DECIMAL",
				IsNullable:   false,
				IsPrimaryKey: false,
			},
			"ordertime": {
				Name:         "ordertime",
				ColType:      "TIMESTAMP",
				IsNullable:   false,
				IsPrimaryKey: false,
			},
		},
		// preserve the DDL column order if you care
		ColumnOrder: []string{"orderinfo", "orderamount", "ordertime"},
	}

	inputs := []string{
		`SELECT * FROM order_line WHERE ol_i_id IN (_,__more__)`,
		`SELECT * FROM order_line WHERE (ol_i_id, ol_d_id, ol_o_id) IN ((_,__more__),__more__)`,
		`SELECT * FROM order_line WHERE ((ol_w_id > _) AND (ol_d_id = _)) AND (ol_o_id = _)`,
		`SELECT * FROM t WHERE price BETWEEN 100 AND _`,
		`INSERT INTO orders(acc_no, status, amount) VALUES (_, __more__) RETURNING id;`,
		`INSERT INTO orders VALUES (_,__more__),(_,__more__)`,

		`INSERT INTO orders VALUES (_,__more__);`,
		`INSERT INTO orders(acc_no, status, amount) VALUES (_, __more__) RETURNING id;`,
		`INSERT INTO orders(acc_no,status,amount) VALUES(_,__more__);`,
		`INSERT INTO orders(acc_no, status, amount) VALUES  ( _ ,__more__ ) , (__, __more__) ;`,
		`insert into orders(acc_no, status, amount) Values(_,__more__),( _,__more__ );`,
		`INSERT INTO orders(acc_no, status, amount) VALUES (NOW(), _),(CURRENT_TIMESTAMP, __more__);`,

		// EXTRA: three-row multi-tuple INSERT
		`INSERT INTO orders(acc_no, status, amount) VALUES (_,__more__),( _,__more__ ),(__more__, _);`,

		// EXTRA: no-cols multi-tuple INSERT (3 rows)
		`INSERT INTO orders VALUES (_,__more__),( _,__more__),( __more__ , _);`,

		// SELECT variants
		`SELECT id, IFNULL(sum(amount), _) FROM orders WHERE acc_no = _;`,
		`SELECT IFNULL(status, _) AS name FROM orders;`,
		`SELECT * FROM orders WHERE (acc_no = _) AND (id = _);`,
		`SELECT * FROM orders WHERE id IN (_, __more__, _);`,
		`SELECT * FROM orders WHERE (acc_no, status) IN ((_,__more__),( __more__ , _));`,
		//`SELECT * FROM orders FOR SYSTEM_TIME AS OF _ WHERE acc_no = _;`,
		`SELECT * FROM ref_data WHERE acc_no = _;`,
		`SELECT version();`,
		` SELECT * FROM orders WHERE amount BETWEEN _ AND __more__;`,

		// EXTRA: larger IN-lists
		`SELECT * FROM orders WHERE id IN (_, __more__, _, __more__, _);`,
		`SELECT * FROM orders WHERE (acc_no, status) IN ((_,__more__),( __more__ , _),( _,__more__));`,
		`SELECT * FROM orders WHERE amount BETWEEN (_ ) AND (__more__);`,

		// UPDATE variants — simple form
		`UPDATE orders SET status = _ WHERE id = _;`,
		`UPDATE orders SET status = _, amount = __more__ WHERE acc_no = _;`,
		`UPDATE orders SET updated_at = NOW(), status = _ WHERE id = _;`,

		// UPDATE variants — tuple form
		`UPDATE orders SET (acc_no, id) = (_, __more__) WHERE status = _;`,
		`UPDATE orders SET (status, amount) = (__more__, _) WHERE id = _;`,

		// DELETE
		`DELETE FROM orders WHERE acc_no = _;`,
		`DELETE FROM orders WHERE (acc_no, id) = (_, __more__);`,

		`UPDATE orders SET status = CASE amount WHEN _ THEN _ WHEN _ THEN _ ELSE _ END WHERE id = _;`,

		// 2) Tuple-form CASE in SET:
		//    Verify that “(qty, price) = CASE (item_id, warehouse_id) WHEN (_,__more__) THEN (_,__more__) … ELSE force_error(_,_) END” works.
		//`UPDATE stock SET (quantity, price) = CASE (item_id, warehouse_id) WHEN (_, __more__) THEN (_, __more__) WHEN (_, __more__) THEN (_, __more__) ELSE force_error(_, _) END WHERE (item_id, warehouse_id) IN ((_, __more__), __more__);`,
	}

	for _, in := range inputs {
		out, err := replacePlaceholders(in, schemas)
		if err != nil {
			t.Fatalf("ReplacePlaceholders(%q) error: %v", in, err)
		}
		fmt.Println("IN:  ", in)
		fmt.Println("OUT: ", out)
		fmt.Println("----")
	}
}

func TestGenerateWorkload_Smoke(t *testing.T) {
	debugZip := "/Users/pradyumagarwal/workloads/git-workloadGeneratorStruct/dbworkload_intProj/debug-zips/debug_2"
	dbName := "tpcc"
	outputDir := "/Users/pradyumagarwal/go/src/github.com/cockroachdb/cockroach/pkg/workload/workload_generator"

	// ensure output dir exists
	if err := os.MkdirAll(outputDir, 0755); err != nil {
		t.Fatalf("failed to create output dir: %v", err)
	}

	// for now, pass an empty schema map
	allSchemas := make(map[string]*TableSchema)

	err := generateWorkload(debugZip, allSchemas, dbName, outputDir)
	if err != nil {
		t.Fatalf("GenerateWorkload failed: %v", err)
	}

	outPath := filepath.Join(outputDir, dbName+".sql")
	if _, err := os.Stat(outPath); err != nil {
		t.Fatalf("expected output file %s not found: %v", outPath, err)
	}

	t.Logf("🎉 workload SQL written to %s", outPath)
}

// makeSimpleSchema builds a *TableSchema with the given name and columns,
// each non-nullable TEXT column.
func makeSimpleSchema(name string, cols []string) *TableSchema {
	ts := &TableSchema{
		TableName:   name,
		Columns:     make(map[string]*Column, len(cols)),
		ColumnOrder: cols,
	}
	for _, c := range cols {
		ts.Columns[c] = &Column{
			Name:       c,
			ColType:    "TEXT",
			IsNullable: false,
		}
	}
	return ts
}

func TestReplacePlaceholders_AllCases(t *testing.T) {
	// 1) Set up two 5-column tables: orders and ref_data
	schemas := map[string]*TableSchema{
		"orders":   makeSimpleSchema("orders", []string{"acc_no", "status", "amount", "id", "ts"}),
		"ref_data": makeSimpleSchema("ref_data", []string{"acc_no", "c2", "c3", "c4", "c5"}),
	}

	// 2) Table-driven inputs covering INSERT, SELECT, UPDATE, DELETE
	tests := []struct {
		name   string
		input  string
		table  string // expected table name in tags
		clause string // expected clause name in tags
	}{
		{"Insert no-cols", "INSERT INTO orders VALUES (_,__more__);", "orders", "INSERT"},
		{"Insert with cols + RETURNING", "INSERT INTO orders(acc_no, status, amount) VALUES (_, __more__) RETURNING id;", "orders", "INSERT"},
		{"Insert compact", "INSERT INTO orders(acc_no,status,amount) VALUES(_,__more__);", "orders", "INSERT"},
		{"Insert two-tuples", "INSERT INTO orders(acc_no, status, amount) VALUES  ( _ ,__more__ ) , (__, __more__) ;", "orders", "INSERT"},
		{"Insert mixed-case", "insert into orders(acc_no, status, amount) Values(_,__more__),( _,__more__ );", "orders", "INSERT"},
		{"Insert with funcs", "INSERT INTO orders(acc_no, status, amount) VALUES (NOW(), _),(CURRENT_TIMESTAMP, __more__);", "orders", "INSERT"},
		{"Insert three-row", "INSERT INTO orders(acc_no, status, amount) VALUES (_,__more__),( _,__more__ ),(__more__, _);", "orders", "INSERT"},
		{"Insert multi-3 no-cols", "INSERT INTO orders VALUES (_,__more__),( _,__more__),( __more__ , _);", "orders", "INSERT"},

		{"Select IFNULL+WHERE", "SELECT id, IFNULL(sum(amount), _) FROM orders WHERE acc_no = _;", "orders", "WHERE"},
		{"Select IFNULL only", "SELECT IFNULL(status, _) AS name FROM orders;", "orders", "WHERE"},
		{"Select AND", "SELECT * FROM orders WHERE (acc_no = _) AND (id = _);", "orders", "WHERE"},
		{"Select simple IN", "SELECT * FROM orders WHERE id IN (_, __more__, _);", "orders", "WHERE"},
		{"Select ref_data", "SELECT * FROM ref_data WHERE acc_no = _;", "ref_data", "WHERE"},
		{"Select BETWEEN", "SELECT * FROM orders WHERE amount BETWEEN _ AND __more__;", "orders", "WHERE"},
		{"Select between Tuple", "SELECT * FROM orders WHERE amount BETWEEN (_ ) AND (__more__);", "orders", "WHERE"},
		{"Select between with binary expr", "SELECT * FROM orders WHERE amount BETWEEN (_-_) AND (_-_);", "orders", "WHERE"},
		{"Select Limit", "SELECT * FROM orders WHERE amount > _ LIMIT _;", "orders", "LIMIT"},
		{"When Then SET", "UPDATE orders SET status = CASE amount WHEN _ THEN _ WHEN _ THEN _ ELSE _ END WHERE id = _;", "orders", "UPDATE"},
		{"Update tuple CASE", "UPDATE orders SET amount = CASE (amount, status) WHEN (_, __more__) THEN _ ELSE _ END;", "orders", "UPDATE"},

		{"Large IN", "SELECT * FROM orders WHERE id IN (_, __more__, _, __more__, _);", "orders", "WHERE"},
		{"Paren BETWEEN", "SELECT * FROM orders WHERE amount BETWEEN (_ ) AND (__more__);", "orders", "WHERE"},
		{"multi col in", "SELECT * FROM orders WHERE (acc_no, status) IN ((_,__more__),__more__);", "orders", "WHERE"},

		{"Update simple", "UPDATE orders SET status = _ WHERE id = _;", "orders", "UPDATE"},
		{"Update multi-col", "UPDATE orders SET status = _, amount = __more__ WHERE acc_no = _;", "orders", "UPDATE"},
		{"Update with func", "UPDATE orders SET updated_at = NOW(), status = _ WHERE id = _;", "orders", "UPDATE"},

		{"Update tuple LHS", "UPDATE orders SET (acc_no, id) = (_, __more__) WHERE status = _;", "orders", "UPDATE"},
		{"Update tuple RHS", "UPDATE orders SET (status, amount) = (__more__, _) WHERE id = _;", "orders", "UPDATE"},

		{"Delete simple", "DELETE FROM orders WHERE acc_no = _;", "orders", "WHERE"},
		{"Delete tuple", "DELETE FROM orders WHERE (acc_no, id) = (_, __more__);", "orders", "WHERE"},
	}

	// regex to strip out our metadata tags of form :-:|...|:-:
	tagRE := regexp.MustCompile(`:-:\|.*?\|:-:`)
	// regex to detect standalone placeholders "_" or "__more__"
	placeholderRE := regexp.MustCompile(`\b_\b|\b__more__\b`)

	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			out, err := replacePlaceholders(tt.input, schemas)
			if err != nil {
				t.Fatalf("replacePlaceholders(%q) error: %v", tt.input, err)
			}

			// Remove all metadata tags, leaving regular SQL
			cleaned := tagRE.ReplaceAllString(out, "")

			// Determine if this input actually contained a placeholder token
			hadPlaceholder := placeholderRE.MatchString(tt.input)

			if hadPlaceholder {
				// After stripping tags, no standalone "_" or "__more__" should remain
				if placeholderRE.MatchString(cleaned) {
					t.Errorf("raw placeholder remains after cleaning: %q", cleaned)
				}
				// We expect at least one tag delimiter in the output
				if !strings.Contains(out, ":-:|") {
					t.Errorf("expected placeholder tags in output: %q", out)
				}
				// And the clause and table names should both appear somewhere in those tags
				if !strings.Contains(out, tt.clause) {
					t.Errorf("expected clause %q in tags: %q", tt.clause, out)
				}
				if !strings.Contains(out, tt.table) {
					t.Errorf("expected table %q in tags: %q", tt.table, out)
				}
			} else {
				// No placeholders → output should be unchanged (ignoring whitespace)
				normalizedIn := strings.Join(strings.Fields(tt.input), " ")
				normalizedOut := strings.Join(strings.Fields(out), " ")
				if normalizedIn != normalizedOut {
					t.Errorf("expected no change for %q, got %q", tt.input, out)
				}
			}
		})
	}
}
