TITLE Guilherme Roelli (22899140) & Vitor Yuzo Takei ()
.MODEL SMALL
.STACK 100h
.DATA
MSG1    DB  'Comece escolhendo a operacao:',10,'$'
OP1     DB  '1 - Adicao',10,'$'
OP2     DB  '2 - Subtracao',10,'$'
OP3     DB  '3 - Multiplicacao',10,'$'
OP4     DB  '4 - Divisao',10,'$'
DIG1	DB	'Digite o primeiro numero (0-9):',10,'$'
DIG2	DB	'Digite o segundo numero (0-9):',10,'$'
NUM1    DW  ?
NUM2    DW  ?

.CODE
    MAIN PROC
        MOV AX,@DATA        ;
        MOV DS,AX           ; Inicio ao segmento de data

        LEA DX,DIG1         ;         
        CALL PRINT
        MOV AH,01           ;
        INT 21h
        MOV NUM1,AL

        LEA DX,DIG2         ;         
        CALL PRINT
        MOV AH,01           ;
        INT 21h
        MOV NUM2,AL

        LEA DX,MSG1         ;         
        CALL PRINT          ;
        LEA DX,OP1          ;
        CALL PRINT          ;
        LEA DX,OP2          ;
        CALL PRINT          ;
        LEA DX,OP3          ;
        CALL PRINT          ;
        LEA DX,OP4          ;
        CALL PRINT          ; Tela inical, qual operação escolher
        
        MOV AH,01           ;
        INT 21h             ;
        CMP AL,31h          ;
        JE ADD              ;
        CMP AL,32h          ;
        JE SUB              ;
        CMP AL,33h          ;
        JE MUL              ;
        CMP AL,34h          ;
        JE DIV              ; Jumps para as operações

    ADD:
    SUB:
    MUL:
    DIV:

    FIM:
        MOV AH,4Ch          ;
        INT 21h             ;Exit do programa
    MAIN ENDP

    
    PRINT PROC
    MOV AH,09h
	INT 21h
	RET  
    PRINT ENDP
END MAIN