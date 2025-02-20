section .text

check_at_least_one_valid_format:
    xor rax,rax
    mov rcx,-1

check_at_least_one:
    inc rcx
    cmp rcx,6
    je invalid_date

    mov rsi,valid_formats
    mov al, byte[rsi + rcx]

    cmp al,1
    jne check_at_least_one
    ret
    
check_date_formats:
    call calculate_size_loop 
    mov rbx,-1
    call find_delimiter

    mov rsi,date_input
    call set_day

    mov rsi,date_input
    inc rbx
    add rsi,rbx
    call set_month

    mov rsi,date_input
    add rbx,3
    add rsi,rbx
    call set_year

    mov eax, dword [day]
    cmp eax,100
    jg four_digits_year

    mov eax, dword [year]
    cmp eax,100
    jl two_digits_year

four_digits_year:
    mov rbx,0
    mov eax, dword [day]
    mov rsi, rax
    mov eax, dword [month]
    mov rdi, rax
    mov eax, dword [year]
    call is_valid_date
    mov byte [valid_formats] , dl

    mov rbx,0
    mov eax, dword [month]
    mov rsi, rax
    mov eax, dword [day]
    mov rdi, rax
    mov eax, dword [year]
    call is_valid_date
    mov byte [valid_formats + 1] , dl

    mov rbx,1
    mov eax, dword [day]
    mov rsi, rax
    mov eax, dword [month]
    mov rdi, rax
    mov eax, dword [year]
    call is_valid_date
    mov byte [valid_formats + 2] , dl

    jmp finish_check_date_formats
two_digits_year:
    mov rbx,0
    mov eax, dword [day]
    mov rsi, rax
    mov eax, dword [month]
    mov rdi, rax
    mov eax, dword [year]
    call is_valid_date
    mov byte [valid_formats + 3] , dl

    mov rbx,0
    mov eax, dword [month]
    mov rsi, rax
    mov eax, dword [day]
    mov rdi, rax
    mov eax, dword [year]
    call is_valid_date
    mov byte [valid_formats + 4] , dl

    mov rbx,1
    mov eax, dword [day]
    mov rsi, rax
    mov eax, dword [month]
    mov rdi, rax
    mov eax, dword [year]
    call is_valid_date
    mov byte [valid_formats + 5] , dl

finish_check_date_formats:
    ret
    
set_day:
    call convert_ascii_in_int
    mov dword [day], eax
    ret
set_month:
    call convert_ascii_in_int
    mov dword [month], eax
    ret
set_year:
    call convert_ascii_in_int
    mov dword [year], eax
    ret

find_delimiter:
    cmp rbx, rdx
    jg invalid_date

    inc rbx
    mov al, byte [rsi + rbx]

    cmp al, 47
    je delimiter_finded

    cmp al, 45
    je delimiter_finded

    call find_delimiter
    ret
delimiter_finded:
    mov byte [date_delimiter], al
    ret
    
check_leap_year:
    mov rbx, rax

    xor rdx, rdx
    mov rcx, 4
    div rcx

    cmp rdx,0
    jne not_leap_year

    mov rax, rbx

    xor rdx, rdx
    mov rcx, 100
    div rcx

    cmp rdx,0
    jne is_leap_year

    mov rax, rbx

    xor rdx, rdx
    mov rcx, 400
    div rcx

    cmp rdx,0
    jne not_leap_year

is_leap_year:
    mov rax,1
    ret

not_leap_year:
    mov rax,0
    ret
