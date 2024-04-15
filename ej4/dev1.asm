INCLUDE MACROS.ASM

.MODEL small
.STACK
.RADIX 16
.DATA           ;SEGMENTO DE DATOS
; DER   00
; IZQ   40
; UP   80
; DOWN   0C0
datosGenerales  db 0ah,0dh, 'Universidad de San Carlos de Guatemala', 0ah,0dh, 'Facultad de Ingenieria', 0ah,0dh, 'Escuela de Ciencias y Sistemas', 0ah,0dh, 'Arquitectura de Computadores y Ensambladores 1', 0ah,0dh, 'Seccion B', 0ah,0dh, 'Hugo Sebastian Martinez Hernandez', 0ah,0dh, '202002793', 0ah,0dh, '$'
datosUsac  db 0dh,'Universidad de San Carlos de Guatemala',0dh, 'Facultad de Ingenieria',0dh, 'Escuela de Ciencias y Sistemas',0dh, 'Arquitectura de Computadores y Ensambladores 1',0dh, 'Seccion B',0dh
nameDeveloper db 'Hugo Sebastian Martinez Hernandez'
carneDeveloper db '202002793'

direction_aceman db 40
aceman_movement db 40
current_aceman db 00
aceman_position_x dw 0000
aceman_position_y dw 0001

ghost_red_movement db 00
ghost_red_x dw 0013
ghost_red_y dw 000A

ghost_skyblue_movement db 40
ghost_skyblue_x dw 0015
ghost_skyblue_y dw 000A

ghost_orange_movement db 80
ghost_orange_x dw 0013
ghost_orange_y dw 000C

ghost_pink_movement db 0C0
ghost_pink_x dw 0015
ghost_pink_y dw 000C

ghost_general_movement db 00
ghost_general_x dw 0013
ghost_general_y dw 000A

ghost_right dw 0005
ghost_left dw 0005
ghost_up dw 0005
ghost_down dw 0005
random dw 0000
random_aux dw 0000

red_ghost   db     00, 00, 00, 28, 28, 28, 00, 00
            db     00, 00, 28, 28, 28, 28, 28, 00
            db     00, 28, 0F, 0F, 28, 0F, 0F, 28
            db     00, 28, 00, 0F, 28, 00, 0F, 28
            db     00, 28, 28, 28, 28, 28, 28, 28
            db     00, 28, 28, 28, 28, 28, 28, 28
            db     00, 28, 28, 28, 28, 28, 28, 28
            db     00, 28, 00, 28, 00, 28, 00, 28

skyblue_ghost   db     00, 00, 00, 34, 34, 34, 00, 00
                db     00, 00, 34, 34, 34, 34, 34, 00
                db     00, 34, 0F, 0F, 34, 0F, 0F, 34
                db     00, 34, 00, 0F, 34, 00, 0F, 34
                db     00, 34, 34, 34, 34, 34, 34, 34
                db     00, 34, 34, 34, 34, 34, 34, 34
                db     00, 34, 34, 34, 34, 34, 34, 34
                db     00, 34, 00, 34, 00, 34, 00, 34

orange_ghost    db     00, 00, 00, 2A, 2A, 2A, 00, 00
                db     00, 00, 2A, 2A, 2A, 2A, 2A, 00
                db     00, 2A, 0F, 0F, 2A, 0F, 0F, 2A
                db     00, 2A, 00, 0F, 2A, 00, 0F, 2A
                db     00, 2A, 2A, 2A, 2A, 2A, 2A, 2A
                db     00, 2A, 2A, 2A, 2A, 2A, 2A, 2A
                db     00, 2A, 2A, 2A, 2A, 2A, 2A, 2A
                db     00, 2A, 00, 2A, 00, 2A, 00, 2A

pink_ghost  db     00, 00, 00, 25, 25, 25, 00, 00
            db     00, 00, 25, 25, 25, 25, 25, 00
            db     00, 25, 0F, 0F, 25, 0F, 0F, 25
            db     00, 25, 00, 0F, 25, 00, 0F, 25
            db     00, 25, 25, 25, 25, 25, 25, 25
            db     00, 25, 25, 25, 25, 25, 25, 25
            db     00, 25, 25, 25, 25, 25, 25, 25
            db     00, 25, 00, 25, 00, 25, 00, 25

aceman_closed_right db     00, 00, 0e, 0e, 0e, 0e, 00, 00
                    db     00, 0e, 0e, 0e, 0e, 0e, 0e, 00
                    db     0e, 0e, 00, 0e, 0e, 0e, 0e, 0e
                    db     0e, 0e, 0e, 0e, 0e, 0e, 0e, 0e
                    db     0e, 0e, 0e, 00, 00, 00, 00, 00
                    db     0e, 0e, 0e, 0e, 0e, 0e, 0e, 0e
                    db     00, 0e, 0e, 0e, 0e, 0e, 0e, 00
                    db     00, 00, 0e, 0e, 0e, 0e, 00, 00

aceman_closed_left  db     00, 00, 0e, 0e, 0e, 0e, 00, 00
                    db     00, 0e, 0e, 0e, 0e, 0e, 0e, 00
                    db     0e, 0e, 0e, 0e, 0e, 00, 0e, 0e
                    db     0e, 0e, 0e, 0e, 0e, 0e, 0e, 0e
                    db     00, 00, 00, 00, 00, 0e, 0e, 0e
                    db     0e, 0e, 0e, 0e, 0e, 0e, 0e, 0e
                    db     00, 0e, 0e, 0e, 0e, 0e, 0e, 00
                    db     00, 00, 0e, 0e, 0e, 0e, 00, 00

