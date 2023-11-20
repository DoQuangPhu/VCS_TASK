segment .text
    global _start
_start:
    mov rdi,12345
    mov rsi,rsp
    call _itoa
    



_itoa:
    xor r8,r8
    xor r9,r9 
    mov rbx,0xa
    mov rax,rdi 
    _itoa_internal:
        div rbx
        add rdx,0x30
        mov BYTE [rsi+r9],dl
        xor rdx,rdx
        cmp rax,0
        je _itoa_done 
        inc r9
        jmp _itoa_internal
    _itoa_done:

        ret 






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

_atoi:
    mov rbx,10
    xor r9,r9 
    xor rax,rax 
    _atoi_internal:
        cmp BYTE [rdi+r9],0
        je _atoi_internal_done
        cmp BYTE [rdi+r9],0xa
        je _atoi_internal_done
        mov rbx , 10
        mul rbx
        mov bl,BYTE[rdi+r9]
        sub bl,0x30
        add rax,rbx
        inc r9
        jmp _atoi_internal
    _atoi_internal_done:
        mov rdi,rsi
        call _strlen
        ret
_is_valid_num:
    xor r8,r8
    _is_valid_num_internal:
        cmp BYTE [rdi+r8],0
        je _is_valid_num_done
        cmp BYTE [rdi+r8],0xa
        je _is_valid_num_done
        cmp BYTE [rdi+r8],0x30
        jl invalid
        cmp BYTE [rdi+r8],0x39
        jg invalid
        inc r8
        jmp _is_valid_num_internal

    invalid:
        mov rsi,msg3
        mov rdx,len3
        call __print
        
        call _exit
    _is_valid_num_done:
        ret 

_itoa:
    xor r8,r8
    xor r9,r9 
    mov rbx,0xa
    mov rax,rdi 
    _itoa_internal:
        div rbx
        add rdx,0x30
        mov [number+r9],dl
        xor rdx,rdx
        cmp rax,0
        je _itoa_done 
        inc r9
        jmp _itoa_internal
    _itoa_done:
        ret 

_reverse_string: ;    mov rdi,S    mov rsi,S_reverse
    mov al,BYTE [rdi+r8]
    mov BYTE [rsi+r9],al
    inc r8
    dec r9
    loop _reverse_string
    mov rax,rsi
    ret