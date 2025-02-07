segment .data
    v1 dw '108', LF,NULL

segment .text

;-------------------------------------------
; Converte valor de string para inteiro
;-------------------------------------------
; Entrada: textoIn (valor em string) 
; Saida..: EAX e inteiro (valor em inteiro)
;-------------------------------------------
converter_valor:
    lea esi, [textoIn]
    mov ecx,esi
    call tamStr
    sub edx,0x1
    mov ecx, edx ;tamanho da sring em ecx
    call string_to_int
    ret
;------------------------------------------------------------
; Mostrar valor
;------------------------------------------------------------
; Entrada: inteiro em EAX
; Saida..: textoOu (inteiro convertido em string) no terminal
;------------------------------------------------------------
mostrar_valor:
    lea esi, [textoOu]
    call int_to_string
    mov ecx, esi
    call fimStr
    mov ecx, esi
    call write
    ret    

;--------------------------------------------------------
; string para inteiro
;--------------------------------------------------------
; Entrada: ESI (valor em string) ECX (tamanho da string)
; Saida..: EAX (valor em inteiro)
;--------------------------------------------------------
string_to_int:
  xor ebx, ebx
.prox_digito:
  movzx   eax, byte[esi]
  inc esi
  sub al, '0'
  imul ebx, 0xA
  add ebx, eax ; ebx = ebx*10 + eax
  loop .prox_digito ; while (--ecx)
  mov eax, ebx
  ret

;------------------------------------------------
; inteiro para string
;------------------------------------------------
; Entrada: inteiro em EAX
; Saida..: textoOu (inteiro convertido em string)
;------------------------------------------------
int_to_string:
  add esi, 0x9
  mov byte[esi], 0xA
  mov ebx, 0xA
.prox_digito:
  xor edx, edx
  div ebx
  add dl, '0'
  dec esi
  mov [esi], dl
  test eax, eax
  jnz .prox_digito
  ret     
