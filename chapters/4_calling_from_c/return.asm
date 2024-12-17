global asm_func

section .text

asm_func:
    mov rax, 10000000000  ; 10 billion doesn't fit in a 32-bit int
    ret                   ; returns control to the caller

section .note.GNU-stack noalloc noexec nowrite progbits
