mSetDataOnDs macro
    mov DX, @data
    mov DS, DX
    MOV ES, DX
endm

mCleanScreen macro
    PUSH AX

    MOV AH, 00h
    MOV AL, 03h
    INT 10h

    POP AX
endm

mPrint macro var
    PUSH DX
    PUSH AX
    
    MOV DX, OFFSET var
    MOV AH, 09
    INT 21

    POP AX
    POP DX
endm

pauseUntilEnter macro
    LOCAL until_press_enter
    PUSH AX

    until_press_enter:
        MOV AH,08h
        INT 21h
        CMP AL, 000DH
        JNE until_press_enter
    POP AX
endm

mGetKey macro
    MOV AH,01h
    INT 21h
endm

mTextMode macro
    mov AX, 03
    int 10
endm

mRetControl macro
        MOV AL, 0       ;mensaje de retorno
        MOV AH, 04Ch    ; devuelve el control al sistema
        INT 21
endm

; ----------------------------------------------------------------------------------------
