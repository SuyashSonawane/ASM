section .data
	nline db 10,10
	nline_len equ $-nline
	ano db "Asssignment 6",10
	ano_len equ $-ano

	msg0 db 10,"Protection Mode"
	msg0_len equ $- msg0

	msg1 db 10,"GDTR ",10
	msg1_len equ $- msg1

	msg2 db 10,"LDTR ",10
	msg2_len equ $- msg2

	msg3 db 10,"TR ",10
	msg3_len equ $- msg3

	msg4 db 10,"MSW ",10
	msg4_len equ $- msg4

	msg5 db 10,"Real Mode"
	msg5_len equ $- msg5

	msg6 db ":"
	msg6_len equ $- msg6

	msg7 db 10,"LDTR ",10
	msg7_len equ $- msg7



section .bss

GDTR resw 3
LDTR resw 1
IDTR resw 3
MSW resw 1
TR resw 1
char_ans resb 16


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

section .text
global _start
_start:
	SGDT [GDTR]
	SLDT [LDTR]
	SMSW [MSW]
	STR [TR]
	SIDT [IDTR]
	print ano,ano_len

	mov rax , [MSW]
	ror rax,1
	jc PE
	PE:
	print msg0,msg0_len

	print msg1,msg1_len

	mov rax , [GDTR + 4]
	call Display
	mov rax,[GDTR + 2]
	call Display

	print msg6,msg6_len

	mov rax,[GDTR]
	call Display

	print msg7,msg7_len

	mov rax , [IDTR + 4]
	call Display
	mov rax,[IDTR + 2]
	call Display

	print msg6,msg6_len

	mov rax,[IDTR]
	call Display

	print msg2,msg2_len

	mov rax,[LDTR]
	call Display

	print msg3,msg3_len

	mov rax,[TR]
	call Display

	print msg4,msg4_len

	mov rax,[MSW]
	call Display



	


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

