%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
FILE *yyin;
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
CONS_FLOAT		 	{DIGITO}+"."{DIGITO}+ 
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
DOS_PUNTOS  ":"
APAR         "("
CPAR         ")"
ALLV         "{"
CLLV         "}"

/* (9) OPERACIONES */
OP_ASIG         "="
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



/* ------------------------------------ SECCION REGLAS  ------------------------------------*/

%%
{CONS_ENTERO}           printf("\nConstante entera: %s\n", yytext);
{CONS_FLOAT}            printf("\nConstante real: %s\n", yytext);
{CONS_STRING}            printf("\nConstante string: %s\n", yytext);
{PR_WRITE}              printf("\nPalabra reservada: %s\n", yytext);
{PR_READ}               printf("\nPalabra reservada: %s\n", yytext);
{PR_WHILE}              printf("\nPalabra reservada: %s\n", yytext);
{PR_IF}                 printf("\nPalabra reservada: %s\n", yytext);
{PR_ELSE}               printf("\nPalabra reservada: %s\n", yytext);
{PR_STR_DECLARA}        printf("\nPalabra reservada: %s\n", yytext);
{PR_END_DECLARA}        printf("\nPalabra reservada: %s\n", yytext);
{PR_INT}                printf("\nPalabra reservada: %s\n", yytext);
{PR_FLOAT}              printf("\nPalabra reservada: %s\n", yytext);
{PR_STRING}             printf("\nPalabra reservada: %s\n", yytext);
{ID}                    printf("\nIdentificador: %s\n", yytext);


{COMA}					printf("\nComa: %s\n", yytext);
{PUNTOCOMA}				printf("\nPunto y coma: %s\n", yytext);
{PUNTO}					printf("\nPunto: %s\n", yytext);
{DOS_PUNTOS}			printf("\nDos puntos: %s\n", yytext);
{APAR}					printf("\nParentesis apertura: %s\n", yytext);
{CPAR}					printf("\nParentesis cierre: %s\n", yytext);
{ALLV}					printf("\nLlave apertura: %s\n", yytext);
{CLLV}					printf("\nLlave cierre: %s\n", yytext);

{OP_ASIG}				printf("\nAsignacion: %s\n", yytext);
{OP_SUMA}				printf("\nSuma: %s\n", yytext);
{OP_REST}				printf("\nResta: %s\n", yytext);
{OP_PROD}				printf("\nMultiplicacion: %s\n", yytext);
{OP_DIVI}				printf("\nDivision: %s\n", yytext);


{OP_MEN}				printf("\nOperador menor: %s\n", yytext);
{OP_MAY}				printf("\nOperador mayor: %s\n", yytext);
{OP_MAYI}		        printf("\nOperador mayor o igual: %s\n", yytext);
{OP_MENI}		        printf("\nOperador menor o igual: %s\n", yytext);
{OP_EQ}		            printf("\nOperador igual: %s\n", yytext);
{OP_NEQ}			    printf("\nOperador distinto: %s\n", yytext);
{OP_AND}			    printf("\nOperador AND: %s\n", yytext);
{OP_OR}			        printf("\nOperador OR: %s\n", yytext);
{OP_NOT}			    printf("\nOperador NOT: %s\n", yytext);
{COMENTARIO}

"\n"
"\t"
%%


int main(int argc, char * argv[]) {

    /* Se abre el archivo en modo lectura y se deja apuntando a yyin (FLEX TRABAJA ASI) */
    if ((yyin = fopen(argv[1],"rt")) == NULL) {
        printf("\nNo se pudo abrir el archivo: %s\n",argv[1]);
        return 1;
    } else {
        printf("\nEl archivo se abrio correctamente\n");
        yylex();
    }

    printf("\nFlex finalizo la lectura del archivo %s\n",argv[1]);
    fclose(yyin);
    return 0;
}


int yyerror(void)
{
    printf("Error Lexico\n");
    system ("Pause");
    exit (1);
}