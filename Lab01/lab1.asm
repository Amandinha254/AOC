%include 'biblioteca.inc'
%include 'texto.inc'
%include 'converte.inc'
%include 'valida.inc'
section .data

section .bss

section .text 
    global _start

_start:

    mov EAX, in1
    lea ESI, [h_marc]
    call le_hora
    
    mov EAX, in2
    lea ESI, [m_marc]
    call le_min
    
    mov EAX, in3
    lea ESI, [h_cheg]
    call le_hora
    
    mov EAX, in4
    lea ESI, [m_cheg]
    call le_min

_end:
    mov rax, 60
    mov rdi, 0
    syscall
    
 le_hora:
    mov ECX, EAX
    call write
    call read
    call converter_valor
    call mostrar_valor
    ;call validaHora
    ret
    
le_min:
    mov ECX, EAX
    call write
    call read
    call converter_valor
    ;call validaMin
    ret
