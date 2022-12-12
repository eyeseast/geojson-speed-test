
TESTS = tests/geojson-to-sqlite/time.txt

# data
processed/counties_2020.geojson:
	pipenv run censusmapdownloader counties

processed/tracts_2020_%.geojson:
	pipenv run censusmapdownloader tracts

counties: processed/counties_2020.geojson
tracts: processed/tracts_2020_al.geojson

# tests

tests/%/time.txt: processed/counties_2020.geojson
	./test.sh $(dir $@) $<

all: $(TESTS)