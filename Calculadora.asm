TITLE Guilherme Roelli (22899140) & Vitor Yuzo Takei (22023740)
.MODEL SMALL
.STACK 100h
.DATA ; Todos os numeros em HEXA/DECIMAL e virgulas vazia são para emolduramento/formatação da calculadora
LAYOUT1 DB  10,0C9h,35 DUP (0CDh),0BBh,'$'
LAYOUT2 DB  3 DUP (),0BAh,10,0CCh,35 DUP (0CDh),0B9H,'$'
LAYOUT3 DB  10,0CCh,35 DUP (0CDh),0B9H,'$'
LAYOUT4 DB  8 DUP (),0BAh,10,0C8h,35 DUP (0CDh),0BCh,'$'
LAYOUT5 DB  18 DUP (),0BAh,10,0CCh,35 DUP (0CDh),0B9H,'$'
LAYOUT6 DB  8 DUP (),0BAh,10,0CCh,35 DUP (0CDh),0B9H,'$'
DIG1	DB	10,0BAh,'Digite o primeiro n',0A3H,'mero (0-9): $'
DIG2	DB	,,0BAh,10,0BAh,'Digite o segundo n',0A3H,'mero (0-9): $'
MSG1    DB  10,0BAh,'Escolha a opera',87h,'ao;',16 DUP (),0BAh,10,'$'
MSG2    DB  10,0BAh,'O resultado ',82h,': $'
MSG3    DB  10,0BAh,'Deseja continuar (S / N): $'
MSG4    DB  10,0BAh,0A5H,,82h,' possivel dividir por 0 $'
OP1     DB  0BAh,'1 - Adi',87h,'ao', 25 DUP (),0BAh,10,'$'
OP2     DB  0BAh,'2 - Subtra',87h,'ao',22 DUP (),0BAh,10,'$'
OP3     DB  0BAh,'3 - Multiplica',87h,'ao',18 DUP (),0BAh,10,'$'
OP4     DB  0BAh,'4 - Divisao',24 DUP (),0BAh,10,'$'
OP5     DB  0BAh,'5 - AND',28 DUP (),0BAh,10,'$'
OP6     DB  0BAh,'6 - OR',29 DUP (),0BAh,10,'$'
OP7     DB  0BAh,'7 - XOR',28 DUP (),0BAh,10,'$'
OP8     DB  0BAh,'8 - NOT',28 DUP (),0BAh,'$'

