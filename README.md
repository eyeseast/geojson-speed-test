# GeoJSON Speed Test

What's the fastest way to load GeoJSON into SQLite?

## Tools and methods to test

- `geojson-to-sqlite`
- `VirtualGeoJSON` using `spatialite` CLI
- SQLite CLI using `readfile` and JSON extension

## Test data

- US counties: A few thousand polygons in one file
- US Census tracts: Several hundred thousand polygons in many files
- AllThePlaces: Points with heterogeneous features in many files
