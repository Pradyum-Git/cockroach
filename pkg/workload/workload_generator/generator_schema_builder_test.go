package workload_generator

import (
	"os"
	"testing"

	"gopkg.in/yaml.v3"
)

func TestBuildWorkloadSchema(t *testing.T) {
	// ---- CONFIGURE THESE ----
	zipDir := "/Users/pradyumagarwal/workloads/git-dbworkload/dbworkload_intProj/debug-zips/debug_2"
	dbName := "tpcc"
	outputFile := "test_workload_schema.yaml"
	// --------------------------

	// Step 1: parse the DDLs
	ddlSchemas, _, err := GenerateDDLs(zipDir, dbName, false)
	if err != nil {
		t.Fatalf("GenerateDDLs failed: %v", err)
	}
	t.Logf("✅ parsed %d tables from DDL", len(ddlSchemas))

	// Step 2: build the in-memory workload schema
	ws := buildWorkloadSchema(ddlSchemas, dbName, 1000)
	t.Logf("✅ built workload schema for %d tables", len(ws))

	// Step 3: serialize to YAML so we can eyeball it
	out, err := yaml.Marshal(ws)
	if err != nil {
		t.Fatalf("failed to marshal workload schema to YAML: %v", err)
	}

	// Step 4: write to disk
	if err := os.WriteFile(outputFile, out, 0644); err != nil {
		t.Fatalf("error writing workload schema to %s: %v", outputFile, err)
	}
	t.Logf("✅ workload schema written to %s", outputFile)
}
