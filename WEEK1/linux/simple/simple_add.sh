nasm -f elf64 simple_addition.asm
ld -s -o add simple_addition.o
./add