aceman_closed_up    db     00, 00, 0e, 0e, 00, 0e, 00, 00
                    db     00, 0e, 0e, 0e, 00, 0e, 0e, 00
                    db     0e, 0e, 0e, 0e, 00, 0e, 0e, 0e
                    db     0e, 0e, 0e, 0e, 00, 0e, 0e, 0e
                    db     0e, 0e, 0e, 0e, 00, 0e, 0e, 0e
                    db     0e, 0e, 00, 0e, 0e, 0e, 0e, 0e
                    db     00, 0e, 0e, 0e, 0e, 0e, 0e, 00
                    db     00, 00, 0e, 0e, 0e, 0e, 00, 00

aceman_closed_down  db     00, 00, 0e, 0e, 0e, 0e, 00, 00
                    db     00, 0e, 0e, 0e, 0e, 0e, 0e, 00
                    db     0e, 0e, 00, 0e, 0e, 0e, 0e, 0e
                    db     0e, 0e, 0e, 0e, 00, 0e, 0e, 0e
                    db     0e, 0e, 0e, 0e, 00, 0e, 0e, 0e
                    db     0e, 0e, 0e, 0e, 00, 0e, 0e, 0e
                    db     00, 0e, 0e, 0e, 00, 0e, 0e, 00
                    db     00, 00, 0e, 0e, 00, 0e, 00, 00

aceman_open_right   db     00, 00, 0e, 0e, 0e, 0e, 0e, 00
                    db     00, 0e, 0e, 0e, 0e, 0e, 0e, 0e
                    db     0e, 0e, 00, 0e, 0e, 0e, 0e, 00
                    db     0e, 0e, 0e, 0e, 0e, 0e, 00, 00
                    db     0e, 0e, 0e, 0e, 0e, 00, 00, 00
                    db     0e, 0e, 0e, 0e, 0e, 0e, 00, 00
                    db     00, 0e, 0e, 0e, 0e, 0e, 0e, 0e
                    db     00, 00, 0e, 0e, 0e, 0e, 0e, 00

aceman_open_left    db     00, 0e, 0e, 0e, 0e, 0e, 00, 00
                    db     0e, 0e, 0e, 0e, 0e, 0e, 0e, 00
                    db     00, 0e, 0e, 0e, 0e, 00, 0e, 0e
                    db     00, 00, 0e, 0e, 0e, 0e, 0e, 0e
                    db     00, 00, 00, 0e, 0e, 0e, 0e, 0e
                    db     00, 00, 0e, 0e, 0e, 0e, 0e, 0e
                    db     0e, 0e, 0e, 0e, 0e, 0e, 0e, 00
                    db     00, 0e, 0e, 0e, 0e, 0e, 00, 00

aceman_open_up  db     00, 0e, 00, 00, 00, 00, 0e, 00
                db     0e, 0e, 0e, 00, 00, 00, 0e, 0e
                db     0e, 0e, 0e, 0e, 00, 0e, 0e, 0e
                db     0e, 0e, 0e, 0e, 0e, 0e, 0e, 0e
                db     0e, 0e, 0e, 0e, 0e, 0e, 0e, 0e
                db     0e, 0e, 00, 0e, 0e, 0e, 0e, 0e
                db     00, 0e, 0e, 0e, 0e, 0e, 0e, 00
                db     00, 00, 0e, 0e, 0e, 0e, 00, 00

aceman_open_down    db     00, 00, 0e, 0e, 0e, 0e, 00, 00
                    db     00, 0e, 0e, 0e, 0e, 0e, 0e, 00
                    db     0e, 0e, 00, 0e, 0e, 0e, 0e, 0e
                    db     0e, 0e, 0e, 0e, 0e, 0e, 0e, 0e
                    db     0e, 0e, 0e, 0e, 0e, 0e, 0e, 0e
                    db     0e, 0e, 0e, 0e, 00, 0e, 0e, 0e
                    db     0e, 0e, 0e, 00, 00, 00, 0e, 0e
                    db     00, 0e, 00, 00, 00, 00, 0e, 00

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
            db     00, 00, 01, 01, 01, 01, 01, 01
            db     00, 00, 01, 01, 01, 01, 01, 01
            db     00, 00, 01, 01, 01, 01, 01, 01
            db     00, 00, 01, 01, 01, 01, 01, 01
            db     00, 00, 00, 00, 00, 00, 00, 00
            db     00, 00, 00, 00, 00, 00, 00, 00

wall_six    db     00, 00, 00, 00, 00, 00, 00, 00
            db     00, 00, 00, 00, 00, 00, 00, 00
            db     01, 01, 01, 01, 01, 01, 00, 00
            db     01, 01, 01, 01, 01, 01, 00, 00
            db     01, 01, 01, 01, 01, 01, 00, 00
            db     01, 01, 01, 01, 01, 01, 00, 00
            db     00, 00, 00, 00, 00, 00, 00, 00
            db     00, 00, 00, 00, 00, 00, 00, 00

wall_seven  db     00, 00, 01, 01, 01, 01, 00, 00
            db     00, 00, 01, 01, 01, 01, 00, 00
            db     00, 00, 01, 01, 01, 01, 00, 00
            db     00, 00, 01, 01, 01, 01, 00, 00
            db     00, 00, 01, 01, 01, 01, 00, 00
            db     00, 00, 01, 01, 01, 01, 00, 00
            db     00, 00, 00, 00, 00, 00, 00, 00
            db     00, 00, 00, 00, 00, 00, 00, 00

wall_eight  db     00, 00, 00, 00, 00, 00, 00, 00
            db     00, 00, 00, 00, 00, 00, 00, 00
            db     00, 00, 01, 01, 01, 01, 00, 00
            db     00, 00, 01, 01, 01, 01, 00, 00
            db     00, 00, 01, 01, 01, 01, 00, 00
            db     00, 00, 01, 01, 01, 01, 00, 00
            db     00, 00, 01, 01, 01, 01, 00, 00
            db     00, 00, 01, 01, 01, 01, 00, 00

