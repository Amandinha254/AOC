#!/bin/bash
nasm -f elf64 teste.asm -o teste.o
ld -m elf_x86_64 -s teste.o -o teste
rm -rf teste.o
./teste
