%include "texto.asm"
%include "inteiro.asm"
section .data
    ;texto input
    in1: db "Entre com a hora do compromisso:",10,0
    in2: db "Entre com os minutos do compromisso:",10,0
    in3: db "Entre com a hora da chegada:",10,0
    in4: db "Entre com os minutos da chegada:",10,0

    ;texto valores invalidos
    errh: db "Hora invalida!",10,0
    errm: db "Minutos invalidos!",10,0

    ;texto saida
    ou: db "A pessoa chegou ",0
    op1: db "adiantada",10,0
    op2: db "atrasada",10,0
    op3: db "pontualmente",10,0

    BUFF: equ 4

section .bss
    h_marc: resb BUFF
    m_marc: resb BUFF
    h_cheg: resb BUFF
    m_cheg: resb BUFF

section .text 
    global _start

_start:
    mov rax, in1  
    call print_str
    mov rsi, h_marc
    call read

    mov rax, in2
    call print_str
    mov rsi, m_marc
    call read

    mov rax, in3
    call print_str
    mov rsi, h_cheg
    call read

    mov rax, in4
    call print_str
    mov rsi, m_cheg
    call read

_end:
    mov rax, 60
    mov rdi, 0
    syscall
