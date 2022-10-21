TITLE Guilherme Roelli (22899140) & Vitor Yuzo Takei (22023740)
.MODEL SMALL
.CODE
    MAIN PROC
    
        MOV BH,9
        MOV BL,9
        SHR BL,1
    VOLTA:
        SHL BH,1
        SHR BL,1
        JC JNAC
        SHL CH,1
    JNAC:
        ADD CH,BH
        CMP BL,0
        JNE VOLTA
    FIM:
    MOV AH,4Ch         ;
    INT 21h 
    MAIN ENDP
END MAIN