segment .data
  hMax dd 23
  mMax dd 59
  min dd 0

segment .text:

; -----------------------------------
; Valida Hora
; -----------------------------------
; Entrada: hora em EAX
; -----------------------------------
validaHora:
  mov EBX, DWORD[hMax]
  cmp EAX, EBX
  jg h_invalido
  mov EBX, DWORD[min]
  cmp EAX, EBX
  jl h_invalido
  ret
  
 h_invalido:
   mov ECX,errh
   call write
   jmp le_hora
  
; -----------------------------------
; Valida Min
; -----------------------------------
; Entrada: min em EAX
; -----------------------------------
validaMin:
  mov EBX, DWORD[mMax]
  cmp EAX, EBX
  jg m_invalido
  mov EBX, DWORD[min]
  cmp EAX, EBX
  jl m_invalido
  ret
  
 m_invalido:
   mov ECX,errm
   call write
   jmp le_min
