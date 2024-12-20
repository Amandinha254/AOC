section .data
    ; Mensagens de formato
    msg_prompt db 'Digite uma data: ', 0
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
    input_buffer resb 100
    valid_formats resb 12    ; Array para marcar formatos válidos
    num1 resb 4             ; Buffer para converter strings em números
    num2 resb 4
    num3 resb 4

section .text
    global _start

_start:
    ; Limpa o array de formatos válidos
    mov rcx, 12
    mov rdi, valid_formats
    xor al, al
    rep stosb
    
    ; Exibe prompt
    mov rax, 1          ; sys_write
    mov rdi, 1          ; stdout
    mov rsi, msg_prompt
    mov rdx, 14
    syscall
    
    ; Lê entrada
    mov rax, 0          ; sys_read
    mov rdi, 0          ; stdin
    mov rsi, input_buffer
    mov rdx, 100
    syscall
    
    ; Remove o newline da entrada
    dec rax
    mov byte [input_buffer + rax], 0
    
    ; Valida o comprimento da entrada
    cmp rax, 8           ; Mínimo aa/mm/dd
    jl invalid_format
    cmp rax, 10          ; Máximo aaaa/mm/dd
    jg invalid_format
    
    ; Checa os separadores
    mov rsi, input_buffer
    add rsi, 2           ; Posição do primeiro separador
    cmp byte [rsi], '/'
    je check_slash_format
    cmp byte [rsi], '-'
    je check_dash_format
    jmp invalid_format

check_slash_format:
    ; Verifica formatos com /
    add rsi, 3           ; Posição do segundo separador
    cmp byte [rsi], '/'
    jne invalid_format
    
    ; Extrai números
    call extract_numbers
    call validate_all_formats
    jmp print_results

check_dash_format:
    ; Similar ao check_slash_format mas para formatos com -
    add rsi, 3
    cmp byte [rsi], '-'
    jne invalid_format
    
    call extract_numbers
    call validate_all_dash_formats
    jmp print_results

extract_numbers:
    ; Extrai os três números da data
    push rsi
    mov rsi, input_buffer
    mov rdi, num1
    mov rcx, 2
    rep movsb
    
    inc rsi              ; Pula separador
    mov rdi, num2
    mov rcx, 2
    rep movsb
    
    inc rsi              ; Pula separador
    mov rdi, num3
    mov rcx, 4
    rep movsb
    
    pop rsi
    ret

validate_all_formats:
    call validate_ddmmaaaa
    call validate_mmddaaaa
    call validate_aaaammdd
    call validate_ddmmaa
    call validate_mmddaa
    call validate_aammdd
    ret

validate_all_dash_formats:
    call validate_ddmmaaaa_dash
    call validate_mmddaaaa_dash
    call validate_aaaammdd_dash
    call validate_ddmmaa_dash
    call validate_mmddaa_dash
    call validate_aammdd_dash
    ret

validate_ddmmaaaa:
    ; Valida formato dd/mm/aaaa
    push rax
    push rbx
    
    mov rsi, num1
    call str_to_num      ; dia em rax
    cmp rax, 1
    jl invalid_ddmmaaaa
    cmp rax, 31
    jg invalid_ddmmaaaa
    mov rbx, rax         ; Guarda dia em rbx
    
    mov rsi, num2
    call str_to_num      ; mês em rax
    cmp rax, 1
    jl invalid_ddmmaaaa
    cmp rax, 12
    jg invalid_ddmmaaaa
    
    ; Validação específica por mês
    cmp rax, 2          ; Fevereiro
    je .check_february
    
    cmp rax, 4
    je .check_30_days
    cmp rax, 6
    je .check_30_days
    cmp rax, 9
    je .check_30_days
    cmp rax, 11
    je .check_30_days
    jmp .valid          ; Meses com 31 dias

.check_february:
    ; Lógica para fevereiro e anos bissextos
    mov rsi, num3
    call str_to_num     ; ano em rax
    call is_leap_year
    cmp rbx, 29
    jg invalid_ddmmaaaa
    test rax, rax       ; rax = 1 se bissexto, 0 se não
    jz .not_leap
    cmp rbx, 29
    jle .valid
    jmp invalid_ddmmaaaa
.not_leap:
    cmp rbx, 28
    jg invalid_ddmmaaaa
    jmp .valid

.check_30_days:
    cmp rbx, 30
    jg invalid_ddmmaaaa

.valid:
    mov byte [valid_formats], 1
    pop rbx
    pop rax
    ret

invalid_ddmmaaaa:
    pop rbx
    pop rax
    ret

validate_mmddaaaa:
    ; Similar a validate_ddmmaaaa mas troca verificação de dia/mês
    mov byte [valid_formats + 1], 1
    ret

validate_aaaammdd:
    mov byte [valid_formats + 2], 1
    ret

validate_ddmmaa:
    mov byte [valid_formats + 3], 1
    ret

validate_mmddaa:
    mov byte [valid_formats + 4], 1
    ret

validate_aammdd:
    mov byte [valid_formats + 5], 1
    ret

