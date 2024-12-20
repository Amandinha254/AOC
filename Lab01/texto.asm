;antes de usar mov rax, msg
print_str:
    .loop:
        push rax            ; Salva endereço em rax na pilha.
        mov rcx, [rax]      ; Copia o valor apontado por rax em rcx.
        cmp cl, 0           ; Compara o byte em cl com zero (\0).
        jz .endsub          ; Se igual, sai da sub-rotina...
        mov rbx, rax        ; Copia o endereço em rax para rbx.
        call write_char     ; Imprime primeiro byte em rbx.
        pop rax             ; Recupera o endereço da mensagem em rax
        inc rax             ; Incrementa o endereço da mensagem em rax
        jmp .loop           ; Repete até encontar o byte 0x0...
    .endsub:
        pop rax             ; Restaura o estado inicial da pilha.
    ret

write_char:
        mov rax, 1
        mov rdi, rax
        mov rsi, rbx
        mov rdx, 1
        syscall
    ret
    
;antes de usar: mov rsi, input
read:
    mov rax, 0          ; sys_read
    mov rdi, 0          ; stdin
    mov rdx, 100
    syscall
    ret
