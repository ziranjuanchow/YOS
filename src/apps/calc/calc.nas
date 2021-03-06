[FORMAT "WCOFF"]
[INSTRSET "i486p"]
[OPTIMIZE 1]
[OPTION 1]
[BITS 32]
	EXTERN	_api_cmdline
	EXTERN	_sprintf
	EXTERN	_api_putstr0
	EXTERN	_api_end
	EXTERN	_strtol
[FILE "calc.c"]
[SECTION .data]
LC1:
	DB	"= %d = 0x%x",0x0A,0x00
LC0:
	DB	"error!",0x0A,0x00
[SECTION .text]
	GLOBAL	_HariMain
_HariMain:
	PUSH	EBP
	MOV	EBP,ESP
	PUSH	EBX
	SUB	ESP,36
	LEA	EBX,DWORD [-36+EBP]
	PUSH	30
	PUSH	EBX
	CALL	_api_cmdline
	MOV	ECX,EBX
	POP	EAX
	MOV	DWORD [-40+EBP],EBX
	POP	EDX
	CMP	BYTE [-36+EBP],32
	JLE	L10
	LEA	EDX,DWORD [-35+EBP]
L6:
	MOV	EAX,EDX
	MOV	DWORD [-40+EBP],EDX
	LEA	EDX,DWORD [2+ECX]
	MOV	ECX,EAX
	CMP	BYTE [-1+EDX],32
	JG	L6
L10:
	PUSH	9
	LEA	EAX,DWORD [-40+EBP]
	PUSH	EAX
	CALL	_getnum
	POP	EDX
	POP	ECX
	CMP	EAX,-2147483647
	JE	L11
	PUSH	EAX
	LEA	EBX,DWORD [-36+EBP]
	PUSH	EAX
	PUSH	LC1
	PUSH	EBX
	CALL	_sprintf
	PUSH	EBX
	CALL	_api_putstr0
	ADD	ESP,20
L8:
	CALL	_api_end
	MOV	EBX,DWORD [-4+EBP]
	LEAVE
	RET
L11:
	PUSH	LC0
	CALL	_api_putstr0
	POP	EAX
	JMP	L8
	GLOBAL	_skipspace
_skipspace:
	PUSH	EBP
	MOV	EBP,ESP
	MOV	EAX,DWORD [8+EBP]
	CMP	BYTE [EAX],32
	JE	L17
L19:
	POP	EBP
	RET
L17:
	INC	EAX
	CMP	BYTE [EAX],32
	JE	L17
	JMP	L19
	GLOBAL	_getnum
_getnum:
	PUSH	EBP
	MOV	EBP,ESP
	PUSH	EDI
	PUSH	ESI
	PUSH	EBX
	MOV	EBX,-2147483647
	PUSH	EAX
	PUSH	EAX
	MOV	EDI,DWORD [8+EBP]
	MOV	ESI,DWORD [12+EBP]
	MOV	EAX,DWORD [EDI]
	PUSH	EAX
	MOV	DWORD [-16+EBP],EAX
	CALL	_skipspace
	ADD	ESP,4
	MOV	ECX,EAX
	MOV	DWORD [-16+EBP],EAX
	MOV	AL,BYTE [EAX]
	CMP	AL,43
	JE	L81
	CMP	AL,45
	JE	L82
	CMP	AL,126
	JE	L83
	CMP	AL,40
	JE	L84
	SUB	EAX,48
	CMP	AL,9
	JBE	L85
L36:
	CMP	EBX,-2147483647
	JE	L37
	PUSH	DWORD [-16+EBP]
	CALL	_skipspace
	POP	ECX
	MOV	DWORD [-16+EBP],EAX
	CMP	BYTE [EAX],43
	JNE	L40
	CMP	ESI,2
	JG	L86
L40:
	CMP	BYTE [EAX],45
	JNE	L44
	CMP	ESI,2
	JG	L87
L44:
	CMP	BYTE [EAX],42
	JNE	L48
	CMP	ESI,1
	JG	L88
L48:
	CMP	BYTE [EAX],47
	JNE	L52
	CMP	ESI,1
	JG	L89
