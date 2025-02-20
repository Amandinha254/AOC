%include "biblioteca.inc"
%include "inp-out.inc"
%include "converte.inc"
%include "verificFormato.inc"
%include "valida.inc"

section .bss
    
section .text
    global _start

_start:
    call read_date

    mov rsi,date_input
    call check_date_formats

    call check_at_least_one_valid_format

    mov rsi,date_input
    call print_string

    mov rsi,valid_date_out
    call print_string

    mov rsi,date_input
    call print_string

    mov rsi,valid_date_out
    add rsi,29 
    call print_string

    call print_valid_formats

    jmp out

print_valid_formats:
    mov rcx,0
    xor rax,rax
    xor rdx,rdx
    xor rdi,rdi

    mov bl, byte [date_delimiter]
    cmp bl, 47
    mov rbx,0
    je valid_formats_to_print
    add rbx,60
valid_formats_to_print:
    push rcx
    mov rsi,valid_formats
    mov al, byte[rsi + rcx]

    cmp al,1
    je print_format

adjust_next_format:
    pop rcx
    inc rcx
    call adjust_dateFormat
    cmp rcx,6 
    je end_print_valid_formats
    jmp valid_formats_to_print

print_format:
   call print_colon
   mov rsi, dateFormats
   add rsi, rbx
   call print_string
   jmp adjust_next_format

print_colon:
    cmp rdi,0
    je do_not_print_colon
    mov rdi,1
    mov rsi,colon
    call print_string
do_not_print_colon:
    ret

end_print_valid_formats:
    mov rsi,enter
    call print_string
    ret

adjust_dateFormat:
    add rbx,9
    cmp rcx,3
    jg return_adjust
    add rbx,2
return_adjust:
    ret

read_date:
    mov rsi,date_input
    call read_string

    call calculate_string_size
    mov byte [rsi + rdx - 1],0

    mov al, byte [rsi]

    call calculate_string_size
    cmp rdx, 8
    jl invalid_date

    call calculate_string_size
    cmp rdx, 10
    jg invalid_date

    cmp al, 48
    jl invalid_date

    cmp al, 57
    jg invalid_date

    ret

out:
    mov rax, SYS_EXIT
    mov rdi, EXIT_SUCESS    
    syscall
