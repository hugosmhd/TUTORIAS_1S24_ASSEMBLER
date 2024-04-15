mTextMode macro
    mov AX, 03
    int 10
endm

mVideoMode macro
    mov AX, 13
    int 10
endm

mMoveToVideo macro
    MOV DX, 0A000H
    MOV DS, DX
endm

mRetControl macro
        MOV AL, 0       ;mensaje de retorno
        MOV AH, 04Ch    ; devuelve el control al sistema
        INT 21
endm

mSetDataOnDs macro
    mov DX, @data
    mov DS, DX
    MOV ES, DX
endm

mGetKey macro
    MOV AH,01h
    INT 21h
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

mDrawText MACRO text, row, column, color
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX
    PUSH BP

    CALL PMOVDATATOES

    MOV AL, 1
    MOV DH, row
    MOV DL, column
    MOV BH, 0
    MOV BL, color
    MOV CX, LENGTHOF text

    MOV BP, OFFSET text
    MOV AH, 13H
    INT 10H


    POP BP
    POP DX
    POP CX
    POP BX
    POP AX
ENDM

mCleanScreen macro
    PUSH AX

    MOV AH, 00h
    MOV AL, 03h
    INT 10h

    POP AX
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

mPushRegisters macro
push ax
push bx
push cx
push dx

xor ax, ax
xor bx, bx
xor cx, cx
xor dx, dx
endm


mPopRegisters macro
pop ax
pop bx
pop cx
pop dx
endm

mPrintTextIntoVideo MACRO row, column, text, chars, color
;AH         13h
;AL         Subservice (0-3)
;BH         Display page number
;BL         Attribute (Subservices 0 and 1)
;CX         Length of string
;DH         Row position where string is to be written
;DL         Column position where string is to be written
;ES:BP      Pointer to string to write
mPushRegisters
CALL PMOVDATATOES

MOV AH, 13
MOV AL, 0
MOV CX, chars
MOV DH, row
MOV DL, column
LEA BX, text
MOV BP, BX
MOV BX, color
INT 10

CALL PMOVESTOVIDEOMODE
mPopRegisters
ENDM

mKeysPause macro
    LOCAL until_select_option, back_game, exit, exit_game
    PUSH AX

    until_select_option:
        MOV AH,01h
        INT 21h
        CMP AL, 1Bh
        JE back_game
        CMP AL, 000DH
        JE exit_game
        JMP until_select_option
    exit_game:
        CALL PCLEANSCREEN
        MOV pauseMode, 04
        ; CALL PFILLLIVES
        ; MOV BX, points
        ; MOV numberInt, BX
        ; mNumToStringPoints
        ; XOR BX, BX
        ; CALL drawPoints
        ; CALL PPAINTMAP
        ; mDrawText timePlayed, 0, 1F, 40
        ; mDrawText timePowerDot, 18, 22, 40
        JMP exit
    back_game:
        CALL PCLEANSCREEN
        MOV pauseMode, 00
        CALL PFILLLIVES
        MOV BX, points
        MOV numberInt, BX
        mNumToStringPoints
        XOR BX, BX
        CALL drawPoints
        CALL PPAINTMAP
        mDrawText timePlayed, 0, 1F, 40
        mDrawText timePowerDot, 18, 22, 40
        JMP exit
    exit:
        POP AX
endm

mNumToStringTime macro time, number, position
    PUSH AX    
    PUSH BX  
    PUSH DX

    XOR AX, AX
    XOR BX, BX
    XOR DX, DX

    LEA DX, time
    MOV BH, 0AH
    MOV AL, number
    DIV BH

    XOR BX, BX
    MOV SI, DX
    ADD AL, 30
    ADD SI, position
    MOV [SI], AL
    ADD AH, 30
    INC SI
    MOV [SI], AH

    POP DX
    POP BX
    POP AX
endm

mNumToStringPoints macro
    LOCAL extraer, almacenar

    PUSH BX
    PUSH CX
    PUSH AX
    PUSH DX
    PUSH SI
    
    MOV BX, 0AH
    XOR CX, CX
    MOV AX, numberInt

    extraer:
        XOR DX, DX
        DIV BX
        ADD DX, 30H
        PUSH DX
        INC CX
        CMP AX, 0
        JNE extraer
    
    MOV SI, 0

    almacenar:
        POP DX
        MOV recoveredStr[SI], DL
        INC SI
        LOOP almacenar
    POP SI
    POP DX
    POP AX
    POP CX
    POP BX
endm
