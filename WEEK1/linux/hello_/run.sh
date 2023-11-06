nasm -f elf64 helloworld.asm
ld -s -o hello helloworld.o
./hello