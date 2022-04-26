flex Lexico.l

bison -yd Sintactico.y

gcc.exe lex.yy.c y.tab.c -o Primera.exe

Primera.exe prueba.txt

@echo off
del lex.yy.c
del y.tab.c

pause