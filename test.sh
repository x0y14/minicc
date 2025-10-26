#!/bin/bash
assert() {
    expected="$1"
    input="$2"

    ./bin/minicc "$input" > ./tmp/test.mir
    ./bin/minivm run -l ./tmp/test.mir
    actual="$?"


    if [ "$actual" = "$expected" ]; then
        echo "$input => $actual"
    else
        echo "$input => $expected expected, but got $actual"
        exit 1
    fi
}

assert 0 0
assert 42 42
assert 21 "5+20-4"

echo OK