validate_ddmmaaaa_dash:
    mov byte [valid_formats + 6], 1
    ret

validate_mmddaaaa_dash:
    mov byte [valid_formats + 7], 1
    ret

validate_aaaammdd_dash:
    mov byte [valid_formats + 8], 1
    ret

validate_ddmmaa_dash:
    mov byte [valid_formats + 9], 1
    ret

validate_mmddaa_dash:
    mov byte [valid_formats + 10], 1
    ret

validate_aammdd_dash:
    mov byte [valid_formats + 11], 1
    ret

is_leap_year:
    ; Verifica se o ano em rax é bissexto
    ; Retorna 1 em rax se bissexto, 0 se não
    push rbx
    push rcx
    push rdx
    
    mov rbx, rax        ; Guarda ano
    
    mov rcx, 4
    xor rdx, rdx
    div rcx
    test rdx, rdx       ; Divisível por 4?
    jnz .not_leap
    
    mov rax, rbx
    mov rcx, 100
    xor rdx, rdx
    div rcx
    test rdx, rdx       ; Não divisível por 100?
    jnz .is_leap
    
    mov rax, rbx
    mov rcx, 400
    xor rdx, rdx
    div rcx
    test rdx, rdx       ; Divisível por 400?
    jz .is_leap

.not_leap:
    xor rax, rax
    jmp .done

.is_leap:
    mov rax, 1

.done:
    pop rdx
    pop rcx
    pop rbx
    ret

str_to_num:
    ; Converte string em rsi para número em rax
    xor rax, rax
    xor rcx, rcx
.loop:
    mov cl, byte [rsi]
    test cl, cl
    jz .done
    sub cl, '0'
    imul rax, 10
    add rax, rcx
    inc rsi
    jmp .loop
.done:
    ret

print_results:
    ; Verifica se algum formato é válido
    mov rcx, 12
    mov rsi, valid_formats
    xor rdx, rdx
    xor r8, r8          ; Contador de formatos válidos
.check_valid:
    lodsb
    test al, al
    jz .next_check
    inc r8
.next_check:
    loop .check_valid
    
    test r8, r8         ; Se não há formatos válidos
    jz invalid_format

    ; Imprime mensagem inicial
    mov rax, 1
    mov rdi, 1
    mov rsi, msg_valid_start
    mov rdx, 20
    syscall
    
    ; Imprime a data original
    mov rax, 1
    mov rdi, 1
    mov rsi, input_buffer
    mov rdx, 10
    syscall
    
    ; Imprime " sao: "
    mov rax, 1
    mov rdi, 1
    mov rsi, msg_valid_mid
    mov rdx, 6
    syscall
    
    ; Imprime os formatos válidos
    mov rcx, 12         ; Total de formatos
    mov rsi, valid_formats
    mov r9, 0          ; Índice do formato atual
    
.print_formats:
    mov al, [rsi]
    test al, al
    jz .skip_format
    
    ; Imprime o formato correspondente
    push rcx
    push rsi
    
    ; Seleciona o formato correto baseado em r9
    mov rdi, fmt1
    cmp r9, 0
    je .print_fmt
    mov rdi, fmt2
    cmp r9, 1
    je .print_fmt
    mov rdi, fmt3
    cmp r9, 2
    je .print_fmt
    mov rdi, fmt4
    cmp r9, 3
    je .print_fmt
    mov rdi, fmt5
    cmp r9, 4
    je .print_fmt
    mov rdi, fmt6
    cmp r9, 5
    je .print_fmt
    mov rdi, fmt7
    cmp r9, 6
    je .print_fmt
    mov rdi, fmt8
    cmp r9, 7
    je .print_fmt
    mov rdi, fmt9
    cmp r9, 8
    je .print_fmt
    mov rdi, fmt10
    cmp r9, 9
    je .print_fmt
    mov rdi, fmt11
    cmp r9, 10
    je .print_fmt
    mov rdi, fmt12
    
.print_fmt:
    ; Calcula comprimento da string
    push rdi
    mov rdx, 0
.strlen:
    inc rdx
    cmp byte [rdi + rdx], 0
    jne .strlen
    
    pop rsi             ; Recupera endereço do formato
    mov rax, 1
    mov rdi, 1
    syscall
    
    dec r8              ; Decrementa contador de formatos restantes
    jz .last_format     ; Se for o último, não imprime vírgula
    
    ; Imprime vírgula e espaço
    mov rax, 1
    mov rdi, 1
    mov rsi, comma
    mov rdx, 2
    syscall
    
.last_format:
    pop rsi
    pop rcx
    
.skip_format:
    inc r9
    inc rsi
    loop .print_formats
    
    ; Imprime newline
    mov rax, 1
    mov rdi, 1
    mov rsi, newline
    mov rdx, 1
    syscall
    jmp exit_program

invalid_format:
    mov rax, 1
    mov rdi, 1
    mov rsi, msg_invalid
    mov rdx, 29
    syscall

exit_program:
    mov rax, 60         ; sys_exit
    xor rdi, rdi        ; status = 0
    syscall
