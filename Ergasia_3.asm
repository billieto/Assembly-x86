TITLE Triti ergasia

INCLUDE Irvine32.inc

.data
array WORD 10, 20, 30, 40, 50, 60, 70, 80, 90, 100
array_size = ($ - array) / TYPE array
message1 BYTE "The average of the array is: ", 0
message2 BYTE "The variance of the array is: ", 0
.code

caculatemean PROC ; int caculatemean(int array[], int array_size)
push ebp
mov ebp, esp
push ebx
push ecx
push edx
push esi
push edi

mov ecx, 0 ; i = 0
mov eax, 0 ; average = 0
mov esi, [ebp + 8] ; array
mov di, [ebp + 12] ; array_size

jmp COND1
L1:
	add ax, [esi + ecx * 2] ; average += array[i]
	inc ecx ; i++
COND1:
cmp ecx, [ebp + 12]
jl L1

cwd
div di ; tha mporousa na kanw dword ptr alla piga me thn ekfwnhsh

lea edx, message1
call WriteString
call WriteInt
call Crlf

pop edi
pop esi
pop edx
pop ecx
pop ebx
mov esp, ebp
pop ebp
ret 8
caculatemean ENDP

caculatevariance PROC ; int caculatevariance(int array[], int array_size)
push ebp
mov ebp, esp
push ebx
push ecx
push edx
push esi
push edi

push [ebp + 12]
push [ebp + 8]
call caculatemean

mov edx, 0 ; result = 0
mov esi, [ebp + 8] ; OFFSET array

mov ecx, 0 ; i = 0
jmp COND2
L2:
	mov ebx, 0 ; val = 0
	mov bx, [esi + ecx * 2] ; val = array[i]
	sub ebx, eax ; val = array[i] - average
	imul ebx, ebx ; val = val * val
	add edx, ebx ; result += val
	inc ecx ; i++
COND2:
cmp ecx, [ebp + 12] ; i < array_size
jl L2

mov bx, [ebp + 12] ; array_size
mov eax, edx ; result

cwd
div bx ; result = result / array_size

pop edi
pop esi
pop edx
pop ecx
pop ebx
mov esp, ebp
pop ebp
ret 8
caculatevariance ENDP

main PROC

lea edi, array
mov ecx, array_size

push ecx
push edi 
call caculatevariance

lea edx, message2
call WriteString
call WriteInt
call Crlf

exit
main ENDP

END main