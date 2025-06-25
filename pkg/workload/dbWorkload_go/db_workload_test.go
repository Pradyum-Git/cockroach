package dbworkloadgo

import (
	"fmt"
	"os"
	"testing"

	"gopkg.in/yaml.v3"
)

func TestGetTableOrder(t *testing.T) {
	// 1) Load the YAML produced by your generator
	raw, err := os.ReadFile("test_output.yaml")
	if err != nil {
		t.Fatalf("could not read test_output.yaml: %v", err)
	}

	// 2) Unmarshal into the Schema type
	var schema Schema
	if err := yaml.Unmarshal(raw, &schema); err != nil {
		t.Fatalf("failed to unmarshal YAML: %v", err)
	}

	// 3) Compute the table order
	order := getTableOrder(schema)

	// 4) Write it out for inspection
	f, err := os.Create("table_order.txt")
	if err != nil {
		t.Fatalf("could not create table_order.txt: %v", err)
	}
	defer f.Close()

	for i, tbl := range order {
		// number it if you like, or just print the names
		fmt.Fprintf(f, "%d: %s\n", i, tbl)
	}
}
