c:\GnuWin32\bin\flex SoloLexico.l
pause
c:\MinGW\bin\gcc.exe lex.yy.c -o archivoejecutable.exe
pause
archivoejecutable.exe Codigo.txt
pause

del	lex.yy.c
del archivoejecutable.exe
pause