wall_nine   db     00, 00, 00, 00, 00, 00, 00, 00
            db     00, 00, 00, 00, 00, 00, 00, 00
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

wall_thirteen   db     00, 00, 00, 00, 00, 00, 00, 00
                db     00, 00, 00, 00, 00, 00, 00, 00
                db     00, 00, 01, 01, 01, 01, 00, 00
                db     00, 00, 01, 01, 01, 01, 00, 00
                db     00, 00, 01, 01, 01, 01, 00, 00
                db     00, 00, 01, 01, 01, 01, 00, 00
                db     00, 00, 00, 00, 00, 00, 00, 00
                db     00, 00, 00, 00, 00, 00, 00, 00

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
ace_dot db     00, 00, 00, 00, 00, 00, 00, 00
        db     00, 00, 00, 00, 00, 00, 00, 00
        db     00, 00, 00, 00, 00, 00, 00, 00
        db     00, 00, 00, 0F, 0F, 00, 00, 00
        db     00, 00, 00, 0F, 0F, 00, 00, 00
        db     00, 00, 00, 00, 00, 00, 00, 00
        db     00, 00, 00, 00, 00, 00, 00, 00
        db     00, 00, 00, 00, 00, 00, 00, 00

power_dot   db     00, 00, 00, 00, 00, 00, 00, 00
            db     00, 1C, 1C, 1C, 1C, 1C, 1C, 00
            db     00, 1C, 1C, 1C, 1C, 1C, 1C, 00
            db     00, 1C, 1C, 0F, 0F, 1C, 1C, 00
            db     00, 1C, 1C, 0F, 0F, 1C, 1C, 00
            db     00, 1C, 1C, 1C, 1C, 1C, 1C, 00
            db     00, 1C, 1C, 1C, 1C, 1C, 1C, 00
            db     00, 00, 00, 00, 00, 00, 00, 00

lives_figure    db     00, 00, 00, 00, 00, 00, 00, 00
                db     00, 00, 00, 00, 00, 00, 00, 00
                db     00, 00, 28, 28, 00, 28, 28, 00
                db     00, 28, 28, 28, 28, 28, 28, 28
                db     00, 28, 28, 28, 28, 28, 28, 28
                db     00, 00, 28, 28, 28, 28, 28, 00
                db     00, 00, 00, 28, 28, 28, 00, 00
                db     00, 00, 00, 00, 28, 00, 00, 00

portal  db     00, 00, 00, 00, 00, 00, 00, 00
        db     00, 00, 00, 00, 00, 00, 00, 00
        db     00, 00, 00, 00, 00, 00, 00, 00
        db     00, 00, 00, 00, 00, 00, 00, 00
        db     00, 00, 00, 00, 00, 00, 00, 00
        db     00, 00, 00, 00, 00, 00, 00, 00
        db     00, 00, 00, 00, 00, 00, 00, 00
        db     00, 00, 00, 00, 00, 00, 00, 00

level db 01
lives db 03
points dw 0000
dotValue dw 0005
powerDotValue dw 0000
ghostValue dw 0064
pauseMode db 00

object_map db 3e8 dup (0)   ;25x40
first_wall_x dw 0000h   ; 1
last_wall_x dw 0027h    ; 39
first_wall_y dw 0001h    ; 1
last_wall_y dw 0017h    ; 23

msgPointsAward db 'Puntos a otorgar:'
msgAcedots db 'ace-dots: '
msgPowerdot db 'power-dots:'
msgGhosts db 'fantasmas:'
msgLevel db 'Nivel 1'
msgPoints db 'Puntos: '
msgLives db 'Vidas: '
msgPlayerName db 'Jugador: '
msgDeveloper db 'Desarrollador: '
msgNameDeveloper db 'Nombre: Hugo Sebastian Martinez'
msgCardDeveloper db 'Carnet: 202002793'
msgPause db ' ESC:CONTINUAR    PAUSA    ENTER:SALIR'
msgWin db ' Has ganado ENTER para continuar'
msgLost db ' Has perdido ENTER para continuar'
msgInitialLevelKey db ' Presionar ENTER para empezar '
mesaje_presionar_enter_continuar       db   '   Presionar ENTER para continuar ','$'

totalAcedots dw 00
timePlayed db '00:00:00'
total_time dw 0000
second_fraction db 00
seconds db 00
minutes db 00

timePowerDot db '00:00'
second_fraction_power db 00
seconds_power db 00

; CAMPOS de JUEGO
tiempo               db   2 dup (0)
puntos               db   2 dup (0)
jugador              db   2 dup (0)
inputBytes db ?
numberInt dw 0000
recoveredStr db 6 dup (24)

userLogueado      dw   0000

newLine db 0ah, 0dh, '$'

