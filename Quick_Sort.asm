INCLUDE Irvine32.inc

.data

array DWORD 10h, 80h, 30h, 90h, 40h

n DWORD ($ - array) / 4

message BYTE "The array is sorted: ", 0

delimeter BYTE ", ",0

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

partition PROC ; returns value on eax
	push ebp
	mov ebp, esp
	push ebx
	push ecx
	push edx
	push esi
	push edi

	mov edi, [ebp + 8] ; array base address
	mov ebx, [ebp + 12] ; low
	mov esi, [ebp + 16] ; high

	mov edx, [edi + esi * 4] ; edx = array[high]
	mov eax, ebx ; eax = low
	dec eax ; eax = low - 1 = i

	; inisialization
	mov ecx, ebx ; ecx = low
	jmp COND

L1: ; body
	
	mov ebx, [edi + ecx * 4] ; ebx = array[j]
	cmp ebx, edx
	jge STEP

	inc eax
	
	push ebx
	push edx

	lea edx, [edi + eax * 4] ; edx = &array[i]
	lea ebx, [edi + ecx * 4] ; esi = &array[j]

	push ebx
	push edx
	call swap

	pop edx
	pop ebx

STEP:; step
	inc ecx ; j++
COND: ; condition
	cmp ecx, [ebp + 16] ; j <= high
	jle L1

	inc eax ; i++
	lea ecx, [edi + eax * 4] ; ecx = &array[i]
	lea ebx, [edi + esi * 4] ; ebx = &array[high]

	push ebx
	push ecx
	call swap

	pop edi
	pop esi
	pop edx
	pop ecx
	pop ebx
	mov esp, ebp
	pop ebp
	ret 12
partition ENDP


quicksort PROC
	push ebp
	mov ebp, esp
	pushad

	mov edi, [ebp + 8] ; array base address
	mov ebx, [ebp + 12] ; low
	mov ecx, [ebp + 16] ; high

	cmp ebx, ecx
	jge OUT1

	push ecx
	push ebx
	push edi 
	call partition ; returns value in eax

	mov edx, eax
	dec edx
	inc eax

	push edx
	push ebx
	push edi
	call quicksort


	push ecx
	push eax
	push edi
	call quicksort

OUT1:
	popad
	mov esp, ebp
	pop ebp
	ret 12
quicksort ENDP

printArray PROC
	push ebp
	mov ebp, esp
	pushad

;void printArray(int arr[], int size)
;{
;    int i;
;    for (i = 0; i < size; i++)

	 ;initialization
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
	ret
printArray ENDP


main PROC
	
	mov ebx, n
	dec ebx
	push ebx
	push 0
	push OFFSET array
	call quicksort

	mov EDX, OFFSET message
	call WriteString
	call crlf

	push n
	push OFFSET array
	call printArray

	exit

main ENDP

END main	