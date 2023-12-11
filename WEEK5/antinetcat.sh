nasm -f elf64 anti_netcat.asm
ld -s -o anti_netcat anti_netcat.o