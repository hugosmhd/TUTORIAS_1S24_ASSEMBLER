INCLUDE MACROS.ASM

.MODEL small
.STACK
.RADIX 16
.DATA           ;SEGMENTO DE DATOS

;SEPARADORES
separate db '-----------------------------------------------'
separateTwo db '==============================================='

; CHAR ESPECIALES
newLine db 0ah, 0dh, '$'

; DATOS PARA IMPRIMIR EN CONSOLA
datosGenerales  db 0ah,0dh, 'Universidad de San Carlos de Guatemala------------------------------------------i', 0ah,0dh, 'Facultad de Ingenieria', 0ah,0dh, 'Escuela de Ciencias y Sistemas', 0ah,0dh, 'Arquitectura de Computadores y Ensambladores 1', 0ah,0dh, 'Seccion #', 0ah,0dh, 'Nombre del estudiante', 0ah,0dh, 'Carnet', 0ah,0dh, '$'
datosUsac  db 0dh,'Universidad de San Carlos de Guatemala',0dh, 'Facultad de Ingenieria',0dh, 'Escuela de Ciencias y Sistemas',0dh, 'Arquitectura de Computadores y Ensambladores 1',0dh, 'Seccion B',0dh
nameDeveloper db 'Datos del estudiante ejemplar'
carneDeveloper db 'Carnet del estudiante'

;MENSAJES DE CONFIRMACION O ESPERA
mesaje_presionar_enter_continuar       db   '   Presionar ENTER para continuar ','$'

; MENU's
mensaje_menu_principal       db   '   MENU PRINCIPAL ','$'
opciones_menu_principal db 0ah,0dh, '   1. Iniciar juego', 0ah,0dh, '   2. Menu grafico', 0ah,0dh,  '   3. Salir', '$'
mensaje_menu_grafico       db 'MENU GRAFICO'
opciones_menu_grafico       db ' ESC:SALIR            ENTER:SELECCIONAR'
opt1_menu_grafico db 'Iniciar Juego'
opt2_menu_grafico db 'Imprimir Datos'
opt3_menu_grafico db 'Regresar al menu anterior'

; MENSAJES MENUS
mensaje_inicio_juego db   'Iniciando Juego...','$'

enterOption  db 0ah,0dh, '   Ingresar opcion: ', '$'
enterValue  db 0ah,0dh, '   Ingresar valor: ', '$'

; PARA EL MENU GRAFICO
ACTLINE     DB  ?
ACTCOLUMN   DB  ?
FONTCOLOR   DW  ?
MARKLINE    DB  ?
MARKCOLUMN  DB  ?
MARKER      DB  ">"
PIXLINE     DW  ?
PIXCOL      DW  ?
; para pintar un cuadrado en el lienzo
SQCOLOR     DW  ?
SQHEIGHT    DB  ?
SQWIDTH     DW  ?
RECQTY      DW  0000
SPACE      DB  " "

