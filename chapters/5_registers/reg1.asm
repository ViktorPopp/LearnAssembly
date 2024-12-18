global _start

section .text

_start:
    mov rdx, 10
    xchg rax, rdx
    mov rbx, rax
    mov rdi, rbx
    mov rax, 60
    syscall
