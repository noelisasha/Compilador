include macros2.asm
include number.asm

.MODEL  LARGE
.386
.STACK 200h

MAXTEXTSIZE equ 30

.DATA

    _8_M_9                                      db    "8 > 9",'$'
    _14                                         dd    14
    _6_M_7                                      db    "6 > 7",'$'
    _4_M_5                                      db    "4 > 5",'$'
    _333                                        dd    333
    _mmmmmmmmmmmmmmmmmmmmmmmmmmmmmm             db    "mmmmmmmmmmmmmmmmmmmmmmmmmmmmmm",'$'
    _asldk__fh_sjf                              db    "asldk  fh sjf",'$'
    _@sdADaSjfla_dfg                            db    "@sdADaSjfla%dfg",'$'
    __3333                                      dd    .3333
    _333_                                       dd    333.
    _333_3333                                   dd    333.3333
    _Salida_7                                   db    "Salida 7",'$'
    _1_22                                       dd    1.22
    _2_3                                        dd    2.3
    _Salida_6                                   db    "Salida 6",'$'
    _Salida_5                                   db    "Salida 5",'$'
    _Salida_4                                   db    "Salida 4",'$'
    _Salida_3                                   db    "Salida 3",'$'
    _3                                          dd    3
    _Salida_2                                   db    "Salida 2",'$'
    _Salida_1                                   db    "Salida 1",'$'
    _5                                          dd    5
    _2                                          dd    2
    _4                                          dd    4
    _El_actual_es__                             db    "El actual es: ",'$'
    _La_suma_es__                               db    "La suma es: ",'$'
    _0_342                                      dd    0.342
    _22                                         dd    22
    _1                                          dd    1
    _02                                         dd    02
    _9_5                                        dd    9.5
    _0                                          dd    0
    _Hola_mundoN                                db    "Hola mundo!",'$'
    _hola                                       db    MAXTEXTSIZE dup (?),'$'
    _b                                          dd    ?
    _a                                          dd    ?
    _suma                                       dd    ?
    _actual                                     dd    ?
    _promedio                                   dd    ?
    _comp                                       dd    ?
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
    ffree
    fld _9_5
    fstp _actual
    ffree
    fld _02
    fstp _suma
    ffree
    fld _contador
    fld _1
    fadd
    fstp _contador
    ffree
ETIQ16:
    fld _contador
    fld _22
    fxch
    fcom
    fstsw ax
    sahf
    ffree
    ja ETIQ43
    fld _contador
    fld _1
    fadd
    fstp _contador
    ffree
    fld _actual
    fld _0_342
    fdiv
    fld _actual
    fld _actual
    fmul
    fadd
    fstp _actual
    ffree
    fld _suma
    fld _contador
    fadd
    fstp _suma
    ffree
    jmp ETIQ16
ETIQ43:
    displayString _La_suma_es__
    newLine 1
    DisplayFloat _suma,3
    newLine 1
    displayString _El_actual_es__
    newLine 1
    DisplayFloat _actual,3
    newLine 1
    fld _4
    fstp _comp
    ffree
    fld _comp
    fld _2
    fxch
    fcom
    fstsw ax
    sahf
    ffree
    jbe ETIQ66
    fld _comp
    fld _5
    fxch
    fcom
    fstsw ax
    sahf
    ffree
    jae ETIQ66
    displayString _Salida_1
    newLine 1
ETIQ66:
    fld _comp
    fld _2
    fxch
    fcom
    fstsw ax
    sahf
    ffree
    ja ETIQ76
    fld _comp
    fld _5
    fxch
    fcom
    fstsw ax
    sahf
    ffree
    jbe ETIQ78
ETIQ76:
    displayString _Salida_2
    newLine 1
ETIQ78:
    fld _comp
    fld _3
    fxch
    fcom
    fstsw ax
    sahf
    ffree
    jb ETIQ85
    displayString _Salida_3
    newLine 1
ETIQ85:
    fld _comp
    fld _3
    fxch
    fcom
    fstsw ax
    sahf
    ffree
    jbe ETIQ156
    fld _comp
    fld _3
    fxch
    fcom
    fstsw ax
    sahf
    ffree
    jb ETIQ97
    displayString _Salida_4
    newLine 1
    fld _comp
    fld _3
    fxch
    fcom
    fstsw ax
    sahf
    ffree
    ja ETIQ104
    displayString _Salida_5
    newLine 1
    fld _a
    fld _2
    fxch
    fcom
    fstsw ax
    sahf
    ffree
    jb ETIQ121
    fld _a
    fld _a
    fld _b
    fld _4
    fsub
    fmul
    fxch
    fcom
    fstsw ax
    sahf
    ffree
    ja ETIQ121
    jmp ETIQ122
    fld _3
    fxch
    fcom
    fstsw ax
    sahf
    ffree
    jne ETIQ128
    displayString _Salida_6
    newLine 1
    fld _a
    fld _2
    fxch
    fcom
    fstsw ax
    sahf
    ffree
    jb ETIQ147
    fld _a
    fld _a
    fld _2_3
    fld _1_22
    fadd
    fld _2
    fdiv
    fmul
    fxch
    fcom
    fstsw ax
    sahf
    ffree
    ja ETIQ147
    jmp ETIQ148
    fld _3
    fxch
    fcom
    fstsw ax
    sahf
    ffree
    je ETIQ154
    displayString _Salida_7
    newLine 1
    jmp ETIQ175
ETIQ156:
    fld _333_3333
    fstp _actual
    ffree
    fld _333_
    fstp _actual
    ffree
    fld __3333
    fstp _actual
    ffree
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
ETIQ175:
    fld _a
    fld _2
    fxch
    fcom
    fstsw ax
    sahf
    ffree
    jb ETIQ192
    fld _a
    fld _a
    fld _b
    fld _4
    fadd
    fmul
    fxch
    fcom
    fstsw ax
    sahf
    ffree
    ja ETIQ192
    jmp ETIQ193
ETIQ192:
ETIQ193:
    fld _2_3
    fld _1_22
    fadd
    fld _2
    fdiv
    fld _comp
    fld _2
    fxch
    fcom
    fstsw ax
    sahf
    ffree
    ja ETIQ205
    displayString _4_M_5
    newLine 1
ETIQ205:
    fld _comp
    fld _2
    fxch
    fcom
    fstsw ax
    sahf
    ffree
    jbe ETIQ217
    fld _comp
    fld _2
    fxch
    fcom
    fstsw ax
    sahf
    ffree
    jb ETIQ217
    displayString _6_M_7
    newLine 1
ETIQ217:
    fld _comp
    fld _2
    fxch
    fcom
    fstsw ax
    sahf
    ffree
    jae ETIQ231
    fld _contador
    fld _comp
    fld _4
    fadd
    fsub
    fld _14
    fxch
    fcom
    fstsw ax
    sahf
    ffree
    jne ETIQ233
ETIQ231:
    displayString _8_M_9
    newLine 1
ETIQ233:
    mov ax, 4C00h
    int 21h
END START
