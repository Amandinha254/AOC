segment .data
  LF        equ 0xA  ; Line Feed
  NULL      equ 0xD  ; Final da String 
  SYS_CALL  equ 0x80 ; Envia informacao ao SO
  ; EAX
  SYS_EXIT  equ 0x1  ; Codigo de chamada para finalizar
  SYS_READ  equ 0x3  ; Operacao de leitura
  SYS_WRITE equ 0x4  ; Operacao de escrita
  ; EBX
  RET_EXIT  equ 0x0  ; Operacao realizada com Sucesso
  STD_IN    equ 0x0  ; Entrada padrao
  STD_OUT   equ 0x1  ; Saida padrao
  
  tamMax dd 0x3
  
  ;texto input
  in1: db "Entre com a hora do compromisso:",LF,NULL
  in2: db "Entre com os minutos do compromisso:",LF,NULL
  in3: db "Entre com a hora da chegada:",LF,NULL
  in4: db "Entre com os minutos da chegada:",LF,NULL

  ;texto valores invalidos
  errh: db "Hora invalida!",LF,NULL
  errm: db "Minutos invalidos!",LF,NULL

  ;texto saida
  ou: db "A pessoa chegou ",0
  op1: db "adiantada",10,0
  op2: db "atrasada",10,0
  op3: db "pontualmente",10,0
  
segment .bss
  textoIn: resb 1
  h_marc: resb 4
  m_marc: resb 4
  h_cheg: resb 4
  m_cheg: resb 4
