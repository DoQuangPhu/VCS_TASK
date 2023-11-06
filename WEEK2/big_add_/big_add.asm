segment .data
    newline db 0xa
	msg1 db "nhap so dau tien:"		
	len1 equ $- msg1			; do dai msg1
	msg2 db "nhap so thu hai:"
	len2 equ $- msg2			; do dai msg2
    msg3 db "ketqua: ",0
    len3 equ $- msg3

segment .bss
	num1 resb 22 				;so dau tien
    num1_rev resb 22
	num2 resb 22				; so thu 2
	num2_rev resb 22
    carry resb 1
    total resb 23
    total_output resb 23
segment .text
	global _start:
_start:
	mov rsi,msg1				
	mov rdx,len1				
	call __print					

	mov rsi,num1				
	mov rdx,21					
	call _scan		
    mov rcx , rax			
    sub rax ,2 
    mov r9,rax
    xor r8,r8
    mov rdi,num1
    mov rsi,num1_rev
    call _reverse_string
    push rax 



    mov rsi,msg2				
	mov rdx,len2				
	call __print					

	mov rsi,num2				
	mov rdx,21					
	call _scan	
    mov rcx,rax
    sub rax ,2 
    mov r9,rax
    xor r8,r8
    mov rdi,num2
    mov rsi,num2_rev
    call _reverse_string
    push rax 
    xor r8,r8
    call _add_loop
    pop rdx
    mov rdi ,total
    call _strlen
    inc rax 
    mov rcx,rax
    sub rax ,2 
    mov r9,rax
    xor r8,r8
    mov rdi ,total
    mov rsi ,total_output
    call _reverse_string

    mov rdi,total_output
    call _strlen
    inc rax
    mov rdx,rax
    inc rdx
    mov rdi,total_output
    call __print
    call _exit

_add_loop:
    mov r10,total
    mov rdi,QWORD [rsp + 8]
    mov rsi , QWORD [rsp + 0x10]
    __add1:
        xor rax,rax
        mov al,BYTE [rdi+r8]
        cmp al,0
        je __add2
        mov dl,BYTE [rsi+r8]
        cmp dl,0
        je __add2
        sub al ,'0'
        sub dl , '0'
        add al,dl
        add al,BYTE [carry]
        mov BYTE [carry],0
        cmp al,0x9
        jle _implement_result
        jmp _carry 

    __add2:
        cmp al,0
        je _add2_para2
        cmp dl,0
        je _add2_para1

    _add2_para1:
        mov al,BYTE [rdi+r8]
        add al,BYTE [carry]
        mov BYTE [carry],0
        cmp al,0
        je _add_loop_done 
        cmp al,1
        jne _label1  
        add al,0x30
        _label1:
            sub al,0x30
            cmp al,0x9
            jle _implement_result
            jmp _carry

    _add2_para2:
        mov al,BYTE [rsi+r8]
        add al,BYTE [carry]
        mov BYTE [carry],0
        cmp al,0
        je _add_loop_done   
        cmp al,1
        jne _label2
        add al,0x30
        _label2:
            sub al,0x30
            cmp al,0x9
            jle _implement_result
            jmp _carry
    _implement_result:
        add al,'0'
        mov BYTE [r10+r8],al
        inc r8 
        _implement_result_done:
            jmp __add1

    _carry:
        mov BYTE [carry],1
        sub al,10
        jmp _implement_result

    _add_loop_done:
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
