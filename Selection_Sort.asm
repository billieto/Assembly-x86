TITLE Selection Sort

INCLUDE Irvine32.inc

.data

array DWORD 64h, 25h, 12h, 22h, 11h

message1 BYTE "Sorted Array: ", 0dh, 0ah, 0
delimeter BYTE ", ", 0

.code	

swap PROC

	push ebp
	mov ebp,esp
	pushad

	mov edi ,[ebp+8]
	mov eax , [edi]  ; eax <- *a

	mov esi ,[ebp+12]
	mov ebx , [esi]  ; ebx <- *b

	mov [esi],eax    ; *b <- *a
	mov [edi],ebx    ; *a <- *b

	popad
	mov esp,ebp
	pop ebp
	ret 8
swap ENDP

selectionsort PROC

	push ebp
	mov ebp,esp
	pushad

	; for(i = 0; i < n - 1; i++)

	;initialization 1
	mov ecx, 0
	mov edi, [ebp + 8] ; array base address
	mov edx, [ebp + 12] ; n
	dec edx ; edx = n - 1
	jmp COND1
	;body 1
	BODY1:
		mov ebx, ecx ; min_idx = i

		;for(j = i + 1; j < n; j++)

		;inisiaization 2
		mov eax, ecx
		inc eax ; eax = i + 1
		jmp COND2
		;body 2
		BODY2:
			push edx
			mov edx, [edi + eax * 4] ; edx = array[j]
			mov esi, [edi + ebx * 4] ; esi = array[min_idx]
			cmp edx, esi ; array[j] < array[min_idx]
			pop edx
			jge STET1
				mov ebx, eax ; min_idx = j

			STET1:

		;step 2
		inc eax

		;condition 2
		COND2:
		cmp eax, [ebp + 12] ; j < n
		jl BODY2
		
		cmp ebx, ecx ; min_idx != i
		je STET2
		
			push eax
			push ebx

			lea eax, [edi + ecx * 4] ; eax = &array[i]
			lea ebx, [edi + ebx * 4] ; ebx = &array[min_idx]

			push eax
			push ebx
			call swap

			pop ebx
			pop eax

		STET2:

	;step 1
	inc ecx

	;condition 1
	COND1:
	cmp ecx, edx ; i < n - 1
	jl BODY1

	popad
	mov esp, ebp
	pop ebp
	ret 8
selectionsort ENDP


printArray Proc
	push ebp
	mov ebp, esp
	pushad

	 mov ebx,0 ; i = 0 loop counter
	 mov edi, [ebp + 8] ; array base address
	 mov edx, [ebp +12]
	 dec edx	; edx <- size - 1
	 jmp COND
	 ;body
	 BODY:
	;cout << " " << arr[i];
	    mov eax, [edi + ebx * 4] ; eax <- array[i] 
		call WriteHex 		
		; check if it is the last element		
		cmp ebx, edx ; i == size-1
		je STEP
		push edx
		mov edx, OFFSET delimeter
		call WriteString
		pop edx
	 ;step
	 STEP:
		inc ebx
	 ;condition		
	 COND:
	    cmp ebx, [ebp + 12] ; i < size
		jl BODY
		call Crlf

	popad
	mov esp, ebp
	pop ebp
	ret 8
printArray ENDP


main PROC
	
	mov eax, LENGTHOF array
	push eax
	push OFFSET array
	call selectionsort

	mov edx, OFFSET message1
	call WriteString

	push eax
	push OFFSET array
	call printarray

exit
main ENDP

END main