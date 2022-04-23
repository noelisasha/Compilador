%{
#include <stdio.h>
#include <stdlib.h>
#include "y.tab.h"
int yystopparser=0;
FILE  *yyin;

  int yyerror();
  int yylex();


%}


%token CONS_ENTERO
%token CONS_FLOAT
%token CONS_STRING
%token PR_WRITE
%token PR_READ
%token PR_WHILE
%token PR_IF
%token PR_ELSE
%token PR_STR_DECLARA
%token PR_END_DECLARA
%token PR_INT
%token PR_FLOAT
%token PR_STRING
%token PR_BETWEEN
%token PR_AVG
%token ID


%token COMA
%token PUNTOCOMA
%token PUNTO
%token DOS_PUNTOS
%token APAR
%token CPAR
%token ALLV
%token CLLV
%token ACOR
%token CCOR


%token OP_ASIG
%token OP_SUMA
%token OP_REST
%token OP_PROD
%token OP_DIVI


%token OP_MEN
%token OP_MAY
%token OP_MAYI
%token OP_MENI
%token OP_EQ
%token OP_NEQ
%token OP_AND
%token OP_OR
%token OP_NOT




%%

programa:
	  sentencia					 {printf(" programa: sentencia\n");}
	| sentencia programa		{printf(" programa: sentencia programa\n");}
	;
	
sentencia:
	  declaracion				{printf(" sentencia: declaracion\n");}
	| asignacion				{printf(" sentencia: asignacion\n");}
	| seleccion					{printf(" sentencia: seleccion\n");}
	| iteracion					{printf(" sentencia: iteracion\n");}
	| lectura					{printf(" sentencia: lectura\n");}
	| escritura					{printf(" sentencia: escritura\n");}
	| func_between PUNTOCOMA	{printf(" sentencia: between\n");}
	| func_avg PUNTOCOMA		{printf(" sentencia: avg\n");}
	;



declaracion:
	  PR_STR_DECLARA linea_declaracion PR_END_DECLARA
	;

linea_declaracion:
	  instanciacion
	| instanciacion linea_declaracion
	;
	
instanciacion:
	  variable OP_ASIG tipodato PUNTOCOMA
	;
	
variable:
	  ID COMA variable
	| ID
	;
	
tipodato:
	  PR_INT
	| PR_FLOAT
	| PR_STRING
	;
	
	

asignacion:
	  ID OP_ASIG expresion PUNTOCOMA
	;
	
	

seleccion:
	  PR_IF APAR condicion CPAR ALLV programa CLLV PR_ELSE ALLV programa CLLV 	{printf(" seleccion: if-else\n");}
	| PR_IF APAR condicion CPAR sentencia										{printf(" seleccion: if-sent\n");}
	| PR_IF APAR condicion CPAR ALLV programa CLLV								{printf(" seleccion: if-prog\n");}
	;
	
	
	
iteracion:
	  PR_WHILE APAR condicion CPAR ALLV programa CLLV
	;
	
	
	
condicion:
	  comparacion							{printf(" condicion: comp\n");}
	| condicion OP_AND comparacion			{printf(" condicion: cond and comp\n");}
	| condicion OP_OR comparacion			{printf(" condicion: cond or comp\n");}
	;
	
comparacion:
	  expresion comparador expresion
	;
	
comparador:
	  OP_MAY
	| OP_MEN
	| OP_EQ
	| OP_NEQ
	| OP_MENI
	| OP_MAYI
	;
	


lectura:
	  PR_READ ID PUNTOCOMA
	;



escritura:
	  PR_WRITE CONS_STRING PUNTOCOMA
	| PR_WRITE ID PUNTOCOMA
	;



func_between:
	  PR_BETWEEN APAR ID COMA ACOR expresion PUNTOCOMA expresion CCOR CPAR
	;



func_avg:
	  PR_AVG APAR ACOR lista CCOR CPAR
	;

lista:
	  lista COMA factor
	| factor
	;

	
	
expresion:
	  expresion OP_SUMA termino
	| expresion OP_REST termino
	| termino
	;
	
termino:
	  termino OP_PROD factor
	| termino OP_DIVI factor
	| factor
	;
	
factor:
	  APAR expresion CPAR
	| CONS_ENTERO
	| CONS_FLOAT
	| ID
	| func_avg
	| func_between
	;

%%


int main(int argc, char *argv[])
{
    if((yyin = fopen(argv[1], "rt"))==NULL)
    {
        printf("\nNo se puede abrir el archivo de prueba: %s\n", argv[1]);
       
    }
    else
    { 
        
        yyparse();
        
    }
	printf("\n Compilacion exitosa!! \n");
	fclose(yyin);
        return 0;
}
int yyerror(void)
     {
       printf("Error Sintactico\n");
	 exit (1);
     }