# Calling From C
Many tasks that are trivial in high level languages can be quite complicated in Assembly. So far we have printed a string to the screen and read the exit code of a program via `echo $?`. Sometimes, however, we just want to know what is the content of a register. <br>
We can do this by writing a program that "returns" the value of that register by putting it in `rax` and returning control to the caller, and writing a C program to call this assembly program and write its return to the screen.

## The C Code (main.c)
```c
#include <stdio.h>
#include <inttypes.h>

uint64_t asm_func();
void print_binary(uint64_t);

int main() {
  uint64_t result = asm_func();
  printf("SGN: %" PRId64 "\n", (int64_t) result);   // 64-bit number
  printf("DEC: %" PRIu64 "\n", result);             // 32-bit Decimal Number
  printf("HEX: %" PRIx64 "\n", result);             // 32-bit Hexadecimal Number
  print_binary(result);                             // 64-bit binary representation
  return 0;
}

void print_binary(uint64_t number) {
  char str[64];

  for(int i = 63; i >= 0; i--) {
    if(number & 1 > 0) str[i] = '1';
    else str[i] = '0';
    number = number >> 1;
  }

  printf("BIN: ");

  for(int i = 0; i < 64; i++) {
    printf("%c", str[i]);
    if(i % 8 == 7) printf(" ");
  }

  printf("\n");
}
```
1. `uint64_t asm_func()`: This function is not defined in this translation unit but instead in our assembly code. The linker will "link" them together.
2. `int main() {...}`: Takes the result from the `asm_func()` function and prints it in diffrent formats. The C runtime has a `_start` symbol which calls our main and initializes all of our global variables (currently we don't have any).
3. `void print_binary(uint64_t number) {...}`: A simple function turning a 64-bit integer into a binary string and prints it to stdout.


## The Assembly Code (return.asm)
```assembly
global asm_func

section .text

asm_func:
    mov rax, 10000000000  ; 10 billion doesn't fit in a 32-bit int
    ret                   ; returns control to the caller

section .note.GNU-stack noalloc noexec nowrite progbits
```
1. We define a global symbol called `asm_func` that moves a very big number into `rax` which is the register that will be returned when calling the `ret` instruction. <br>
2. `section .note.GNU-stack noalloc noexec nowrite progbits`: The `.note.GNU-stack` section in an ELF file marks the stack as non-executable, with specific flags indicating that the stack shouldn't be allocated in memory, shouldn't be writable, and should be protected against execution. This is a security feature aimed at preventing exploits that rely on executing code from the stack, such as stack buffer overflow attacks. Read more [**HERE**](../../references/gnu_stack.md)

## Run The Code (run.sh)
```bash
#!/usr/bin/env bash

mkdir -p ./bin/
nasm -f elf64 return.asm -o ./bin/return.o
gcc main.c ./bin/return.o -o ./bin/main
chmod +x ./bin/main
./bin/main
echo "[Exited with error code: $?]"
```
Because we are now using C we can let `gcc` link the program for us. However we can still do it ourselves by passing the `-c` flag to `gcc`.
