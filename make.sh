#!/bin/sh

MAC_OSX=false
[ `uname` = "Darwin"   ] && MAC_OSX=true

mkdir -p ./build

CC=gcc
CFLAGS="-Wall -Wextra"

RAYLIB_FLAGS="-I/opt/raylib-5.5/include"
RAYLIB_LIBS="-L/opt/raylib-5.5/lib -lraylib"

if $MAC_OSX; then
  RAYLIB_FLAGS=`pkg-config --cflags raylib`
  RAYLIB_LIBS=`pkg-config --libs raylib`
else
  #
  # NOTE:
  # On Ubuntu, the GnuCOBOL compiler define the _FORTIFY_SOURCE flag two times, like:
  #   -D_FORTIFY_SOURCE=2 -Wdate-time -D_FORTIFY_SOURCE=3
  # This cause the GCC compiler to emit the following warning:
  #   <command-line>: warning: "_FORTIFY_SOURCE" redefined
  #   <command-line>: note: this is the location of the previous definition
  # To fix this warning we need to redefine the COB_CFLAGS as follow:
  #
  export COB_CFLAGS="-finline-functions -ggdb3 -pipe -Wdate-time -D_FORTIFY_SOURCE=3 -Wno-unused -fsigned-char -Wno-pointer-sign"
  #
  # PS: cobc --info   (to get all the default defined flags)
  #
fi

echo "RAYLIB flags: $RAYLIB_FLAGS"
echo "RAYLIB libs: $RAYLIB_LIBS"

echo "Compiling ..."

set -xe

$CC $CFLAGS $RAYLIB_FLAGS -c wrapper.c -o ./build/wrapper.o

cobc -x -o raycast main.cbl ./build/wrapper.o -I copybooks \
  $RAYLIB_LIBS -lm -lpthread
