%{
#include <stdio.h>
#include <stdlib.h>
#include <conio.h>

FILE  *yyin;
int yylval;
char *yyltex;

%}
%option noyywrap  
%option yylineno 

DECVAR				"DECVAR"
ENDDEC				"ENDDEC"
Integer				"Integer"
Float				"Float"
write				"write"
if					"if"
else				"else"
while				"while"

DIGITO				[0-9]
LETRA				[a-zA-Z]
CARACTER		    [=,>,<,!,:,+,-,*,/]

ID					{LETRA}({LETRA}|{DIGITO}|_)*
CONST_STRING	    [\"]({LETRA}|{DIGITO}|{CARACTER}|" ")*[\"]
CONST_INT		   	{DIGITO}+
CONST_FLOAT		 	{DIGITO}+"."{DIGITO}+

PYC					";"
ASIG				":"
COMA				","
OP_SUMA				"+"
OP_RESTA			"-"
OP_MUL				"*"
OP_DIV				"/"
P_A					"("
P_C					")"
L_A					"{"
L_C					"}"
OP_MENOR			"<"
OP_MAYOR			">"
OP_MAYOR_IGUAL		">="
OP_MENOR_IGUAL		"<="
OP_COMPARACION		"=="
OP_DISTINTO			"!="

%%

{DECVAR}				printf("\nPalabra reservada: %s\n", yytext);
{ENDDEC}				printf("\nPalabra reservada: %s\n", yytext);
{Integer}				printf("\nPalabra reservada: %s\n", yytext);
{Float}					printf("\nPalabra reservada: %s\n", yytext);
{write}					printf("\nPalabra reservada: %s\n", yytext);
{if}					printf("\nPalabra reservada: %s\n", yytext);
{else}					printf("\nPalabra reservada: %s\n", yytext);
{while}					printf("\nPalabra reservada: %s\n", yytext);

{ID}					printf("\nIdentificador: %s\n", yytext);
{CONST_STRING}			printf("\nConstante string: %s\n", yytext);
{CONST_INT}				printf("\nConstante entera: %s\n", yytext);
{CONST_FLOAT}			printf("\nConstante real: %s\n", yytext);

{PYC}					printf("\nPunto y coma: %s\n", yytext);
{ASIG}					printf("\nAsignacion: %s\n", yytext);
{COMA}					printf("\nComa: %s\n", yytext);
{OP_SUMA}				printf("\nSuma: %s\n", yytext);
{OP_RESTA}				printf("\nResta: %s\n", yytext);
{OP_MUL}				printf("\nMultiplicacion: %s\n", yytext);
{OP_DIV}				printf("\nDivision: %s\n", yytext);
{P_A}					printf("\nParentesis apertura: %s\n", yytext);
{P_C}					printf("\nParentesis cierre: %s\n", yytext);
{L_A}					printf("\nLlave apertura: %s\n", yytext);
{L_C}					printf("\nLlave cierre: %s\n", yytext);
{OP_MENOR}				printf("\nOperador menor: %s\n", yytext);
{OP_MAYOR}				printf("\nOperador mayor: %s\n", yytext);
{OP_MAYOR_IGUAL}		printf("\nOperador mayor o igual: %s\n", yytext);
{OP_MENOR_IGUAL}		printf("\nOperador menor o igual: %s\n", yytext);
{OP_COMPARACION}		printf("\nOperador comparacion: %s\n", yytext);
{OP_DISTINTO}			printf("\nOperador distinto: %s\n", yytext);

"\n"      		
"\t"		
%%

int main(int argc,char *argv[])
{
  if ((yyin = fopen(argv[1], "rt")) == NULL)
  {
	printf("\nNo se puede abrir el archivo: %s\n", argv[1]);
  }
  else
  {
	yylex();
  }
  fclose(yyin);
  return 0;
}
int yyerror(void)
     {
       printf("Error Lexico\n");
		system ("Pause");
		exit (1);
     }