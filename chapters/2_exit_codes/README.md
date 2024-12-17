# Exit Codes
In this first program we simply return the exit code 0. Here is how it works:

## The code (main.asm)
```assembly
global _start

section .text

_start:
    mov rax, 60
    mov rdi, 0
    syscall
```
* `global _start`: This makes the `_start` label globally accessible, so the linker and operating system can find the entry point for the program.
* `section .text`: This defines the section of the program where the executable code resides.
* `_start`: This is the entry point of the program. When the program runs, execution starts here.
* `mov rax, 60`: Moves the value 60 into the `rax` register. In Linux, `60` is the syscall number for `exit`.
* `mov rdi, 0`: Moves the value `0` into the `rdi` register. This is the exit status code that the `exit` syscall will use.
* `syscall`: This makes a system call to the kernel. Here, it uses the `exit` syscall to terminate the program and return the exit status code `0`.

### Syscalls (System calls)
A syscall, or system call, is a way for programs to interact with the operating system's kernel. Syscalls provide a controlled interface for user-level applications to request services and resources managed by the OS. These requests can include tasks such as file manipulation, process control, and communication. 

#### How Syscalls Work:
1. **Request:** The program prepares a syscall request by placing the syscall number (which identifies the desired service) and any necessary arguments in specific registers.
2. **Interrupt:** The program triggers a software interrupt (often via the syscall instruction on x86_64) to switch from user mode to kernel mode.
3. **Execution:** The kernel receives the request, validates it, and executes the corresponding kernel function.
4. **Return:** The kernel places the result of the syscall back into a predefined register and switches back to user mode, returning control to the calling program. <br>
Syscalls are fundamental to the functionality of an operating system, as they provide a secure and efficient way for user applications to access kernel services.


## Run the code (run.sh)
This is a Bash script that assembles, links, and runs the assembly code.
```bash
#!/usr/bin/env bash

mkdir -p ./bin/
nasm -f elf64 main.asm -o ./bin/main.o
ld bin/main.o -o ./bin/main
chmod +x ./bin/main
./bin/main
echo "[Exited with error code: $?]"
```
* `#!/usr/bin/env bash`: This shebang line tells the system to use the Bash shell to interpret this script.
* `mkdir -p ./bin/`: Creates a directory named `bin` if it doesn't already exist. The `-p` flag ensures that no error is thrown if the directory already exists.
* `nasm -f elf64 main.asm-o ./bin/main.o`: Assembles the `main.asm` file into an object file named `main.o`, using the `ELF64` format, and places it in the `bin` directory.
* `ld bin/main.o -o ./bin/main`: Links the `main.o` object file to create an executable named `main` in the `bin` directory.
* `chmod +x ./bin/main`: Changes the permissions of the `main` file to make it executable.
* `./bin/main`: Executes the main program.
* `echo "[Exited with error code: $?]"`: Prints the exit code of the `main` program to the terminal. `$?` holds the exit code of the last executed command.

### ELF64 (Executable and Linkable Format 64-bit)
The Executable and Linkable Format (ELF) is a file format used for executables, object files, shared libraries, and core dumps in Unix-like operating systems, including Linux.

#### Key Components of an ELF File:
1. **Header:** Contains metadata about the file, including the type (executable, shared library, etc.), architecture (64-bit), entry point address, and offsets to other sections of the file.
2. **Program Header Table:** Contains information needed by the system loader to create a process image suitable for execution. This includes segments such as the text (code), data, and read-only data (rodata).
3. **Section Header Table:** Describes the sections in the file, such as the symbol table, string table, and various other data required for linking.
4. **Sections:**
    * `.text`: Contains the executable code.
    * `.data`: Contains initialized data.
    * `.bss`: Contains uninitialized data.
    * `.rodata`: Contains read-only data, such as constants and string literals.
5. **Dynamic Linking Information:** Contains information and pointers needed for dynamic linking and loading shared libraries.

#### How It Works
1. **Loader Reads the Header:** The system loader reads the ELF header to understand where the code is and what it needs to run.
2. **Creates Segments:** The loader creates segments in memory according to the program header table.
3. **Loads Sections:** The loader copies the contents of the .text, .data, and other sections into the appropriate memory segments.
4. **Starts Execution:** The loader jumps to the entry point address specified in the header to start executing the code.

## Challenge
Try setting the error code to `8` instead.
