section .data

	msg0 db 10,"ASSIGNMENT 3",10
	msg0_len equ $- msg0

	msg1 db 10,"1.HEX to BCD",10,"2.BCD to HEX",10,"3.EXIT",10
	msg1_len equ $- msg1



; A macro with 2 parameters
%macro print 2
    mov rax ,1
    mov rdi, 1
    mov rsi ,%1
    mov rdx ,%2
    syscall
%endmacro
%macro exit 0
    	mov rax ,60
        mov rdi ,0
        syscall
%endmacro


section .bss
	char_ans resb 16


section .text
	global _start
		_start:
			print msg0,msg0_len
			print msg1,msg1_len

		exit








Display:
	mov rbx , 16
	mov rcx ,2
	mov rsi , char_ans+1

	cnt:
		mov rdx,0
		div rbx
		cmp dl,09h
		jbe add30
		add dl ,07h

	add30:
		add dl,30h
		mov [rsi],dl
		dec rsi
		dec rcx
		jnz cnt
		print char_ans,2


	ret
