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
    _2_                                         dd    2.
    _1_22                                       dd    1.22
    _2_3                                        dd    2.3
    _Salida_6                                   db    "Salida 6",'$'
    _4                                          dd    4
    _Salida_5                                   db    "Salida 5",'$'
    _Salida_4                                   db    "Salida 4",'$'
    _Salida_3                                   db    "Salida 3",'$'
    _3                                          dd    3
    _Salida_2                                   db    "Salida 2",'$'
    _Salida_1                                   db    "Salida 1",'$'
    _5                                          dd    5
    _2                                          dd    2
    _Hola_mundoN                                db    "Hola mundo!",'$'
    _b                                          dd    ?
    _a                                          dd    ?
    _suma                                       dd    ?
    _actual                                     dd    ?
    _comp                                       dd    ?
    _contador                                   dd    ?

.CODE

START:
    mov AX,@DATA
    mov DS,AX
    mov es,ax
    displayString _Hola_mundoN
    newLine 1
    fld _2
    fstp _comp
    ffree
    fld _comp
    fld _2
    fxch
    fcom
    fstsw ax
    sahf
    ffree
    jbe ETIQ17
    fld _comp
    fld _5
    fxch
    fcom
    fstsw ax
    sahf
    ffree
    jae ETIQ17
    displayString _Salida_1
    newLine 1
ETIQ17:
    fld _comp
    fld _2
    fxch
    fcom
    fstsw ax
    sahf
    ffree
    ja ETIQ27
    fld _comp
    fld _5
    fxch
    fcom
    fstsw ax
    sahf
    ffree
    jbe ETIQ29
ETIQ27:
    displayString _Salida_2
    newLine 1
ETIQ29:
    fld _comp
    fld _3
    fxch
    fcom
    fstsw ax
    sahf
    ffree
    jb ETIQ36
    displayString _Salida_3
    newLine 1
ETIQ36:
    fld _comp
    fld _3
    fxch
    fcom
    fstsw ax
    sahf
    ffree
    jbe ETIQ107
    fld _comp
    fld _3
    fxch
    fcom
    fstsw ax
    sahf
    ffree
    jb ETIQ48
    displayString _Salida_4
    newLine 1
ETIQ48:
    fld _comp
    fld _3
    fxch
    fcom
    fstsw ax
    sahf
    ffree
    ja ETIQ55
    displayString _Salida_5
    newLine 1
ETIQ55:
    fld _a
    fld _2
    fxch
    fcom
    fstsw ax
    sahf
    ffree
    jb ETIQ72
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
    ja ETIQ72
    jmp ETIQ73
ETIQ72:
ETIQ73:
    fld _3
    fxch
    fcom
    fstsw ax
    sahf
    ffree
    jne ETIQ79
    displayString _Salida_6
    newLine 1
ETIQ79:
    fld _a
    fld _2
    fxch
    fcom
    fstsw ax
    sahf
    ffree
    jb ETIQ98
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
    ja ETIQ98
    jmp ETIQ99
ETIQ98:
ETIQ99:
    fld _3
    fxch
    fcom
    fstsw ax
    sahf
    ffree
    je ETIQ105
    displayString _Salida_7
    newLine 1
ETIQ105:
    jmp ETIQ126
ETIQ107:
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
ETIQ126:
    fld _a
    fld _2
    fxch
    fcom
    fstsw ax
    sahf
    ffree
    jb ETIQ143
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
    ja ETIQ143
    jmp ETIQ144
ETIQ143:
ETIQ144:
    fld _2_3
    fld _1_22
    fadd
    fld _2_
    fdiv
    fld _comp
    fld _2
    fxch
    fcom
    fstsw ax
    sahf
    ffree
    ja ETIQ156
    displayString _4_M_5
    newLine 1
ETIQ156:
    fld _comp
    fld _2
    fxch
    fcom
    fstsw ax
    sahf
    ffree
    jbe ETIQ168
    fld _comp
    fld _2
    fxch
    fcom
    fstsw ax
    sahf
    ffree
    jb ETIQ168
    displayString _6_M_7
    newLine 1
ETIQ168:
    fld _comp
    fld _2
    fxch
    fcom
    fstsw ax
    sahf
    ffree
    jae ETIQ182
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
    jne ETIQ184
ETIQ182:
    displayString _8_M_9
    newLine 1
ETIQ184:
    mov ax, 4C00h
    int 21h
END START
