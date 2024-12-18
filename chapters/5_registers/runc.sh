#!/usr/bin/env bash

mkdir -p ./bin/
nasm -f elf64 $1.asm -o ./bin/$1.o
gcc main.c bin/$1.o -o ./bin/$1
chmod +x ./bin/$1
./bin/$1
echo "[Exited with error code: $?]"
