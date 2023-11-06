segment .data
    newline  db 10;
    msg db "Enter sth:"
    msg_len equ $- msg 
segment .bss
    buffer resb 100

segment .text
    global _start



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
    mov rdi,rsi
    call _upper
    mov rax,0x3c
    syscall


_upper:

    mov r10,rax ; rax is buf len , rdi is our buf
    xor r8,r8
    check:
        mov al, BYTE  [rdi+r8]
        cmp al,0xa
        je _finish
        cmp al,0x61
        jge _check_2
        
        inc r8
        loop check

    _check_2:
        cmp al,0x7a
        jle _found
        ret 

    _found:
        sub al,0x20
        mov BYTE [rdi+r8],al
        inc r8 
        jmp _upper

    _finish:
        mov rsi,rdi
        mov rax,1
        mov rdi,1
        mov rdx,r10
        syscall
        ret




    