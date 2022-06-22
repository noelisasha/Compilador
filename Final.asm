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
    _1_5                                        dd    1.5
    _1_                                         dd    1.
    _Salida_6                                   db    "Salida 6",'$'
    _@auxBetween                                db    MAXTEXTSIZE dup (?),'$'
    _false                                      db    "false",'$'
    _true                                       db    "true",'$'
    _6_                                         dd    6.
    _3_                                         dd    3.
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
    _5_                                         dd    5.
    _10_                                        dd    10.
    _2_                                         dd    2.
    _12                                         dd    12
    _1                                          dd    1
    _02                                         dd    02
    _3_85                                       dd    3.85
    _0                                          dd    0
    _Hola_mundoN                                db    "Hola mundo!",'$'
    _b                                          dd    ?
    _a                                          dd    ?
    _actual                                     dd    ?
    _promedio                                   dd    ?
    _suma                                       dd    ?
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
    fld _3_85
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
    fld _12
    fxch
    fcom
    fstsw ax
    sahf
    ffree
    ja ETIQ45
    fld _contador
    fld _1
    fadd
    fstp _contador
    ffree
    fld _actual
    fld _2_
    fmul
    fld _10_
    fld _5_
    fdiv
    fsub
    fstp _actual
    ffree
    DisplayFloat _actual,3
    newLine 1
    fld _suma
    fld _contador
    fadd
    fstp _suma
    ffree
    jmp ETIQ16
ETIQ45:
    displayString _La_suma_es__
    newLine 1
    DisplayInteger _suma
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
    jbe ETIQ68
    fld _comp
    fld _5
    fxch
    fcom
    fstsw ax
    sahf
    ffree
    jae ETIQ68
    displayString _Salida_1
    newLine 1
ETIQ68:
    fld _comp
    fld _2
    fxch
    fcom
    fstsw ax
    sahf
    ffree
    ja ETIQ78
    fld _comp
    fld _5
    fxch
    fcom
    fstsw ax
    sahf
    ffree
    jbe ETIQ80
ETIQ78:
    displayString _Salida_2
    newLine 1
ETIQ80:
    fld _comp
    fld _3
    fxch
    fcom
    fstsw ax
    sahf
    ffree
    jb ETIQ87
    displayString _Salida_3
    newLine 1
ETIQ87:
    fld _comp
    fld _3
    fxch
    fcom
    fstsw ax
    sahf
    ffree
    jbe ETIQ177
    fld _comp
    fld _3
    fxch
    fcom
    fstsw ax
    sahf
    ffree
    jb ETIQ99
    displayString _Salida_4
    newLine 1
ETIQ99:
    fld _comp
    fld _3
    fxch
    fcom
    fstsw ax
    sahf
    ffree
    ja ETIQ106
    displayString _Salida_5
    newLine 1
ETIQ106:
    fld _3_
    fstp _a
    ffree
    fld _6_
    fstp _b
    ffree
    fld _a
    fld _2
    fxch
    fcom
    fstsw ax
    sahf
    ffree
    jb ETIQ131
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
    ja ETIQ131
    mov dx, OFFSET _true
    jmp ETIQ135
ETIQ131:
    mov dx, OFFSET _false
ETIQ135:
    cmp dx, OFFSET _true
    jne ETIQ141
    displayString _Salida_6
    newLine 1
ETIQ141:
    fld _1_
    fstp _a
    ffree
    fld _a
    fld _1_5
    fxch
    fcom
    fstsw ax
    sahf
    ffree
    jb ETIQ165
    fld _a
    fld _a
    fld _2_3
    fld _1_22
    fadd
    fld _2_
    fdiv
    fmul
    fxch
    fcom
    fstsw ax
    sahf
    ffree
    ja ETIQ165
    mov dx, OFFSET _true
    jmp ETIQ169
ETIQ165:
    mov dx, OFFSET _false
ETIQ169:
    cmp dx, OFFSET _false
    jne ETIQ175
    displayString _Salida_7
    newLine 1
ETIQ175:
    jmp ETIQ196
ETIQ177:
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
ETIQ196:
    fld _2_3
    fld _1_22
    fadd
    fld _2_
    fdiv
    fstp _actual
    ffree
    DisplayFloat _actual,3
    newLine 1
    fld _comp
    fld _2
    fxch
    fcom
    fstsw ax
    sahf
    ffree
    ja ETIQ212
    displayString _4_M_5
    newLine 1
ETIQ212:
    fld _comp
    fld _2
    fxch
    fcom
    fstsw ax
    sahf
    ffree
    jbe ETIQ224
    fld _comp
    fld _2
    fxch
    fcom
    fstsw ax
    sahf
    ffree
    jb ETIQ224
    displayString _6_M_7
    newLine 1
ETIQ224:
    fld _comp
    fld _2
    fxch
    fcom
    fstsw ax
    sahf
    ffree
    jae ETIQ238
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
    jne ETIQ240
ETIQ238:
    displayString _8_M_9
    newLine 1
ETIQ240:
    mov ax, 4C00h
    int 21h
END START
