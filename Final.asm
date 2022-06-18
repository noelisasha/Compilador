include macros2.asm
include number.asm

.MODEL  LARGE
.386
.STACK 200h

MAXTEXTSIZE equ 30

.DATA

    _8_M_9                                      db    "8 > 9"
    _6_M_7                                      db    "6 > 7"
    _4_M_5                                      db    "4 > 5"
    _333                                        dq    333
    _mmmmmmmmmmmmmmmmmmmmmmmmmmmmmm             db    "mmmmmmmmmmmmmmmmmmmmmmmmmmmmmm"
    _asldk__fh_sjf                              db    "asldk  fh sjf"
    _@sdADaSjfla%dfg                            db    "@sdADaSjfla%dfg"
    __3333                                      dt    .3333
    _333_                                       dt    333.
    _333_3333                                   dt    333.3333
    _1_22                                       dt    1.22
    _2_3                                        dt    2.3
    _4                                          dq    4
    _soy_true                                   db    "soy true"
    _3                                          dq    3
    _2_M_3                                      db    "2 > 3"
    _5                                          dq    5
    _2                                          dq    2
    _La_suma_es__                               db    "La suma es: "
    _0_342                                      dt    0.342
    _92                                         dq    92
    _1                                          dq    1
    _02                                         dq    02
    _999                                        dq    999
    _0                                          dq    0
    _Hola_mundoN                                db    "Hola mundo!"
    _hola                                       db    MAXTEXTSIZE dup (?),'$'
    _b                                          dt    ?
    _suma                                       dt    ?
    _actual                                     dt    ?
    _promedio                                   dt    ?
    _a                                          dq    ?
    _contador                                   dq    ?

.CODE

START:
    mov AX,@DATA
    mov DS,AX
    mov es,ax
    mov ax, 4C00h
    int 21h
END START
