nasm -f elf64 reverse_string.asm
ld -s -o reverse_string reverse_string.o
./reverse_string