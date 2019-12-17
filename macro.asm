; A macro with 2 parameters
%macro write_string 2
    mov rax ,1
    mov rdi, 1
    mov rsi ,%1
    mov rdx ,%2
    syscall
%endmacro


section .data
    msg db 10,"Printed using macros"
    msg_len equ $- msg

section .text
    global _start
    _start:
        write_string msg,msg_len
        mov rax ,60
        mov rdi ,0
        syscall
