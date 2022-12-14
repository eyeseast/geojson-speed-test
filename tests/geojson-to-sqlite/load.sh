#!/usr/bin/env bash

set -e

filename=$1
dir=$2
cycle=${3:-1}

db="${dir}/test.db"
table=$(basename $filename .geojson)

if [[ $cycle == 1 ]]; then
    echo "Testing geojson-to-sqlite"
    echo "Dir: $dir"
    echo "DB: $db"
    echo "Table: $table"
    echo "File: $filename"
fi

pipenv run geojson-to-sqlite $db $table $filename --spatialite
