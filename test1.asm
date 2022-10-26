TITLE Guilherme Roelli (22899140) & Vitor Yuzo Takei (22023740)
.MODEL SMALL
.STACK 100h
.DATA ; Todos os numeros em HEXA/DECIMAL e virgulas vazia são puramente formatação 
LAYOUT1 DB  0C9h,0CDh,0CDh,0CDh,0CDh,0CDh,0CDh,0CDh,0CDh,0CDh,0CDh,0CDh,0CDh,0CDh,0CDh,0CDh,0CDh,0CDh,0CDh,0CDh,0CDh,0CDh,0CDh,0CDh,0CDh,0CDh,0CDh,0CDh,0CDh,0CDh,0CDh,0CDh,0CDh,0CDh,0CDh,0CDh,0BBh,'$'
LAYOUT2 DB  ,,,0BAh,10,0CCh,0CDh,0CDh,0CDh,0CDh,0CDh,0CDh,0CDh,0CDh,0CDh,0CDh,0CDh,0CDh,0CDh,0CDh,0CDh,0CDh,0CDh,0CDh,0CDh,0CDh,0CDh,0CDh,0CDh,0CDh,0CDh,0CDh,0CDh,0CDh,0CDh,0CDh,0CDh,0CDh,0CDh,0CDh,0CDh,0B9H,'$'
LAYOUT3 DB  10,0CCh,0CDh,0CDh,0CDh,0CDh,0CDh,0CDh,0CDh,0CDh,0CDh,0CDh,0CDh,0CDh,0CDh,0CDh,0CDh,0CDh,0CDh,0CDh,0CDh,0CDh,0CDh,0CDh,0CDh,0CDh,0CDh,0CDh,0CDh,0CDh,0CDh,0CDh,0CDh,0CDh,0CDh,0CDh,0CDh,0B9H,'$'
LAYOUT4 DB  ,,,,,,,,,,,,,,,,,,0BAh,10,0C8h,0CDh,0CDh,0CDh,0CDh,0CDh,0CDh,0CDh,0CDh,0CDh,0CDh,0CDh,0CDh,0CDh,0CDh,0CDh,0CDh,0CDh,0CDh,0CDh,0CDh,0CDh,0CDh,0CDh,0CDh,0CDh,0CDh,0CDh,0CDh,0CDh,0CDh,0CDh,0CDh,0CDh,0CDh,0CDh,0BCh,'$'
DIG1	DB	10,0BAh,'Digite o primeiro n',0A3H,'mero (0-9): $'
DIG2	DB	,,0BAh,10,0BAh,'Digite o segundo n',0A3H,'mero (0-9): $'
MSG1    DB  10,0BAh,'Escolha a opera',87h,'ao:',,,,,,,,,,,,,,,,,0BAh,10,'$'
MSG2    DB  10,0BAh,'O resultado ',82h,': $'
OP1     DB  0BAh,'1 - Adi',87h,'ao',,,,,,,,,,,,,,,,,,,,,,,,,,0BAh,10,'$'
OP2     DB  0BAh,'2 - Subtra',87h,'ao',,,,,,,,,,,,,,,,,,,,,,,0BAh,10,'$'
OP3     DB  0BAh,'3 - Multiplica',87h,'ao',,,,,,,,,,,,,,,,,,,0BAh,10,'$'
OP4     DB  0BAh,'4 - Divisao',,,,,,,,,,,,,,,,,,,,,,,,,0BAh,10,'$'
OP5     DB  0BAh,'5 - AND',,,,,,,,,,,,,,,,,,,,,,,,,,,,,0BAh,10,'$'
OP6     DB  0BAh,'6 - OR',,,,,,,,,,,,,,,,,,,,,,,,,,,,,,0BAh,10,'$'
OP7     DB  0BAh,'7 - XOR',,,,,,,,,,,,,,,,,,,,,,,,,,,,,0BAh,10,'$'
OP8     DB  0BAh,'8 - NOT',,,,,,,,,,,,,,,,,,,,,,,,,,,,,0BAh,'$'
RESTO   DB  10,'O resto e:$'
DIVISAO_ZERO DB 10,10,'NAO E POSSIVEL DIVIDIR POR ZERO$'

