#!/bin/sh
find . -name cpu.pprof -print0 | xargs -0 go tool pprof -tags
