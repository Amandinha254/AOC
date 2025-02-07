segment .text

; -----------------------------------
; Leitura de String
; -----------------------------------
read:
  mov EAX, SYS_READ
  mov EBX, STD_IN
  mov ECX, textoIn
  mov EDX, tamMax
  int SYS_CALL
  call fimStr
  mov ECX, textoIn
  ret

; ---------------------------------------------------
; Coloca NULL no fim da String
; ---------------------------------------------------
; Entrada: valor da String em ECX
; Saida: valor da String em textoIn com NULL no final
; ----------------------------------------------------
fimStr:
  mov EAX, ECX
prox:
  cmp byte[ECX], LF
  jz termino
  inc ECX
  jmp prox
termino:
  mov EDX, ECX
  sub EDX, EAX
  inc ECX
  mov byte[ECX], NULL
  ret 

; -----------------------------------
; Saida da String no terminal
; -----------------------------------
; Entrada: valor da String em ECX
; -----------------------------------
write:
  mov EAX, SYS_WRITE
  mov EBX, STD_OUT
  call tamStr
  int SYS_CALL
  ret  

; -----------------------------------
; Calcular o tamanho da String
; -----------------------------------
; Entrada: valor da String em ECX
; Saida: tamanho da String em EDX
; -----------------------------------
tamStr:
  mov EDX, ECX
proxchar:
  cmp byte[EDX], NULL
  jz terminei
  inc EDX
  jmp proxchar
terminei:
  sub EDX, ECX
  ret 