.CODE           ;SEGMENTO DE CODIGO
inicio:
    main proc
        mSetDataOnDs
        mCleanScreen
        mPrint datosGenerales
        mPrint newLine
        mPrint mesaje_presionar_enter_continuar
        pauseUntilEnter

        initial_menu:
            mCleanScreen
            mPrint mensaje_menu_principal
            mPrint newLine
            mPrint opciones_menu_principal
            mPrint newLine
            mPrint enterOption
            mGetKey
            CMP AL, 31
            JE opt_inicio_juego
            CMP AL, 32
            JE opt_menu_grafico
            CMP AL, 33
            JE finish
            JMP initial_menu
        opt_inicio_juego:
            CALL PINICIOJUEGO
            JMP initial_menu
        opt_menu_grafico:
            mCleanScreen
            MOV RECQTY, 0003
            MOV ACTLINE, 2
            MOV ACTCOLUMN, 1
            MOV FONTCOLOR, 0FH

            MOV MARKCOLUMN, 0
            MOV ACTCOLUMN, 1
            CALL PPRINTMENUGRAFICO
            XOR SI, SI
            MOV BP, BX

            CALL PLOOPMENUGRAFICO
            JMP initial_menu

        finish:
            mTextMode
            mRetControl
    main endp

    PPRINTMENUGRAFICO PROC
        CALL PMOVESTOVIDEOMODE
        mVideoMode
        mDivLine 09, 29
        mDivLine 0BBh, 29
        mPrintTextIntoVideo 00, 0C, mensaje_menu_grafico, 0C, 000F
        mPrintTextIntoVideo 02, 01, opt1_menu_grafico, 0D, 000F
        mPrintTextIntoVideo 03, 01, opt2_menu_grafico, 0E, 000F
        mPrintTextIntoVideo 04, 01, opt3_menu_grafico, 19, 000F
        mPrintTextIntoVideo 18, 00, opciones_menu_grafico, 27, 000F
        RET
    PPRINTMENUGRAFICO ENDP

    PINICIOJUEGO PROC
        mCleanScreen
        mPrint newLine
        mPrint mensaje_inicio_juego
        mPrint newLine
        mPrint mesaje_presionar_enter_continuar
        pauseUntilEnter
        RET
    PINICIOJUEGO ENDP

    PREVIEWNUMBERMARKERDOWN PROC
        PUSH AX
        PUSH BX
        MOV AX, SI
        MOV BL, 15
        DIV BL
        CMP AH, 00
        JNE finish_review_marker_down
        MOV MARKLINE, 1
        MOV ACTLINE, 1
        ADD MARKCOLUMN, 0C
        ADD ACTCOLUMN, 0C

        finish_review_marker_down:
            POP BX
            POP AX
            RET
    PREVIEWNUMBERMARKERDOWN ENDP

    PREVIEWNUMBERMARKERUP PROC
        PUSH AX
        PUSH BX
        MOV AX, SI
        MOV BL, 15
        DIV BL
        CMP AH, 00
        JNE finish_review_marker_up
        MOV MARKLINE, 17
        MOV ACTLINE, 16
        SUB MARKCOLUMN, 0C
        SUB ACTCOLUMN, 0C

        finish_review_marker_up:
            POP BX
            POP AX
            RET
    PREVIEWNUMBERMARKERUP ENDP

    PMARKVALUE PROC
        mPrintTextIntoVideo MARKLINE, MARKCOLUMN, MARKER, 1, FONTCOLOR
        RET
    PMARKVALUE ENDP

    PLOOPMENUGRAFICO  PROC
        PUSH AX
        PUSH DX

        MOV AX, SI
        ADD AX, 2
        MOV MARKLINE, AL
        MOV FONTCOLOR, 0A
        CALL PMARKVALUE
        MOV SI, 0001
        MOV ACTCOLUMN, 01
        MOV ACTLINE, 02
        mKeysSelectMenuGrafico
        
        exit_loop_menu_grafico:

            ; POP DI
            POP DX
            POP AX
            RET
    PLOOPMENUGRAFICO  ENDP

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

    CALCPIXELLOC  PROC
      PUSH BX
      
      MOV BX, 140
      MOV AX, PIXLINE
      MUL BX

      ADD AX, PIXCOL
      POP BX
      
      RET
    CALCPIXELLOC ENDP

    DRAWSQUARE  PROC
      PUSH BX
      PUSH CX

      MOV BX, AX
      MOV AX, SQCOLOR

      MOV CX, SQWIDTH

      SQnextLine:
        SQnextPixel:
          MOV ES:[BX], AL
          INC BX
          LOOP SQnextPixel

        INC AH
        CMP AH, SQHEIGHT
        JE SQsalida

        MOV CX, SQWIDTH
        SUB BX, CX
        ADD BX, 140
        JMP SQnextLine

      SQsalida:

      POP CX
      POP BX
      RET
    DRAWSQUARE  ENDP
END inicio