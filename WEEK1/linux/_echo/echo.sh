nasm -f elf64 echo.asm
ld -s -o echo echo.o
./echo