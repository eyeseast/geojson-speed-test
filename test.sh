#!/usr/bin/env bash

test_dir=$1
filename=$2

output=$test_dir/time.txt

for cycle in {1..5}; do
    rm -f $test_dir/test.db; # delete the test database if it exists
    /usr/bin/time -a -o $output ./$test_dir/load.sh $filename $test_dir $cycle;
done
