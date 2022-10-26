
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
            CMP BL,10
            JNA FIM
            SHR BL,1
            SHR BH,1
            ADD CL,1
            CMP BL,10
            JMP DAUX3 



    FIM:
    MOV AH,4Ch         
    INT 21h 
    MAIN ENDP
END MAIN