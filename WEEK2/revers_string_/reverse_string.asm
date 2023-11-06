segment .data
    msg db "ENTER STHG:",0
    len equ $- msg 
	newline db 0xa		;dau xuong dong
	space db 32 		;dau cach
segment .bss
	S resb 100
    S_reverse resb 100

segment .text
	global _start:
_start:
    mov rsi,msg,
    mov rdx,len
    call __print

    mov rsi,S
    mov rdx,100
    call _scan

    mov rdi,S 
    call _strlen
    push rax 
    xor r8,r8
    mov r9,rax
    mov rcx , rax
    dec r9
    mov rdi,S
    mov rsi,S_reverse
    _reverse_string:
        mov al,BYTE [rdi+r8]
        mov BYTE [rsi+r9],al
        inc r8
        dec r9
        loop _reverse_string
    pop rdx 
    mov rsi,S_reverse
    call __print

    mov rdx,1
    mov rsi,newline
    call __print
    call _exit
    
_exit:
    mov rax,0x3c
    syscall

__print: 
	mov rax,1		; syswrite
	mov rdi,1		; tham so cho stdout
	syscall			; goi ham write
	ret			; tra ve luong thuc thi ban dau
_scan: ; useage scan(rsi,rdx)
	mov rax,0		;sysread
	mov rdi,0		;tham so cho stdin 
	syscall			; goi ham read
	ret	

_strlen: ; useage strlen(rdi)
    xor rax,rax
    _find_newline:
        cmp BYTE [rdi+rax],0xa
        je _strlen_done
        inc rax
        jmp _find_newline
    _strlen_done:
        ret