#!/bin/sh
for stat in "queries" "writes" "reads" "write_bytes" "read_bytes" "cpu_time"; do
	echo "$stat"
	find . -path './nodes/*/ranges/*.json' -print0 | xargs -0 grep "$stat"_per_second | sort -rhk3 | head -n 10
done
