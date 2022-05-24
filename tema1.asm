; Butufei Tudor-David, grupa 161, problema 26
section .text
global _start

_start:
    mov eax, 4
    mov ebx, 1
    mov ecx, msgInput
    mov edx, lenMsgInput
    int 0x80

    mov eax, 3
    mov ebx, 2
    mov ecx, cuvant
    mov edx, 256
    int 0x80

    mov ecx, 0
    mov edx, cuvant

loop_final:
    ; s-a depaist lungimea bufferului
    cmp ecx, 256
    jge eroare

    ; preluare litera
    mov al, [edx]

    ; linie noua => finalul cuvantului
    cmp al, 10
    je verificare

    add edx, 1
    inc ecx
    jmp loop_final

verificare:
    ; revenire la ultima litera
    sub edx, 1
    mov [pointer_st], dword cuvant
    mov [pointer_dr], dword edx

loop_verificare:
    ; preluare literele
    mov edx, [pointer_st]
    mov al, [edx]
    mov edx, [pointer_dr]
    mov bl, [edx]

    ; comparare litere
    cmp al, bl
    jne nepalindrom

    ; actualizare pointeri stanga si dreapta
    mov eax, [pointer_st]
    mov ebx, [pointer_dr]
    cmp eax, ebx
    jge palindrom

    add eax, 1
    sub ebx, 1
    mov [pointer_st], dword eax
    mov [pointer_dr], dword ebx
    jmp loop_verificare

palindrom:
    mov eax, 4
    mov ebx, 1
    mov ecx, msgPalindrom
    mov edx, lenMsgPalindrom
    int 0x80
    jmp exit

nepalindrom:
    mov eax, 4
    mov ebx, 1
    mov ecx, msgNePalindrom
    mov edx, lenMsgNePalindrom
    int 0x80
    jmp exit

eroare:
    mov eax, 4
    mov ebx, 1
    mov ecx, msgEroare
    mov edx, lenMsgEroare
    int 0x80

exit:
    mov eax, 1
    mov ebx, 0
    int 0x80


section .data
    msgInput db 'Introduceti cuvant: '
    lenMsgInput equ $ - msgInput
    msgPalindrom db 'Cuvantul este palindrom.' , 10
    lenMsgPalindrom equ $ - msgPalindrom
    msgNePalindrom db 'Cuvantul nu este palindrom.' , 10
    lenMsgNePalindrom equ $ - msgNePalindrom
    msgEroare db 'Cuvantul introdus este prea lung!', 10
    lenMsgEroare equ $ - msgEroare

segment .bss
    cuvant resb 256
    lungime resw 1
    pointer_st resd 1
    pointer_dr resd 1
