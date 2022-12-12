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
    select load_extension('/usr/local/lib/mod_spatialite.dylib');
    select InitSpatialMetaData();

    create table $table (
        id integer primary key,
        properties text
    );

    select AddGeometryColumn('$table', 'geometry', 4326, 'geometry');

    insert into $table
    select id, value ->> 'properties' as properties, GeomFromGeoJSON(value ->> 'geometry') as geometry 
    from json_each(readfile('$filename'), '$.features');
EOF
)

/usr/local/opt/sqlite3/bin/sqlite3 $db "$SQL"
