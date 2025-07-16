package workload_generator

import (
	"fmt"
	"os"
	"path/filepath"
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
		out, err := ReplacePlaceholders(in, schemas)
		if err != nil {
			t.Fatalf("ReplacePlaceholders(%q) error: %v", in, err)
		}
		fmt.Println("IN:  ", in)
		fmt.Println("OUT: ", out)
		fmt.Println("----")
	}
}

func TestGenerateWorkload_Smoke(t *testing.T) {
	debugZip := "/Users/pradyumagarwal/workloads/git-dbworkload/dbworkload_intProj/debug-zips/debug_2"
	dbName := "tpcc"
	outputDir := "/Users/pradyumagarwal/go/src/github.com/cockroachdb/cockroach/pkg/workload/workload_generator"

	// ensure output dir exists
	if err := os.MkdirAll(outputDir, 0755); err != nil {
		t.Fatalf("failed to create output dir: %v", err)
	}

	// for now, pass an empty schema map
	allSchemas := make(map[string]*TableSchema)

	err := GenerateWorkload(debugZip, allSchemas, dbName, outputDir)
	if err != nil {
		t.Fatalf("GenerateWorkload failed: %v", err)
	}

	outPath := filepath.Join(outputDir, dbName+".sql")
	if _, err := os.Stat(outPath); err != nil {
		t.Fatalf("expected output file %s not found: %v", outPath, err)
	}

	t.Logf("🎉 workload SQL written to %s", outPath)
}
