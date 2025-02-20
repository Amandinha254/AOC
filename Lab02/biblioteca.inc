section .data
    LF          equ 10 ; Line Feed
    NULL        equ 0  ; Final de uma string
    EXIT_SUCESS equ 0  ; Operação com Sucesso
    SYS_EXIT    equ 60 ; Código de chamada para finalizar

    STDIN       equ 0  ; System.in
    STDOUT      equ 1  ; System.out
    STDERR      equ 2  ; System.err

    SYS_READ    equ 0  ; leitura
    SYS_WRITE   equ 1  ; escrita / saída
    
    tamInput equ 20
    
    ;especificas lab2
    dateFormats:
        db "dd/mm/aaaa", 0
        db "mm/dd/aaaa", 0
        db "aaaa/mm/dd", 0
        db "dd/mm/aa", 0
        db "mm/dd/aa", 0
        db "aa/mm/dd", 0
        db "dd-mm-aaaa", 0
        db "mm-dd-aaaa", 0
        db "aaaa-mm-dd", 0
        db "dd-mm-aa", 0
        db "mm-dd-aa", 0
        db "aa-mm-dd", 0
    
    colon: db "," , 0

    enter: db 10,0
    
    days_in_months: db 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31

    valid_formats: db 0,0,0,0,0,0
    
    valid_date_out: 
                    db " - Os formatos validos para ",0
                    db " sao: ",0
    invalid_date_out db " – O formato nao e uma data valida.", 10, 0

section .bss
    date_input: resb tamInput

    day: resb 4
    month: resb 4
    year: resb 4

    date_delimiter: resb 1
