
TESTS = tests/geojson-to-sqlite/time.txt



# data
processed/counties_2020.geojson:
	pipenv run censusmapdownloader counties

processed/tracts_2020_%.geojson:
	pipenv run censusmapdownloader tracts

alltheplaces/url.txt:
	mkdir -p $(dir $@)
	curl https://data.alltheplaces.xyz/runs/history.json | jq -r 'sort_by(.start_time) | reverse [0].output_url' > $@

alltheplaces/output.tar.gz: alltheplaces/url.txt
	wget -O $@ $(shell cat $^)
	touch $@

alltheplaces: alltheplaces/output.tar.gz
	tar -zxvf $^
	find output -type f -empty -delete
	mv output/* alltheplaces/
	rm -r output/

counties: processed/counties_2020.geojson
tracts: processed/tracts_2020_al.geojson

# tests

tests/%/time.txt: processed/counties_2020.geojson
	./test.sh $(dir $@) $<

all: $(TESTS)

run:
	pipenv run datasette serve $(shell find . -name test.db) --load-extension spatialite
