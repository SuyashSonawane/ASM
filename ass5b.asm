

section .data

	msg2 db 10,"No of blank Spaces are : ",10
	msg2_len equ $- msg2

	msg3 db 10,"Occurance of letter : ",10
	msg3_len equ $- msg3

	msg4 db 10,"Occurance of new line : ",10
	msg4_len equ $- msg4



section .bss
	ncount resq 1
	scount resq 1
	ccount resq 1



section .text	

		


far_procedure:
	xor rax,rax
	xor rbx,rbx
	xor rcx,rcx
	xor rsi,rsi
	mov bl,[char]
	mov rsi,buf
	mov rcx,[abuff]

	again:
		mov al,[rsi]
		case_s:
			cmp al,20h
			jne case_n
			inc qword[scount]
			jmp next
		case_n:
			cmp al,0Ah
			jne case_c
			inc qword[ncount]
			jmp next
		case_c:
			cmp al,bl
			jne next
			inc qword[ccount]
		next:
			inc rsi
			dec rcx
			jnz again
			print msg2,msg2_len
			mov rax,[scount]
			call Display
			print msg4,msg4_len
			mov rax,[ncount]
			call Display
			print msg3,msg3_len
			mov rax,[ccount]
			call Display
			fclose [filehandler]


 
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

