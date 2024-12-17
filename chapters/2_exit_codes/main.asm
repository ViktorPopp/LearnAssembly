global _start   ; make the _start label globally accessible

section .text   ; this is where the executable code resides

_start:         ; the entry point of the program
    mov rax, 60 ; 60 is the syscall number for "exit"
    mov rdi, 0  ; exit status code that the "exit" syscall will use
    syscall     ; makes the system call to the kernel
