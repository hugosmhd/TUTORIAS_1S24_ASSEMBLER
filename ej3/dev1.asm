INCLUDE MACROS.ASM

.MODEL small
.STACK
.RADIX 16
.DATA           ;SEGMENTO DE DATOS
; CHAR ESPECIALES
newLine db 0ah, 0dh, '$'

;CONTROL DEL TURNO DEL JUGADOR
turno_jugador db 01
ganador db 00
is_celda_invalida db 00

;CORDENADAS DONDE SE COLOCARA LAS OBJETOS
wallRead db 00
posXRead dw 00
posYRead dw 00
indiceTablero db 00, '$'

; COORDENADAS QUE SE INGRESAN POR TEXTO
coordenada_x db 00
coordenada_y db 00

;COORDENADAS CURSOR
coordenada_c_fila db 00
coordenada_c_columna db 00

coordenada_limpiar_fila db 00

; MENSAJES
mensaje_ingresar_coor db 'INGRESAR COORDENADAS: '
mensaje_celda_invalida db 'La celda ingresada esta ocupada'
mensaje_ganado_j1 db 'Ha ganado el jugador 1 jugando con X', '$'
mensaje_ganado_j2 db 'Ha ganado el jugador 2 jugando con O', '$'

;ENTRADA DE TEXTO
bufferEntrada db 255 dup('$')

;PAREDES TOTITO
empty_block db     00, 00, 00, 00, 00, 00, 00, 00
            db     00, 00, 00, 00, 00, 00, 00, 00
            db     00, 00, 00, 00, 00, 00, 00, 00
            db     00, 00, 00, 00, 00, 00, 00, 00
            db     00, 00, 00, 00, 00, 00, 00, 00
            db     00, 00, 00, 00, 00, 00, 00, 00
            db     00, 00, 00, 00, 00, 00, 00, 00
            db     00, 00, 00, 00, 00, 00, 00, 00
wall_one    db     00, 00, 00, 00, 00, 00, 00, 00
            db     00, 00, 00, 00, 00, 00, 00, 00
            db     00, 00, 01, 01, 01, 01, 01, 01
            db     00, 00, 01, 01, 01, 01, 01, 01
            db     00, 00, 01, 01, 01, 01, 01, 01
            db     00, 00, 01, 01, 01, 01, 01, 01
            db     00, 00, 01, 01, 01, 01, 00, 00
            db     00, 00, 01, 01, 01, 01, 00, 00
wall_two    db     00, 00, 00, 00, 00, 00, 00, 00
            db     00, 00, 00, 00, 00, 00, 00, 00
            db     01, 01, 01, 01, 01, 01, 00, 00
            db     01, 01, 01, 01, 01, 01, 00, 00
            db     01, 01, 01, 01, 01, 01, 00, 00
            db     01, 01, 01, 01, 01, 01, 00, 00
            db     00, 00, 01, 01, 01, 01, 00, 00
            db     00, 00, 01, 01, 01, 01, 00, 00
wall_three  db     00, 00, 01, 01, 01, 01, 00, 00
            db     00, 00, 01, 01, 01, 01, 00, 00
            db     00, 00, 01, 01, 01, 01, 00, 00
            db     00, 00, 01, 01, 01, 01, 00, 00
            db     00, 00, 01, 01, 01, 01, 00, 00
            db     00, 00, 01, 01, 01, 01, 00, 00
            db     00, 00, 01, 01, 01, 01, 00, 00
            db     00, 00, 01, 01, 01, 01, 00, 00
wall_four   db     00, 00, 00, 00, 00, 00, 00, 00
            db     00, 00, 00, 00, 00, 00, 00, 00
            db     01, 01, 01, 01, 01, 01, 01, 01
            db     01, 01, 01, 01, 01, 01, 01, 01
            db     01, 01, 01, 01, 01, 01, 01, 01
            db     01, 01, 01, 01, 01, 01, 01, 01
            db     00, 00, 00, 00, 00, 00, 00, 00
            db     00, 00, 00, 00, 00, 00, 00, 00
wall_five   db     00, 00, 00, 00, 00, 00, 00, 00
            db     00, 00, 00, 00, 00, 00, 00, 00
            db     01, 01, 01, 01, 01, 01, 01, 01
            db     01, 01, 01, 01, 01, 01, 01, 01
            db     01, 01, 01, 01, 01, 01, 01, 01
            db     01, 01, 01, 01, 01, 01, 01, 01
            db     00, 00, 01, 01, 01, 01, 00, 00
            db     00, 00, 01, 01, 01, 01, 00, 00
