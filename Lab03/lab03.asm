; Pokémon Agenda - x86_64 Assembly for Linux
section .data
    ; Constants for system calls
    SYS_READ    equ 0
    SYS_WRITE   equ 1
    SYS_OPEN    equ 2
    SYS_CLOSE   equ 3
    SYS_EXIT    equ 60
    
    ; File open modes
    O_RDWR      equ 2
    O_CREAT     equ 64
    O_APPEND    equ 1024
    
    ; File permissions
    RW_RW_R     equ 0644
    
    ; Prompts
    prompt_cmd  db "Enter command (add/remove/list/id_search/name_search/exit): ", 0
    prompt_id   db "Enter Pokemon ID: ", 0
    prompt_name db "Enter Pokemon name: ", 0
    prompt_t1   db "Enter first type: ", 0
    prompt_t2   db "Enter second type: ", 0
    
    ; Pokemon types
    type_normal   db "Normal", 0
    type_fire     db "Fire", 0
    type_water    db "Water", 0
    type_grass    db "Grass", 0
    type_flying   db "Flying", 0
    type_fighting db "Fighting", 0
    type_poison   db "Poison", 0
    type_electric db "Electric", 0
    type_ground   db "Ground", 0
    type_rock     db "Rock", 0
    type_psychic  db "Psychic", 0
    type_ice      db "Ice", 0
    type_bug      db "Bug", 0
    type_ghost    db "Ghost", 0
    type_steel    db "Steel", 0
    type_dragon   db "Dragon", 0
    type_dark     db "Dark", 0
    type_fairy    db "Fairy", 0
    type_none     db "None", 0
    
    ; File name (replace XXXXX with your RA number)
    filename db "XXXXX.txt", 0
    
    ; Error messages
    err_file    db "Error opening file", 10, 0
    err_type    db "Invalid type", 10, 0
    err_id      db "Invalid ID", 10, 0
    
section .bss
    command     resb 20    ; Buffer for command input
    id_buffer   resb 10    ; Buffer for ID input
    name_buffer resb 50    ; Buffer for name input
    type1_buf   resb 20    ; Buffer for type1 input
    type2_buf   resb 20    ; Buffer for type2 input
    file_handle resq 1     ; File handle storage
    
section .text
global _start

_start:
    ; Open/create the file
    mov rax, SYS_OPEN
    mov rdi, filename
    mov rsi, O_RDWR | O_CREAT | O_APPEND
    mov rdx, RW_RW_R
    syscall
    
    ; Store file handle
    mov [file_handle], rax
    
main_loop:
    ; Display command prompt
    call display_prompt
    
    ; Read command
    call read_command
    
    ; Compare command and jump to appropriate handler
    cmp byte [command], 'a'
    je handle_add
    
    cmp byte [command], 'r'
    je handle_remove
    
    cmp byte [command], 'l'
    je handle_list
    
    cmp byte [command], 'i'
    je handle_id_search
    
    cmp byte [command], 'n'
    je handle_name_search
    
    cmp byte [command], 'e'
    je exit_program
    
    jmp main_loop

handle_add:
    ; Get Pokemon ID
    mov rdi, prompt_id
    call print_string
    call read_number
    
    ; Get Pokemon name
    mov rdi, prompt_name
    call print_string
    call read_string
    
    ; Get type1
    mov rdi, prompt_t1
    call print_string
    call read_type
    
    ; Get type2
    mov rdi, prompt_t2
    call print_string
    call read_type
    
    ; Write to file
    call write_pokemon
    
    jmp main_loop

handle_remove:
    ; Implementation for remove command
    ; Read ID and remove from file
    jmp main_loop

handle_list:
    ; Implementation for list command
    ; Read and display all Pokemon from file
    jmp main_loop

handle_id_search:
    ; Implementation for ID search
    ; Read ID and search in file
    jmp main_loop

handle_name_search:
    ; Implementation for name search
    ; Read name and search in file
    jmp main_loop

exit_program:
    ; Close file
    mov rax, SYS_CLOSE
    mov rdi, [file_handle]
    syscall
    
    ; Exit program
    mov rax, SYS_EXIT
    xor rdi, rdi
    syscall

; Helper functions
display_prompt:
    mov rdi, prompt_cmd
    call print_string
    ret

read_command:
    mov rax, SYS_READ
    mov rdi, 0          ; stdin
    mov rsi, command
    mov rdx, 20
    syscall
    ret

print_string:
    ; Calculate string length
    push rdi
    xor rcx, rcx
    dec rcx
    xor al, al
    cld
    repne scasb
    not rcx
    dec rcx
    
    ; Print string
    mov rax, SYS_WRITE
    mov rdi, 1          ; stdout
    pop rsi             ; string address
    mov rdx, rcx        ; length
    syscall
    ret

read_number:
    ; Implementation for reading and validating numbers
    ret

read_string:
    ; Implementation for reading strings
    ret

read_type:
    ; Implementation for reading and validating Pokemon types
    ret

write_pokemon:
    ; Implementation for writing Pokemon data to file
    ret