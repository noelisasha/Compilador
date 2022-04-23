%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "y.tab.h"
FILE *yyin;
int yylval;
%}

%option noyywrap
%option yylineno


/* ------------------------------------ SECCION TOKENS (TEMAS COMUNES)  ------------------------------------*/


/* REGEX GENERALES */
DIGITO          [0-9]
LETRA           [A-Za-z]

/* (1) TIPOS DE DATOS*/
CONS_ENTERO		   	-?{DIGITO}{1,5}
/* 3.4 * 10 ^ (-38) <---> 3.4 * 10 ^ (38) */
CONS_FLOAT		 	({DIGITO}+)?"."({DIGITO}+)? 
CONS_STRING         \"[^\n"]*\"

/* (2) VARIABLES / IDENTIFICADORES */
ID					{LETRA}({LETRA}|{DIGITO}|_)*

/* (3) COMENTARIOS */
COMENTARIO  \-\/[^\n]*\/\-

/* (4) SALIDAS Y ENTRADAS*/
PR_WRITE    "write"
PR_READ     "read"

/* (5) ITERACIONES */ 
PR_WHILE        "while"

/* (6) DESICIONES */ 
PR_IF           "if"
PR_ELSE         "else"

/* (7) DECLARACIONES */ 
PR_STR_DECLARA  "DECVAR"
PR_END_DECLARA  "ENDDEC"

/* (8) PUNTUACION Y APERTURA CIERRE ESTRUCTURAS */

COMA        ","
PUNTOCOMA   ";"
PUNTO       "."
APAR         "("
CPAR         ")"
ALLV         "{"
CLLV         "}"
ACOR		"["
CCOR		"]"

/* (9) OPERACIONES */
OP_ASIG         ":"
OP_SUMA         "+"
OP_REST         "-"
OP_PROD         "*"
OP_DIVI         "/"
OP_MENI         "<="
OP_MAYI         ">="
OP_MAY          ">"
OP_MEN          "<"
OP_EQ           "=="
OP_NEQ          "!="
OP_AND          "and"
OP_OR           "or"
OP_NOT          "not"



/* (10) TIPOS DE DATO */
PR_INT          "int"
PR_FLOAT        "float"
PR_STRING        "string"


/* ------------------------------------ SECCION TOKENS (TEMAS ESPECIALES)  ------------------------------------*/
PR_BETWEEN			"between"
PR_AVG				"avg"

/* ------------------------------------ SECCION REGLAS  ------------------------------------*/

%%
{CONS_ENTERO}           {yylval = atoi( yytext ); if(yylval < -32768 || yylval > 32767){printf( "\nERROR LEXICO : Constante entera fuera de rango: %s\n", yytext ); exit (0);} else{printf("\nConstante entera: %s\n", yytext);return (CONS_ENTERO);}}
{CONS_FLOAT}            {printf("\nConstante real: %s\n", yytext);return (CONS_FLOAT);}
{CONS_STRING}           {if(yyleng > 32){printf( "\nERROR LEXICO : Las constantes string no deben superar los 30 caracteres: %s\n", yytext ); exit (0);}else{printf("\nConstante string: %s\n", yytext);return (CONS_STRING);}}
{PR_WRITE}              {printf("\nPalabra reservada: %s\n", yytext);return (PR_WRITE);}
{PR_READ}               {printf("\nPalabra reservada: %s\n", yytext);return (PR_READ);}
{PR_WHILE}              {printf("\nPalabra reservada: %s\n", yytext);return (PR_WHILE);}
{PR_IF}                 {printf("\nPalabra reservada: %s\n", yytext);return (PR_IF);}
{PR_ELSE}               {printf("\nPalabra reservada: %s\n", yytext);return (PR_ELSE);}
{PR_STR_DECLARA}        {printf("\nPalabra reservada: %s\n", yytext);return (PR_STR_DECLARA);}
{PR_END_DECLARA}        {printf("\nPalabra reservada: %s\n", yytext);return (PR_END_DECLARA);}
{PR_INT}                {printf("\nPalabra reservada: %s\n", yytext);return (PR_INT);}
{PR_FLOAT}              {printf("\nPalabra reservada: %s\n", yytext);return (PR_FLOAT);}
{PR_STRING}             {printf("\nPalabra reservada: %s\n", yytext);return (PR_STRING);}
{PR_BETWEEN}            {printf("\nPalabra reservada: %s\n", yytext);return (PR_BETWEEN);}
{PR_AVG}             	{printf("\nPalabra reservada: %s\n", yytext);return (PR_AVG);}
{ID}                    {printf("\nIdentificador: %s\n", yytext);return (ID);}


{COMA}					{printf("\nComa: %s\n", yytext);return (COMA);}
{PUNTOCOMA}				{printf("\nPunto y coma: %s\n", yytext);return (PUNTOCOMA);}
{PUNTO}					{printf("\nPunto: %s\n", yytext);return (PUNTO);}
{APAR}					{printf("\nParentesis apertura: %s\n", yytext);return (APAR);}
{CPAR}					{printf("\nParentesis cierre: %s\n", yytext);return (CPAR);}
{ALLV}					{printf("\nLlave apertura: %s\n", yytext);return (ALLV);}
{CLLV}					{printf("\nLlave cierre: %s\n", yytext);return (CLLV);}
{ACOR}					{printf("\nCorchete apertura: %s\n", yytext);return (ACOR);}
{CCOR}					{printf("\nCorchete cierre: %s\n", yytext);return (CCOR);}

{OP_ASIG}				{printf("\nAsignacion: %s\n", yytext);return (OP_ASIG);}
{OP_SUMA}				{printf("\nSuma: %s\n", yytext);return (OP_SUMA);}
{OP_REST}				{printf("\nResta: %s\n", yytext);return (OP_REST);}
{OP_PROD}				{printf("\nMultiplicacion: %s\n", yytext);return (OP_PROD);}
{OP_DIVI}				{printf("\nDivision: %s\n", yytext);return (OP_DIVI);}


{OP_MEN}				{printf("\nOperador menor: %s\n", yytext);return (OP_MEN);}
{OP_MAY}				{printf("\nOperador mayor: %s\n", yytext);return (OP_MAY);}
{OP_MAYI}		        {printf("\nOperador mayor o igual: %s\n", yytext);return (OP_MAYI);}
{OP_MENI}		        {printf("\nOperador menor o igual: %s\n", yytext);return (OP_MENI);}
{OP_EQ}		            {printf("\nOperador igual: %s\n", yytext);return (OP_EQ);}
{OP_NEQ}			    {printf("\nOperador distinto: %s\n", yytext);return (OP_NEQ);}
{OP_AND}			    {printf("\nOperador AND: %s\n", yytext);return (OP_AND);}
{OP_OR}			        {printf("\nOperador OR: %s\n", yytext);return (OP_OR);}
{OP_NOT}			    {printf("\nOperador NOT: %s\n", yytext);return (OP_NOT);}
{COMENTARIO}

" "
"\n"
"\t"
.			 			{ printf( "ERROR LEXICO : Caracter no reconocido: %s\n", yytext ); exit (0);}
%%

