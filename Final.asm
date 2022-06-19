include macros2.asm
include number.asm

.MODEL  LARGE
.386
.STACK 200h

MAXTEXTSIZE equ 30

.DATA

    _8_M_9                                      db    "8 > 9",'$'
    _6_M_7                                      db    "6 > 7",'$'
    _4_M_5                                      db    "4 > 5",'$'
    _333                                        dd    333
    _mmmmmmmmmmmmmmmmmmmmmmmmmmmmmm             db    "mmmmmmmmmmmmmmmmmmmmmmmmmmmmmm",'$'
    _asldk__fh_sjf                              db    "asldk  fh sjf",'$'
    _@sdADaSjfla_dfg                            db    "@sdADaSjfla%dfg",'$'
    __3333                                      dd    .3333
    _333_                                       dd    333.
    _333_3333                                   dd    333.3333
    _1_22                                       dd    1.22
    _2_3                                        dd    2.3
    _4                                          dd    4
    _soy_true                                   db    "soy true",'$'
    _3                                          dd    3
    _2_M_3                                      db    "2 > 3",'$'
    _5                                          dd    5
    _2                                          dd    2
    _La_suma_es__                               db    "La suma es: ",'$'
    _0_342                                      dd    0.342
    _92                                         dd    92
    _1                                          dd    1
    _02                                         dd    02
    _999                                        dd    999
    _0                                          dd    0
    _Hola_mundoN                                db    "Hola mundo!",'$'
    _hola                                       db    MAXTEXTSIZE dup (?),'$'
    _b                                          dd    ?
    _suma                                       dd    ?
    _actual                                     dd    ?
    _promedio                                   dd    ?
    _a                                          dd    ?
    _contador                                   dd    ?

.CODE

START:
    mov AX,@DATA
    mov DS,AX
    mov es,ax
    displayString _Hola_mundoN
    newLine 1
    fld _0
    fstp _contador
    fld _999
    fstp _actual
    fld _02
    fstp _suma
    fld _contador
    fld _1
    fadd
    fstp _contador
    fld _contador
    fld _92
    fld _contador
    fld _1
    fadd
    fstp _contador
    fld _contador
    fld _0_342
    fdiv
    fld _contador
    fld _contador
    fmul
    fadd
    fstp _actual
    fld _suma
    fld _actual
    fadd
    fstp _suma
    displayString _La_suma_es__
    newLine 1
    DisplayFloat _suma,3
    newLine 1
    fld _actual
    fld _2
    fld _actual
    fld _5
    displayString _2_M_3
    newLine 1
    fld _actual
    fld _2
    fld _actual
    fld _5
    displayString _2_M_3
    newLine 1
    fld _actual
    fld _3
    displayString _2_M_3
    newLine 1
    fld _actual
    fld _3
    fld _actual
    fld _3
    displayString _soy_true
    newLine 1
    fld _actual
    fld _3
    displayString _soy_true
    newLine 1
    fld _a
    fld _2
    fld _a
    fld _a
    fld _b
    fld _4
    fsub
    fmul
    fld _3
    displayString _soy_true
    newLine 1
    fld _a
    fld _2
    fld _a
    fld _a
    fld _2_3
    fld _1_22
    fadd
    fld _2
    fdiv
    fmul
    fld _3
    displayString _soy_true
    newLine 1
    fld _333_3333
    fstp _actual
    fld _333_
    fstp _actual
    fld __3333
    fstp _actual
    displayString _@sdADaSjfla_dfg
    newLine 1
    displayString _asldk__fh_sjf
    newLine 1
    displayString _mmmmmmmmmmmmmmmmmmmmmmmmmmmmmm
    newLine 1
    DisplayInteger _333
    newLine 1
    DisplayFloat _333_3333,3
    newLine 1
    fld _a
    fld _2
    fld _a
    fld _a
    fld _b
    fld _4
    fadd
    fmul
    fld _2_3
    fld _1_22
    fadd
    fld _2
    fdiv
    fld _actual
    fld _2
    displayString _4_M_5
    newLine 1
    fld _actual
    fld _2
    fld _actual
    fld _2
    displayString _6_M_7
    newLine 1
    fld _actual
    fld _2
    fld _a
    fld _b
    fld _4
    fadd
    fmul
    fld _2
    displayString _8_M_9
    newLine 1
    mov ax, 4C00h
    int 21h
END START
