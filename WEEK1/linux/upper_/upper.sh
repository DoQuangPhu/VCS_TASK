nasm -f elf64 uppercase.asm 
ld -s -o upper  uppercase.o
./upper 
