;Program for printing HelloWorld

section .data
    msg db 10,"Displaying 10 stars",10
    msg_len equ $ - msg
    star times 10 db "*"


section .text
    global _start

    _start:
        mov rax , 1
        mov rdi , 1
        mov rsi , msg
        mov rdx ,msg_len
        syscall
        mov rax , 1
        mov rdi , 1
        mov rsi , star
        mov rdx ,10
        syscall
        mov rax, 60
        mov rdi ,0
        syscall
