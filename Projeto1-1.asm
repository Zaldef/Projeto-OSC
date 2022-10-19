TITLE Guilherme Roelli (22899140) & Vitor Yuzo Takei (22023740)
.MODEL SMALL
.STACK 100h
.DATA
MSG1    DB  10,'Comece escolhendo a operacao:',10,'$'
OP1     DB  '1 - Adicao',10,'$'
OP2     DB  '2 - Subtracao',10,'$'
OP3     DB  '3 - Multiplicacao',10,'$'
OP4     DB  '4 - Divisao',10,'$'
OP5     DB  '5 - AND',10,'$'
OP6     DB  '6 - OR',10,'$'
OP7     DB  '7 - XOR',10,'$'
OP8     DB  '8 - NOT',10,'$'
DIG1	DB	10,'Digite o primeiro numero (0-9): $'
DIG2	DB	10,'Digite o segundo numero (0-9): $'

.CODE
    MAIN PROC
        MOV AX,@DATA        ;
        MOV DS,AX           ; Inicio ao segmento de data

        LEA DX,DIG1         ;         
        CALL PRINT          ;
        MOV AH,01           ;
        INT 21h             ;
        MOV BH,AL           ;
        AND BH,0Fh          ;

        LEA DX,DIG2         ;              
        CALL PRINT          ;
        MOV AH,01           ;      
        INT 21h             ;
        MOV BL,AL           ;
        AND BL,0Fh          ;

        LEA DX,MSG1         ;         
        CALL PRINT          ;
        LEA DX,OP1          ;
        CALL PRINT          ;
        LEA DX,OP2          ;
        CALL PRINT          ;
        LEA DX,OP3          ;
        CALL PRINT          ;
        LEA DX,OP4          ;
        CALL PRINT          ;
        LEA DX,OP5          ;
        CALL PRINT          ;
        LEA DX,OP6          ;
        CALL PRINT          ;
        LEA DX,OP7          ;
        CALL PRINT          ;
        LEA DX,OP8          ;
        CALL PRINT          ; Tela inical, qual operação escolher

        MOV AH,08h          ;
        INT 21h             ;
        CMP AL,31h          ;
        JE ADD              ;
        CMP AL,32h          ;
        JE SUB              ;
        CMP AL,33h          ;
        JE MUL              ;
        CMP AL,34h          ;
        JE DIV              ; 
        CMP AL,35h          ;
        JE AND              ;
        CMP AL,36h          ;
        JE OR               ;
        CMP AL,37h          ;
        JE XOR              ;
        CMP AL,38h          ;
        JE NOT              ;Jumps para as operações

    ADD:
        ADD BH,BL
        JMP RESULT
    SUB:
        SUB BH,BL
        JMP RESULT
    MUL:
        JMP FIM
    DIV:
        JMP FIM
    AND:
        JMP FIM
    OR:
        JMP FIM
    XOR:
        JMP FIM
    NOT:
        JMP FIM
    RESULT:
    xor ax,AX
    MOV Al,Bh

    MOV BL,10
    DIV BL
    MOV BX,AX
    MOV DL,BL
    OR  DL,30H
    MOV AH,02h
    INT 21h
    MOV DL,BH
    OR  DL,30H
    MOV AH,2
    INT 21h
    JMP FIM
    
    
    
    
    
    
    
    FIM:
        MOV AH,4Ch          ;
        INT 21h             ;Exit do programa
    MAIN ENDP

    
    PRINT PROC
        MOV AH,09h
	    INT 21h
	    RET  
    PRINT ENDP

    LF PROC
        MOV AH,02h
        MOV DL,10
        INT 21h
        RET 
    LF ENDP
END MAIN

MOV AX,18
MOV BL,10
DIV BL
MOV BX,AX
MOV DL BL
OR DL 30H
MOV AH, 2
INT 21H
MOV DL,BL
OR DL, 30H
MOV AH,2

