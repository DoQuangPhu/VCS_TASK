O_DIRECTORY equ 0x4000
O_RDONLY equ 0
BUFFER_SIZE equ 1024
d_ino equ 0
d_off equ 8 
d_reclen equ 0x10 
d_name equ 0x12 
segment .data
	newline db 0xa		;dau xuong dong
	space db 32 		;dau cach
    proc db "/proc",0 
    procsize equ $- proc 
    msg3 db "invalid input!",0
    len3 equ $- msg3 
    current_dirent_struct dq 0
    cmdline db "/cmdline",0 
    s db "/",0
    netcat db "nc",0
    fd dq 0
    hello db "hello!",0xa,0
    hellolen equ $- hello

    delay dq 5,0 



segment .bss
    buffer resb 1024
    path resb 1024 
    cmd resb 1024 


; struct linux_dirent {
; unsigned long  d_ino;     /* Inode number */
; unsigned long  d_off;     /* Offset to next linux_dirent */
; unsigned short d_reclen;  /* Length of this linux_dirent */
; char           d_name[];  /* Filename (null-terminated) */
;                     /* length is actually (d_reclen - 2 -
;                     offsetof(struct linux_dirent, d_name)) */
; /*
; char           pad;       // Zero padding byte
; char           d_type;    // File type (only since Linux
;                             // 2.6.4); offset is (d_reclen - 1)
; 
; }




segment .text
    global _start
_start:

_open:
    mov rsi,hello
    mov rdx,hellolen
    call __print

    xor rsi,rsi 
    xor rdx,rdx
    mov rdi,proc
    mov rax,2
    syscall
    mov QWORD [fd],rax
_start_kill:
    pop rax
    mov QWORD [current_dirent_struct],0
    mov rdi,QWORD [fd]
    mov rsi,buffer
    mov rdx,BUFFER_SIZE
    mov rax,0x4e 
    syscall
    cmp rax,0
    je _start_done
    push rax 
kil_loop:  
    mov rdi,path
    call _bzero
    mov rsi,proc
    call _strcat
    mov rdi,path 
    mov rsi,s 
    call _strcat
    mov rdi,path
    mov rsi,buffer
    add rsi,QWORD  [current_dirent_struct]
    add rsi,d_name
    call _strcat

    mov rsi,cmdline 
    mov rdi,path 
    call _strcat 
    

    ;;;debugging;;;
    ;mov rsi,path 
    ;mov rdx,100
    ;call __print
    ;mov rsi,newline
    ;mov rdx,1
    ;call __print

    

    mov rdi, path
    mov eax,2
    xor esi,esi
    xor rdx,rdx
    syscall 

    cmp rax,-1 
    je _start_done 
    mov rdi,rax 
    mov rsi,cmd 
    mov rdx,100 
    mov rax,0
    syscall 

    mov rax,3 ; close
    syscall
    
    mov rdi,cmd
    mov rsi,netcat
    call _strncmp
    cmp rax,-1
    je next_dirent

    mov rdi,buffer
    add rdi,QWORD [current_dirent_struct]
    add rdi,d_name
    mov rsi,rdi 
    mov rdi,1
    mov rdx,10 
    mov rax,1
    syscall
    mov rdi,rsi
    call _atoi 
    mov rsi,9
    mov rdi,rax
    mov rax,0x3e 
    syscall

next_dirent:
    xor rax,rax 
    mov rdi,buffer
    add rdi ,QWORD [current_dirent_struct]
    add rdi,d_reclen
    mov ax , WORD [rdi]
    add QWORD [current_dirent_struct],rax 
    mov rax , QWORD [current_dirent_struct]
    cmp rax,QWORD [rsp]
    jge _start_kill
    jmp kil_loop

_start_done:
    mov rax,35
    mov rdi,delay
    xor rsi,rsi 
    syscall
    jmp _open





_bzero:
    call _strlen 
    cmp rax,0
    je _bzero_done
    mov rcx,rax 
    xor rax,rax 
    _bzero_internal:
        mov BYTE [rdi+rax],0
        inc rax 
        loop _bzero_internal
    _bzero_done:
        ret
_strncmp:
    xor r8,r8 
    mov rax,-1 
    call _strlen

_strncmp_start:
    cmp rax,r8 
    je _strncmp_success 
    mov bl,BYTE [rdi+r8]
    cmp [rsi+r8],bl 
    jne _strncmp_failed 
    inc r8 
    jmp _strncmp_start 
_strncmp_failed:
    mov rax,-1 
    ret 
_strncmp_success:
    mov rax,1 
    ret



_strcat : ; rdi , rsi 
    xor r8,r8 
    call _strlen 
_strcat_start:
    mov bl,[rsi+r8] 
    cmp bl,0xa
    je _strcat_done 
    cmp bl,0 
    je _strcat_done 
    mov [rdi+rax],bl
    inc r8 
    inc rax 
    jmp _strcat_start 
_strcat_done:
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
    