.CODE           ;SEGMENTO DE CODIGO
inicio:
    main proc
        mSetDataOnDs
        mCleanScreen
        mPrint datosGenerales
        mPrint newLine
        mPrint mesaje_presionar_enter_continuar
        pauseUntilEnter

        start_game:
            mVideoMode
            CALL PCLEANSCREEN

            CALL PPRINTGHOSTS

            CALL PFILLACEDOTS
            CALL PFILLLIVES
            MOV BX, points
            MOV numberInt, BX
            mNumToStringPoints
            XOR BX, BX
            CALL drawPoints

            CALL PPAINTMAP
            MOV AX, aceman_position_x
            MOV CX, aceman_position_y
            CALL PDRAWACEMAN
            mDrawText timePlayed, 0, 1F, 40
            pauseUntilEnter
        game_aceman:
            CMP pauseMode, 00
            JE game_mode
            CMP pauseMode, 01
            JE pause_mode
            CMP pauseMode, 03
            JE lost_life
            CMP pauseMode, 04
            JE exit_game
            
            JMP finish
        lost_life:
            CMP lives, 00
            JE you_lost
            CALL PDRAWACEMAN
            MOV AX, ghost_red_x
            MOV CX, ghost_red_y
            MOV DI, offset red_ghost
            CALL PDRAWFIGURESCREEN
            
            MOV AX, ghost_skyblue_x
            MOV CX, ghost_skyblue_y
            MOV DI, offset skyblue_ghost
            CALL PDRAWFIGURESCREEN
            
            MOV AX, ghost_orange_x
            MOV CX, ghost_orange_y
            MOV DI, offset orange_ghost
            CALL PDRAWFIGURESCREEN
            
            MOV AX, ghost_pink_x
            MOV CX, ghost_pink_y
            MOV DI, offset pink_ghost
            CALL PDRAWFIGURESCREEN
            MOV pauseMode, 00
            pauseUntilEnter
            JMP game_aceman
        you_lost:
            MOV pauseMode, 05
            CALL PCLEANSCREEN
            CALL PSCREENPAUSE
            pauseUntilEnter
            JMP exit_game
        game_mode:
            CALL PVERIFYLOSE
            CMP pauseMode, 03
            JE lost_life
            CALL PDRAWACEMAN

            CALL PPRINTGHOSTS
            
            CMP totalAcedots, 0000
            JE next_level

            CALL delay
            CALL PCLEANGHOSTS

            CALL input
            MOV AX, aceman_position_x
            MOV CX, aceman_position_y
            call PMOVEACEMAN
            CALL PVERIFYLOSE
            CMP pauseMode, 03
            JE lost_life

            JMP game_aceman
            
        pause_mode:
            CALL PCLEANSCREEN
            CALL PSCREENPAUSE
            mKeysPause
            
            JMP game_aceman
        next_level:
            INC level
            CMP level, 01
            JE you_win
        you_win:
            MOV pauseMode, 06
            CALL PCLEANSCREEN
            CALL PSCREENPAUSE
            pauseUntilEnter
            JMP exit_game
        exit_game:
            mTextMode
            MOV AX, points
            MOV [puntos], AH
            MOV [puntos+1], AL
            MOV AX, total_time
            MOV [tiempo], AH
            MOV [tiempo+1], AL
            mPrint newLine
            ; pauseUntilEnter
            MOV AX, points
            JMP return_menus
            JMP return_menus
        return_menus:
            JMP finish
        finish:
            mTextMode
            mRetControl
    main endp
    
    ;LISTO
    PPRINTGHOSTS PROC
        MOV AX, ghost_red_x
        MOV CX, ghost_red_y
        MOV DI, offset red_ghost
        CALL PDRAWFIGURESCREEN
        
        MOV AX, ghost_skyblue_x
        MOV CX, ghost_skyblue_y
        MOV DI, offset skyblue_ghost
        CALL PDRAWFIGURESCREEN
        
        MOV AX, ghost_orange_x
        MOV CX, ghost_orange_y
        MOV DI, offset orange_ghost
        CALL PDRAWFIGURESCREEN
        
        MOV AX, ghost_pink_x
        MOV CX, ghost_pink_y
        MOV DI, offset pink_ghost
        CALL PDRAWFIGURESCREEN
        RET
    PPRINTGHOSTS ENDP
    ;LISTO
    PMOVESTOVIDEOMODE PROC
      PUSH DX

      MOV DX, 0A000h
      MOV ES, DX

      POP DX
      RET
    PMOVESTOVIDEOMODE ENDP

    ;LISTO
    PVERIFYLOSE PROC

        is_lost:
            MOV AX, aceman_position_x ; POS X
            MOV CX, aceman_position_y ; POS Y
            JMP verify_red_ghost_lost
        verify_red_ghost_lost:
            CMP ghost_red_x, AX
            JNE verify_skyblue_ghost_lost
            CMP ghost_red_y, CX
            JNE verify_skyblue_ghost_lost
            CALL PCLEANLIVES
            MOV pauseMode, 03
            ; pauseUntilEnter
            JMP change_coordinates_ghost
        verify_skyblue_ghost_lost:
            CMP ghost_skyblue_x, AX
            JNE verify_orange_ghost_lost
            CMP ghost_skyblue_y, CX
            JNE verify_orange_ghost_lost
            CALL PCLEANLIVES
            MOV pauseMode, 03
            JMP change_coordinates_ghost
        verify_orange_ghost_lost:
            CMP ghost_orange_x, AX
            JNE verify_pink_ghost_lost
            CMP ghost_orange_y, CX
            JNE verify_pink_ghost_lost
            CALL PCLEANLIVES
            MOV pauseMode, 03
            JMP change_coordinates_ghost
        verify_pink_ghost_lost:
            CMP ghost_pink_x, AX
            JNE finish_verify_lose
            CMP ghost_pink_y, CX
            JNE finish_verify_lose
            CALL PCLEANLIVES
            MOV pauseMode, 03
            JMP change_coordinates_ghost
        change_coordinates_ghost:
            MOV ghost_red_movement, 00
            MOV ghost_red_x, 0013
            MOV ghost_red_y, 000A

            MOV ghost_skyblue_movement, 40
            MOV ghost_skyblue_x, 0015
            MOV ghost_skyblue_y, 000A

            MOV ghost_orange_movement, 80
            MOV ghost_orange_x, 0013
            MOV ghost_orange_y, 000C

            MOV ghost_pink_movement, 0C0
            MOV ghost_pink_x, 0015
            MOV ghost_pink_y, 000C
            JMP finish_verify_lose
        finish_verify_lose:
            RET
    PVERIFYLOSE ENDP

    ;LISTO
    PCLEANGHOSTS PROC

        MOV DI, offset empty_block
        MOV AX, aceman_position_x
        MOV CX, aceman_position_y
        CALL PDRAWFIGURESCREEN
        ; CALL PREPAINTFIGURE

        ; MOV DI, offset empty_block
        ; MOV AX, ghost_red_x
        ; MOV CX, ghost_red_y
        ; CALL PDRAWFIGURESCREEN
        ; CALL PREPAINTFIGURE
            
        ; MOV DI, offset empty_block
        ; MOV AX, ghost_skyblue_x
        ; MOV CX, ghost_skyblue_y
        ; CALL PDRAWFIGURESCREEN
        ; CALL PREPAINTFIGURE

        ; MOV DI, offset empty_block
        ; MOV AX, ghost_orange_x
        ; MOV CX, ghost_orange_y
        ; CALL PDRAWFIGURESCREEN
        ; CALL PREPAINTFIGURE
            
        ; MOV DI, offset empty_block
        ; MOV AX, ghost_pink_x
        ; MOV CX, ghost_pink_y
        ; CALL PDRAWFIGURESCREEN
        ; CALL PREPAINTFIGURE
        RET
    PCLEANGHOSTS ENDP

    ; LISTO
    PCLEANNUMBERSTR PROC
        PUSH SI
        XOR SI, SI
        clean_dup_str:
            MOV recoveredStr[SI], 24
            INC SI
            CMP SI, 0007
            JNE clean_dup_str
        POP SI
        RET

    PCLEANNUMBERSTR ENDP

    ; LISTO
    PSCREENPAUSE PROC
        MOV AX, 000B
        MOV CX, 0005
        mDrawText msgPointsAward, 0, 0, 28
        MOV AX, 0002
        MOV CX, 0002
        MOV DI, offset ace_dot
        CALL PDRAWFIGURESCREEN
        mDrawText msgAcedots, 2, 4, 1B
        
        CALL PCLEANNUMBERSTR
        MOV BX, dotValue
        MOV numberInt, BX
        mNumToStringPoints
        MOV BL, 02
        MOV BH, 0E
        CALL drawPoints

        MOV AX, 0002
        MOV CX, 0004
        MOV DI, offset power_dot
        CALL PDRAWFIGURESCREEN
        mDrawText msgPowerdot, 4, 4, 1B

        CALL PCLEANNUMBERSTR
        MOV BX, powerDotValue
        MOV numberInt, BX
        mNumToStringPoints
        MOV BL, 04
        MOV BH, 10
        CALL drawPoints

        MOV AX, 0002
        MOV CX, 0006
        MOV DI, offset skyblue_ghost
        CALL PDRAWFIGURESCREEN
        mDrawText msgGhosts, 6, 4, 1B

        CALL PCLEANNUMBERSTR
        MOV BX, ghostValue
        MOV numberInt, BX
        mNumToStringPoints
        MOV BL, 06
        MOV BH, 0F
        CALL drawPoints
        
        mDrawText msgLevel, 8, 0, 2F

        mDrawText msgPoints, 0A, 4, 1B
        CALL PCLEANNUMBERSTR
        MOV BX, points
        MOV numberInt, BX
        mNumToStringPoints
        MOV BL, 0A
        MOV BH, 0C
        CALL drawPoints

        mDrawText msgLives, 0C, 4, 1B
        CALL PFILLLIVESPAUSE
        mDrawText msgPlayerName, 0E, 4, 1B
        MOV BX, [userLogueado]

        mDrawText msgDeveloper, 10, 0, 2C
        mDrawText msgNameDeveloper, 12, 4, 1B
        mDrawText msgCardDeveloper, 14, 4, 1B

        CMP pauseMode, 01
        JE print_pause
        CMP pauseMode, 05
        JE print_lost
        CMP pauseMode, 06
        JE print_win

        mDrawText msgInitialLevelKey, 17, 0, 20
        pauseUntilEnter
        RET
        print_pause:
            mDrawText msgPause, 17, 0, 28
            RET
        print_lost:
            mDrawText msgLost, 17, 0, 28
            RET
        print_win:
            mDrawText msgWin, 17, 0, 28
            RET
    PSCREENPAUSE ENDP

    ; LISTO
    PGETFIGURE PROC
        PUSH AX
        PUSH CX

        MOV DI, offset object_map
        MOV DL, 28          ; POS Y * 40d
        XCHG AX, CX
        MUL DL
        XCHG AX, CX
        ADD DI, AX          ; ROW MAJOR: offset + POS X + POS Y * 40d
        ADD DI, CX
        MOV DL, [DI]

        POP CX
        POP AX
        ret
    PGETFIGURE ENDP

    ; LISTO
    PGETPOSITION PROC
        PUSH AX
        PUSH CX

        XOR BX, BX

        MOV DL, 28          ; POS Y * 40d
        XCHG AX, CX
        MUL DL
        XCHG AX, CX
        ADD BX, AX          ; ROW MAJOR: offset + POS X + POS Y * 40d
        ADD BX, CX

        POP CX
        POP AX
        ret
    PGETPOSITION ENDP
    
    ; LISTO
    PPUTFIGURE PROC
        PUSH AX
        PUSH CX

        MOV DI, offset object_map
        MOV DL, 28          ; 40d
        XCHG AX, CX
        MUL DL              ; POS Y * 40d
        XCHG AX, CX
        ADD DI, AX          ; Hacer row major: offset + x + y * 40d
        ADD DI, CX
        MOV [DI], DH        ; colocar objeto

        POP CX
        POP AX
        ret
    PPUTFIGURE ENDP
    
    ; LISTO
    PCLEANMAP PROC
        XOR CX, CX
        XOR SI, SI
        mov CX, 03E8      ; 00d
        clean_map:
            MOV object_map[SI], 00
            INC SI
            LOOP clean_map
        ret
    PCLEANMAP ENDP

    ; LISTO
    PFILLACEDOTS PROC
        XOR AX, AX
        XOR CX, CX
        XOR SI, SI
        XOR BX, BX
        XOR DX, DX
        mov CX, first_wall_y      ; 00d
        fill_rows:
            PUSH CX
            MOV AX, first_wall_x
        fill_points:
            CMP AX, last_wall_x
            JE back_rows

            CALL PGETPOSITION
            CMP BX, 017C
            JE fill_empty
            CMP BX, 01A3
            JE fill_empty
            CMP BX, 01A4
            JE fill_empty
            CMP BX, 01A5
            JE fill_empty
            CMP BX, 01CB
            JE fill_empty
            CMP BX, 01CC
            JE fill_empty
            CMP BX, 01CD
            JE fill_empty
            CMP BX, 01F3
            JE fill_empty
            CMP BX, 01F4
            JE fill_empty
            CMP BX, 01F5
            JE fill_empty

            CALL PGETFIGURE

            CMP DL, 00
            JNE next_point

            MOV DH, 10h
            CALL PPUTFIGURE
            INC totalAcedots
            JMP next_point
        fill_empty:
            MOV DH, 00
            CALL PPUTFIGURE
            JMP next_point
        next_point:
            INC AX
            JMP fill_points
        back_rows:
            POP CX
            INC CX
            CMP CX, last_wall_y
            JE finish_fill_ace_dots
            JMP fill_rows
        finish_fill_ace_dots:
            ret
    PFILLACEDOTS ENDP
    
    ; LISTO
    PREPAINTFIGURE PROC
        PUSH AX
        CALL PGETFIGURE
        POP AX
        CMP DL, 00
        JE exit_repaint
        PUSH AX
        mov DI, offset wall_one
        DEC DL
        MOV AX, 0040
        MUL DL
        ADD DI, AX
        POP AX
        CALL PDRAWFIGURESCREEN
        exit_repaint:
            ret
    PREPAINTFIGURE ENDP

    ; LISTO
    PPAINTMAP PROC
        XOR AX, AX      ; POS X
        XOR CX, CX      ; POS Y
        XOR SI, SI
        XOR BX, BX
        mov DI, offset object_map
        mov CX, 19      ; 25d
        traverse_rows:
            XOR AX, AX      ; POS X
            push CX         ; SE GUARDAN LAS FILAS
            xchg CX, SI     ; CX = POS Y, SI = 25d
            xchg CX, BX     ; CX = NO SIRVE EL VALOR, BX = POS Y
            mov CX, 28      ; 40d
        traverse_columns:
            push CX         ; SE GUARDAN LAS COLUMNAS
            xchg CX, BX     ; CX = POS Y, BX = 40d
            call PGETFIGURE
            CMP DL, 12
            JBE compare_figure
            MOV DL, 13
            JMP compare_figure

            jmp loop_cols
        compare_figure:
            CMP DL, 00
            JE loop_cols

            PUSH AX

            mov DI, offset wall_one
            DEC DL
            MOV AX, 0040
            MUL DL
            ADD DI, AX
            POP AX
            JMP draw_fig

        draw_fig:
            push AX
            push CX
            call PDRAWFIGURE
            pop CX
            pop AX
        loop_cols:
            inc AX      ; SE INCREMENTA POSICION EN X
            xchg CX, BX ; EL VALOR DESPUES DE DIBUJAR SE TRASLADA A CX, SE ACTUALIZA POSICION EN Y
                        ; CX = POS EN Y, BX = POS EN Y ANTES DE DIBUJAR
            pop CX      ; SE RECUPERA EL VALOR DE LAS COLUMNAS
            loop traverse_columns
            xchg CX, BX ; EL VALOR DESPUES DE DIBUJAR SE TRASLADA A CX, SE ACTUALIZA POSICION EN Y
            inc CX      ; SE INCREMENTA POSICION EN Y
            xchg CX, SI ; CX = NO SIRVE EL VALOR, SI = POS EN Y
            pop CX
            loop traverse_rows
        finish_paint_map:
            ret
    PPAINTMAP ENDP
    
    ; LISTO
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

    ; LISTO
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

    ; LISTO
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
    
    ; LISTO
    PFILLLIVES PROC
        CMP lives, 00
        JE exit_lives
        XOR CX, CX
        MOV CL, lives
        MOV AX, 14
        draw_lives:
            PUSH CX
            MOV CX, 00
            MOV DI, OFFSET lives_figure
            CALL PDRAWFIGURESCREEN
            ; MOV DH, 12
            ; CALL PPUTFIGURE
            INC AX
            POP CX
            LOOP draw_lives
        exit_lives:
            RET
    PFILLLIVES ENDP

    ; LISTO
    PCLEANLIVES PROC
        CMP lives, 00
        JE exit_clean_lives
        XOR CX, CX
        ; MOV CL, lives
        MOV AX, 14
        ADD AL, lives
        DEC AX
        MOV DI, OFFSET empty_block
        CALL PDRAWFIGURESCREEN
        DEC lives

        ; MOV ghost_red_movement, 00
        ; MOV ghost_red_x, 0013
        ; MOV ghost_red_y, 000A

        ; MOV ghost_skyblue_movement, 40
        ; MOV ghost_skyblue_x, 0015
        ; MOV ghost_skyblue_y, 000A

        ; MOV ghost_orange_movement, 80
        ; MOV ghost_orange_x, 0013
        ; MOV ghost_orange_y, 000C

        ; MOV ghost_pink_movement, 0C0
        ; MOV ghost_pink_x, 0015
        ; MOV ghost_pink_y, 000C

        ; draw_lives:
        ;     PUSH CX
        ;     MOV CX, 00
        ;     MOV DH, 12
        ;     CALL PPUTFIGURE
        ;     INC AX
        ;     POP CX
        ;     LOOP draw_lives
        exit_clean_lives:
            RET
    PCLEANLIVES ENDP

    ; LISTO
    PFILLLIVESPAUSE PROC
        CMP lives, 00
        JE exit_lives
        XOR CX, CX
        MOV CL, lives
        MOV AX, 0B
        draw_lives:
            PUSH CX
            MOV CX, 000C
            MOV DI, offset lives_figure
            PUSH AX
            CALL PDRAWFIGURESCREEN
            POP AX
            INC AX
            POP CX
            LOOP draw_lives
        exit_lives:
            RET
    PFILLLIVESPAUSE ENDP

    ; LISTO
    PMOVEACEMAN PROC
        MOV DH, [aceman_movement]       ; SE LE PASA EL MOVIMIENTO ACTUAL DEL ACEMAN
        is_right:
            CMP DH, 00      ; SE VERIFICA SI ES DERECHA
            JNE is_left
            INC AX
            CALL PGETFIGURE
            CMP AX, last_wall_x    ; SI ES EL FINAL DE PARED NO SE PUEDE MOVER
            JAE back_right
            CMP DL, 00      ; SI ES ESPACIO VACIO SIMPLEMENTE SE MUEVE
            JE move_right
            CMP DL, 10      ; SI ES ACEDOT SE MUEVE Y REFRESCA EL MAPA
            JE refresh_map
            JMP back_right
        move_right:            
            MOV [aceman_position_x], AX
            ret
        back_right:
            DEC AX
            ret
        is_left:
            CMP DH, 40      ; SE VERIFICA SI ES IZQUIERDA
            JNE is_up
            DEC AX
            CALL PGETFIGURE
            CMP AX, first_wall_x
            JL back_left
            CMP DL, 00      ; SI ES ESPACIO VACIO SIMPLEMENTE SE MUEVE
            JE move_left
            CMP DL, 10      ; SI ES ACEDOT SE MUEVE Y REFRESCA EL MAPA
            JE refresh_map
            JMP back_left
        move_left:
            MOV [aceman_position_x], AX
            ret
        back_left:
            INC AX
            ret
        is_up:
            CMP DH, 80      ; SE VERIFICA SI ES ARRIBA
            JNE is_down
            DEC CX
            CALL PGETFIGURE
            MOV BX, first_wall_y
            DEC BX
            CMP CX, BX
            JBE back_up
            CMP DL, 00      ; SI ES ESPACIO VACIO SIMPLEMENTE SE MUEVE
            JE move_up
            CMP DL, 10      ; SI ES ACEDOT SE MUEVE Y REFRESCA EL MAPA
            JE refresh_map
            JMP back_up
        move_up:
            MOV [aceman_position_y], CX
            ret
        back_up:
            INC CX
            ret
        is_down:
            CMP DH, 0C0     ; SE VERIFICA SI ES ABAJO
            JNE finish_move
            INC CX
            CALL PGETFIGURE
            CMP CX, last_wall_y
            JAE back_down
            CMP DL, 00      ; SI ES ESPACIO VACIO SIMPLEMENTE SE MUEVE
            JE move_down
            CMP DL, 10      ; SI ES ACEDOT SE MUEVE Y REFRESCA EL MAPA
            JE refresh_map
            JMP back_down
        move_down:
            CMP DL, 00
            JNE back_down
            MOV [aceman_position_y], CX
            ret
        back_down:
            DEC CX
            ret
        refresh_map:
            PUSH AX
            MOV AX, dotValue
            ADD points, AX
            DEC totalAcedots
            MOV BX, points
            MOV numberInt, BX
            mNumToStringPoints
            XOR BX, BX
            CALL drawPoints
            POP AX
            MOV DH, 00
            CALL PPUTFIGURE
            MOV [aceman_position_x], AX
            MOV [aceman_position_y], CX
            ret
        finish_move:
            ret
    PMOVEACEMAN ENDP

    ; LISTO
    input PROC
        start_input:
            mov AH, 01
            int 16
            jz finish_input
            CMP pauseMode, 00
            JE game_keys
        
        game_keys:
            
            cmp AH, 4B
            je change_direction_left
            cmp AH, 4D
            je change_direction_right
            cmp AH, 48
            je change_direction_up
            cmp AH, 50
            je change_direction_down
            CMP AH, 01
            JE change_pause_mode_game
            
            jmp clear_buffer
            change_direction_left:
                mov AH, 00
                int 16
                MOV AX, aceman_position_x
                DEC AX
                MOV CX, aceman_position_y
                CALL PGETFIGURE
                CMP DL, 00      ; SI ES ESPACIO VACIO SIMPLEMENTE SE MUEVE
                JE change_left_ace
                CMP DL, 10      ; SI ES ACEDOT SE MUEVE Y REFRESCA EL MAPA
                JE change_left_ace
                CMP DL, 11      ; SI ES POWER DOT SE MUEVE Y REFRESCA EL MAPA
                JE change_left_ace
                CMP DL, 30      ; SI ES PORTAL
                JAE change_left_ace
                jmp finish_input
            change_left_ace:
                mov [direction_aceman], 40
                mov [aceman_movement], 40
                jmp finish_input
            change_direction_right:
                mov AH, 00
                int 16
                MOV AX, aceman_position_x
                INC AX
                MOV CX, aceman_position_y
                CALL PGETFIGURE
                CMP DL, 00      ; SI ES ESPACIO VACIO SIMPLEMENTE SE MUEVE
                JE change_right_ace
                CMP DL, 10      ; SI ES ACEDOT SE MUEVE Y REFRESCA EL MAPA
                JE change_right_ace
                CMP DL, 11      ; SI ES POWER DOT SE MUEVE Y REFRESCA EL MAPA
                JE change_right_ace
                CMP DL, 30      ; SI ES PORTAL
                JAE change_right_ace
                jmp finish_input
            change_right_ace:
                mov [direction_aceman], 00
                mov [aceman_movement], 00
                jmp finish_input
            change_direction_up:
                mov AH, 00
                int 16
                MOV AX, aceman_position_x
                MOV CX, aceman_position_y
                DEC CX
                CALL PGETFIGURE
                CMP DL, 00      ; SI ES ESPACIO VACIO SIMPLEMENTE SE MUEVE
                JE change_up_ace
                CMP DL, 10      ; SI ES ACEDOT SE MUEVE Y REFRESCA EL MAPA
                JE change_up_ace
                CMP DL, 11      ; SI ES POWER DOT SE MUEVE Y REFRESCA EL MAPA
                JE change_up_ace
                CMP DL, 30      ; SI ES PORTAL
                JAE change_up_ace
                jmp finish_input
            change_up_ace:
                mov [direction_aceman], 80
                mov [aceman_movement], 80
                jmp finish_input
            change_direction_down:
                mov AH, 00
                int 16
                MOV AX, aceman_position_x
                MOV CX, aceman_position_y
                INC CX
                CALL PGETFIGURE
                CMP DL, 00      ; SI ES ESPACIO VACIO SIMPLEMENTE SE MUEVE
                JE change_down_ace
                CMP DL, 10      ; SI ES ACEDOT SE MUEVE Y REFRESCA EL MAPA
                JE change_down_ace
                CMP DL, 11      ; SI ES POWER DOT SE MUEVE Y REFRESCA EL MAPA
                JE change_down_ace
                CMP DL, 30      ; SI ES PORTAL
                JAE change_down_ace
                jmp finish_input
            change_down_ace:
                mov [direction_aceman], 0C0
                mov [aceman_movement], 0C0
                jmp finish_input
            
            change_pause_mode_game:
                MOV AH, 00
                INT 16
                MOV pauseMode, 01
                JMP finish_input
        clear_buffer:
            mov AH, 00
		    int 16
        finish_input:
            ret
    input ENDP
        
    PDRAWACEMAN PROC
        MOV AX, aceman_position_x ; POS X
        MOV CX, aceman_position_y ; POS Y

        MOV DL, [current_aceman]
        CMP DL, 0FF             ; SE COMPARA PARA VER SI ES BOCA ABIERTA
        JE aceman_open_mouth
        MOV DI, offset aceman_closed_right
        MOV DH, 00      ; SE LE PASA 00 PARA NO TENER PROBLEMAS
        MOV DL, [direction_aceman]  ; DIRECCION ACTUAL DEL ACEMAN
        ADD DI, DX      ; SE LE SUMA A DI LA DIRECCION DEL ACEMAN
        JMP draw_pacman
        aceman_open_mouth:
            MOV DI, offset aceman_open_right
            MOV DH, 00      ; SE LE PASA 00 PARA NO TENER PROBLEMAS
            MOV DL, [direction_aceman]  ; DIRECCION ACTUAL DEL ACEMAN
            ADD DI, DX       ; SE LE SUMA A DI LA DIRECCION DEL ACEMAN
            JMP draw_pacman
        draw_pacman:
            CALL PDRAWFIGURE
            MOV DL, [current_aceman]
            NOT DL      ; SE CAMBIA DE BOCA ABIERTA A CERRADA Y VICEVERSA
            MOV [current_aceman], DL
            ret
    PDRAWACEMAN ENDP
        
    delay PROC
        MOV BP, 0015
        cycle_b:
            MOV SI, 02710
        cycle_a:
            DEC SI
            CMP SI, 00
            JNE cycle_a
            mDrawText timePlayed, 0, 1F, 40
            CALL chronometerGame
            mDrawText timePowerDot, 18, 22, 40
            DEC BP
            CMP BP, 00
            JNE cycle_b
            ret
    delay ENDP
    
    PMOVDATATOES PROC
      PUSH DX

      MOV DX, @DATA
      MOV ES, DX

      POP DX
      RET
    PMOVDATATOES ENDP

    chronometerGame PROC
        INC second_fraction
        CMP second_fraction, 64
        JAE add_second
        JMP exit_chronometer_game
        add_second:
            MOV second_fraction, 00
            INC seconds
            INC total_time
            CMP seconds, 3C
            JAE add_minute
            JMP exit_chronometer_game
        add_minute:
            MOV seconds, 00
            INC minutes
            JMP exit_chronometer_game
        exit_chronometer_game:
            mNumToStringTime timePlayed, minutes, 00
            mNumToStringTime timePlayed, seconds, 03
            mNumToStringTime timePlayed, second_fraction, 06
            ret
    chronometerGame ENDP

    drawPoints PROC
        PUSH SI
        PUSH AX
        XOR SI, SI
        XOR AX, AX
        draw_points:
            MOV AL, recoveredStr[SI]
            CMP AL, 24
            JE exit_draw_points
            MOV inputBytes, AL 
            mDrawText inputBytes, BL, BH, 40
            INC BH
            INC SI
            JMP draw_points
        exit_draw_points:
        POP AX
        POP SI
        RET
    drawPoints ENDP

END inicio