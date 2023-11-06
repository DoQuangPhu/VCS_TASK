segment .data
    newline  db 10;
    msg db "Enter sth:"
    msg_len equ $- msg 
segment .bss
    buffer resb 100

segment .text
    global _start;

_start:
    mov rax,1
    mov rdi,1
    mov rsi,msg
    mov rdx,msg_len
    syscall

    xor rax,rax
    xor rdi,rdi
    mov rsi,buffer
    mov dl,100
    syscall

    mov edx,eax
    mov rax,1
    mov rdi,1
    syscall

    mov eax,0x3c
    syscall