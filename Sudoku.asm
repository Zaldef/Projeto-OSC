TITLE ENTRADA E E SAIDA DE MATRIZ, INVERSAO DE LINHAS POR COLUNAS
.MODEL SMALL
.STACK 100h
.DATA
LIN  EQU  9
COL  EQU  9
    MATRIZ DB LIN DUP(COL DUP(?))
MOLDURA DB 0C9H, 8 DUP (3 DUP (0CDH), 0CBH), 3 DUP (0CDH), 0BBH , 10,'$'
LINHA  DB 0BAH, 20H, '$'
LINHA2 DB 0CCH, 8 DUP (3 DUP (0CDH), 0CEH), 3 DUP (0CDH), 0B9H , 10,'$'
 
.CODE

    PRINT MACRO MENSAGEM
        LEA DX,MENSAGEM
        MOV AH,09h         
	    INT 21h 
    ENDM
    MAIN PROC
        MOV AX,@DATA;
        MOV DS,AX   ; Inicia o segmento de dados
        CALL FACIL
       CALL MATRIZ_OUT
    FIM:
        MOV AH,4CH
        INT 21H
    MAIN ENDP

    MATRIZ_OUT PROC ; Proc para leitura e impressao de matriz
        XOR BX,BX
        XOR SI,SI
        
        PRINT MOLDURA

        MOV CL, LIN             ; Usado como contador de linhas    

        OUT1:                           ;   
            MOV CH, COL                 ; Usado como contador de colunas  
            OUT2:                       ; 
                PRINT LINHA
                MOV AH, 02h  
                MOV DL, MATRIZ[BX][SI]  ; Copia a informacao da matriz para DL(entrada padrao para função 02h)  
                OR DL, 30h              ; Converte para caracter
                INT 21h                 ;   
                MOV DL, 20H
                INT 21H             
                INC SI                  ; Atualiza o endereço da matriz, deslocando para a proxima coluna  
                DEC CH                  ;   
            JNZ OUT2                ; LOOP1
            MOV DL, 0BAH
            INT 21H
            MOV DL, 10              ; 
            INT 21h                 ; LINE FEED
            PRINT LINHA2  
            ADD BX, LIN             ; Desloca uma linha na matriz  
            XOR SI,SI               ; Reseta as colunas
            DEC CL                  ;   
        JNZ OUT1                ; LOOP2 (nao utilizado LOOP, pois estamos utilizando CX para outro "loop" temos um loop1 dentro do outro loop2)
        RET
    MATRIZ_OUT ENDP

    FACIL PROC
        XOR BX,BX
        XOR SI,SI
            MOV SI,2
            MOV MATRIZ [BX][SI],2
            INC SI
            MOV MATRIZ [BX][SI],5
            ADD SI, 3
            MOV MATRIZ [BX][SI],6
        ADD BX, LIN
        XOR SI,SI
            ADD SI, 4
            MOV MATRIZ [BX][SI],8
            INC SI
            MOV MATRIZ [BX][SI],4
        ADD BX, LIN
        XOR SI,SI
            MOV MATRIZ [BX][SI],8
            ADD SI, 2
            MOV MATRIZ [BX][SI],4
            ADD SI,2
            MOV MATRIZ [BX][SI],2
            INC SI
            MOV MATRIZ [BX][SI],3
            INC SI
            MOV MATRIZ [BX][SI],9
            ADD SI, 2
            MOV MATRIZ [BX][SI],5  
        ADD BX, LIN
        XOR SI,SI
            INC SI
            MOV MATRIZ [BX][SI],9
            INC SI
            MOV MATRIZ [BX][SI],1
            INC SI
            MOV MATRIZ [BX][SI],8
            ADD SI,2
            MOV MATRIZ [BX][SI],5
            ADD SI,3
            MOV MATRIZ [BX][SI],7
        ADD BX, LIN
        XOR SI,SI    
            INC SI
            MOV MATRIZ [BX][SI],4
            INC SI
            MOV MATRIZ [BX][SI],6
            ADD SI, 2
            MOV MATRIZ [BX][SI],7
            ADD SI,2
            MOV MATRIZ [BX][SI],8
            INC SI
            MOV MATRIZ [BX][SI],3
        ADD BX, LIN
        XOR SI,SI
            MOV MATRIZ [BX][SI],2
            ADD SI,3
            MOV MATRIZ [BX][SI],4
            ADD SI, 2
            MOV MATRIZ [BX][SI],1
            INC SI
            MOV MATRIZ [BX][SI],5
            INC SI
            MOV MATRIZ [BX][SI],6
        ADD BX, LIN
        XOR SI,SI
            MOV MATRIZ [BX][SI],9
            ADD SI, 2
            MOV MATRIZ [BX][SI],8
            INC SI
            MOV MATRIZ [BX][SI],7
            INC SI
            MOV MATRIZ [BX][SI],1
            ADD SI, 2
            MOV MATRIZ [BX][SI],3
            ADD SI,2
            MOV MATRIZ [BX][SI],4
        ADD BX, LIN
        XOR SI,SI
            ADD SI,3
            MOV MATRIZ [BX][SI],3
            INC SI
            MOV MATRIZ [BX][SI],4
        ADD BX, LIN
        XOR SI,SI
            ADD SI,2
            MOV MATRIZ [BX][SI],3
            ADD SI,3
            MOV MATRIZ [BX][SI],2
            INC SI
            MOV MATRIZ [BX][SI],1 
        RET  
    FACIL ENDP

    MEDIO PROC   
    MEDIO ENDP

    DIFICIL PROC
    DIFICIL ENDP
END MAIN