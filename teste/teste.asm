%include 'bibliotecaTeste.inc'
%include 'texto.inc'
%include 'converte.inc'

section .text 
    global _start

_start:
  call read
  
  call converter_valor
  call mostrar_valor
   
_end:
    mov EAX, SYS_EXIT
    mov EBX, RET_EXIT
    int SYS_CALL
