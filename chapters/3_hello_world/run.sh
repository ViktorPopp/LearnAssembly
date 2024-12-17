#!/usr/bin/env bash

mkdir -p ./bin/
nasm -f elf64 main.asm -o ./bin/main.o
ld bin/main.o -o ./bin/main
chmod +x ./bin/main
./bin/main
echo "[Exited with error code: $?]"