wall_six    db     00, 00, 01, 01, 01, 01, 00, 00
            db     00, 00, 01, 01, 01, 01, 00, 00
            db     01, 01, 01, 01, 01, 01, 01, 01
            db     01, 01, 01, 01, 01, 01, 01, 01
            db     01, 01, 01, 01, 01, 01, 01, 01
            db     01, 01, 01, 01, 01, 01, 01, 01
            db     00, 00, 01, 01, 01, 01, 00, 00
            db     00, 00, 01, 01, 01, 01, 00, 00
wall_ten    db     00, 00, 01, 01, 01, 01, 00, 00
            db     00, 00, 01, 01, 01, 01, 00, 00
            db     00, 00, 01, 01, 01, 01, 01, 01
            db     00, 00, 01, 01, 01, 01, 01, 01
            db     00, 00, 01, 01, 01, 01, 01, 01
            db     00, 00, 01, 01, 01, 01, 01, 01
            db     00, 00, 01, 01, 01, 01, 00, 00
            db     00, 00, 01, 01, 01, 01, 00, 00
wall_eleven db     00, 00, 01, 01, 01, 01, 00, 00
            db     00, 00, 01, 01, 01, 01, 00, 00
            db     01, 01, 01, 01, 01, 01, 01, 01
            db     01, 01, 01, 01, 01, 01, 01, 01
            db     01, 01, 01, 01, 01, 01, 01, 01
            db     01, 01, 01, 01, 01, 01, 01, 01
            db     00, 00, 00, 00, 00, 00, 00, 00
            db     00, 00, 00, 00, 00, 00, 00, 00
wall_twelve db     00, 00, 01, 01, 01, 01, 00, 00
            db     00, 00, 01, 01, 01, 01, 00, 00
            db     01, 01, 01, 01, 01, 01, 00, 00
            db     01, 01, 01, 01, 01, 01, 00, 00
            db     01, 01, 01, 01, 01, 01, 00, 00
            db     01, 01, 01, 01, 01, 01, 00, 00
            db     00, 00, 01, 01, 01, 01, 00, 00
            db     00, 00, 01, 01, 01, 01, 00, 00
wall_fourteen   db     00, 00, 01, 01, 01, 01, 00, 00
                db     00, 00, 01, 01, 01, 01, 00, 00
                db     00, 00, 01, 01, 01, 01, 01, 01
                db     00, 00, 01, 01, 01, 01, 01, 01
                db     00, 00, 01, 01, 01, 01, 01, 01
                db     00, 00, 01, 01, 01, 01, 01, 01
                db     00, 00, 00, 00, 00, 00, 00, 00
                db     00, 00, 00, 00, 00, 00, 00, 00
wall_fifteen    db     00, 00, 01, 01, 01, 01, 00, 00
                db     00, 00, 01, 01, 01, 01, 00, 00
                db     01, 01, 01, 01, 01, 01, 00, 00
                db     01, 01, 01, 01, 01, 01, 00, 00
                db     01, 01, 01, 01, 01, 01, 00, 00
                db     01, 01, 01, 01, 01, 01, 00, 00
                db     00, 00, 00, 00, 00, 00, 00, 00
                db     00, 00, 00, 00, 00, 00, 00, 00


;FIGURA X
barrax_uno      db     01, 01, 00, 00, 00, 00, 00, 00
                db     00, 01, 01, 00, 00, 00, 00, 00
                db     00, 00, 01, 01, 00, 00, 00, 00
                db     00, 00, 00, 01, 01, 00, 00, 00
                db     00, 00, 00, 00, 01, 01, 00, 00
                db     00, 00, 00, 00, 00, 01, 01, 00
                db     00, 00, 00, 00, 00, 00, 01, 01
                db     00, 00, 00, 00, 00, 00, 00, 01

