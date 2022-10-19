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
        AND BH,0Fh          ; Reconhece a entrada do primeiro caracter, converte para numero e armazena em BH

        LEA DX,DIG2         ;              
        CALL PRINT          ;
        MOV AH,01           ;      
        INT 21h             ;
        MOV BL,AL           ;
        AND BL,0Fh          ; Reconhece a entrada do primeiro caracter, converte para numero e armazena em BL

        LEA DX,MSG1         ;         
        CALL PRINT          ;
        LEA DX,OP1          ; ADD
        CALL PRINT          ;
        LEA DX,OP2          ; SUB
        CALL PRINT          ;
        LEA DX,OP3          ; MUL
        CALL PRINT          ;
        LEA DX,OP4          ; DIV
        CALL PRINT          ;
        LEA DX,OP5          ; AND
        CALL PRINT          ;
        LEA DX,OP6          ; OR
        CALL PRINT          ;
        LEA DX,OP7          ; XOR
        CALL PRINT          ;
        LEA DX,OP8          ; NOT
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
        JE NOT              ; Jumps para as operações (ADD, SUB MUL DIV AND OR XOR NOT)

    ADD:
        ADD BH,BL           ;            
        JMP RESULT          ; Operação ADD 
    SUB:
        SUB BH,BL           ; 
        JMP RESULT          ; Operação SUB
    MUL:
        JMP RESULT
    DIV:
        JMP RESULT
    AND:
        JMP RESULT
    OR:
        JMP RESULT
    XOR:
        JMP RESULT
    NOT:
        JMP RESULT
    RESULT:
    XOR AX,AX              ; Zera o registrador AX para ser utilizado 
    MOV AL,BH              ; Trás o resultado da operação para AL
   
    MOV BL,10              ;
    DIV BL                 ;
    MOV BX,AX              ; Diviede os caracteres em armazena em BH/BL

    MOV DL,BL              ;
    OR  DL,30H             ; 
    MOV AH,02h             ;
    INT 21h                ; Converte para caracter e imprime o primeiro digito

    MOV DL,BH              ;
    OR  DL,30H             ;
    MOV AH,2               ;
    INT 21h                ;
    JMP FIM                ; Converte para caracter e imprime o segundo digito
    
    FIM:                    ;
        MOV AH,4Ch          ;
        INT 21h             ;Exit do programa
    MAIN ENDP               ;
  
    PRINT PROC              ;
        MOV AH,09h          ;
	    INT 21h             ;
	    RET                 ;
    PRINT ENDP              ; Proc para dar print na tela

END MAIN