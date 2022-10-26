TITLE Guilherme Roelli (22899140) & Vitor Yuzo Takei (22023740)
.MODEL SMALL
.CODE
    MAIN PROC
    MOV BH,7
    MOV BL,2
        DAUX1:
            SHL BH,4
        DAUX2:
            SHL BL,4
        DAUX3:
            CMP BH,BL
            JAE DAUX4
            JB FIM
            JMP DAUX3
        DAUX4:
            SUB BH,BL
            ADD CL, 1
            JMP DAUX3
            CMP BH,0
            JE FIM
            JMP DAUX3


    FIM:
    MOV AH,4Ch         
    INT 21h 
    MAIN ENDP
END MAIN