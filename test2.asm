TITLE CALCULADORA AVANÇADA
.MODEL SMALL

.DATA
    LF EQU 10
    CR EQU 13
    num1 DW ?
    num2 DW ?
    num3 db ?
    nummenu db ?

    msgmenu db  '                CALCULADORA - PROJETO  (LIMITE DE RESULTADO 32.768)',10,13,10,13 ,'| 1 - Soma |',10, 13, '| 2 - Subtracao |',10,13, '| 3 - Divisao |',10,13,'| 4 - Multiplicacao|',10,13,'| 5 - Exponecial |',10,13,'| 6 - X^2 |',10,13,'| 7 - 10^X: |',10,13,'| 8 - Modulo |',10,13,'| 9 - W% de Y |',10,13,'| A - Raiz Quadrada de X |',10,13,'| B - Log X |',10,13,'| C - Conversao|', 10, 13,'Para sair digite ( X )',10,13,'$'
    menu_conv db 10, 13, ' 1 -> Converter de decimal em binario ',10,13,' 2 -> Converter de binario em decimal ',10,13,' 3 -> Converter de binario em hexadecimal',10,13,' 4 -> Converter de hexadecimal em binario ',10,13,' 5 -> Converter de hexadecimal em decimal',10,13,' 6 -> Converter de decimal em hexadecimal ',10,13,'* Para sair digite qualquer outra tecla ...',10,13,'$'
    msgopcao db 'DIGITE A OPCAO: ','$'
    msg_cont db 10,13,'Pressione qualquer tecla para continuar...',10,13,'$'
    msg1 db  10, 13, 'Digite o 1o numero: ','$'
    msg2 db  10, 13, 'Digite o 2o numero: ','$'
    msg3 db  10, 13, 'Subtracao = ','$'
    msg4 db  10, 13, 'Soma = ','$'
    msg5 db  'Multiplicacao = ','$'
    msg6 db  'Divisao = ','$'
    msg7 db  'Numero em decimal = ','$'

    msg9 db  'Exponencial = ','$'
    msg10 db 10, 13, 'X^2 = ','$'
    msg11 db 10, 13, '10^X = ','$'
    msg12 db 10, 13, 'Modulo = ','$'
    msg13 db 'Porcentagem = ','$'
    msg14 db 10, 13, 'Raiz Quadrada = ','$'
    msg15 db 10, 13, ' SEM RAIZ EXATA !','$'

    msg16 db 'Numero em binario = ','$'
    msg17 db 10, 13, 'Digite o numero em binario: ','$'

    msg18 db 10, 13, 'Digite o numero em hexadecimal: ','$'
    msg19 db 'Numero em hexadecimal = ','$'

    pula_linha db CR, LF, '$'
    msglimite db 10, 13, '(LIMITE DE RESULTADO 32.768)','$'

    res DW ?

    Text DB 10,13,"         Calculadora - Projeto",10,13,10,13,10,13,'$'
    TEXT_1 DB 10, 13,'    >>>  Para acessar digite ( 1 )', 10,13,10,13, '    >>>  Para sair digite    ( 0 )','$'

    LOG_1 DB 10,13,' LOG = 0 ','$'
    LOG_10 DB 10,13,' LOG = 1 ','$'
    LOG_100 DB 10,13,' LOG = 2 ','$'
    LOG_1000 DB 10,13,' LOG = 3 ','$'
    LOG_10000 DB 10,13,' LOG = 4 ','$'
    LOG_5 DB 10,13,' LOG = 0,69897 ','$'
    SEM_LOG DB 10,13,' LOG SEM NUMERO EXATO! ','$'

    EXIT DB '  >>>  OBRIGADO POR UTILIZAR A CALCULADORA  !  <<<','$'

.STACK 100H

