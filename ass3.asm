section .data

	msg0 db 10,"ASSIGNMENT 3",10
	msg0_len equ $- msg0

	msg1 db 10,"1.HEX to BCD",10,"2.BCD to HEX",10,"3.EXIT",10,10
	msg1_len equ $- msg1

	invalid_msg db 10,"Invalid Option Entered",10
	invalid_msg_len equ $- invalid_msg

	msg2 db 10,"Enter 4 digit HEX number",10
	msg2_len equ $- msg2

	msg3 db 10,"Enter 4 digit BCD number",10
	msg3_len equ $- msg3



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
%macro read 2
    	mov rax ,0
        mov rdi ,0
        mov rsi, %1
        mov rdx, %2
        syscall
%endmacro


section .bss
	char_ans resb 16
	buf resb 2


section .text
	global _start
		_start:
			print msg0,msg0_len   ; ASS3
			menu:
				call Display_menu	
				read buf,2
				mov al ,[buf]
				c1:
					cmp al ,'1'
					jne c2
					call HEX_BCD
					jmp menu
				c2:
					cmp al,'2'
					jne c3
					call BCD_HEX
					jmp menu
				c3:
					cmp al,'3'
					jne invalid
					exit
				invalid:
					print invalid_msg,invalid_msg_len
					jmp menu


		



HEX_BCD:
	print msg2,msg2_len
	ret
BCD_HEX:
	print msg3,msg3_len
	ret
Display_menu:
	mov rax ,1
    mov rdi, 1
    mov rsi ,msg1
    mov rdx ,msg1_len
    syscall

	ret


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