.CODE
    MAIN PROC
        MOV AX,@DATA       ;
        MOV DS,AX          ; Inicio ao segmento de data

        LEA DX,LAYOUT1     ;
        CALL PRINT         ; Vai formatar a "moldura" da calculadora
        LEA DX,DIG1        ;         
        CALL PRINT         ; Vai printar o texto para entrada para o primeiro digito
        MOV AH,01          ;
        INT 21h            ;
        MOV BH,AL          ;
        AND BH,0Fh         ; Reconhece a entrada do primeiro caracter, armazena em BH e converte para numero e armazena em BH

        LEA DX,DIG2        ;              
        CALL PRINT         ; Vai printar o texto para entrada para o segundo digito
        MOV AH,01          ;      
        INT 21h            ;
        MOV BL,AL          ;
        AND BL,0Fh         ; Reconhece a entrada do segundo caracter, armazena em BL e converte para numero 

        LEA DX,LAYOUT2     ;
        CALL PRINT         ; Vai formatar a "moldura" da calculadora
        LEA DX,MSG1        ;         
        CALL PRINT         ; Vai printar o texto para escolha de operação
        LEA DX,OP1         ; ADD
        CALL PRINT         ;
        LEA DX,OP2         ; SUB
        CALL PRINT         ;
        LEA DX,OP3         ; MUL
        CALL PRINT         ;
        LEA DX,OP4         ; DIV
        CALL PRINT         ;
        LEA DX,OP5         ; AND
        CALL PRINT         ;
        LEA DX,OP6         ; OR
        CALL PRINT         ;
        LEA DX,OP7         ; XOR
        CALL PRINT         ;
        LEA DX,OP8         ; NOT
        CALL PRINT         ; Tela inical, qual operação escolher

        MOV AH,08h         ;
        INT 21h            ;
        CMP AL,31h         ;
        JE ADD             ;
        CMP AL,32h         ;
        JE SUB             ;
        CMP AL,33h         ;
        JE MUL             ;
        CMP AL,34h         ;
        JE DIV             ; 
        CMP AL,35h         ;
        JE AND             ;
        CMP AL,36h         ;
        JE OR              ;
        CMP AL,37h         ;
        JE XOR             ;
        CMP AL,38h         ;
        JE NOT             ; Vai pegar a entrada do teclado e realizar um CMP para definir o jumps para a operação (ADD, SUB, MUL, DIV, AND, OR, XOR, NOT)

    ADD:
        ADD BH,BL          ; Operação ADD           
        JMP RESULT         ;  
    SUB:
        SUB BH,BL          ; 
        JS  RESULTN        ;
        JMP RESULT         ; Operação SUB
    MUL:
        XOR CX,CX          ; Limpar o registrador CX, que vai ser usado como auxiliar na contagem desta OP
        CMP BL,0           ; Se o multiplicador(BL) for 0, jump para "X0"
        JE M0              ;
        MAUX1:             ; Segmento auxiliar da multiplicação 1
            SHR BL,1       ; Desloca o ultimo bit do multiplicador(BL) para direita, jogando em CF
            JC MAUX2       ; Se CF for 1, jump para AUX1, se ñ segue o codigo
            SHL BH,1       ; Desloca BH uma casa para direita 
            JMP MAUX1      ;
        MAUX2:             ; Segmento auxiliar da multiplicação 2
            ADD CH,BH      ; Adiciona o Numerador(BH) no produto(CH)
            SHL BH,1       ;    
            CMP BL,0       ; Enquanto o Multiplicador(BL) nao for zero, ñ pula para o resultado
            JNE MAUX1      ;
            MOV BH, CH     ; Joga o produto em BH, para ser processado pelo RESULT
            JMP RESULT     ; Operação MUL
        M0:
            XOR BH,BH      ; Zera BH
            JMP RESULT     ;
    DIV:
        CMP BL,0
        JE D0
        DAUX1:
            SHL BH,4
        DAUX2:
            SHL BL,4
        DAUX3:
            CMP BH,BL
            JAE DAUX4
            CMP BH,0
            JE FIM
            CMP BH,1
            JE FIM
            JMP DAUX3
        DAUX4:
            SUB BH,BL
            ADD CL, 1
            JMP DAUX3
            CMP BH,0
            JE FIM
            JMP DAUX3

        D0:
            LEA DX, LAYOUT3
            CALL PRINT
            LEA DX, MSG4
            CALL PRINT
        LEA DX,LAYOUT6     ;
        CALL PRINT         ; Vai formatar a "moldura" da calculadora
        JMP FIM         ; Operação DIV
    AND:
        AND BH,BL          ;
        JMP RESULT         ; Operação AND
    OR:
        OR BH,BL           ;
        JMP RESULT         ; Operação OR
    XOR:
        XOR BH,BL          ;
        JMP RESULT         ; Operação XOR
    NOT:
        NOT BH             ;
        JMP RESULT         ; Operação NOT
    
    RESULTN:
        LEA DX,LAYOUT3     ;
        CALL PRINT         ; Vai formatar a "moldura" da calculadora
        LEA DX,MSG2        ;         
        CALL PRINT         ; Printa a MSG2

        MOV DL,2Dh         ;
        MOV AH,02h         ;
        INT 21h            ; Printa o sinal "-"
        
       
        MOV DL,BH          ;
        NEG DL             ; 
        OR  DL,30h         ;
        MOV AH,02h         ;
        INT 21h            ; Nega o resultado e converte para caracter e depois printa na tela
        JMP FIM            ; Jump para o final da calculador
    
    RESULT:
        LEA DX,LAYOUT3     ;
        CALL PRINT  	   ; Vai formatar a "moldura" da calculadora
        LEA DX,MSG2        ;         
        CALL PRINT         ; Printa a MSG2   
    
        XOR AX,AX          ; Zera o registrador AX para ser utilizado 
        MOV AL,BH          ; Trás o resultado da operação para AL
   
        MOV BL,10          ;
        DIV BL             ;
        MOV BX,AX          ; Diviede os numeros e armazena em BH/BL

        MOV DL,BL          ;
        OR  DL,30h         ; 
        MOV AH,02h         ;
        INT 21h            ; Converte para caracter e imprime o primeiro digito
  
        MOV DL,BH          ;
        OR  DL,30h         ;
        MOV AH,2           ;
        INT 21h            ; Converte para caracter e imprime o segundo digito
        LEA DX,LAYOUT5     ;
        CALL PRINT         ; Vai formatar a "moldura" da calculadora
        JMP FIM            ; Jump para o fim da calculadora

    RESTART:
        LEA DX, LAYOUT4    ; 
        CALL PRINT         ; Vai formatar a "moldura" da calculadora
        CALL MAIN          ; Vai retornar para o inicio da MAIN PROC

    FIM:
        
        LEA DX,MSG3        ;
        CALL PRINT         ; Vai printar o texto para o restart da calculadora
        MOV AH,01h         ;
        INT 21h            ;
        CMP AL, 73h        ;
        JE RESTART         ;
        CMP AL,53h         ;
        JE RESTART         ; Vai pegar a entrada do teclado e realizar um CMP para definir se deve ou não encerrar a calculadora 
           
        LEA DX,LAYOUT4     ; Vai formatar a "moldura" da calculadora
        CALL PRINT         ; Fecha a "moldura" da calculadora
        MOV AH,4Ch         ;
        INT 21h            ; Exit do programa
    MAIN ENDP              ;
  
    PRINT PROC             ;
        MOV AH,09h         ;
	    INT 21h            ;
	    RET                ;
    PRINT ENDP             ; Procedimento para dar print na tela

END MAIN
