%{
#include <stdio.h>
#include <stdlib.h>
#include "tabla.h"
#include "y.tab.h"
#include "polacaInversa.h"

int yystopparser=0;
FILE  *yyin;

int yyerror();
int yylex();

tabla tablaDeSimbolos;

%}

%union{
    char* str;
}

%token <str>CONS_ENTERO
%token <str>CONS_FLOAT
%token <str>CONS_STRING
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
%token <str>ID


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
	  sentencia					{printf("	\"Sentencia\" es un Programa\n");}
	| sentencia programa		{printf("	\"Sentencia Programa\" es un Programa\n");}
	;
	
sentencia:
	  declaracion				{printf("	\"Declaracion\" es una Sentencia\n");}
	| asignacion				{printf("	\"Asignacion\" es una Sentencia\n");}
	| seleccion					{printf("	\"Seleccion\" es una Sentencia\n");}
	| iteracion					{printf("	\"Iteracion\" es una Sentencia\n");}
	| lectura					{printf("	\"Lectura\" es una Sentencia\n");}
	| escritura					{printf("	\"Escritura\" es una Sentencia\n");}
	| func_between PUNTOCOMA	{printf("	\"Between\" es una Sentencia\n");}
	| func_avg PUNTOCOMA		{printf("	\"Avg\" es una Sentencia\n");}
	;



declaracion:
	  PR_STR_DECLARA linea_declaracion PR_END_DECLARA		{printf("	\"DECVAR linea de declaracion ENDDEC\" es una Declaracion\n");}
	;

linea_declaracion:
	  instanciacion								{printf("	\"Instanciacion\" es una Linea de Declaracion\n");}
	| instanciacion linea_declaracion			{printf("	\"Instanciacion Linea de Declaracion\" es una Linea de Declaracion\n");}
	;
	
instanciacion:
	  variable OP_ASIG tipodato PUNTOCOMA		{printf("	\"Variable: Tipo de Dato;\" es una Instanciacion\n");}
	;
	
variable:
	  ID COMA variable			{printf("	\"ID, Variable\" es una Variable\n");
								 agregarId(&tablaDeSimbolos, $1);
								}
	| ID						{printf("	\"ID\" es una Variable\n");
								 agregarId(&tablaDeSimbolos, $1);
								}
	;
	
tipodato:
	  PR_INT					{printf("	\"int\" es una Tipo de Dato\n");}
	| PR_FLOAT					{printf("	\"float\" es una Tipo de Dato\n");}
	| PR_STRING					{printf("	\"string\" es una Tipo de Dato\n");}
	;
	
	

asignacion:
	  ID OP_ASIG expresion PUNTOCOMA		{printf("	\"ID: Expresion;\" es una Asignacion\n");
											 insertarEnPolaca($1);
											 insertarEnPolaca(":");
											}
	;
	
	

seleccion:
	  PR_IF APAR condicion CPAR ALLV programa CLLV PR_ELSE ALLV programa CLLV 	{printf("	\"if(condicion){programa} else{programa}\" es una Seleccion\n");}
	| PR_IF APAR condicion CPAR sentencia										{printf("	\"if(condicion)sentencia\" es una Seleccion\n");}
	| PR_IF APAR condicion CPAR ALLV programa CLLV								{printf("	\"if(condicion){programa}\" es una Seleccion\n");}
	;
	
	
	
iteracion:
	  PR_WHILE APAR condicion CPAR ALLV programa CLLV			{printf("	\"while(condicion){programa}\" es una Iteracion\n");}
	;
	
	
	
condicion:
	  comparacion							{printf("	\"Comparacion\" es una Condicion\n");}
	| condicion OP_AND comparacion			{printf("	\"Condicion and Comparacion\" es una Condicion\n");}
	| condicion OP_OR comparacion			{printf("	\"Condicion or Comparacion\" es una Condicion\n");}
	;
	
comparacion:
	  expresion comparador expresion		{printf("	\"Expresion Comparador Expresion\" es una Comparacion\n");}
	| OP_NOT expresion						{printf("	\"!Expresion\" es una Condicion\n");}
	| OP_NOT APAR comparacion CPAR			{printf("	\"!(Comparacion)\" es una Condicion\n");}
	;
	
