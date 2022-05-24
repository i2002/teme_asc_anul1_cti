; Butufei Tudor-David, grupa 161, problema 20
extern printf
extern scanf

; variabile
section .data
    x_var dq 0.0
    x_tmp dq 0.0
    a_const dq -380.0
    b_const dq 28.0
    b_const_dr dq 56.0
    c_const_dr dq 2.0
    n_var dd 0
    msg_citire db "Introduceti x0:", 10, 0
    msg_citire2 db "Introduceti n:", 10, 0
    msg_afisare db "Solutia aproximata folosind metoda Newton-Rapson in %d pasi este: %lf", 10, 0
    fmt_double db "%lf", 0
    fmt_int db "%d", 0

section .bss
section .text

global main

main:
    ; initializare
    push rbp
    mov rbp, rsp

    ; mesaj introducere x0
    mov rax, 0
    mov rdi, msg_citire
    call printf

    ; citire x0
    mov rax, 1
    mov rdi, fmt_double
    call scanf
    movsd [x_var], xmm0

    ; mesaj introducere n
    mov rax, 0
    mov rdi, msg_citire2
    call printf

    ; citire n
    mov rax, 0
    mov rdi, fmt_int
    mov rsi, n_var
    call scanf

    ; initializare repetitie
    mov ecx, 0
    mov rax, 3
    movsd xmm0, [x_var]

calculare_pas:
    ; conditie repetitie
    cmp ecx, [n_var]
    jge afisare_rezultat

    ; f(x) = -380x + 28 x^2 + x^3
    ; f'(x) = -380 + 56 x + 2 x ^ 2

    ; x ^ 0
    movsd [x_var], xmm0
    movsd xmm2, [a_const]
    
    ; x ^ 1
    movsd xmm1, xmm0
    mulsd xmm1, [a_const]

    movsd [x_tmp], xmm0
    mulsd xmm0, [b_const_dr]
    addsd xmm2, xmm0
    movsd xmm0, [x_tmp]

    ; x ^ 2
    mulsd xmm0, [x_var]
    movsd [x_tmp], xmm0
    mulsd xmm0, [b_const]
    addsd xmm1, xmm0

    movsd xmm0, [x_tmp]
    mulsd xmm0, [c_const_dr]
    addsd xmm2, xmm0
    movsd xmm0, [x_tmp]

    ; x ^ 3
    mulsd xmm0, [x_var]
    addsd xmm1, xmm0

    ; f(x) / f'(x)
    divsd xmm1, xmm2

    ; noul x_k
    movsd xmm0, [x_var]
    subsd xmm0, xmm1

    ; continuare repetitie
    inc ecx
    jmp calculare_pas

afisare_rezultat:
    mov rax, 1
    mov rsi, [n_var]
    mov rdi, msg_afisare
    call printf

    ; finalizare program
    mov rax, 0
    mov rsp, rbp
    pop rbp
    ret


