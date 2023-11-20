nasm -f elf64 calculator.asm
ld -s -o calculator calculator.o
./calculator