.CODE
main proc
    mov ax,@data        
    mov ds,ax
    mov es,ax

    CALL INTRO_VIDEO

    lea dx, pula_linha
    mov ah, 09h 
    int 21h

    lea dx, pula_linha
    mov ah, 09h 
    int 21h

    lea dx, msgopcao
    mov ah, 09h
    int 21h 

    MOV AH, 01H
    INT 21H

    lea dx, pula_linha
    mov ah, 09h 
    int 21h

    lea dx, pula_linha
    mov ah, 09h 
    int 21h

    CMP AL,'1'
    JE MENU 

    MOV AH, 4CH
    INT 21H

MENU:
    lea dx, msg_cont
    MOV AH, 09H
    INT 21H 

    MOV AH, 01H
    INT 21H

reset:
    CALL MODO_VIDEO

    lea dx,pula_linha
    mov ah,09H
    int 21H

    lea dx,msgmenu
    int 21H

    lea dx,pula_linha
    int 21H

    lea dx,msgopcao
    INT 21h

    mov ah,01           
    int 21h
              

    cmp al,'X'
    jne first

    CALL SAIR_CALC

first:
    sub al,30h
    cmp al,1
    je opcao1 
    jmp MID1

opcao1: 
    CALL SOMA
    jmp MENU

MENU_REV2:
    jmp MENU

MID1:
    cmp al,2
    je opcao2
    jmp MID2

opcao2:
    CALL SUBTRACAO
    JMP MENU_REV2

MID2:
    cmp al,3
    je opcao3
    jmp MID3

opcao3:
    
    CALL DIVISAO
    jmp MENU_REV2

MENU_REV:
    jmp MENU_REV2

MID3:
    cmp al,4
    je opcao4
    jmp MID5

opcao4:
    Call MULTIPLICACA0
    jmp MENU_REV

MID5:
    cmp al,5
    je opcao5
    jmp MID6   

opcao5:
    CALL EXPONECIAL
    JMP MENU_REV

MID6:
    cmp al,6
    je opcao6
    JMP MID7

opcao6:
    CALL X_exponencial_2
    JMP MENU_REV

MID7:
    cmp al,7
    je opcao7
    JMP MID8

opcao7:
    CALL DEZ_ELEVADO_X
    JMP MENU_REV

MID8:
    cmp al,8
    je opcao8
    JMP MID9

opcao8:
    CALL MODULO
    JMP MENU_REV

MID9:
    cmp al,9
    je opcao9
    JMP MIDA

opcao9:
    CALL PORCENTAGEM
    JMP MENU_REV

MIDA:
    add al, 30h
    cmp al,'A'
    je opcaoA
    JMP MIDB

opcaoA:
    CALL RAIZ
    JMP MENU_REV

MIDB:
    cmp al,'B'
    je opcaoB
    JMP MIDC

opcaoB:
    CALL LOG_X
    JMP MENU_REV

MIDC:
    cmp al,'C'
    je opcaoC
    JMP sair

opcaoC:
    CALL CONVERSAO
    JMP MENU

sair:
    jmp reset

main endp



ENTDEC1 proc
; entrada de decimal -32768 a 32768
    push BX
    push cx
    push DX

    lea dx,pula_linha
    mov ah, 09h
    int 21H
inicio:

    mov ah, 09H 
    LEA DX, msg1
    int 21H

    xor bx, bx

    xor cx, cx

    mov ah, 1
    int 21H

    cmp al, '-'
    je negt
    cmp al, '+'
    je post
    jmp rep2
negt:
    mov cx, 1
post:
    int 21H  
rep2:

    cmp al, '0'
    jnge nodig
    cmp al, '9'
    jnle nodig

    and ax, 000fh
    push ax

    mov ax, 10
    mul bx 
    pop bx
    add bx, ax 

    mov ah, 1
    int 21H
    cmp al, 13 
    jne rep2 

    mov ax, bx

    or cx, cx
    je sai
    neg ax
sai:
    pop DX
    pop cx
    pop bx
    mov num1,AX
    RET
    ret 
