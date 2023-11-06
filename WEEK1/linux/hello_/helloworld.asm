segment .data
    newline  db 10;
    msg db "hello world!",10
    len_msg equ $- msg;

segment .text
    global _start;

_start:
    mov rax,1
    mov rdi,1
    mov rsi,msg
    mov rdx,len_msg
    syscall

    mov eax,0x3c
    syscall
    