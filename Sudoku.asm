TITLE SUDOKU Guilherme Bernardini Roelli (22899140) & Vitor Yuzo Takei (22023740)
.MODEL SMALL
.STACK 100h
.DATA
LIN  EQU  9
COL  EQU  9
    MATRIZ DB LIN DUP(COL DUP(?))
MOLDURA DB 201,2 DUP(11 DUP (205),203),11 DUP (205),187,'$'
LINHA DB 10,13,3 DUP(186,32,2 DUP (196),197, 3 DUP (196), 197, 2 DUP (196),32),186, '$'
 
.CODE
    PRINT MACRO MENSAGEM
        LEA DX,MENSAGEM
        MOV AH,09h         
	    INT 21h 
    ENDM

    LFCR MACRO 
        MOV AH,02
        MOV DL,10
        INT 21h
        MOV DL,13
        INT 21h  
    ENDM
    
    BARRADUPLA MACRO
        MOV DL,186
        INT 21h
    ENDM

    SPACE MACRO
        MOV DL,32
        INT 21h
    ENDM
    PRINTMATRIZ MACRO
        MOV DL, MATRIZ[BX][SI]
        OR DL,30h
        INT 21h
        INC SI
    ENDM
    MAIN PROC
        MOV AX,@DATA;
        MOV DS,AX   ; Inicia o segmento de dados
        CALL FACIL
        CALL MATRIZ_OUT
    FIM:
        MOV AH,4CH
        INT 21h
    MAIN ENDP

    MATRIZ_OUT PROC
        XOR BX,BX
        XOR SI,SI
        PRINT MOLDURA
        ADD CX, 3
        PUSH CX
            OUT3:
                MOV CH, 3
                LFCR
                BARRADUPLA
                OUT2:
                    MOV CL,2
                        OUT1:
                            SPACE
                            PRINTMATRIZ
                            SPACE
                            MOV DL,179
                            INT 21h
                        DEC CL                   
                        JNZ OUT1
                    SPACE
                    PRINTMATRIZ
                    SPACE
                    BARRADUPLA
                DEC CH                   
                JNZ OUT2
                POP CX
                PRINT LINHA
                XOR SI,SI
                ADD BX,COL
            DEC CL
            PUSH CX                   
            JNZ OUT3
            POP CX
            ADD CX, 3
            PUSH CX
            OUT4:
                MOV CH, 3
                LFCR
                BARRADUPLA
                OUT5:
                    MOV CL,2
                        OUT6:
                            SPACE
                            PRINTMATRIZ
                            SPACE
                            MOV DL,179
                            INT 21h
                        DEC CL                   
                        JNZ OUT6
                    SPACE
                    PRINTMATRIZ
                    SPACE
                    BARRADUPLA
                DEC CH                   
                JNZ OUT5
                POP CX
                PRINT LINHA
                XOR SI,SI
                ADD BX,COL
            DEC CL
            PUSH CX                   
            JNZ OUT4
 
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