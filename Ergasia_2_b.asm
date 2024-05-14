TITLE Expression calculator
; This program declares and reads array elements
INCLUDE Irvine32.inc

.data

array2d SDWORD 00d,10d,20d,30d,
			   01d,11d,21d,31d,
			   02d,12d,22d,32d,
			   03d,13d,23d,33d

line_size = ($ - array2d) / 4
line_elements = line_size / 4

x BYTE 2
y BYTE 2
z SWORD -30d

message1 BYTE "The position of the element [2,2] is: ",0
message2 BYTE "The sum a[2,2] + z is: ",0
message3 BYTE "The sum a[2,2] - z is: ",0

.code

main PROC
	; effective adress = array_base_address + offset 
	; offset = x * (elements_per_row) + y) * (bytes_per_elements)

	;calculate the offset
	movzx ebx, x
	shl ebx, 2 ; x * 2^2 = x * 4

	movzx eax, y
	add eax, ebx ; eax = x * 4 + y
	shl eax, 2 ; y * 2^2 = y * 4

	;calculate the effective address
	mov eax, [OFFSET array2d + eax]

	
	mov edx, OFFSET message1

	call WriteString
	call WriteInt
	call Crlf

	mov edx, OFFSET message2
	mov ecx, eax
	movsx ebx, z
	add eax, ebx
	call WriteString
	call WriteInt
	call Crlf

	mov edx, OFFSET message3
	mov eax, ecx
	sub	eax, ebx
	call WriteString
	call WriteInt
	call Crlf

	call foo

	exit

main ENDP


.data

x2 = 3
y2 = 1

message4 BYTE "The position of the element [3,1] is: ",0

effective_address DWORD ?

.code

foo PROC

	mov eax, array2d[x2 * line_size + y2 * SIZEOF SDWORD]
	mov edx, OFFSET message4
	call WriteString
	call WriteInt
	call Crlf

foo ENDP
END main