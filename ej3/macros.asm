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

mVideoMode macro
    mov AX, 13
    int 10
endm

mDivLine macro line, color
    PUSH AX

    ; INICIA EN 0 EL CONTADOR
    MOV PIXLINE, line
    MOV PIXCOL, 0

    CALL CALCPIXELLOC   ;SALIDA EN AX
    
    MOV BH, 00
    MOV BL, color
    MOV SQCOLOR, BX
    MOV SQHEIGHT, 4
    MOV SQWIDTH, 140
    CALL DRAWSQUARE

    POP AX
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

; -----------------------------------------------------------------------------------------
mMoveToVideo macro
    MOV DX, 0A000H
    MOV DS, DX
endm

mEnterText macro
    LOCAL enterChar, endproc
    LOCAL validChar, invalidChar, handleBackspace
    XOR DI, DI
    enterChar:
        INC coordenada_c_columna
        MOV AH, 01
        INT 21h
        CMP AL, 3Bh    ; Comprueba si el carácter es un punto y coma
        JE  validChar   ; Si es igual a ';', salta a validChar
        CMP AL, 0Dh
        JE endproc
        CMP AL, 08     ; Comprueba si el carácter es el retroceso (backspace)
        JE  handleBackspace ; Si es retroceso, salta a handleBackspace
        CMP AL, 30     ; Comprueba si el carácter es un número
        JB  invalidChar ; Si es menor que '0', salta a invalidChar
        CMP AL, 39     ; Comprueba si el carácter es un número
        JA  invalidChar ; Si es mayor que '9', salta a invalidChar
        ; JMP validChar ; Si no es un número ni un punto y coma, salta a invalidChar
    validChar:
        MOV [bufferEntrada + DI], AL
        INC DI
        JMP enterChar
    handleBackspace:
        ; mPrintTextIntoVideo 0E, 00, mensaje_ingresar_coor, 16, 000F
        ; Retrocede el cursor
        mov ah, 02     ; Función de DOS para mover el cursor
        mov dh, coordenada_c_fila       ; Fila
        mov dl, coordenada_c_columna      ; Columna anterior
        dec dl          ; Retrocede una columna
        dec dl          ; Retrocede una columna
        int 10h         ; Llama a la interrupción del BIOS para mover el cursor

        ; Borra el carácter anterior en pantalla
        push dx
        mov ah, 02     ; Función de DOS para imprimir un carácter
        mov dl, 20
        ; mov al, 040     ; Carácter de espacio en blanco
        int 21h         ; Llama a la interrupción del BIOS para imprimir un carácter
        pop dx

        ; Retrocede el cursor nuevamente
        DEC coordenada_c_columna
        DEC coordenada_c_columna
        mov ah, 02     ; Función de DOS para mover el cursor
        mov dl, coordenada_c_columna      ; Columna actual
        int 10h         ; Llama a la interrupción del BIOS para mover el cursor

        DEC DI          ; Retrocede el índice en el búfer
        JMP enterChar

    invalidChar:
        ; Retrocede el cursor
        mov ah, 02     ; Función de DOS para mover el cursor
        mov dh, coordenada_c_fila       ; Fila
        mov dl, coordenada_c_columna      ; Columna anterior
        dec dl          ; Retrocede una columna
        int 10h         ; Llama a la interrupción del BIOS para mover el cursor
        
        ; Borra el carácter anterior en pantalla
        push dx
        mov ah, 02     ; Función de DOS para imprimir un carácter
        mov dl, 20
        ; mov al, 040     ; Carácter de espacio en blanco
        int 21h         ; Llama a la interrupción del BIOS para imprimir un carácter
        pop dx
        
        DEC coordenada_c_columna
        mov ah, 02     ; Función de DOS para mover el cursor
        mov dl, coordenada_c_columna      ; Columna actual
        int 10h         ; Llama a la interrupción del BIOS para mover el cursor

        JMP enterChar

    endproc:
        ; INC DI
        ; DEC DI
        MOV AL,00h ;
        MOV [bufferEntrada + DI], AL
endm

mVerficarCoordenadas macro
    PUSH BX
    PUSH AX
    PUSH DX
    PUSH CX
    
    MOV BX, offset bufferEntrada
    ; HACER VALIDACIONES QUE ESTE EN EL RANGO PARA NUMERO
    MOV AL, [BX]
    SUB AL, 31
    MOV AH, AL      ;VALOR DE MI FILA
    MOV coordenada_y, AH
    
    INC BX
    MOV AL, [BX] ;ESTE SERIA LA COMA
    
    INC BX
    MOV AL, [BX] ;VALOR DE MI COLUMNA
    SUB AL, 31
    MOV DL, AL
    MOV coordenada_x, DL

    POP CX
    POP DX
    POP AX
    POP BX
endm