L52:
	CMP	BYTE [EAX],37
	JNE	L56
	CMP	ESI,1
	JG	L90
L56:
	CMP	BYTE [EAX],60
	JNE	L60
	CMP	BYTE [1+EAX],60
	JNE	L60
	CMP	ESI,3
	JG	L91
L60:
	CMP	BYTE [EAX],62
	JNE	L64
	CMP	BYTE [1+EAX],62
	JNE	L64
	CMP	ESI,3
	JG	L92
L64:
	CMP	BYTE [EAX],38
	JNE	L68
	CMP	ESI,4
	JG	L93
L68:
	CMP	BYTE [EAX],94
	JNE	L72
	CMP	ESI,5
	JG	L94
L72:
	CMP	BYTE [EAX],124
	JNE	L37
	CMP	ESI,6
	JLE	L37
	INC	EAX
	PUSH	EAX
	CALL	_skipspace
	PUSH	6
	MOV	DWORD [-16+EBP],EAX
	LEA	EAX,DWORD [-16+EBP]
	PUSH	EAX
	CALL	_getnum
	ADD	ESP,12
	CMP	EAX,-2147483647
	MOV	DWORD [-20+EBP],EAX
	JNE	L95
L77:
	MOV	EBX,-2147483647
	JMP	L36
L95:
	OR	EBX,EAX
	JMP	L36
L37:
	PUSH	DWORD [-16+EBP]
	CALL	_skipspace
	MOV	DWORD [EDI],EAX
	LEA	ESP,DWORD [-12+EBP]
	MOV	EAX,EBX
	POP	EBX
	POP	ESI
	POP	EDI
	POP	EBP
	RET
L94:
	INC	EAX
	PUSH	EAX
	CALL	_skipspace
	PUSH	5
	MOV	DWORD [-16+EBP],EAX
	LEA	EAX,DWORD [-16+EBP]
	PUSH	EAX
	CALL	_getnum
	ADD	ESP,12
	CMP	EAX,-2147483647
	MOV	DWORD [-20+EBP],EAX
	JE	L77
	XOR	EBX,EAX
	JMP	L36
L93:
	INC	EAX
	PUSH	EAX
	CALL	_skipspace
	PUSH	4
	MOV	DWORD [-16+EBP],EAX
	LEA	EAX,DWORD [-16+EBP]
	PUSH	EAX
	CALL	_getnum
	ADD	ESP,12
	CMP	EAX,-2147483647
	MOV	DWORD [-20+EBP],EAX
	JE	L77
	AND	EBX,EAX
	JMP	L36
L92:
	ADD	EAX,2
	PUSH	EAX
	CALL	_skipspace
	PUSH	3
	MOV	DWORD [-16+EBP],EAX
	LEA	EAX,DWORD [-16+EBP]
	PUSH	EAX
	CALL	_getnum
	ADD	ESP,12
	CMP	EAX,-2147483647
	MOV	DWORD [-20+EBP],EAX
	JE	L77
	TEST	EAX,EAX
	JE	L77
	MOV	CL,BYTE [-20+EBP]
	SAR	EBX,CL
	JMP	L36
L91:
	ADD	EAX,2
	PUSH	EAX
	CALL	_skipspace
	PUSH	3
	MOV	DWORD [-16+EBP],EAX
	LEA	EAX,DWORD [-16+EBP]
	PUSH	EAX
	CALL	_getnum
	ADD	ESP,12
	CMP	EAX,-2147483647
	MOV	DWORD [-20+EBP],EAX
	JE	L77
	TEST	EAX,EAX
	JE	L77
	MOV	CL,BYTE [-20+EBP]
	SAL	EBX,CL
	JMP	L36
L90:
	INC	EAX
	PUSH	EAX
	CALL	_skipspace
	PUSH	1
	MOV	DWORD [-16+EBP],EAX
	LEA	EAX,DWORD [-16+EBP]
	PUSH	EAX
	CALL	_getnum
	ADD	ESP,12
	CMP	EAX,-2147483647
	MOV	DWORD [-20+EBP],EAX
	JE	L77
	TEST	EAX,EAX
	JE	L77
	MOV	EAX,EBX
	CDQ
	IDIV	DWORD [-20+EBP]
	MOV	EBX,EDX
	JMP	L36
