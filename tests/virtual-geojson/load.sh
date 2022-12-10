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

SQL=$(cat << EOF
-- create a virtual table
create virtual table geojson using VirtualGeoJSON($filename);

-- read it into a table
create table $table as
select * from geojson;

-- done with the virtual table
drop table geojson;
EOF
)

spatialite -silent "$db" "$SQL"