TITLE Expression calculator
; This program calculates a simple arithmetical expression
Include irvine32.inc

p EQU 8d

.data
	x SDWORD 16d
	y SDWORD 154d
	z SDWORD -17d
	w SDWORD ?
	

.code

main PROC
	;putting the data into registers
	mov eax, x
	mov ebx, y
	mov ecx, w
	mov edx, z
	
	mov ecx, ebx ;moving y to w
	add ecx, eax ;adding x and y (doing that in w)

	add edx, ebx ;adding z and y
	add edx, eax ;adding (z + y) and x
	add edx, 50d ;adding (z + y + x) and 50d
	sub edx, p   ;subtracting (z + y + x + 50d) and p = 8d

	sub ecx, edx ;subtracting (x + y) and (z + y + x + 50d - p) [storing it in w]

	mov eax, ecx ;moving w to eax so WriteInt works right

	call WriteInt ;Write in console the value of w
	call Crlf ;prints out '\n'(enter)


	exit
main ENDP
END main
