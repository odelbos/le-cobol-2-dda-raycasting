#!/bin/sh

set -xe

mkdir -p ./build

gcc -c wrapper.c -o ./build/wrapper.o

cobc -x -o raycast main.cbl ./build/wrapper.o
