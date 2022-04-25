flex Lexico.l

bison -yd Sintactico.y

gcc.exe lex.yy.c y.tab.c -o Primera.exe

Primera.exe Codigo.txt
pause
