TITLE Guilherme Roelli (22899140) & Vitor Yuzo Takei (22023740)
.MODEL SMALL
.CODE
    MAIN PROC
        MOV AH,01h
        INT 21h
        MOV BL,AL
        MOV AH,02h
        MOV DL,10
        INT 21h
        MOV AH,02h
        MOV DL,BL
        INT 21H

    FIM:
    MOV AH,4Ch         
    INT 21h 
    MAIN ENDP
END MAIN