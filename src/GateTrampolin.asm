.code

PrepareSyscall PROC

	xor r11, r11
	xor r12, r12
	mov r11, rcx
	mov r12, rdx
	ret

PrepareSyscall ENDP

DoSyscall Proc

	xor rax, rax
	mov r10, rcx
	mov eax, r11d
	jmp r12
	

DoSyscall ENDP

end