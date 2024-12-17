# Hello World
In this second program we print the string "Hello, world!" to the console. Here is how it works:

## The code (main.asm)
```assembly
%define ENDL 10

global _start

section .text

_start:
    mov rax, 1
    mov rdi, 1
    mov rsi, msg_hello
    mov rdx, 14
    syscall

    mov rax, 60
    mov rdi, 0
    syscall


section .data
    msg_hello: db "Hello, world!", ENDL
```
Here is everything new we have added:
* `%define ENDL 10`: Defines a constant value 10 as ENDL (newline character). This is similar to the C/C++ preprocessor.
* `mov rax, 1`: Moves the code for the `write` syscall into `rax`.
* `mov rdi, 1`: The first parameter of the syscall is the file descriptor. `1` corresponds to the standard output (stdout).
* `mov rsi, 1`: The second parameter of the syscall is the pointer to the buffer to output. In this case the adress of `msg_hello`.
* `mov rdx, 14`: The second parameter of the syscall is the number of bytes to write. In this case `14` for the string and the `ENDL`.
* `section .data`: This indicates the beginning of the data section where variables and constants are placed.
* `msg_hello: db "Hello, world", ENDL`: Defines a sequence of data bytes using the `db` directive with the string "Hello, world" followed by a newline character.

## Directives versus Instructions
### Directives
Commands that are executed by the assembler during the assembly process. They are not translated into machine code but are used to control the assembly process, organize the code, and define data. Some common directives include defining constants, allocating space for variables, and specifying the start of code or data sections.
#### Examples:
* `%define ENDL 10`: Defines a constant value `10` named `ENDL`.
* `section .text`: Indicates the beginning of the code section.
* `global _start`: Makes the `_start` label globally accessible.
* `db "Hello, world"`: Defines a sequence of bytes (data).

### Instructions
Commands that are translated by the assembler into machine code that the CPU can execute. They perform actions such as moving data between registers, performing arithmetic operations, and controlling the flow of the program. Instructions are the actual operations that the CPU will execute at runtime.
#### Examples:
* `mov rax, 1`: Moves the value `1` into the `rax` register.
* `add rax, rbx`: Adds the value in `rbx` to the value in `rax` and stores the result in `rax`.
* `syscall`: Makes a system call.
* `jmp _label`: Jumps to the instruction at the label `_label`.

## Challenge
Try printing "I'm learning assembly" instead.
