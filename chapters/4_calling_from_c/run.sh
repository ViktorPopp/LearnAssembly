#!/usr/bin/env bash

mkdir -p ./bin/
nasm -f elf64 return.asm -o ./bin/return.o
gcc main.c ./bin/return.o -o ./bin/main
chmod +x ./bin/main
./bin/main
echo "[Exited with error code: $?]"
