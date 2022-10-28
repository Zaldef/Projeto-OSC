TITLE Guilherme Roelli (22899140) & Vitor Yuzo Takei (22023740)
.MODEL SMALL
.CODE
    MAIN PROC
       MOV CX,4
       MOV AH,01h
       INT 21H
    ID1:
        CMP AL,0Dh
        JE FIM
        AND AL,0Fh
        MOV DX,10
        MUL DX
        ADD BX,AL
        XOR AL,AL

        
        INT 21H
        LOOP ID1

    FIM:
    MOV AH,4Ch         
    INT 21h 
    MAIN ENDP
END MAIN