nodig:

    mov ah,2
    mov dl, 0Dh
    int 21H
    mov dl, 0Ah
    int 21H
    jmp inicio
ENTDEC1 endp


ENTDEC2 proc 

    push BX
    push cx
    push DX
inicio_2:

    mov ah, 09H 
    LEA DX, msg2
    int 21H

    xor bx, bx

    xor cx, cx

    mov ah, 1
    int 21H

    cmp al, '-'
    je negt_2
    cmp al, '+'
    je post_2
    jmp rep2_2
negt_2:
    mov cx, 1
post_2:
    int 21H  
rep2_2:

    cmp al, '0'
    jnge nodig_2
    cmp al, '9'
    jnle nodig_2

    and ax, 000fh
    push ax

    mov ax, 10
    mul bx ; 
    pop bx
    add bx, ax 

    mov ah, 1
    int 21H
    cmp al, 13 
    jne rep2_2 

    mov ax, bx

    or cx, cx
    je sai_2
    neg ax
sai_2:
    pop DX
    pop cx
    pop bx
    mov num2,AX
    RET
nodig_2:

    mov ah,2
    mov dl, 0Dh
    int 21H
    mov dl, 0Ah
    int 21H
    jmp inicio_2
ENTDEC2 endp


ENTDEC3 proc 
    xor bl,bl
    xor bh,bh
    
WHILE1:
    MOV AH,01H
    INT 21H
    CMP AL, 13
    JE SAIR1
    sub al, 30h
    mov cx,9
multi1: 
    add bh,dh
    loop multi1
    mov bl,al
    add bh,al
    mov dh,bh
    jmp WHILE1
SAIR1:
    mov num3, bh 

ENTDEC3 endp

SAIDEC PROC 

    MOV AX, res

    push ax
    push bx
    push cx
    push dx

    or ax, ax
    jge end_if

    push ax 
    mov dl, '-'
    mov ah, 2
    int 21H 
    pop ax 
    neg ax

end_if:
    xor cx, cx 
    mov bx, 10
rep1:
    xor dx, dx 
    div bx 
    push dx 
    inc cx 
    or ax, ax 
    jne rep1 

    mov ah, 2

imp_loop:
    pop dx 
    or dl, 30h
    int 21H
    loop imp_loop

    pop dx
    pop cx
    pop bx
    pop ax
    ret 
SAIDEC endp

SOMA proc
    CALL ENTDEC1

    CALL ENTDEC2
    
    xor dx, dx
    mov DX, num1
    add DX, num2
    mov res, DX

    MOV AH, 09h
    LEA DX, msg4
    INT 21h

    
    CALL SAIDEC

    
    RET
SOMA endp


SUBTRACAO proc
    CALL ENTDEC1

    CALL ENTDEC2
    
    xor dx, dx
    mov DX, num1
    SUB DX, num2
    mov res, DX

    MOV AH, 09h
    LEA DX, msg3
    INT 21h

    
    CALL SAIDEC
    RET
SUBTRACAO endp


DIVISAO proc
    CALL ENTDEC1

    CALL ENTDEC2

    mov BX, num2
    mov AX, num1
    XOR DX, DX

    IDIV BX

    mov res, AX

    lea dx, pula_linha
    mov ah, 09h
    int 21h
    
    lea dx, msg6
    mov ah, 09H
    int 21h 
    
    CALL SAIDEC
    RET
DIVISAO endp


MULTIPLICACA0 proc
    CALL ENTDEC1

    CALL ENTDEC2

    mov BX, num2
    mov AX, num1

    IMUL BX
    mov res, AX

    lea dx, pula_linha
    mov ah, 09h
    int 21h

    lea dx, msg5
    mov ah, 09H
    int 21h 
    
    CALL SAIDEC
    RET
MULTIPLICACA0 endp

EXPONECIAL proc
    CALL ENTDEC1

    CALL ENTDEC2

    MOV CX, num2
    DEC CX
    MOV AX, num1
    MOV BX, num1

