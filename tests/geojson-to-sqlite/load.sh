#!/usr/bin/env bash

set -e

echo "Testing geojson-to-sqlite"

filename=$1
dir=$2

db="${dir}test.db"
table=$(basename $filename .geojson)
output="${dir}time.txt"

echo "Dir: $dir"
echo "DB: $db"
echo "Table: $table"
echo "File: $filename"

pipenv run geojson-to-sqlite $db $table $filename --spatialite
