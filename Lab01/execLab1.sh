#!/bin/bash
nasm -f elf64 lab1.asm -o lab1.o
ld -m elf_x86_64 -s lab1.o -o lab1
./lab1
