#!/bin/bash
nasm -f elf64 lab2.asm -o lab2.o
ld -m elf_x86_64 -s lab2.o -o lab2
rm -rf lab2.o
./lab2
