TITLE Guilherme Roelli (22899140) & Vitor Yuzo Takei (22023740)
.MODEL SMALL
.STACK 100h
.DATA
.CODE
    MAIN PROC

        mov bh, 9
        mov bl, 0
        cmp
    volta:
        sar bl,1
        jc exe
        sal BH,1
        cmp bl,0 
        jne volta
        JE FIM
    exe: 
        add ch,bh
        sal bh,1
        cmp bl,0 
        jne volta
        

    FIM:
        MOV AH,4Ch         ;
        INT 21h            ; Exit do programa
    MAIN ENDP  
END MAIN