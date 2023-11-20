segment .data
    menu db "1.nhan",0xa,"2.chia",0xa,"3.cong",0xa,"4.tru",0xa,"nhap lua chon: "
    len equ $- menu
    msg1 db "nhap so thu 1:"
    len1 equ $- msg1
    msg2 db "nhap so thu 2:"
    len2 equ $- msg2
    msg3 db "invalid in put:!",0xa
    len3 equ $- msg3
    newline db 0xa
segment .bss
    N resb 4
    op1 resb 11
    op2 resb 11
    num1 resd 1
    num2 resd 1
    num resq 1
    output resb 12
    output_rev resb 12
segment .text
    global _start

_start:
    __infinite_calculator:
        mov rsi,menu
        mov rdx,len
        call __print
        
        mov rsi,N 
        mov rdx,4
        call _scan
        mov rdi,N 
        call _atoi
        push rax 

        mov rsi,msg1
        mov rdx,len1
        call __print
        mov rsi,op1
        mov rdx,11
        call _scan
        mov rdi,op1 
        call _is_valid_num
        mov rdi,op1 
        call _atoi
        mov DWORD[num1],eax 
        
        mov rsi,msg2
        mov rdx,len2 
        call __print

        mov rsi,op2
        mov rdx,11
        call _scan
        mov rdi,op2 
        call _is_valid_num
        mov rdi,op2 
        call _atoi
        mov DWORD[num2],eax 

        pop rax 
        cmp rax,1
        je _nhan
        cmp rax,2
        je _chia
        cmp rax,3 
        je _cong
        cmp rax,4 
        je _tru
    _label1:
        mov rsi,msg3
        mov rdx,len3
        call __print

        jmp __infinite_calculator

_nhan:
    xor rax,rax 
    xor rbx,rbx
    mov eax,DWORD[num1]
    mov ebx, DWORD[num2]
    mul ebx 
    mov QWORD[num],rax
    mov rdi,QWORD[num]
    mov rsi,output
    call _itoa

    mov rdi , output
    call _strlen
    mov rcx,rax
    dec rax
    mov r9,rax 
    mov rsi,output_rev
    call _reverse_string
    mov rdi,output_rev
    call _strlen
    mov rdx,rax
    mov rsi,output_rev
    call __print
    mov rsi,newline
    mov rdx,1

    call __print
    jmp __infinite_calculator
_chia:
    xor rax,rax 
    xor rbx,rbx
    mov eax,DWORD[num1]
    mov ebx, DWORD[num2]
    cmp ebx,0
    je _label1
    div ebx 
    mov QWORD[num],rax
    mov rdi,QWORD[num]
    mov rsi,output
    call _itoa

    mov rdi , output
    call _strlen
    mov rcx,rax
    dec rax
    mov r9,rax 
    mov rsi,output_rev
    call _reverse_string
    mov rdi,output_rev
    call _strlen
    mov rdx,rax
    mov rsi,output_rev
    call __print
    mov rsi,newline
    mov rdx,1

    call __print
    jmp __infinite_calculator 
_cong:
    xor rax,rax 
    xor rbx,rbx
    mov eax,DWORD[num1]
    mov ebx, DWORD[num2]
    add eax,ebx  
    mov QWORD[num],rax
    mov rdi,QWORD[num]
    mov rsi,output
    call _itoa

    mov rdi , output
    call _strlen
    mov rcx,rax
    dec rax
    mov r9,rax 
    mov rsi,output_rev
    call _reverse_string
    mov rdi,output_rev
    call _strlen
    mov rdx,rax
    mov rsi,output_rev
    call __print
    mov rsi,newline
    mov rdx,1

    call __print
    jmp __infinite_calculator
_tru: 

    xor rax,rax 
    xor rbx,rbx
    mov eax,DWORD[num1]
    mov ebx, DWORD[num2]
    cmp eax,ebx
    jl _negative
    sub eax,ebx
    mov BYTE[output_rev],'+' 
    jmp _label2  
    _negative:
        sub ebx,eax
        mov rax,rbx
        mov BYTE[output_rev],'-'
    _label2:
        mov QWORD[num],rax
        mov rdi,QWORD[num]
        mov rsi,output
        call _itoa

        mov rdi , output
        call _strlen
        mov rcx,rax
        dec rax
        mov r9,rax 
        mov rsi,output_rev
        inc rsi
        call _reverse_string
        mov rdi,output_rev
        call _strlen
        mov rdx,rax
        mov rsi,output_rev
        call __print
        mov rsi,newline
        mov rdx,1

        call __print
        jmp __infinite_calculator 




_reverse_string: ;    mov rdi,S    mov rsi,S_reverse
    mov BYTE[rsi+r9+1],0
    _reverse_string_internal:
        mov al,BYTE [rdi+r8]
        mov BYTE [rsi+r9],al
        inc r8
        dec r9
        loop _reverse_string_internal
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
        inc r9
        mov BYTE[rsi+r9],0
        ret 