;antes usa mov rax, num
str_to_int:
        xor rbx, rbx            ; zera rbx para receber resultados.
    .loop:
        movzx rcx, byte [rax]   ; copia o byte e zera restante do registro.
        inc rax                 ; incrementa endereço em rax.
        cmp rcx, '0'            ; compara o byte com o menor byte válido.
        jl .end_sub             ; se menor, encerra a sub-rotina.
        cmp rcx, '9'            ; compara o byte com o maior byte válido.
        jg .end_sub             ; se maior, encerra a sub-rotina.
        sub rcx, '0'            ; subtrai 0x30 do byte.
        imul rbx, 10            ; multiplica resultado parcial por 10.
        add rbx, rcx            ; soma o valor em rbx com o valor em rcx.
        jmp .loop               ; repete até encontrar um byte inválido.
    .end_sub:
    ret

;antes usa mov rax, num
print_int:
        xor rcx, rcx        ; Zera contador (rcx).
    .loop:
        inc rcx             ; Incrementa o contador.
        xor rdx, rdx        ; Zera rdx (restos).
        mov rbx, 10         ; Copia o divisor para rbx.
        div rbx             ; Divide rax por rbx.
        add dl, '0'         ; Soma 0x30 ao resto no último byte de rdx.
        push rdx            ; Salva rdx na pilha.
        cmp rax, 0          ; Compara o quociente (rax) com zero.
        jnz .loop           ; Se não for zero, repete o loop.        
        mov rbx, rcx        ; Copia o contador (rcx) para rbx.
    .write:
        mov rax, 1          
        mov rdi, 1
        mov rsi, rsp        ; Usa o endereço do topo da pilha.
        mov rdx, 1          ; Imprimir apenas 1 byte.
        syscall
        pop rax             ; Remove o elemento no topo da pilha.
        dec rbx             ; Decrementa o contador (rbx).
        jnz .write          ; Enquanto não for zero, repete.
    ret
