TITLE Guilherme Roelli (22899140) & Vitor Yuzo Takei (22023740)
.MODEL SMALL
.CODE
    MAIN PROC
    MOV BH,6
    MOV BL,3
        DAUX1:
            SHL BH,4
        DAUX2:
            SHL BL,4
        DAUX3:
            CMP BH,BL
            JAE DAUX4
            SHR BL,1
            SHL CL,1
            CMP BL,0
            JA DAUX3
            JMP FIM
        DAUX4:
            SUB BH,BL
            SHR BL,2
            ADD CL,1
            CMP BL,0
            JA DAUX3
            JMP FIM


    FIM:
    MOV AH,4Ch         
    INT 21h 
    MAIN ENDP
END MAIN