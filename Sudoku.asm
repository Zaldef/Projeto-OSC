TITLE SUDOKU Guilherme Bernardini Roelli (22899140)
.MODEL SMALL
.STACK 100h
.DATA
LIN         EQU  9
COL         EQU  9
MATRIZ      DB LIN DUP(COL DUP(?))

MATRIZ2      DB LIN DUP(COL DUP(?))

MOLDURA     DB 10,13,201,2 DUP(11 DUP (205),203),11 DUP (205),187,'$'
LINHA1      DB 10,13,3 DUP(186,32,2 DUP (196),197, 3 DUP (196), 197, 2 DUP (196),32),186, '$'
LINHA2      DB 10,13,204,2 DUP(11 DUP (205),206),11 DUP (205),185,'$'
LINHA3      DB 10,13,200,2 DUP(11 DUP (205),202),11 DUP (205),188,10,13,'$'
TELA1       DB 10,201,78 DUP(205),187,'$'
TELA2       DB 204,38 DUP(205),203,39 DUP(205),185,'$'
TELA3       DB 204,38 DUP(205),202,39 DUP(205),185,'$'
TELA4       DB 204,78 DUP(205),185,'$'
TELA5       DB 200,78 DUP(205),188,'$'
TELA6       DB 186,78 DUP(32),186,'$'
MSG1        DB 186,29 DUP(32),'BEM VINDO AO SUDOKU',30 DUP(32),186,'$'
MSG2        DB 186,10 DUP(32),'O QUE ',144,' O SUDOKU?',11 DUP(32),186,16 DUP(32),'REGRAS',17 DUP(32),186,'$'
MSG3        DB 186,38 DUP(32),186,39 DUP(32),186,'$'
MSG4        DB 186,' Sudoku ',130,' um jogo baseado na coloca',135,'ao',186,' Nao podem haver n',163,'meros repetidos nas ',186,'$'
MSG5        DB 186,'l',162,'gica de n',163,'meros. O objetivo do jogo ',186,'linhas horizontais e verticais, assim  ',186,'$'
MSG6        DB 186,130,' a coloca',135,'ao de n',163,'meros de 1 a 9 em  ',186,'como nos quadrantes delimitados por    ',186,'$'
MSG7        DB 186,'cada uma das c',130,'lulas vazias numa grade',186,'linhas duplas.',25 DUP(32),186,'$'
MSG8        DB 186,'de 9x9, constitu',214,'da por 3x3 subgrades ',186,' Voc',136,' ganha quando todos os quadrados  ',186,'$'
MSG9        DB 186,'chamadas quadrantes.',18 DUP(32),186,'estiverem preenchidos com n',163,'meros de   ',186,'$'
MSG10       DB 186,38 DUP(32),186,'1 a 9 e nao tiver nenhuma repeti',135,'ao    ',186,'$'
MSG11       DB 186,38 DUP(32),186,'tanto em linhas, colunas e quadrantes.',32,186,'$'
COMOJOGAR1  DB 186,33 DUP(32),'COMO JOGAR:',34 DUP(32),186,'$'
COMOJOGAR2  DB 186,' Primeiro se desloque ate a casa que pretende preencher atraves de WASD:      ',186,'$'
COMOJOGAR3  DB 186,'A -desloca uma coluna para a esquerda, D- desloca uma coluna para direita     ',186,'$'
COMOJOGAR4  DB 186,'W -desloca uma linha para cima, S- desloca uma linha para baixo.Comeca em 1x1 ',186,'$'
COMOJOGAR5  DB 186,'Depois aperte ENTER para entrar com o n',163,'mero que deve ser de 1-9              ',186,'$'
COMOJOGAR6  DB 186,'apos isso, repita o processo at',130,' completar o sudoku. Uma mensagem sera exibida',186,'$'
COMOJOGAR7  DB 186,'quando ele for completado corretamente, indicando que voc',136,' ganhou!            ',186,'$'
DIFICULDADE DB 186,'QUAL DIFICULADE VOCE QUER? 1-FACIL 2-MEDIO 3-DIFICIL 4-TESTE                  ',186,'$'
ENTRADA1    DB 'SE DESLOQUE ATE A CASA (VC ESTA EM 1X1): $'
ENTRADA2    DB 'DIGITE O NUMERO: $'
ERRO1       DB 10,13,'ALGO DE ERRADO ACONTECEU, TENTE NOVAMENTE :) $'
ERRO2       DB 10,13,'ALGO DE ERRADO ACONTECEU, ESCOLHA NOVAMENTE A DIFICULDADE :) $'
CERTO       DB 10,13,'O NUMERO ESTA CERTO, PARABENS $'
ERRADO      DB 10,13,'O NUMERO ESTA ERRADO, TENTE NOVAMENTE $'


 
.CODE
    PRINT MACRO MENSAGEM
        LEA DX,MENSAGEM
        MOV AH,09h
	    INT 21h
    ENDM
    LFCR MACRO; PULA LINHA
        MOV AH,02
        MOV DL,10
        INT 21h
        MOV DL,13
        INT 21h  
    ENDM 
    BARRADUPLA MACRO; IMPRIMIR "║"
        MOV DL,186
        INT 21h
    ENDM
    BARRASIMPLES MACRO; IMPRIMIR "│"
        MOV DL,179
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
        CALL TELAINICIAL
        LOOP_MAIN:
            CALL SAIDA
            CALL ENTRADA
            CALL CONFERENCIA
            CMP DX,0
            JE LOOP_MAIN
            CALL TELAFINAL
        FIM:
            MOV AH,4CH
            INT 21h
    MAIN ENDP

    SAIDA PROC; IMPRESSAO DA MATRIZ NA TELA
        XOR BX,BX   ; ZERANDO REGISTRADORES PARA SEREM UTILIZADOS
        XOR SI,SI   ; ZERANDO REGISTRADORES PARA SEREM UTILIZADOS
        PRINT MOLDURA
        MOV CX,3    ; QUANTIDADE DE QUADRANTES VERTICAIS
        PUSH CX
        QUADRANTE_VERTICAL:
        XOR CL,CL   ; ZERANDO REGISTRADORES PARA SEREM UTILIZADOS
        ADD CH,3    ; QUANTIDADE DE LINHAS INTERNAS DO QUADRANTE
        ADD CL,3    ; QUANTIDADE DE COLUNAS X3 (PRIMEIRA LINHA1 DO QUADRANTE)
        LFCR
        BARRADUPLA
        JMP QUADRANTE_COLUNA
        QUADRANTE_LINHA:
            ADD CL, 3   ; QUANTIDADE DE COLUNAS X3 (SEGUNDA E TERCEIRA LINHA1 DO QUADRANTE)
            ADD BX,COL  ; PULA PARA PROXIMA LINHA1 DA MATRIZ
            XOR SI,SI   ; VOLTA PARA PRIMEIRA COLUNA
            PRINT LINHA1
            LFCR
            BARRADUPLA   
                QUADRANTE_COLUNA:
                    SPACE
                    PRINTMATRIZ
                    SPACE
                    BARRASIMPLES
                    SPACE
                    PRINTMATRIZ
                    SPACE
                    BARRASIMPLES
                    SPACE
                    PRINTMATRIZ
                    SPACE
                    BARRADUPLA
            DEC CL               ;
            JNZ QUADRANTE_COLUNA  ; LOOP PARA COLUNAS DOS QUADRANTES         
        DEC CH      ;
        JNZ QUADRANTE_LINHA    ;LOOP PARA LINHAS DOS QUADRANTES
        ADD BX,COL  ; PULA PARA PROXIMA LINHA1 DA MATRIZ
        XOR SI,SI   ; VOLTA PARA PRIMEIRA COLUNA
        POP CX      ; RESGATA A QUANTIDADE DE QUADRANTES VERTICAIS A SEREM IMPRESSOS
        CMP CX, 1   ;
            JNE OUT1    ; 
            PRINT LINHA3; LINHA EXTERNA(MOLDURA)
            JMP OUT2    ;
        OUT1:       ; 
            PRINT LINHA2; LINHAS INTERNAS(MOLDURA)
        OUT2:
        DEC CX  ;
        PUSH CX ; DECREMENTA A QUANTIDADE DE QUADRANTES VERTICAIS E GUARDA NA MEMORIA
        JNZ RESTART ; ENQUANTO NAO FOR ZERO RESTARTA O PROCESSO DE IMPRESSAO DE QUADRANTES VERTICAIS
        POP CX  ; DESEMPILHA O 0 DE CX PARA O RET NAO BUGAR
        RET
        RESTART:
        JMP QUADRANTE_VERTICAL
    SAIDA ENDP
    TELAINICIAL PROC; PROC com as informacoes sobre o sudoku e a escolha de dificuldade
        PRINT TELA1
        PRINT MSG1
        PRINT TELA2
        PRINT MSG2
        PRINT MSG3
        PRINT MSG4
        PRINT MSG5
        PRINT MSG6
        PRINT MSG7
        PRINT MSG8
        PRINT MSG9
        PRINT MSG10
        PRINT MSG11
        PRINT TELA3
        PRINT COMOJOGAR1
        PRINT COMOJOGAR2
        PRINT COMOJOGAR3
        PRINT COMOJOGAR4
        PRINT COMOJOGAR5
        PRINT COMOJOGAR6
        PRINT COMOJOGAR7
        PRINT TELA4
        PRINT DIFICULDADE
        PRINT TELA5
        DIF:    ; LOGICA PARA ESCOLHA DE DIFICULDADE
        MOV AH,08
        INT 21H
        CMP AL,31H
        JE DIF_FAC
        CMP AL,32H
        JE DIF_MED
        CMP AL,33H
        JE DIF_DIF
        JMP DIF_ERRO
        DIF_FAC:
        CALL FACIL
        JMP DIF_EXIT
        DIF_MED:
        CALL MEDIO
        JMP DIF_EXIT  
        DIF_DIF:
        CALL DIFICIL
        DIF_EXIT:
        RET

        DIF_ERRO:
        PRINT ERRO2
        JMP DIF
    TELAINICIAL ENDP
    ENTRADA PROC; ENTRADA DE NUMEROS DENTRO DA MATRIZ(SUDOKU
        XOR BX,BX   ;
        XOR SI,SI   ; ZERA REGISTRADORES PARA SEREM UTILIZADOS

        LFCR
        PRINT ENTRADA1  ; 'SE DESLOQUE ATE A CASA (VC ESTA EM 1X1): $'

        IN_1:   ; LOGICA PARA DESLOCAMENTO NA MATRIZ ATRAVES DE WASD
            MOV AH,01   ;  
            INT 21h     ;   
            CMP AL,13   ; 
            JE IN_2     ; SE FOR "ENTER" PULA PARA IN_2
            CMP AL,'w'  ; 
            JE IN_UP    ; SE FOR "W" PULA PARA IN_UP
            CMP AL,'a'  ;
            JE IN_LEFT  ; SE FOR "A" PULA PARA IN_LEFT
            CMP AL,'s'  ;
            JE IN_DOWN  ; SE FOR "S" PULA PARA IN_DOWM
            CMP AL,'d'  ;
            JE IN_RIGHT ; SE FOR "D" PULA PARA IN_RIGTH
            JMP IN_ERRO ; SE TIVER ALGUMA ENTRADA FORA ISSO PULA PARA IN_ERRO

        IN_UP:  ; desloca uma linha para baixo
            SUB BX,COL
            JMP IN_1
        IN_LEFT:    ; desloca uma linha para cima
            DEC SI
            JMP IN_1
        IN_DOWN:    ; desloca uma coluna para a esquerda
            ADD BX,COL
            JMP IN_1
        IN_RIGHT:   ; desloca uma coluna para direita
            INC SI
            JMP IN_1

        IN_2:
            CMP BX, 72  ;
            JG IN_ERRO  ;
            CMP BX, 0   ;
            JL IN_ERRO  ;
            CMP SI, 8   ;
            JG IN_ERRO  ;
            CMP SI, 0   ; LOGICA PARA NÃO ACEITAR POSICOES FORA DA MATRIZ 
            JL IN_ERRO  ; 

        PRINT ENTRADA2  ; 'DIGITE O NUMERO: $'
        MOV AH,01
        INT 21h     
        CMP AL, '1' ;
        JL IN_ERRO  ;
        CMP AL, '9' ;
        JG IN_ERRO  ;
        AND AL,0Fh  ; LOGICA PARA PERMITIR ENTRADA DE NUMEROS DE 1-9

        CMP AL, MATRIZ2[BX][SI] ;
        JE IN_CERTO             ;
        PRINT ERRADO            ;
        JMP FIM_E               ;
        IN_CERTO:               ; 
        MOV MATRIZ [BX][SI],AL  ; 
        PRINT CERTO             ; PEGA O NUMERO DIGITADO PELO USUARIO, COMPARA COM O CARTAO RESPOSTA(MATRIZ2)
        JMP FIM_E               ; SE FOR IGUAL ELE MANDA PARA MATRIZ(SUDOKU), SE Ñ EXIBE UMA MENSAGEM DE NUMERO ERRADO

        IN_ERRO:            ;
            PRINT ERRO1 ; MENSAGEM DE ERRO
        FIM_E: 
     RET 
    ENTRADA ENDP
    CONFERENCIA PROC; ESSE PROC VAI ANALISAR SE O JOGO ESTA COMPLETO E CORRETO
     ; PENSEI EM VARIAS MANEIRAS, SEJA POR SOMA DE ITENS INDIVIDUIAS TOTAL, CONFERENCIA DE LINHA/COLUNA/QUADRANTE 
     ; COMPARAR A MATRIZ(SUDOKU) COM A MATRIZ2(CARTAO RESPOSTA), O MAIS SIMPLES QUE EU PENSEI FOI:
     ; PERCORRER TODA A MATRIZ(SUDOKU) SE ELE NAO ENCONTRAR NENHUM ZERO QUER DIZER QUE VC GANHOU, 
     ; POIS A LOGICA DE ENTRADA SÓ PERMITE A ENTRADA DE NUMEROS CORRETOS

        XOR BX,BX
        XOR DX,DX
        MOV CH,LIN
        CONF_2:
            XOR SI,SI
            MOV CL,COL
                CONF_1:
                    CMP MATRIZ[BX][SI],0
                    JE CONF_FIM
                    INC SI
                    DEC CL
                JNE CONF_1
            ADD BX, COL
            DEC CH
        JNE CONF_2
        INC DX
        CONF_FIM:
     RET
    CONFERENCIA ENDP
    TELAFINAL PROC
        
    TELAFINAL ENDP
    FACIL PROC; DIFICULDADE (PREENCHIMENTO DA MATRIZ(SUDOKU))
        XOR BX,BX   ; SUDOKU INCOMPLETO RESPOSTA
        XOR SI,SI
            MOV SI,2
            MOV MATRIZ [BX][SI],2
            INC SI
            MOV MATRIZ [BX][SI],5
            ADD SI, 3
            MOV MATRIZ [BX][SI],6
        ADD BX, COL
        XOR SI,SI
            ADD SI, 4
            MOV MATRIZ [BX][SI],8
            INC SI
            MOV MATRIZ [BX][SI],4
        ADD BX, COL
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
        ADD BX, COL
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
        ADD BX, COL
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
        ADD BX, COL
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
        ADD BX, COL
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
        ADD BX, COL
        XOR SI,SI
            ADD SI,3
            MOV MATRIZ [BX][SI],3
            INC SI
            MOV MATRIZ [BX][SI],4
        ADD BX, COL
        XOR SI,SI
            ADD SI,2
            MOV MATRIZ [BX][SI],3
            ADD SI,3
            MOV MATRIZ [BX][SI],2
            INC SI
            MOV MATRIZ [BX][SI],1

            ; SUDOKU COMPLETO (RESPOSTA)
            XOR BX,BX
            XOR SI,SI
                MOV MATRIZ2 [BX][SI],1
                INC SI
                MOV MATRIZ2 [BX][SI],3
                INC SI
                MOV MATRIZ2 [BX][SI],2
                INC SI
                MOV MATRIZ2 [BX][SI],5
                INC SI
                MOV MATRIZ2 [BX][SI],9
                INC SI
                MOV MATRIZ2 [BX][SI],7
                INC SI
                MOV MATRIZ2 [BX][SI],6
                INC SI
                MOV MATRIZ2 [BX][SI],4
                INC SI
                MOV MATRIZ2 [BX][SI],8
                INC SI
            ADD BX, COL
            XOR SI,SI
                MOV MATRIZ2 [BX][SI],7
                INC SI
                MOV MATRIZ2 [BX][SI],5
                INC SI
                MOV MATRIZ2 [BX][SI],9
                INC SI
                MOV MATRIZ2 [BX][SI],6
                INC SI
                MOV MATRIZ2 [BX][SI],8
                INC SI
                MOV MATRIZ2 [BX][SI],4
                INC SI
                MOV MATRIZ2 [BX][SI],2
                INC SI
                MOV MATRIZ2 [BX][SI],1
                INC SI
                MOV MATRIZ2 [BX][SI],3
                INC SI
            ADD BX, COL
            XOR SI,SI
                MOV MATRIZ2 [BX][SI],8
                INC SI
                MOV MATRIZ2 [BX][SI],6
                INC SI
                MOV MATRIZ2 [BX][SI],4
                INC SI
                MOV MATRIZ2 [BX][SI],1
                INC SI
                MOV MATRIZ2 [BX][SI],2
                INC SI
                MOV MATRIZ2 [BX][SI],3
                INC SI
                MOV MATRIZ2 [BX][SI],9
                INC SI
                MOV MATRIZ2 [BX][SI],7
                INC SI
                MOV MATRIZ2 [BX][SI],5
                INC SI
            ADD BX, COL
            XOR SI,SI
                MOV MATRIZ2 [BX][SI],3
                INC SI
                MOV MATRIZ2 [BX][SI],9
                INC SI
                MOV MATRIZ2 [BX][SI],1
                INC SI
                MOV MATRIZ2 [BX][SI],8
                INC SI
                MOV MATRIZ2 [BX][SI],6
                INC SI
                MOV MATRIZ2 [BX][SI],5
                INC SI
                MOV MATRIZ2 [BX][SI],4
                INC SI
                MOV MATRIZ2 [BX][SI],2
                INC SI
                MOV MATRIZ2 [BX][SI],7
                INC SI
            ADD BX, COL
            XOR SI,SI
                MOV MATRIZ2 [BX][SI],5
                INC SI
                MOV MATRIZ2 [BX][SI],4
                INC SI
                MOV MATRIZ2 [BX][SI],6
                INC SI
                MOV MATRIZ2 [BX][SI],2
                INC SI
                MOV MATRIZ2 [BX][SI],7
                INC SI
                MOV MATRIZ2 [BX][SI],9
                INC SI
                MOV MATRIZ2 [BX][SI],8
                INC SI
                MOV MATRIZ2 [BX][SI],3
                INC SI
                MOV MATRIZ2 [BX][SI],1
                INC SI
            ADD BX, COL
            XOR SI,SI
                MOV MATRIZ2 [BX][SI],2
                INC SI
                MOV MATRIZ2 [BX][SI],8
                INC SI
                MOV MATRIZ2 [BX][SI],7
                INC SI
                MOV MATRIZ2 [BX][SI],4
                INC SI
                MOV MATRIZ2 [BX][SI],3
                INC SI
                MOV MATRIZ2 [BX][SI],1
                INC SI
                MOV MATRIZ2 [BX][SI],5
                INC SI
                MOV MATRIZ2 [BX][SI],6
                INC SI
                MOV MATRIZ2 [BX][SI],9
                INC SI
            ADD BX, COL
            XOR SI,SI
                MOV MATRIZ2 [BX][SI],9
                INC SI
                MOV MATRIZ2 [BX][SI],2
                INC SI
                MOV MATRIZ2 [BX][SI],8
                INC SI
                MOV MATRIZ2 [BX][SI],7
                INC SI
                MOV MATRIZ2 [BX][SI],1
                INC SI
                MOV MATRIZ2 [BX][SI],6
                INC SI
                MOV MATRIZ2 [BX][SI],3
                INC SI
                MOV MATRIZ2 [BX][SI],5
                INC SI
                MOV MATRIZ2 [BX][SI],4
                INC SI
            ADD BX, COL
            XOR SI,SI
                MOV MATRIZ2 [BX][SI],6
                INC SI
                MOV MATRIZ2 [BX][SI],1
                INC SI
                MOV MATRIZ2 [BX][SI],5
                INC SI
                MOV MATRIZ2 [BX][SI],3
                INC SI
                MOV MATRIZ2 [BX][SI],4
                INC SI
                MOV MATRIZ2 [BX][SI],8
                INC SI
                MOV MATRIZ2 [BX][SI],7
                INC SI
                MOV MATRIZ2 [BX][SI],9
                INC SI
                MOV MATRIZ2 [BX][SI],2
                INC SI
            ADD BX, COL
            XOR SI,SI
                MOV MATRIZ2 [BX][SI],4
                INC SI
                MOV MATRIZ2 [BX][SI],7
                INC SI
                MOV MATRIZ2 [BX][SI],3
                INC SI
                MOV MATRIZ2 [BX][SI],9
                INC SI
                MOV MATRIZ2 [BX][SI],5
                INC SI
                MOV MATRIZ2 [BX][SI],2
                INC SI
                MOV MATRIZ2 [BX][SI],1
                INC SI
                MOV MATRIZ2 [BX][SI],8
                INC SI
                MOV MATRIZ2 [BX][SI],6
                INC SI
        RET  
    FACIL ENDP
    MEDIO PROC; DIFICULDADE (PREENCHIMENTO DA MATRIZ(SUDOKU))
        XOR BX,BX
        XOR SI,SI
            INC SI
            MOV MATRIZ [BX][SI],5
            ADD SI,3
            MOV MATRIZ [BX][SI],8
            ADD SI,3
            MOV MATRIZ [BX][SI],6
        ADD BX,COL
        XOR SI,SI
            ADD SI,2
            MOV MATRIZ [BX][SI],1
            INC SI
            MOV MATRIZ [BX][SI],6
            INC SI
            MOV MATRIZ [BX][SI],7
            ADD SI,3
            MOV MATRIZ [BX][SI],9
        ADD BX,COL
        XOR SI,SI
            INC SI
            MOV MATRIZ [BX][SI],4
            ADD SI,6
            MOV MATRIZ [BX][SI],7
        ADD BX,COL
        XOR SI,SI
            MOV MATRIZ [BX][SI],9
            ADD SI,4
            MOV MATRIZ [BX][SI],2
            ADD SI,3
            MOV MATRIZ [BX][SI],8
        ADD BX,COL
        XOR SI,SI
        ADD BX,COL
            INC SI
            MOV MATRIZ [BX][SI],1
            ADD SI,3
            MOV MATRIZ [BX][SI],6
            ADD SI,2
            MOV MATRIZ [BX][SI],5
        ADD BX,COL
        XOR SI,SI
            INC SI
            MOV MATRIZ [BX][SI],2
            ADD SI,3
            MOV MATRIZ [BX][SI],1
            ADD SI,2
            MOV MATRIZ [BX][SI],3
        ADD BX,COL
        XOR SI,SI
            ADD SI,3
            MOV MATRIZ [BX][SI],4
            ADD SI,2
            MOV MATRIZ [BX][SI],7
        ADD BX,COL
        XOR SI,SI
            ADD SI,2
            MOV MATRIZ [BX][SI],4
            ADD SI,3
            MOV MATRIZ [BX][SI],2
            INC SI
            MOV MATRIZ [BX][SI],8
            ADD BX, COL
            XOR SI,SI

        ; SUDOKU COMPLETO(resposta)
            XOR BX,BX
            XOR SI,SI
                MOV MATRIZ2 [BX][SI],7
                INC SI
                MOV MATRIZ2 [BX][SI],5
                INC SI
                MOV MATRIZ2 [BX][SI],9
                INC SI
                MOV MATRIZ2 [BX][SI],2
                INC SI
                MOV MATRIZ2 [BX][SI],8
                INC SI
                MOV MATRIZ2 [BX][SI],1
                INC SI
                MOV MATRIZ2 [BX][SI],4
                INC SI
                MOV MATRIZ2 [BX][SI],6
                INC SI
                MOV MATRIZ2 [BX][SI],3
                INC SI
            ADD BX,COL
            XOR SI,SI
                MOV MATRIZ2 [BX][SI],3
                INC SI
                MOV MATRIZ2 [BX][SI],8
                INC SI
                MOV MATRIZ2 [BX][SI],1
                INC SI
                MOV MATRIZ2 [BX][SI],6
                INC SI
                MOV MATRIZ2 [BX][SI],7
                INC SI
                MOV MATRIZ2 [BX][SI],4
                INC SI
                MOV MATRIZ2 [BX][SI],2
                INC SI
                MOV MATRIZ2 [BX][SI],9
                INC SI
                MOV MATRIZ2 [BX][SI],5
                INC SI
            ADD BX,COL
            XOR SI,SI
                MOV MATRIZ2 [BX][SI],6
                INC SI
                MOV MATRIZ2 [BX][SI],4
                INC SI
                MOV MATRIZ2 [BX][SI],2
                INC SI
                MOV MATRIZ2 [BX][SI],5
                INC SI
                MOV MATRIZ2 [BX][SI],9
                INC SI
                MOV MATRIZ2 [BX][SI],3
                INC SI
                MOV MATRIZ2 [BX][SI],1
                INC SI
                MOV MATRIZ2 [BX][SI],7
                INC SI
                MOV MATRIZ2 [BX][SI],8
                INC SI 
            ADD BX,COL
            XOR SI,SI
                MOV MATRIZ2 [BX][SI],9
                INC SI
                MOV MATRIZ2 [BX][SI],3
                INC SI
                MOV MATRIZ2 [BX][SI],6
                INC SI
                MOV MATRIZ2 [BX][SI],1
                INC SI
                MOV MATRIZ2 [BX][SI],2
                INC SI
                MOV MATRIZ2 [BX][SI],5
                INC SI
                MOV MATRIZ2 [BX][SI],7
                INC SI
                MOV MATRIZ2 [BX][SI],8
                INC SI
                MOV MATRIZ2 [BX][SI],4
                INC SI 
            ADD BX,COL
            XOR SI,SI
                MOV MATRIZ2 [BX][SI],2
                INC SI
                MOV MATRIZ2 [BX][SI],7
                INC SI
                MOV MATRIZ2 [BX][SI],5
                INC SI
                MOV MATRIZ2 [BX][SI],3
                INC SI
                MOV MATRIZ2 [BX][SI],4
                INC SI
                MOV MATRIZ2 [BX][SI],8
                INC SI
                MOV MATRIZ2 [BX][SI],9
                INC SI
                MOV MATRIZ2 [BX][SI],1
                INC SI
                MOV MATRIZ2 [BX][SI],6
                INC SI 
            ADD BX,COL
            XOR SI,SI
                MOV MATRIZ2 [BX][SI],4
                INC SI
                MOV MATRIZ2 [BX][SI],1
                INC SI
                MOV MATRIZ2 [BX][SI],8
                INC SI
                MOV MATRIZ2 [BX][SI],7
                INC SI
                MOV MATRIZ2 [BX][SI],6
                INC SI
                MOV MATRIZ2 [BX][SI],9
                INC SI
                MOV MATRIZ2 [BX][SI],5
                INC SI
                MOV MATRIZ2 [BX][SI],3
                INC SI
                MOV MATRIZ2 [BX][SI],2
                INC SI 
            ADD BX,COL
            XOR SI,SI
                MOV MATRIZ2 [BX][SI],5
                INC SI
                MOV MATRIZ2 [BX][SI],2
                INC SI
                MOV MATRIZ2 [BX][SI],7
                INC SI
                MOV MATRIZ2 [BX][SI],8
                INC SI
                MOV MATRIZ2 [BX][SI],1
                INC SI
                MOV MATRIZ2 [BX][SI],6
                INC SI
                MOV MATRIZ2 [BX][SI],3
                INC SI
                MOV MATRIZ2 [BX][SI],4
                INC SI
                MOV MATRIZ2 [BX][SI],9
                INC SI 
            ADD BX,COL
            XOR SI,SI
                MOV MATRIZ2 [BX][SI],8
                INC SI
                MOV MATRIZ2 [BX][SI],9
                INC SI
                MOV MATRIZ2 [BX][SI],3
                INC SI
                MOV MATRIZ2 [BX][SI],4
                INC SI
                MOV MATRIZ2 [BX][SI],5
                INC SI
                MOV MATRIZ2 [BX][SI],7
                INC SI
                MOV MATRIZ2 [BX][SI],6
                INC SI
                MOV MATRIZ2 [BX][SI],2
                INC SI
                MOV MATRIZ2 [BX][SI],1
                INC SI 
            ADD BX,COL
            XOR SI,SI
                MOV MATRIZ2 [BX][SI],1
                INC SI
                MOV MATRIZ2 [BX][SI],6
                INC SI
                MOV MATRIZ2 [BX][SI],4
                INC SI
                MOV MATRIZ2 [BX][SI],9
                INC SI
                MOV MATRIZ2 [BX][SI],3
                INC SI
                MOV MATRIZ2 [BX][SI],2
                INC SI
                MOV MATRIZ2 [BX][SI],8
                INC SI
                MOV MATRIZ2 [BX][SI],5
                INC SI
                MOV MATRIZ2 [BX][SI],7
                INC SI 
        RET
    MEDIO ENDP
    DIFICIL PROC; DIFICULDADE (PREENCHIMENTO DA MATRIZ(SUDOKU))
    XOR BX,BX
    XOR SI,SI
        ADD SI,4
        MOV MATRIZ [BX][SI],6
    ADD BX,COL
    XOR SI,SI
        MOV MATRIZ [BX][SI],9
        ADD SI,6
        MOV MATRIZ [BX][SI],6
        INC SI
        MOV MATRIZ [BX][SI],5
    ADD BX,COL
    XOR SI,SI 
        ADD SI,3
        MOV MATRIZ [BX][SI],7
        ADD SI,2
        MOV MATRIZ [BX][SI],5 
    ADD BX,COL
    XOR SI,SI 
        INC SI
        MOV MATRIZ [BX][SI],7
        ADD SI,2
        MOV MATRIZ [BX][SI],5
        ADD SI,4 
        MOV MATRIZ [BX][SI],1
        INC SI 
        MOV MATRIZ [BX][SI],2
    ADD BX,COL
    XOR SI,SI 
        INC SI
        MOV MATRIZ [BX][SI],3
        ADD SI,7
        MOV MATRIZ [BX][SI],5
    ADD BX,COL
    XOR SI,SI 
        MOV MATRIZ [BX][SI],1
        ADD SI,3 
        MOV MATRIZ [BX][SI],6
        INC SI
        MOV MATRIZ [BX][SI],9
        INC SI
        MOV MATRIZ [BX][SI],8
        ADD SI,3 
        MOV MATRIZ [BX][SI],7  
    ADD BX,COL
    XOR SI,SI 
        MOV MATRIZ [BX][SI],6
        INC SI 
        MOV MATRIZ [BX][SI],9
        ADD SI,4 
        MOV MATRIZ [BX][SI],3
    ADD BX,COL
    XOR SI,SI 
        MOV MATRIZ [BX][SI],5
    ADD BX,COL
    XOR SI,SI 
        INC SI 
        MOV MATRIZ [BX][SI],2
        ADD SI,2 
        MOV MATRIZ [BX][SI],1
        ADD SI,5
        MOV MATRIZ [BX][SI],3
        
    ; SUDOKU COMPLETO(resposta)
        XOR BX,BX
        XOR SI,SI
    RET
    DIFICIL ENDP
END MAIN