barrax_dos      db     00, 00, 00, 00, 00, 00, 01, 01
                db     00, 00, 00, 00, 00, 01, 01, 00
                db     00, 00, 00, 00, 01, 01, 00, 00
                db     00, 00, 00, 01, 01, 00, 00, 00
                db     00, 00, 01, 01, 00, 00, 00, 00
                db     00, 01, 01, 00, 00, 00, 00, 00
                db     01, 01, 00, 00, 00, 00, 00, 00
                db     01, 00, 00, 00, 00, 00, 00, 00

;FIGURA O
barrao_uno      db     01, 01, 01, 01, 01, 01, 01, 01
                db     01, 00, 00, 00, 00, 00, 00, 00
                db     01, 00, 00, 00, 00, 00, 00, 00
                db     01, 00, 00, 00, 00, 00, 00, 00
                db     01, 00, 00, 00, 00, 00, 00, 00
                db     01, 00, 00, 00, 00, 00, 00, 00
                db     01, 00, 00, 00, 00, 00, 00, 00
                db     01, 00, 00, 00, 00, 00, 00, 00

barrao_dos      db     01, 00, 00, 00, 00, 00, 00, 00
                db     01, 00, 00, 00, 00, 00, 00, 00
                db     01, 00, 00, 00, 00, 00, 00, 00
                db     01, 00, 00, 00, 00, 00, 00, 00
                db     01, 00, 00, 00, 00, 00, 00, 00
                db     01, 00, 00, 00, 00, 00, 00, 00
                db     01, 00, 00, 00, 00, 00, 00, 00
                db     01, 01, 01, 01, 01, 01, 01, 01

barrao_tres     db     01, 01, 01, 01, 01, 01, 01, 01
                db     00, 00, 00, 00, 00, 00, 00, 01
                db     00, 00, 00, 00, 00, 00, 00, 01
                db     00, 00, 00, 00, 00, 00, 00, 01
                db     00, 00, 00, 00, 00, 00, 00, 01
                db     00, 00, 00, 00, 00, 00, 00, 01
                db     00, 00, 00, 00, 00, 00, 00, 01
                db     00, 00, 00, 00, 00, 00, 00, 01

barrao_cuatro   db     00, 00, 00, 00, 00, 00, 00, 01
                db     00, 00, 00, 00, 00, 00, 00, 01
                db     00, 00, 00, 00, 00, 00, 00, 01
                db     00, 00, 00, 00, 00, 00, 00, 01
                db     00, 00, 00, 00, 00, 00, 00, 01
                db     00, 00, 00, 00, 00, 00, 00, 01
                db     00, 00, 00, 00, 00, 00, 00, 01
                db     01, 01, 01, 01, 01, 01, 01, 01

object_map db 09 dup (0)   ;3x3

