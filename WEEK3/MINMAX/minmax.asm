segment .data
	msg1 db "how much?:",0
	len1 equ $- msg1	; do dai msg1
	msg2 db "enter positive number only:",0xa
	len2 equ $- msg2	; do dai msg2
    msg3 db "invalid in put:!",0xa
    len3 equ $- msg3 
	newline db 0xa		;dau xuong dong
	space db 32 		;dau cach
segment .bss
	N resb 4
    array resd 100
    intoa resb 4
    maxbuf resb 11
    MaxBufOutPut resb 11
    minbuf  resb 11
    MinBufOutPut resb 11
    min resd 1
    max resd 1
    number resb 11

segment .text
    global _start

_start:
    mov rsi,msg1
    mov rdx,len1
    call __print
    
    mov rsi,N 
    mov rdx,4
    call _scan
    mov rdi,N 
    call _atoi
    push rax ; saved the count so we can use it again
    mov r10,rax
    xor rax,rax 
    xor r8,r8
    xor r9,r9 
    mov rdi , array
    get_num:
        inc r9
        push rdi
        mov rsi,msg2
        mov rdx,len2
        call __print
        mov rsi,number
        mov rdx,11
        call _scan

        mov rdi,rsi
        push r9 
        call _is_valid_num
        call _atoi
        pop r9
        pop rdi 
        mov DWORD[rdi],eax
        add rdi , 4
        cmp r9,r10
        jl  get_num
    pop r10
    xor r9 ,r9 
    mov rdi,array
    mov eax,DWORD[rdi]
    mov rdx,min
    mov DWORD[rdx],eax
    mov eax,DWORD[rdi]
    mov rdx,max
    mov DWORD[rdx],eax
    xor rax,rax 
    minmax: 
        inc r9   
        mov eax,DWORD[rdi]
        cmp eax,DWORD[max]
        jg _newmax
        cmp eax,DWORD[min]
        jl _newmin
        add rdi,4
        cmp r9,r10
        jl minmax 
        jmp minmax_done
    _newmax:
        mov rdx,max
        mov DWORD[rdx],eax
        add rdi,4
        cmp r9,r10
        jl minmax 
        jmp minmax_done

    _newmin:
        mov rdx,min
        mov DWORD[rdx],eax
        add rdi,4
        cmp r9,r10
        jl minmax 
        jmp minmax_done
    minmax_done:
        mov edi,DWORD[min]
        mov rsi,minbuf
        call _itoa
        mov rdi,minbuf
        call _strlen
        mov rcx,rax
        dec rax
        mov r9,rax
        mov rsi,MinBufOutPut
        call _reverse_string
        mov rdi,MinBufOutPut
        call _strlen
        mov rdx,rax
        mov rsi,MinBufOutPut
        call __print

        mov rsi,newline
        mov rdx,1
        call __print
        mov edi,DWORD[max]
        mov rsi,maxbuf
        call _itoa
        mov rdi,maxbuf
        call _strlen
        mov rcx,rax
        dec rax
        mov r9,rax
        mov rsi,MaxBufOutPut
        call _reverse_string
        mov rdi,MaxBufOutPut
        call _strlen
        mov rdx,rax
        mov rsi,MaxBufOutPut
        call __print

        call _exit

        
_reverse_string: ;    mov rdi,S    mov rsi,S_reverse
    mov al,BYTE [rdi+r8]
    mov BYTE [rsi+r9],al
    inc r8
    dec r9
    loop _reverse_string
    mov rax,rsi
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
        cmp BYTE [rdi+rax],0
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
    xor rdx,rdx
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
    