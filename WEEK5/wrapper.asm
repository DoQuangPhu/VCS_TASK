tv_sec equ 5
tv_nsec equ 0

segment .data
    cmd db "./anti_netcat",0
    cmdlen equ $- cmd 

segment .bss
    timespec  resq 2 
    
segment .text
    global _start

_start:
    mov QWORD [timespec],tv_sec
    mov QWORD [timespec+8],tv_nsec
    loop:
        mov rsi,cmd
        mov rdi,1
        mov rdx,cmdlen
        mov rax,1
        syscall

        mov rdi,cmd 
        mov rsi,0
        mov rdx,0
        mov rax ,0x3b
        syscall 


        mov rsi,timespec
        mov rdx,timespec
        mov rax,0x65
        syscall 
        jmp loop  