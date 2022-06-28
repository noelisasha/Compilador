flex Lexico.l

bison -yd Sintactico.y

gcc.exe lex.yy.c y.tab.c -o Grupo18.exe

Grupo18.exe prueba.txt

@echo off
del lex.yy.c
del y.tab.c

pause