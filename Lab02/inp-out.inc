section .text

read_string:
    mov rax, SYS_READ 
    mov rdi, STDIN 
    mov rdx, tamInput
    syscall
    ret

print_string:
    call calculate_string_size
    mov rax, SYS_WRITE
    mov rdi, STDOUT
    syscall
    ret

calculate_string_size:
    mov rdx, 0
    cmp byte [rsi + rdx], 0
    jne calculate_size_loop
    ret
calculate_size_loop:
    inc rdx
    cmp byte [rsi + rdx], 0
    jne calculate_size_loop
    ret
