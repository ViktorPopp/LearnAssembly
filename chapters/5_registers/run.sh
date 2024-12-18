#!/usr/bin/env bash

mkdir -p ./bin/
nasm -f elf64 reg1.asm -o ./bin/reg1.o
ld bin/reg1.o -o ./bin/reg1
chmod +x ./bin/reg1
./bin/reg1
echo "[Exited with error code: $?]"
