#!/bin/sh

mkdir -p ./build

CC=gcc
CFLAGS="-Wall -Wextra"

RAYLIB_FLAGS=`pkg-config --cflags raylib`
RAYLIB_LIBS=`pkg-config --libs raylib`

echo "RAYLIB flags: $RAYLIB_FLAGS"
echo "RAYLIB libs: $RAYLIB_LIBS"

echo "Compiling ..."

set -xe

$CC $CFLAGS $RAYLIB_FLAGS -c wrapper.c -o ./build/wrapper.o

cobc -x -o raycast main.cbl ./build/wrapper.o \
  $RAYLIB_LIBS -lm -lpthread
