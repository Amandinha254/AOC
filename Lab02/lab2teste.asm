%include "texto.asm"
%include "valid.asm"

section .data
    ; Mensagens de formato
    msg_prompt db 'Digite uma data: ',10,0
    msg_invalid db 'O formato nao e uma data valida.', 10, 0
    msg_valid_start db 'Os formatos validos para ', 0
    msg_valid_mid db ' sao: ', 0
    
    ; Formatos possíveis
    fmt1 db 'dd/mm/aaaa', 0
    fmt2 db 'mm/dd/aaaa', 0
    fmt3 db 'aaaa/mm/dd', 0
    fmt4 db 'dd/mm/aa', 0
    fmt5 db 'mm/dd/aa', 0
    fmt6 db 'aa/mm/dd', 0
    fmt7 db 'dd-mm-aaaa', 0
    fmt8 db 'mm-dd-aaaa', 0
    fmt9 db 'aaaa-mm-dd', 0
    fmt10 db 'dd-mm-aa', 0
    fmt11 db 'mm-dd-aa', 0
    fmt12 db 'aa-mm-dd', 0
    
    comma db ', ', 0
    newline db 10, 0

section .bss
    input_buffer resb 10
    valid_formats resb 12    ; Array para marcar formatos válidos
    num1 resb 4             ; Buffer para converter strings em números
    num2 resb 4
    num3 resb 4
    
section .text
    global _start

_start:
    mov rax, msg_prompt
    call print_str
    mov rsi, input_buffer
    call read
    
_exit:
    mov rax, 60
    mov rdi, 0
    syscall