comparador:
	  OP_MAY				{printf("	\">\" es una Comparador\n");}
	| OP_MEN				{printf("	\"<\" es una Comparador\n");}
	| OP_EQ					{printf("	\"==\" es una Comparador\n");}
	| OP_NEQ				{printf("	\"!=\" es una Comparador\n");}
	| OP_MENI				{printf("	\"<=\" es una Comparador\n");}
	| OP_MAYI				{printf("	\">=\" es una Comparador\n");}
	;
	


lectura:
	  PR_READ ID PUNTOCOMA		{printf("	\"read ID;\" es una Lectura\n");}
	;



escritura:
	  PR_WRITE CONS_STRING PUNTOCOMA		{printf("	\"write ConstanteString;\" es una Escritura\n");
											 agregarConsString(&tablaDeSimbolos, $2);
											}
	| PR_WRITE ID PUNTOCOMA					{printf("	\"write ID;\" es una Escritura\n");}
	| PR_WRITE CONS_ENTERO PUNTOCOMA		{printf("	\"write CONS_ENTERO;\" es una Escritura\n");}
	| PR_WRITE CONS_FLOAT PUNTOCOMA			{printf("	\"write CONS_FLOAT;\" es una Escritura\n");}
	;



func_between:
	  PR_BETWEEN APAR ID COMA ACOR expresion PUNTOCOMA expresion CCOR CPAR		{printf("	\"between(ID,[Expresion;Expresion])\" es un Between\n");}
	;



func_avg:
	  PR_AVG APAR ACOR lista CCOR CPAR		{printf("	\"avg([lista])\" es un Avg\n");}
	;

lista:
	  lista COMA factor			{printf("	\"Lista, Factor\" es una Lista\n");}
	| factor					{printf("	\"Factor\" es una Lista\n");}
	;

	
	
expresion:
	  expresion OP_SUMA termino		{printf("	\"Expresion+Termino\" es una Expresion\n");
									 insertarEnPolaca("+");
									}
	| expresion OP_REST termino		{printf("	\"Expresion-Termino\" es una Expresion\n");
									 insertarEnPolaca("-");
									}
	| termino						{printf("	\"Termino\" es una Expresion\n");}
	;
	
termino:
	  termino OP_PROD factor		{printf("	\"Termino*Factor\" es una Termino\n");
									 insertarEnPolaca("*");
									}
	| termino OP_DIVI factor		{printf("	\"Termino/Factor\" es una Termino\n");
									 insertarEnPolaca("/");
									}
	| factor						{printf("	\"Factor\" es una Termino\n");}
	;
	
factor:
	  APAR expresion CPAR			{printf("	\"(Expresion)\" es una Factor\n");}
	| CONS_ENTERO					{printf("	\"ConstanteEntera\" es una Factor\n");
									 agregarNumero(&tablaDeSimbolos, $1);
									 insertarEnPolaca($1);
									}
	| CONS_FLOAT					{printf("	\"ConstanteReal\" es una Factor\n");
									 agregarNumero(&tablaDeSimbolos, $1);
									 insertarEnPolaca($1);
									}
	| ID							{printf("	\"ID\" es una Factor\n");
									 insertarEnPolaca($1);
									}
	| func_avg						{printf("	\"Avg\" es una Factor\n");}
	| func_between					{printf("	\"Between\" es una Factor\n");}
	;

%%


int main(int argc, char *argv[])
{
    if((yyin = fopen(argv[1], "rt"))==NULL)
    {
        printf("\nNo se puede abrir el archivo de prueba: %s\n", argv[1]);
		return -1;
    }
	
	crearTablaSimbolos(&tablaDeSimbolos);
	crearPolacaInversa();
    yyparse();   
	imprimirTabla(&tablaDeSimbolos);
	imprimirCodigoIntermedio();

	printf("\n Compilacion exitosa!! \n");
	fclose(yyin);
    return 0;
}

int yyerror(void)
{
	printf("Error Sintactico\n");
	exit (1);
}