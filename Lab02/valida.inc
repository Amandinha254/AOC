section .text

is_valid_date:
    cmp rbx,0
    je continue_valid_date
    mov rcx,rax
    mov rax,rsi
    mov rsi,rcx
continue_valid_date:
    cmp eax,100
    jg valid_date
    cmp eax,50
    jle adjust_year
    add eax,1900
    jmp valid_date
adjust_year:
    add eax,2000
valid_date:
    call check_leap_year

    xor rbx,rbx

    dec rdi
    movzx rbx, byte [days_in_months + rdi]
    inc rdi
    cmp rax,1
    jne check_month_day_interval
    cmp rdi,2
    jne check_month_day_interval
    inc rbx
    
check_month_day_interval:
    cmp rdi,1
    jl invalid_format

    cmp rdi,12
    jg invalid_format

    cmp rsi,1
    jl invalid_format

    cmp rsi,rbx
    jg invalid_format

    mov rdx,1
    ret
invalid_format:
    mov rdx,0
    ret
    
invalid_date:
    mov rsi,date_input
    call print_string

    mov rsi,invalid_date_out
    call print_string
    jmp out
