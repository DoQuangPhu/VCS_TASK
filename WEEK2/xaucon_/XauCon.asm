segment .data
	msg1 db "nhap sau S:"	
	len1 equ $- msg1	; do dai msg1
	msg2 db "nhap sau C:"
	len2 equ $- msg2	; do dai msg2
	newline db 0xa		;dau xuong dong
	space db 32 		;dau cach
segment .bss
	S resb 100
    C resb 10
    intoa resb 4

segment .text
	global _start:
_start:
    mov rsi,msg1
    mov rdx ,len1
    call __print

    mov rsi,S
    mov rdx,100
    call _scan

    mov rsi,msg2
    mov rdx ,len1
    call __print

    mov rsi,C 
    mov rdx,10
    call _scan
    xor r8,r8
    call _strstr

    call _exit

_strstr: ; r8 as index
    mov rdi,S 
    mov rsi,C 
    mov dl,BYTE [rdi+r8]
    cmp dl,0xa
    je _exit
    mov dl,BYTE [rsi] 
    cmp BYTE [rdi+r8],dl 
    je _strstr_internal_check
    inc r8
    jmp _strstr 

    _strstr_internal_check:
        push rdi 
        push r8 
        xor r8,r8 
        mov rdi,C 
        call _strlen 
        mov r10,QWORD [rsp+0x8]
        mov r9,QWORD[rsp] ; r9 is our index for S string
        mov rcx,rax
        _check:
            mov dl,BYTE[C+r8]
            cmp BYTE [r10+r9],dl
            jne _done
            inc r8 
            inc r9
            loop _check
        _implement_result:
            mov rax,QWORD[rsp]
            mov rdi,intoa
            xor r9,r9 
            call _intoa
            mov rsi,rax
            mov rdx,3 
            call __print
            mov DWORD[intoa],0
            mov rsi,space
            mov rdx,1
            call __print
            jmp _done 
        _done:

            pop r8
            pop rdi
            inc r8
            jmp _strstr





_intoa: ;_intoa(rax=value,rdi=buf,r9 = 0)
    push rax ; r9 is 0 now so we can use it as count variable
    jmp _intoa_count_len

    _intoa_:
        dec r9
        mov rbx,10
        xor rdx,rdx
        div rbx
        add dl,'0'
        mov BYTE [rdi+r9],dl
        dec r9
        cmp rax,0
        jnz _intoa
        mov rax,rdi
        ret 
    _intoa_count_len:
        inc r9
        mov rbx,10
        xor rdx,rdx
        div rbx
        cmp rax, 0
        je _intoa_count_len_done
        jmp _intoa_count_len
        _intoa_count_len_done:
            pop rax
            jmp _intoa_

    
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