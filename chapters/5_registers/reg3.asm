global asm_func 

section .text

asm_func:
    mov rax, 5000000000
    mov eax, 3
    ret

section .note.GNU-stack noalloc noexec nowrite progbits
