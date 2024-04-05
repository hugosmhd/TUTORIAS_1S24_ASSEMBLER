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
datosGenerales  db 0ah,0dh, 'Universidad de San Carlos de Guatemala', 0ah,0dh, 'Facultad de Ingenieria', 0ah,0dh, 'Escuela de Ciencias y Sistemas', 0ah,0dh, 'Arquitectura de Computadores y Ensambladores 1', 0ah,0dh, 'Seccion #', 0ah,0dh, 'Nombre del estudiante', 0ah,0dh, 'Carnet', 0ah,0dh, '$'
datosUsac  db 0dh,'Universidad de San Carlos de Guatemala',0dh, 'Facultad de Ingenieria',0dh, 'Escuela de Ciencias y Sistemas',0dh, 'Arquitectura de Computadores y Ensambladores 1',0dh, 'Seccion B',0dh
nameDeveloper db 'Datos del estudiante ejemplar'
carneDeveloper db 'Carnet del estudiante'

;MENSAJES DE CONFIRMACION O ESPERA
mesaje_presionar_enter_continuar       db   '   Presionar ENTER para continuar ','$'

; MENU's
mensaje_menu_principal       db   '   MENU PRINCIPAL ','$'
opciones_menu_principal db 0ah,0dh, '   1. Iniciar juego', 0ah,0dh, '   2. Obtener informacion', 0ah,0dh,  '   3. Salir', '$'

; MENSAJES MENUS
mensaje_inicio_juego db   'Iniciando Juego...','$'

enterOption  db 0ah,0dh, '   Ingresar opcion: ', '$'
enterValue  db 0ah,0dh, '   Ingresar valor: ', '$'

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
            JE opt_informacion
            CMP AL, 33
            JE finish
            JMP initial_menu
        opt_inicio_juego:
            mCleanScreen
            mPrint newLine
            mPrint mensaje_inicio_juego
            mPrint newLine
            mPrint mesaje_presionar_enter_continuar
            pauseUntilEnter
            JMP initial_menu
        opt_informacion:
            mCleanScreen
            mPrint newLine
            mPrint datosGenerales
            mPrint newLine
            mPrint mesaje_presionar_enter_continuar
            pauseUntilEnter
            JMP initial_menu
        finish:
            mTextMode
            mRetControl
    main endp

    

END inicio