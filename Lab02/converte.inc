section .text

convert_ascii_in_int:
    xor eax, eax
    xor ecx, ecx

    movzx edx, byte [esi]
    cmp dl, '-'
    jne convert_ascii

    inc esi
    mov ecx, 1

convert_ascii:
    movzx edx, byte [esi]
    cmp dl, byte [date_delimiter]
    je done_convert
    cmp dl, 0
    je done_convert
    imul eax, 10
    sub edx, '0'
    add eax, edx
    inc esi
    jmp convert_ascii

done_convert:
    test ecx, ecx
    jz finish_convert
    neg eax
finish_convert:
    ret