EXPONEN:
    MUL BX
    loop EXPONEN

    MOV res, AX

    lea dx, pula_linha
    mov ah, 09h
    int 21h

    lea dx, msg9
    mov ah, 09H
    int 21h

    CALL SAIDEC
    RET
EXPONECIAL endp


X_exponencial_2 proc
    CALL ENTDEC1

    MOV AX, num1
    MOV BX, num1

    MUL BX
    MOV res, AX

    lea dx, pula_linha
    mov ah, 09h
    int 21h

    lea dx, msg10
    mov ah, 09H
    int 21h

    CALL SAIDEC
    RET
X_exponencial_2 endp


DEZ_ELEVADO_X PROC 

    CALL ENTDEC1

    MOV CX, num1
    MOV AX, 1
    MOV BX, 10

DEZ_ELEVA:
    MUL BX
    loop DEZ_ELEVA

    MOV res, AX

    lea dx, pula_linha
    mov ah, 09h
    int 21h

    lea dx, msg11
    mov ah, 09H
    int 21h

    CALL SAIDEC
    RET
DEZ_ELEVADO_X ENDP


MODULO PROC
    CALL ENTDEC1

    MOV AX, num1

    CMP AX, 0
    JGE POSI

    NEG AX
POSI:
    MOV res, AX

    lea dx, pula_linha
    mov ah, 09h
    int 21h

    lea dx, msg12
    mov ah, 09H
    int 21h

    CALL SAIDEC
    RET
MODULO ENDP


PORCENTAGEM PROC
    CALL ENTDEC1
    CALL ENTDEC2

    MOV AX, num2
    MOV BX, num1
    MUL BX

    MOV CX, 100
    DIV CX

    MOV RES, AX

    lea dx, pula_linha
    mov ah, 09h
    int 21h

    lea dx, msg13
    mov ah, 09H
    int 21h

    CALL SAIDEC
    RET
PORCENTAGEM ENDP


RAIZ PROC
    CALL ENTDEC1
    
    XOR BX, BX
    XOR AX, AX
    XOR CX, CX
    XOR DX, DX 

SQRT: 
    INC CX
    MOV AX, CX 
    MUL CX 
    MOV BX, AX 
    MOV DX, num1 
    CMP BX, DX
    JL SQRT
    JMP SQRT2
    
SQRT2:
    MOV DX, num1 
    CMP BX, DX
    JE SQRT_RESULT
    JMP SQRT_ERROR

SQRT_RESULT:
    MOV res, CX

    lea dx, pula_linha
    mov ah, 09h
    int 21h

    lea dx, msg14
    mov ah, 09H
    int 21h

    CALL SAIDEC
    RET

SQRT_ERROR:
    lea dx, pula_linha
    mov ah, 09h
    int 21h

    lea dx, msg15
    mov ah, 09H
    int 21h

    RET
RAIZ ENDP

LOG_X PROC
    CALL ENTDEC1

    MOV AX, NUM1

LOG_PARTE1:
    CMP AX, 1
    JE log1
    JMP LOG_PARTE2
log1:
    LEA DX, LOG_1
    MOV AH, 09H
    INT 21H
    JMP LOG_SAIR

LOG_PARTE2:
    CMP AX, 10
    JE log10
    JMP LOG_PARTE3
log10:
    LEA DX, LOG_10
    MOV AH, 09H
    INT 21H
    JMP LOG_SAIR

LOG_PARTE3:
    CMP AX, 100
    JE log100
    JMP LOG_PARTE4
log100:
    LEA DX, LOG_100
    MOV AH, 09H
    INT 21H
    JMP LOG_SAIR

LOG_PARTE4:
    CMP AX, 1000
    JE log1000
    JMP LOG_PARTE5
log1000:
    LEA DX, LOG_1000
    MOV AH, 09H
    INT 21H
    JMP LOG_SAIR

