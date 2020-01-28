section .data

	msg0 db 10,"ASSIGNMENT 4",10
	msg0_len equ $- msg0

	msg1 db 10,"1.MUL by Subsequent Addition",10,"2.MUL by Add and Shift",10,"3.EXIT",10,10
	msg1_len equ $- msg1

	invalid_msg db 10,"Invalid Option Entered",10
	invalid_msg_len equ $- invalid_msg

	msg2 db 10,"Enter 16 bit number",10
	msg2_len equ $- msg2

	msg3 db 10,"Enter 16 bit number",10
	msg3_len equ $- msg3

	e_msg db 10,"Invalid input",10
	e_msg_len equ $- e_msg

	bcd_msg db 10,"BCD format = "
	bcd_msg_len equ $- bcd_msg

	hex_msg db 10,"Hex format = "
	hex_msg_len equ $- hex_msg



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
	char_ans resb 4
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
					call MUL_sub
					jmp menu
				c2:
					cmp al,'2'
					jne c3
					call MUL_shift
					jmp menu
				c3:
					cmp al,'3'
					jne invalid
					exit
					
				invalid:
					print invalid_msg,invalid_msg_len
					jmp menu


		

Accept:
	read buf,5
	mov rcx,4
	mov rsi,buf
	xor bx,bx

	Next_byte:
		shl bx,4
		mov al,[rsi]
		cmp al,'0'
		jb error
		cmp al,'9'
		jbe sub30
		cmp al,'A'
		jb error
		cmp al,'F'
		jbe sub37
		cmp al,'a'
		jb error
		cmp al,'f'
		jbe sub57

	error:
		print e_msg,e_msg_len
		exit
	sub57:
		sub al,20h
	sub37:
		sub al,07h
	sub30:
		sub al,30h

	add bx,ax
	inc rsi
	dec rcx
	jnz Next_byte

	ret

MUL_sub:
	print msg2,msg2_len	

	ret


	ret

MUL_shift:
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
	mov rcx ,4
	mov rsi , char_ans+3

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
		print char_ans,4


	ret
