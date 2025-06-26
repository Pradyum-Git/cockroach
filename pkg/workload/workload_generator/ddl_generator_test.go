// Copyright 2025 The Cockroach Authors.
//
// Use of this software is governed by the CockroachDB Software License
// included in the /LICENSE file

// ddl_generator_test.go
// Unit tests for ddl_generator.go
package workload_generator

import (
	"os"
	"testing"
)

const (
	testZipDir = "/Users/pradyumagarwal/workloads/git-dbworkload/dbworkload_intProj/debug-zips/debug_2"
	testDBName = "tpcc"
)

func TestSplitColumnDefsAndTableConstraints(t *testing.T) {
	body := `
		id INT PRIMARY KEY,
		name TEXT NOT NULL,
		age INT DEFAULT 30,
		CONSTRAINT user_pk PRIMARY KEY (id),
		UNIQUE (name),
		FOREIGN KEY (age) REFERENCES other(age),
		CHECK (age > 0)
	`
	cols, constraints := splitColumnDefsAndTableConstraints(body)
	wantCols := []string{
	}
	wantConstraints := []string{
	}
}

	d := `CREATE TABLE IF NOT EXISTS schema.users (
		id INT PRIMARY KEY,
		name TEXT,
		age INT DEFAULT 18,
		email TEXT UNIQUE,
		country TEXT CHECK (country IN ('US','CA'))
    CHECK (age>0)
	)`
	schema, err := ParseDDL(d)
	// Table name
	// Column order
	wantCols := []string{"id", "name", "age", "email", "country"}
	// Primary key
	// Default value
	// Unique
	// Check constraint
	d := `CREATE TABLE orders (
		order_id INT,
		user_id INT,
		amount DECIMAL REFERENCES users(amt),
		PRIMARY KEY (order_id, user_id),
		UNIQUE (amount),
		FOREIGN KEY (user_id) REFERENCES users(id),
		CHECK (amount > 0)
	)`
	schema, err := ParseDDL(d)
	// Composite primary key
	// Unique constraints
	// Foreign keys
	fk := schema.ForeignKeys[0]
	// Check constraints
	_, err := ParseDDL("INVALID DDL")
}

func TestGenerateDDLsIntegration(t *testing.T) {
	if _, err := os.Stat(testZipDir); os.IsNotExist(err) {
		t.Skipf("testZipDir %s not found; skipping integration test", testZipDir)
	}
	schemas, stmts, err := GenerateDDLs(testZipDir, testDBName, false)
}