LOG_PARTE5:
    CMP AX, 10000
    JE log10000
    JMP LOG_PARTE6
log10000:
    LEA DX, LOG_10000
    MOV AH, 09H
    INT 21H
    JMP LOG_SAIR

LOG_PARTE6:
    CMP AX, 5
    JE log5
    JMP LOGERROR
log5:
    LEA DX, LOG_5
    MOV AH, 09H
    INT 21H
    JMP LOG_SAIR

LOGERROR:
    LEA DX, SEM_LOG
    MOV AH, 09H
    INT 21H

LOG_SAIR:
    RET
LOG_X ENDP



CONVERSAO PROC
    CALL MODO_VIDEO

    LEA DX, menu_conv
    MOV AH, 09h
    INT 21h

    LEA DX, pula_linha
    MOV AH, 09H
    INT 21H

    LEA DX, msgopcao
    MOV AH, 09H
    INT 21H

    mov ah, 01H
    int 21h
    SUB AL, 30H

    LEA DX, pula_linha
    MOV AH, 09H
    INT 21H


CONV_MID1: 
    CMP AL, 1
    JE CONV_OPCAO1
    JMP CONV_MID2

CONV_OPCAO1:
    CALL CONV_DEC_BIN
    RET

CONV_MID2: 
    CMP AL, 2
    JE CONV_OPCAO2
    JMP CONV_MID3

CONV_OPCAO2:
    CALL CONV_BIN_DEC
    RET

CONV_MID3: 
    CMP AL, 3
    JE CONV_OPCAO3
    JMP CONV_MID4

CONV_OPCAO3:
    CALL CONV_BIN_HEX
    RET

CONV_MID4: 
    CMP AL, 4
    JE CONV_OPCAO4
    JMP CONV_MID5

CONV_OPCAO4:
    CALL CONV_HEX_BIN
    RET

CONV_MID5: 
    CMP AL, 5
    JE CONV_OPCAO5
    JMP CONV_MID6

CONV_OPCAO5:
    CALL CONV_HEX_DEC
    RET

CONV_MID6: 
    CMP AL, 6
    JE CONV_OPCAO6
    JMP CONV_SAIR

CONV_OPCAO6:
    CALL CONV_DEC_HEX
    
CONV_SAIR:
    RET
CONVERSAO ENDP 


ENTBIN PROC
    MOV AH, 09h
    LEA DX, msg17
    INT 21H 

    XOR AX,AX
    XOR DX,DX

    MOV CX,16
	MOV AH,1h
	XOR BX,BX
	INT 21h

BIN_TOP: 	
    CMP AL,0Dh
	JE 	BIN_END
	AND AL,0Fh
	SHL BX,1
	OR 	BL,AL
	INT 21h
	LOOP BIN_TOP

BIN_END:
    MOV num1, BX
    RET
ENTBIN ENDP


SAIBIN PROC
    MOV AH, 09h
    LEA DX, msg16
    INT 21h

    XOR AX,AX
    XOR DX,DX

    MOV BX, res
	MOV CX,16
	MOV AH,02h
BIN_1: 
    ROL BX,1 
	JNC BIN_2
	MOV DL,31h
	INT 21h
	JMP	BIN_3
BIN_2: 
    MOV DL,30h
	INT 21h
BIN_3:	
    LOOP BIN_1
	RET
SAIBIN ENDP


ENTHEX PROC
    MOV AH, 09H
    LEA DX, msg18
    INT 21H
    XOR AX,AX
    XOR DX,DX

    XOR BX,BX
    MOV CL,4
    MOV AH,1h
    INT 21h
HEX:
    CMP AL, 0Dh
    JE HEX_FIM
    CMP AL, 39H
    JG HEX_LETRA
    AND AL, 0Fh
    JMP HEX_SHIFT

HEX_LETRA:
    SUB AL, 37H

HEX_SHIFT:
    SHL BX, CL
    OR BL, AL
    INT 21h
    JMP HEX

