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

# borrowing a bit from Alex Garcia here
SQL=$(cat << EOF
    select load_extension('/usr/local/lib/mod_spatialite.dylib');

    create table counties_2020 as
    select 
        value ->> '$.properties.state_fips'     as state_fips,
        value ->> '$.properties.county_fips'    as county_fips,
        value ->> '$.properties.geoid'          as geoid,
        value ->> '$.properties.county_name'    as county_name,
        GeomFromGeoJSON(value ->> '$.geometry') as geometry
    from json_each(readfile('processed/counties_2020.geojson'), '$.features');
EOF
)

/usr/local/opt/sqlite3/bin/sqlite3 $db "$SQL"
