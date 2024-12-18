global asm_func 

section .text

asm_func:
    mov eax, 70000
    mov cx, 7
    mov dx, cx
    mov ax, dx
    ret

section .note.GNU-stack noalloc noexec nowrite progbits
