section .data
    ;texto input
    in1: db "Entre com a hora do compromisso:",10
    len_in1: equ $ - in1
    in2: db "Entre com os minutos do compromisso:",10
    len_in2: equ $ - in2
    in3: db "Entre com a hora da chegada:",10
    len_in3: equ $ - in3
    in4: db "Entre com os minutos da chegada:",10
    len_in4: equ $ - in4

    ;texto valores invalidos
    errh: db "Hora invalida!",10
    len_errh: equ $ - errh
    errm: db "Minutos invalidos!",10
    len_errm: equ $ - errm

    ;texto saida
    ou: db "A pessoa chegou "
    len_ou: equ $ - ou
    op1: db "adiantada",10
    len_op1: equ $ - op1
    op2: db "atrasada",10
    len_op2: equ $ - op2
    op3: db "pontualmente",10
    len_op3: equ $ - op3

    BUFF: equ 4

section .bss
    h_marc: resb BUFF
    m_marc: resb BUFF
    h_cheg: resb BUFF
    m_cheg: resb BUFF

section .text 
    global _start

_start:
    mov rsi, in1 
    mov rdx, len_in1 
    call write
    mov rsi, h_marc
    call read

    mov rsi, in2
    mov rdx, len_in2
    call write
    mov rsi, m_marc
    call read

    mov rsi, in3
    mov rdx, len_in3
    call write
    mov rsi, h_cheg
    call read

    mov rsi, in4
    mov rdx, len_in4
    call write
    mov rsi, m_cheg
    call read

_end:
    mov rax, 60
    mov rdi, 0
    syscall

write:
    ;imprime string
    mov rax, 1
    mov rdi, rax
    syscall
    ret

read:
    ;le valores
    mov rax, 0
    mov rdi, rax
    mov rdx, BUFF
    syscall
    ret

result:
    mov rsi, ou
    mov rdx, len_ou
    call write
    mov rsi, h_cheg
    call write
    ret