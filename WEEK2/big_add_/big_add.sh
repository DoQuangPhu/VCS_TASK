nasm -f elf64 big_add.asm
ld -s -o big_add big_add.o
./big_add