.CODE
    MAIN PROC
        MOV AX,@DATA       ;
        MOV DS,AX          ; Inicio ao segmento de data
        LEA DX,LAYOUT1     ;
        CALL PRINT         ;
        LEA DX,DIG1        ;         
        CALL PRINT         ;
        MOV AH,01          ;
        INT 21h            ;
        MOV BH,AL          ;
        AND BH,0Fh         ; Reconhece a entrada do primeiro caracter, converte para numero e armazena em BH

        LEA DX,DIG2        ;              
        CALL PRINT         ;
        MOV AH,01          ;      
        INT 21h            ;
        MOV BL,AL          ;
        AND BL,0Fh         ; Reconhece a entrada do primeiro caracter, converte para numero e armazena em BL

        LEA DX,LAYOUT2     ;
        CALL PRINT         ;
        LEA DX,MSG1        ;         
        CALL PRINT         ;
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
        JE NOT             ; Jumps para as operações (ADD, SUB MUL DIV AND OR XOR NOT)

    ADD:
        ADD BH,BL          ;            
        JMP RESULT         ; Operação ADD 
    SUB:
        SUB BH,BL          ; 
        JS  RESULTN        ;
        JMP RESULT         ; Operação SUB
    MUL:
        JMP RESULT         ; Operação MUL
    DIV:
INICIO_DIVISAO:
CMP BL,00h            ; compara o divisor (segundo dígito) com 0
JE ERRO_DIVISAO       ; se for 0 vai para mensagem de erro

CMP BH,BL             ; comparar os valores de entrada
JB IMPRIMIR_DIVISAO   ; se BH menor que BL, da o JUMP, se não, continua

CALCULO:              ; operação da divisao
SUB BH,BL             ; subtrair o divisor do dividendo
ADD CL, 01h           ; valor do quociente
CMP BH,BL             ; comparando os valores após a subtração
JAE CALCULO           ; se BH for maior que BL, JUMP, se não continua

IMPRIMIR_DIVISAO:     ; resultado da divisao
XOR DX,DX             ; limpando DX
MOV AH,09
LEA DX, MSG2          ; imprimir mensagem de resultado
INT 21h

XOR DX,DX
XOR AX,AX
MOV AH,02       
MOV DL,CL             ; armazena o resultado da divisão no registrador de impressão
OR DL,30h             ; transforma em caractrer
INT 21h               ; imprime resultado da divisão

MOV AH,09       
LEA DX,RESTO          ; Imprime a mensagem de resto
INT 21h  

XOR DX,DX
MOV AH,02       
MOV DL,BH             ; Armazena o resto da impressão no registrador de impressão
OR DL,30h             ; Transforma em caracter
INT 21h               ; Imrpime o resto

JMP FIM

ERRO_DIVISAO:
MOV AH,09         
LEA DX,DIVISAO_ZERO   ; Imprime a mensagem de erro de divisao por zero
INT 21h           

JMP FIM
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
        CALL PRINT         ;
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
        JMP FIM            ;
    
    RESULT:
        LEA DX,LAYOUT3     ;
        CALL PRINT  	   ;
        LEA DX,MSG2        ;         
        CALL PRINT         ; Printa a MSG2   
    
        XOR AX,AX          ; Zera o registrador AX para ser utilizado 
        MOV AL,BH          ; Trás o resultado da operação para AL
   
        MOV BL,10          ;
        DIV BL             ;
        MOV BX,AX          ; Diviede os caracteres em armazena em BH/BL

        MOV DL,BL          ;
        OR  DL,30h         ; 
        MOV AH,02h         ;
        INT 21h            ; Converte para caracter e imprime o primeiro digito
  
        MOV DL,BH          ;
        OR  DL,30h         ;
        MOV AH,2           ;
        INT 21h            ;
        JMP FIM            ; Converte para caracter e imprime o segundo digito
    
    FIM: 
        LEA DX,LAYOUT4     ;
        CALL PRINT         ; Fecha a moldura
        MOV AH,4Ch         ;
        INT 21h            ; Exit do programa
    MAIN ENDP              ;
  
    PRINT PROC             ;
        MOV AH,09h         ;
	    INT 21h            ;
	    RET                ;
    PRINT ENDP             ; Proc para dar print na tela

END MAIN