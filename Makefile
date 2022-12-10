
TESTS = tests/geojson-to-sqlite/time.txt

# data
processed/counties_2020.geojson:
	pipenv run censusmapdownloader counties

# tests

tests/%/time.txt: processed/counties_2020.geojson
	./test.sh $(dir $@) $<

all: $(TESTS)