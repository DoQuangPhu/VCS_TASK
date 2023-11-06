nasm -f elf64 fibo.asm
ld -s -o fibo fibo.o
./fibo