HEX_FIM:
    MOV num1,BX
    RET
ENTHEX ENDP


SAIHEX PROC 
    MOV AH, 09H
    LEA DX, msg19
    INT 21H
    XOR AX,AX
    XOR DX,DX

    MOV BX, res
    MOV CH, 4
    MOV CL, 4
    MOV AH, 2H 

HEX_1:
    MOV DL, BH 
    SHR DL, CL
    CMP DL, 0AH
    JAE HEX_2

    ADD DL, 30H
    JMP HEX_3

HEX_2:
    ADD DL, 37H

HEX_3:
    INT 21H 
    ROL BX, CL
    DEC CH
    JNZ HEX_1 

    RET
SAIHEX ENDP 



CONV_DEC_BIN proc
    CALL ENTDEC1
    MOV BX, num1
    MOV res, BX

    mov ah, 09H
    LEA DX, pula_linha
    INT 21h

    CALL SAIBIN

    RET 
CONV_DEC_BIN ENDP 



CONV_BIN_DEC PROC
    CALL ENTBIN

    MOV BX, num1
    MOV res, BX

    mov ah, 09H
    LEA DX, pula_linha
    INT 21h

    MOV ah, 09H
    LEA DX, msg7
    INT 21h

    CALL SAIDEC

    RET
CONV_BIN_DEC ENDP



CONV_BIN_HEX PROC
    CALL ENTBIN

    MOV BX, num1
    MOV res, BX

    MOV ah, 09H
    LEA DX, pula_linha
    INT 21h

    CALL SAIHEX

    RET 
CONV_BIN_HEX ENDP



CONV_HEX_BIN PROC
    CALL ENTHEX

    MOV BX, num1
    MOV res, BX

    MOV ah, 09H
    LEA DX, pula_linha
    INT 21h

    CALL SAIBIN

    RET
CONV_HEX_BIN ENDP



CONV_HEX_DEC PROC
    CALL ENTHEX

    MOV BX, num1
    MOV res, BX

    MOV ah, 09H
    LEA DX, pula_linha
    INT 21h

    MOV ah, 09H
    LEA DX, msg7
    INT 21h

    CALL SAIDEC

    RET
CONV_HEX_DEC ENDP



CONV_DEC_HEX PROC
    CALL ENTDEC1

    MOV BX, num1
    MOV res, BX

    MOV ah, 09H
    LEA DX, pula_linha
    INT 21h

    CALL SAIHEX

    RET
CONV_DEC_HEX ENDP


MODO_VIDEO PROC 
    MOV AH,0
    MOV AL,2
    INT 10h   

    MOV AH, 06H
    XOR AL, AL
    XOR CX, CX
    MOV DX, 0FFFFH
    MOV BH, 03FH
    INT 10H 

    RET
MODO_VIDEO ENDP

INTRO_VIDEO PROC
    MOV AH,0 
    MOV AL,0
    INT 10H

    MOV AH, 06H
    XOR AL, AL
    XOR CX, CX
    MOV DX, 0257H
    MOV BH, 089H
    INT 10H 

    LEA DX, Text 
    MOV AH, 09H 
    INT 21H 

    MOV AH, 06H
    XOR AL, AL
    mov CX, 0300H
    MOV DX, 1027H
    MOV BH, 0FH
    INT 10H 

    LEA DX, TEXT_1
    MOV AH, 09H
    INT 21H

    RET
INTRO_VIDEO ENDP


SAIR_CALC PROC
    LEA DX, pula_linha
    MOV AH, 09H
    INT 21H

    LEA DX, pula_linha
    MOV AH, 09H
    INT 21H

    LEA DX, EXIT
    MOV AH, 09H
    INT 21H

    LEA DX, pula_linha
    MOV AH, 09H
    INT 21H

    LEA DX, pula_linha
    MOV AH, 09H
    INT 21H

    MOV AH, 4CH
    INT 21H

    RET
SAIR_CALC ENDP

END MAIN