.CODE           ;SEGMENTO DE CODIGO
inicio:
    main proc
      mSetDataOnDs
      mCleanScreen

      start_game:
        mVideoMode
        CALL PCLEANSCREEN
        CALL PCREARTABLERO
        inicio_turno:
            CMP ganador, 01
            JE imprimir_ganador
            mPrintTextIntoVideo 0C, 00, mensaje_ingresar_coor, 16, 000F
            MOV coordenada_c_fila, 0C
            MOV coordenada_c_columna, 15
            CALL PMOVERCURSOR
            mEnterText
            mVerficarCoordenadas
            CALL PCOORDENADASOBJETOS
            CMP turno_jugador, 01
            JE tuno_x
            CMP turno_jugador, 02
            JE tuno_o
        tuno_x:
            PUSH AX
            PUSH CX
            PUSH DX
            XOR AX, AX
            MOV AL, coordenada_x
            XOR CX, CX
            MOV CL, coordenada_y
            MOV DH, turno_jugador
            CALL PPUTFIGURE
            POP DX
            POP CX
            POP AX
            CMP is_celda_invalida, 01
            JE volver_a_intentar

            CALL PDRAWX
            CALL PCLEANLINECURSOR
            MOV coordenada_limpiar_fila, 0Bh
            CALL PCLEANANYLINE
            CALL PCHECKPLAYERWIN
            MOV turno_jugador, 02
            JMP inicio_turno
        tuno_o:
            PUSH AX
            PUSH CX
            PUSH DX
            XOR AX, AX
            MOV AL, coordenada_x
            XOR CX, CX
            MOV CL, coordenada_y
            MOV DH, turno_jugador
            CALL PPUTFIGURE
            POP DX
            POP CX
            POP AX
            CMP is_celda_invalida, 01
            JE volver_a_intentar

            CALL PDRAWO
            CALL PCLEANLINECURSOR
            MOV coordenada_limpiar_fila, 0Bh
            CALL PCLEANANYLINE
            CALL PCHECKPLAYERWIN
            MOV turno_jugador, 01
            JMP inicio_turno

        volver_a_intentar:
            CALL PCLEANLINECURSOR
            MOV is_celda_invalida, 00
            JMP inicio_turno
        imprimir_ganador:
            CMP turno_jugador, 01
            JE ganador_j2
            CMP turno_jugador, 02
            JE ganador_j1
        ganador_j2:
            mTextMode
            mPrint mensaje_ganado_j2
            JMP finish
        ganador_j1:
            mTextMode
            mPrint mensaje_ganado_j1
            JMP finish

      finish:
          pauseUntilEnter
          mRetControl
    main endp

    PCHECKPLAYERWIN proc
        ; Comprueba las filas
        mov cx, 3 ; Número de filas
        mov si, offset object_map
        checkRows:
            ; Compara cada fila
            PUSH SI
            mov al, [si]
            inc si
            cmp al, [si]
            jne nextRow
            inc si
            cmp al, [si]
            jne nextRow
            ; Si los tres elementos de la fila son 1, hay un ganador
            cmp al, turno_jugador
            jne nextRow
            ; En este punto, tenemos un ganador (jugador 1)
            POP SI
            mov al, 1
            mov ganador, 01
            ret

        nextRow:
            POP SI
            add si, 3 ; Avanza al inicio de la siguiente fila
            loop checkRows ; Repite para todas las filas

            ; Comprueba las columnas
            mov cx, 3 ; Número de columnas
            mov si, offset object_map
        checkColumns:
            ; Compara cada columna
            PUSH SI
            mov al, [si]
            add si, 3 ; Avanza a la siguiente columna
            cmp al, [si]
            jne nextColumn
            add si, 3 ; Avanza a la siguiente columna
            cmp al, [si]
            jne nextColumn
            ; Si los tres elementos de la columna son 1, hay un ganador
            cmp al, turno_jugador
            jne nextColumn
            ; En este punto, tenemos un ganador (jugador 1)
            mov al, turno_jugador
            mov ganador, 01
            POP SI
            ret

        nextColumn:
            POP SI
            ; sub si, 8 ; Retrocede al inicio de la siguiente columna
            INC SI
            loop checkColumns ; Repite para todas las columnas

            ; Comprueba las diagonales
            mov si, offset object_map
            ; Compara la diagonal principal (de izquierda a derecha)
            mov al, [si]
            add si, 4 ; Avanza a la siguiente celda de la diagonal
            cmp al, [si]
            jne checkSecondaryDiagonal
            add si, 4 ; Avanza a la siguiente celda de la diagonal
            cmp al, [si]
            jne checkSecondaryDiagonal
            ; Si los tres elementos de la diagonal son 1, hay un ganador
            cmp al, turno_jugador
            jne checkSecondaryDiagonal
            ; En este punto, tenemos un ganador (jugador 1)
            mov al, turno_jugador
            mov ganador, 01
            ret

        checkSecondaryDiagonal:
            ; Comprueba la diagonal secundaria (de derecha a izquierda)
            mov si, offset object_map + 2 ; Comienza en la segunda celda de la diagonal secundaria
            mov al, [si] ; Obtiene el primer elemento de la diagonal
            add si, 2 ; Retrocede a la siguiente celda de la diagonal
            cmp al, [si] ; Compara con el segundo elemento de la diagonal
            jne noWinner ; Si no son iguales, no hay ganador
            add si, 2 ; Retrocede a la siguiente celda de la diagonal
            cmp al, [si] ; Compara con el tercer elemento de la diagonal
            jne noWinner ; Si no son iguales, no hay ganador
            ; Si los tres elementos de la diagonal son 1, hay un ganador
            cmp al, turno_jugador
            jne noWinner ; Si no todos son iguales a 1, no hay ganador
            ; En este punto, tenemos un ganador (jugador 1)
            mov al, turno_jugador
            mov ganador, 01
            ret

        noWinner:
            ; No hay ganador para el jugador 1
            xor al, al
            ret

    PCHECKPLAYERWIN endp

    PCOORDENADASOBJETOS PROC
        XOR AX, AX
        MOV AL, coordenada_x
        DEC AL
        MOV CL, 03
        MUL CL
        ADD AX, 03
        INC AX
        PUSH AX
        MOV AL, coordenada_y
        DEC AL
        MOV CL, 03
        MUL CL
        ADD AX, 03
        INC AX
        XOR CX, CX
        MOV CX, AX
        POP AX
        RET
    PCOORDENADASOBJETOS ENDP
    
    PCLEANANYLINE PROC
        XOR AX, AX      ; POS X
        XOR CX, CX      ; POS Y
        XOR SI, SI
        XOR BX, BX
        MOV CX, 28
        traverse_columns_cls:
            mov DI, offset empty_block
            push AX
            push CX
            XOR CX, CX
            mov CL, coordenada_limpiar_fila
            call PDRAWFIGURE
            pop CX
            pop AX
            inc AX      ; SE INCREMENTA POSICION EN X
            loop traverse_columns_cls
        finish_clean_screen:
            ret
    PCLEANANYLINE ENDP

    PCLEANLINECURSOR PROC
        XOR AX, AX      ; POS X
        XOR CX, CX      ; POS Y
        XOR SI, SI
        XOR BX, BX
        MOV CX, 28
        traverse_columns_cls:
            mov DI, offset empty_block
            push AX
            push CX
            XOR CX, CX
            mov CL, coordenada_c_fila
            call PDRAWFIGURE
            pop CX
            pop AX
            inc AX      ; SE INCREMENTA POSICION EN X
            loop traverse_columns_cls
        finish_clean_screen:
            ret
    PCLEANLINECURSOR ENDP

    PMOVERCURSOR PROC
        PUSH DX
        PUSH AX
        mov dh, coordenada_c_fila       ; Fila
        mov dl, coordenada_c_columna      ; Columna
        mov ah, 02h     ; Función de DOS para mover el cursor
        int 10h         ; Llama a la interrupción del BIOS para mover el cursor
        POP AX
        POP DX
        RET
    PMOVERCURSOR ENDP

    PCREARTABLERO PROC

      CALL PPAINTHORIZONTAL
      MOV AX, 00
      MOV CX, 00
      MOV DI, offset wall_one
      CALL PDRAWFIGURESCREEN
      MOV AX, 03
      MOV DI, offset wall_five
      CALL PDRAWFIGURESCREEN
      MOV AX, 06
      MOV DI, offset wall_five
      CALL PDRAWFIGURESCREEN
      MOV AX, 09
      MOV DI, offset wall_two
      CALL PDRAWFIGURESCREEN

      INC CX
      CALL PPAINTVERTICAL
      INC CX
      CALL PPAINTVERTICAL
      INC CX
      MOV AX, 00
      MOV DI, offset wall_ten
      CALL PDRAWFIGURESCREEN
      MOV AX, 03
      MOV DI, offset wall_six
      CALL PDRAWFIGURESCREEN
      MOV AX, 06
      MOV DI, offset wall_six
      CALL PDRAWFIGURESCREEN
      MOV AX, 09
      MOV DI, offset wall_twelve
      CALL PDRAWFIGURESCREEN
      CALL PPAINTHORIZONTAL

      INC CX
      CALL PPAINTVERTICAL
      INC CX
      CALL PPAINTVERTICAL
      INC CX
      MOV AX, 00
      MOV DI, offset wall_ten
      CALL PDRAWFIGURESCREEN
      MOV AX, 03
      MOV DI, offset wall_six
      CALL PDRAWFIGURESCREEN
      MOV AX, 06
      MOV DI, offset wall_six
      CALL PDRAWFIGURESCREEN
      MOV AX, 09
      MOV DI, offset wall_twelve
      CALL PDRAWFIGURESCREEN
      CALL PPAINTHORIZONTAL

      INC CX
      CALL PPAINTVERTICAL
      INC CX
      CALL PPAINTVERTICAL
      INC CX
      MOV AX, 00
      MOV DI, offset wall_fourteen
      CALL PDRAWFIGURESCREEN
      MOV AX, 03
      MOV DI, offset wall_eleven
      CALL PDRAWFIGURESCREEN
      MOV AX, 06
      MOV DI, offset wall_eleven
      CALL PDRAWFIGURESCREEN
      MOV AX, 09
      MOV DI, offset wall_fifteen
      CALL PDRAWFIGURESCREEN
      CALL PPAINTHORIZONTAL



      RET
    PCREARTABLERO ENDP

    PPAINTHORIZONTAL PROC
      MOV AX, 01
      MOV DI, offset wall_four
      CALL PDRAWFIGURESCREEN
      INC AX
      MOV DI, offset wall_four
      CALL PDRAWFIGURESCREEN
      
      INC AX
      INC AX
      MOV DI, offset wall_four
      CALL PDRAWFIGURESCREEN
      INC AX
      MOV DI, offset wall_four
      CALL PDRAWFIGURESCREEN

      INC AX
      INC AX
      MOV DI, offset wall_four
      CALL PDRAWFIGURESCREEN
      INC AX
      MOV DI, offset wall_four
      CALL PDRAWFIGURESCREEN
      RET

    PPAINTHORIZONTAL ENDP

    PPAINTVERTICAL PROC
      MOV AX, 00
      MOV DI, offset wall_three
      CALL PDRAWFIGURESCREEN
      ADD AX, 03
      MOV DI, offset wall_three
      CALL PDRAWFIGURESCREEN
      ADD AX, 03
      MOV DI, offset wall_three
      CALL PDRAWFIGURESCREEN
      ADD AX, 03
      MOV DI, offset wall_three
      CALL PDRAWFIGURESCREEN
      RET
    PPAINTVERTICAL ENDP
    
    PDRAWFIGURESCREEN PROC
        PUSH AX
        PUSH CX

        MOV BX, 0000
        MOV DL, 08
        MUL DL          ; SE MULTIPLICA AX * 8 PARA OBTENER LA COLUMNA EN LA CUAL SE UBICARA
        ADD BX, AX
        XCHG AX, CX     ; INTERCAMBIA POS X = CX y POS Y = AX
        MUL DL
        XCHG AX, CX     ; POS X = BX    POS Y = CX
        position_screen:
            CMP CX, 0000
            JE end_position_screen
            ADD BX, 140     ; BX SE QUEDA CON LA POSICION FINAL DONDE SE COLOCARA EL GRAFICO
            LOOP position_screen
        end_position_screen:
            MOV CX, 0008
        draw_figure_row_screen:
            PUSH CX
            MOV CX, 0008
        draw_figure_column_screen:
            MOV AL, [DI]

            PUSH DS

            mMoveToVideo
            MOV [BX], AL
            INC BX
            INC DI

            POP DS
            LOOP draw_figure_column_screen

            POP CX
            SUB BX, 08      ; SE LE RESTA LOS 8 QUE SE AVANZAN EN LAS COLUMNAS
            ADD BX, 140     ; SE LE SUMA LOS 320 PARA AVANZAR A LA SIGUIENTE FILA
            LOOP draw_figure_row_screen
            POP CX
            POP AX
            ret
    PDRAWFIGURESCREEN ENDP

    PDRAWO PROC
      PUSH AX
      PUSH CX

      PUSH AX
      PUSH CX
      MOV DI, offset barrao_uno
      CALL PDRAWFIGURESCREEN
      INC AX
      MOV DI, offset barrao_tres
      CALL PDRAWFIGURESCREEN
      POP CX
      POP AX
      
      INC CX
      MOV DI, offset barrao_dos
      CALL PDRAWFIGURESCREEN
      INC AX
      MOV DI, offset barrao_cuatro
      CALL PDRAWFIGURESCREEN

      POP CX
      POP AX  
      RET
    PDRAWO ENDP

    PDRAWX PROC
      PUSH AX
      PUSH AX
      MOV DI, offset barrax_uno
      CALL PDRAWFIGURESCREEN
      INC AX
      MOV DI, offset barrax_dos
      CALL PDRAWFIGURESCREEN
      POP AX

      INC CX
      MOV DI, offset barrax_dos
      CALL PDRAWFIGURESCREEN
      INC AX
      MOV DI, offset barrax_uno
      CALL PDRAWFIGURESCREEN
      POP AX
      RET
    PDRAWX ENDP

    PCREAROBJETO PROC
        make_wall: 
            mov AX, [posXRead]    ; POS X DE LA PARED
            DEC AX
            mov CX, [posYRead]    ; POS Y DE LA PARED
            mov DH, [wallRead]
            call PPUTFIGURE
            JMP end_coordinates
        end_coordinates:
            RET
    PCREAROBJETO ENDP

    PDRAWFIGURE PROC
        MOV BX, 0000
        MOV DL, 08
        MUL DL          ; SE MULTIPLICA AX * 8 PARA OBTENER LA COLUMNA EN LA CUAL SE UBICARA
        ADD BX, AX
        XCHG AX, CX     ; INTERCAMBIA POS X = CX y POS Y = AX
        MUL DL
        XCHG AX, CX     ; POS X = BX    POS Y = CX
        position:
            CMP CX, 0000
            JE end_position
            ADD BX, 140     ; BX SE QUEDA CON LA POSICION FINAL DONDE SE COLOCARA EL GRAFICO
            LOOP position
        end_position:
            MOV CX, 0008
        draw_figure_row:
            PUSH CX
            MOV CX, 0008
        draw_figure_column:
            MOV AL, [DI]

            PUSH DS

            mMoveToVideo
            MOV [BX], AL
            INC BX
            INC DI

            POP DS
            LOOP draw_figure_column

            POP CX
            SUB BX, 08      ; SE LE RESTA LOS 8 QUE SE AVANZAN EN LAS COLUMNAS
            ADD BX, 140     ; SE LE SUMA LOS 320 PARA AVANZAR A LA SIGUIENTE FILA
            LOOP draw_figure_row

            ret
    PDRAWFIGURE ENDP

    PPUTFIGURE PROC
        PUSH AX
        PUSH CX

        MOV DI, offset object_map
        MOV DL, 03          ; 3d
        XCHG AX, CX
        MUL DL              ; POS Y * 3d
        XCHG AX, CX
        ADD DI, AX          ; Hacer row major: offset + x + y * 3d
        ADD DI, CX
        MOV AL, [DI]
        CMP AL, 00
        JNE celda_ocupada
        MOV [DI], DH        ; colocar objeto
        JMP finish_put_figure
        celda_ocupada:
            mPrintTextIntoVideo 0Bh, 00, mensaje_celda_invalida, 1F, 0004
            MOV is_celda_invalida, 01
        finish_put_figure:
            POP CX
            POP AX
            ret
    PPUTFIGURE ENDP

    PMOVDATATOES PROC
      PUSH DX

      MOV DX, @DATA
      MOV ES, DX

      POP DX
      RET
    PMOVDATATOES ENDP

    PMOVESTOVIDEOMODE PROC
      PUSH DX

      MOV DX, 0A000h
      MOV ES, DX

      POP DX
      RET
    PMOVESTOVIDEOMODE ENDP
    
    PCLEANSCREEN PROC
        XOR AX, AX      ; POS X
        XOR CX, CX      ; POS Y
        XOR SI, SI
        XOR BX, BX
        mov CX, 19      ; 25d
        traverse_rows_cls:
            XOR AX, AX      ; POS X
            push CX         ; SE GUARDAN LAS FILAS
            xchg CX, SI     ; CX = POS Y, SI = 25d
            xchg CX, BX     ; CX = NO SIRVE EL VALOR, BX = POS Y
            mov CX, 28      ; 40d
        traverse_columns_cls:
            push CX         ; SE GUARDAN LAS COLUMNAS
            xchg CX, BX     ; CX = POS Y, BX = 40d
            mov DI, offset empty_block
            push AX
            push CX
            call PDRAWFIGURE
            pop CX
            pop AX
            inc AX      ; SE INCREMENTA POSICION EN X
            xchg CX, BX ; EL VALOR DESPUES DE DIBUJAR SE TRASLADA A CX, SE ACTUALIZA POSICION EN Y
                        ; CX = POS EN Y, BX = POS EN Y ANTES DE DIBUJAR
            pop CX      ; SE RECUPERA EL VALOR DE LAS COLUMNAS
            loop traverse_columns_cls
            xchg CX, BX ; EL VALOR DESPUES DE DIBUJAR SE TRASLADA A CX, SE ACTUALIZA POSICION EN Y
            inc CX      ; SE INCREMENTA POSICION EN Y
            xchg CX, SI ; CX = NO SIRVE EL VALOR, SI = POS EN Y
            pop CX
            loop traverse_rows_cls
        finish_clean_screen:
            ret
    PCLEANSCREEN ENDP
END inicio