L89:
	INC	EAX
	PUSH	EAX
	CALL	_skipspace
	PUSH	1
	MOV	DWORD [-16+EBP],EAX
	LEA	EAX,DWORD [-16+EBP]
	PUSH	EAX
	CALL	_getnum
	ADD	ESP,12
	CMP	EAX,-2147483647
	MOV	DWORD [-20+EBP],EAX
	JE	L77
	TEST	EAX,EAX
	JE	L77
	MOV	EAX,EBX
	CDQ
	IDIV	DWORD [-20+EBP]
	MOV	EBX,EAX
	JMP	L36
L88:
	INC	EAX
	PUSH	EAX
	CALL	_skipspace
	PUSH	1
	MOV	DWORD [-16+EBP],EAX
	LEA	EAX,DWORD [-16+EBP]
	PUSH	EAX
	CALL	_getnum
	ADD	ESP,12
	CMP	EAX,-2147483647
	MOV	DWORD [-20+EBP],EAX
	JE	L77
	IMUL	EBX,EAX
	JMP	L36
L87:
	INC	EAX
	PUSH	EAX
	CALL	_skipspace
	PUSH	2
	MOV	DWORD [-16+EBP],EAX
	LEA	EAX,DWORD [-16+EBP]
	PUSH	EAX
	CALL	_getnum
	ADD	ESP,12
	CMP	EAX,-2147483647
	MOV	DWORD [-20+EBP],EAX
	JE	L77
	SUB	EBX,EAX
	JMP	L36
L86:
	INC	EAX
	PUSH	EAX
	CALL	_skipspace
	PUSH	2
	MOV	DWORD [-16+EBP],EAX
	LEA	EAX,DWORD [-16+EBP]
	PUSH	EAX
	CALL	_getnum
	ADD	ESP,12
	CMP	EAX,-2147483647
	MOV	DWORD [-20+EBP],EAX
	JE	L77
	ADD	EBX,EAX
	JMP	L36
L85:
	PUSH	0
	LEA	EAX,DWORD [-16+EBP]
	PUSH	EAX
	PUSH	ECX
	CALL	_strtol
L80:
	MOV	EBX,EAX
	ADD	ESP,12
	JMP	L36
L84:
	LEA	EAX,DWORD [1+ECX]
	PUSH	EAX
	CALL	_skipspace
	PUSH	9
	MOV	DWORD [-16+EBP],EAX
	LEA	EAX,DWORD [-16+EBP]
	PUSH	EAX
	CALL	_getnum
	ADD	ESP,12
	MOV	EBX,EAX
	MOV	EAX,DWORD [-16+EBP]
	CMP	BYTE [EAX],41
	JNE	L77
	INC	EAX
	PUSH	EAX
	CALL	_skipspace
	MOV	DWORD [-16+EBP],EAX
	POP	EAX
	JMP	L36
L83:
	LEA	EAX,DWORD [1+ECX]
	PUSH	EAX
	CALL	_skipspace
	PUSH	0
	MOV	DWORD [-16+EBP],EAX
	LEA	EAX,DWORD [-16+EBP]
	PUSH	EAX
	CALL	_getnum
	ADD	ESP,12
	MOV	EBX,EAX
	CMP	EAX,-2147483647
	JE	L37
	NOT	EBX
	JMP	L36
L82:
	LEA	EAX,DWORD [1+ECX]
	PUSH	EAX
	CALL	_skipspace
	PUSH	0
	MOV	DWORD [-16+EBP],EAX
	LEA	EAX,DWORD [-16+EBP]
	PUSH	EAX
	CALL	_getnum
	ADD	ESP,12
	MOV	EBX,EAX
	CMP	EAX,-2147483647
	JE	L37
	NEG	EBX
	JMP	L36
L81:
	LEA	EAX,DWORD [1+ECX]
	PUSH	EAX
	CALL	_skipspace
	PUSH	0
	MOV	DWORD [-16+EBP],EAX
	LEA	EAX,DWORD [-16+EBP]
	PUSH	EAX
	CALL	_getnum
	JMP	L80
