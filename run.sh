#!/bin/sh
set -e
cmake -B build
cmake --build build --target run
