segment .data
	msg1 db "how much?:",0
	len1 equ $- msg1	; do dai msg1
	msg2 db "enter positive number only:",0xa
	len2 equ $- msg2	; do dai msg2
    msg3 db "invalid in put:!",0xa
    msg4 db "CHAN :"
    len4 equ $- msg4
    msg5 db "LE :"
    len5 equ $- msg5 
    len3 equ $- msg3 
	newline db 0xa		;dau xuong dong
	space db 32 		;dau cach
    TotalOdd dq 0
    TotalEven dq 0
segment .bss
	N resb 4
    array resd 100
    intoa resb 4
    TotalEvenBuf resb 11
    TotalEvenOutPut resb 11
    TotalOddBuf  resb 11
    TotalOddOutPut resb 11
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
    mov rcx,rax
    sub rax,2
    mov r9,rax
    mov rdi,N 
    call _atoi

    push rax 
    mov r10,rax
    xor r9,r9
    mov rdi,array
    _scan_loop:
        push r9 
        mov rsi,msg2
        mov rdx,len2
        call __print

        mov rsi,number
        mov rdx,11
        call _scan
        push rax
        mov rdi,rsi
        call _is_valid_num
        pop rax 
        mov rcx,rax
        sub rax,2
        mov r9,rax
        mov rdi,number 
        call _atoi
        pop r9
        mov DWORD[rdi +r9*4],eax 
        call _EvenorOdd
        inc r9

        cmp r9,r10
        je _scan_loop_done
        jmp _scan_loop

        _scan_loop_done:
            mov rdi,QWORD[TotalEven]
            mov rsi,TotalEvenBuf
            call _itoa
            mov rdi,TotalEvenBuf
            call _strlen
            mov rcx,rax
            dec rax
            mov r9,rax
            mov rsi,TotalEvenOutPut 
            call _reverse_string
            mov rdi,rsi
            call _strlen
            push rax
            mov rsi,msg4
            mov rdx,len4
            call __print
            pop rdx
            mov rsi,TotalEvenOutPut
            call __print

            mov rsi,newline
            mov rdx,1
            call __print

            mov rdi,QWORD[TotalOdd]
            mov rsi,TotalOddBuf
            call _itoa
            mov rdi,TotalOddBuf
            call _strlen
            mov rcx,rax
            dec rax
            mov r9,rax
            mov rsi,TotalOddOutPut 
            call _reverse_string
            mov rdi,rsi
            call _strlen
            push rax
            mov rsi,msg5
            mov rdx,len5
            call __print
            pop rdx
            mov rsi,TotalOddOutPut
            call __print

            mov rsi,newline
            mov rdx,1
            call __print

            call _exit



_EvenorOdd:
    xor rdx,rdx
    mov rbx,2
    div ebx
    cmp dl,1
    je _odd
    cmp dl,0
    je _even 

    _odd:
        mov edx,DWORD[rdi+r9*4]
        add QWORD[TotalOdd],rdx
        ret   
    _even:
        mov edx,DWORD[rdi+r9*4]
        add QWORD[TotalEven],rdx
        ret       
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