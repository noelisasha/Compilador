%{
#include <stdio.h>
#include <stdlib.h>
#include "tabla.h"
#include "y.tab.h"
#include "polacaInversa.h"
#include "pilaChar.h"

int yystopparser=0;
FILE  *yyin;

int yyerror();
int yylex();
void negarOperador();
int idDeclarado(char* id);

tabla tablaDeSimbolos;
superiorChar varDeclaracion;
char tipoDeDato[20];
char aux_operador[4];
int contadorAvg;
char variableBetween[50];
int contadorAnd = 0;
int contadorOr = 0;

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

start:
	  programa					{printf("\n Compilacion exitosa!! \n");
								 generarCabeceraAssembler(&tablaDeSimbolos);
								 generarCodigoAssembler(&tablaDeSimbolos);}	
	;

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
	  variable OP_ASIG tipodato PUNTOCOMA		{printf("	\"Variable: Tipo de Dato;\" es una Instanciacion\n");
												 char var[100];
												 while(desapilarChar(&varDeclaracion, var) != -1)
												 {agregarId(&tablaDeSimbolos, var, tipoDeDato);}
												}
	;
	
variable:
	  ID COMA variable			{printf("	\"ID, Variable\" es una Variable\n");
								 apilarChar(&varDeclaracion, $1);
								}
	| ID						{printf("	\"ID\" es una Variable\n");
								 apilarChar(&varDeclaracion, $1);
								}
	;
	
tipodato:
	  PR_INT					{printf("	\"int\" es una Tipo de Dato\n"); strcpy(tipoDeDato, "int");}
	| PR_FLOAT					{printf("	\"float\" es una Tipo de Dato\n"); strcpy(tipoDeDato, "float");}
	| PR_STRING					{printf("	\"string\" es una Tipo de Dato\n"); strcpy(tipoDeDato, "string");}
	;
	
	

asignacion:
	  ID OP_ASIG expresion PUNTOCOMA		{printf("	\"ID: Expresion;\" es una Asignacion\n");
											 if(idDeclarado($1) == 1) return 1;
											 insertarEnPolaca($1);
											 insertarEnPolaca(":");
											}
	;
	
	

seleccion:
	  PR_IF APAR condicion CPAR ALLV programa CLLV 								{insertarEnPolaca("BI");
																				 int espacio = escribirPunteroOffset(1);
																				 if(contadorOr != 0){
																				  escribirPunteroCompOr(espacio);
																				  contadorOr = 0;
																				 }else{
																				  while(contadorAnd != 0){
																					escribirPunteroOffset(1);
																					contadorAnd--;
																				  }
																				 }
																				 avanzarEnPolaca();
																				} 
	  PR_ELSE ALLV programa CLLV 												{printf("	\"if(condicion){programa} else{programa}\" es una Seleccion\n");
																				 escribirPuntero();}
	| PR_IF APAR condicion CPAR sentencia										{printf("	\"if(condicion)sentencia\" es una Seleccion\n");
																				 int espacio = escribirPuntero();
																				 if(contadorOr != 0){
																				  escribirPunteroCompOr(espacio);
																				  contadorOr = 0;
																				 }else{
																				  while(contadorAnd != 0){
																					escribirPuntero();
																					contadorAnd--;
																				  }
																				 }
																				}
	| PR_IF APAR condicion CPAR ALLV programa CLLV								{printf("	\"if(condicion){programa}\" es una Seleccion\n");
																				 int espacio = escribirPuntero();
																				 if(contadorOr != 0){
																				  escribirPunteroCompOr(espacio);
																				  contadorOr = 0;
																				 }else{
																				  while(contadorAnd != 0){
																					escribirPuntero();
																					contadorAnd--;
																				  }
																				 }
																				}
	;
	
	
	
iteracion:
	  PR_WHILE 											{apilarEnPolaca();
														 insertarEnPolaca("ETIQ");
														}
	  APAR condicion CPAR ALLV programa CLLV			{printf("	\"while(condicion){programa}\" es una Iteracion\n");
														 insertarEnPolaca("BI");
														 int espacio = escribirPunteroOffset(1);
														 if(contadorOr != 0){
															escribirPunteroCompOr(espacio);
															contadorOr = 0;
														 }else{
														  while(contadorAnd != 0){
															escribirPunteroOffset(1);
															contadorAnd--;
														  }
														 }
														 escribirEnCeldaActual();
														}
	;
	
	
	
condicion:
	  comparacion								{printf("	\"Comparacion\" es una Condicion\n");}
	| condicion OP_AND comparacion				{printf("	\"Condicion and Comparacion\" es una Condicion\n");
												 contadorAnd++;
												}
	| condicion OP_OR comparacion				{printf("	\"Condicion or Comparacion\" es una Condicion\n");
												 contadorOr = 1;
												}
	;
	
comparacion:
	  expresion comparador expresion					{printf("	\"Expresion Comparador Expresion\" es una Comparacion\n");
														 insertarEnPolaca("CMP");
														 insertarEnPolaca(aux_operador);
														 avanzarEnPolaca();
														}
	| OP_NOT expresion comparador expresion				{printf("	\"!Comparacion\" es una Condicion\n");
														 insertarEnPolaca("CMP");
														 negarOperador();
														 insertarEnPolaca(aux_operador);
														 avanzarEnPolaca();
														}
	| OP_NOT APAR expresion comparador expresion CPAR	{printf("	\"!(Comparacion)\" es una Condicion\n");
														 insertarEnPolaca("CMP");
														 negarOperador();
														 insertarEnPolaca(aux_operador);
														 avanzarEnPolaca();
														}
	;
	
comparador:
	  OP_MAY				{strcpy(aux_operador, "BLE");}
	| OP_MEN				{strcpy(aux_operador, "BGE");}
	| OP_EQ					{strcpy(aux_operador, "BNE");}
	| OP_NEQ				{strcpy(aux_operador, "BEQ");}
	| OP_MENI				{strcpy(aux_operador, "BGT");}
	| OP_MAYI				{strcpy(aux_operador, "BLT");}
	;
	


lectura:
	  PR_READ ID PUNTOCOMA		{printf("	\"read ID;\" es una Lectura\n");
								 if(idDeclarado($2) == 1) return 1;
								 insertarEnPolaca($2);
								 insertarEnPolaca("read");
								}
	;



escritura:
	  PR_WRITE CONS_STRING PUNTOCOMA		{printf("	\"write ConstanteString;\" es una Escritura\n");
											 agregarConsString(&tablaDeSimbolos, $2);
											 char cstr[41];
											 substring(cstr, $2, 1, strlen($2)-2);
											 insertarEnPolaca(cstr);
											 insertarEnPolaca("write");
											}
	| PR_WRITE ID PUNTOCOMA					{printf("	\"write ID;\" es una Escritura\n");
											 if(idDeclarado($2) == 1) return 1;
											 insertarEnPolaca($2);
											 insertarEnPolaca("write");
											}
	| PR_WRITE CONS_ENTERO PUNTOCOMA		{printf("	\"write CONS_ENTERO;\" es una Escritura\n");
											 agregarNumero(&tablaDeSimbolos, $2, "int");
											 insertarEnPolaca($2);
											 insertarEnPolaca("write");
											}
	| PR_WRITE CONS_FLOAT PUNTOCOMA			{printf("	\"write CONS_FLOAT;\" es una Escritura\n");
											 agregarNumero(&tablaDeSimbolos, $2, "float");
											 insertarEnPolaca($2);
											 insertarEnPolaca("write");
											}
	;



func_between:
	  PR_BETWEEN APAR ID 					{if(idDeclarado($3) == 1) return 1;
											 strcpy(variableBetween, $3);
											 insertarEnPolaca(variableBetween);
											 agregarConsString(&tablaDeSimbolos, "\"true\"");
											 agregarConsString(&tablaDeSimbolos, "\"false\"");								 
											}
	  COMA ACOR expresion PUNTOCOMA			{insertarEnPolaca("CMP");
											 insertarEnPolaca("BLT");
											 avanzarEnPolaca();
											 insertarEnPolaca(variableBetween);
											}
	  expresion CCOR CPAR					{printf("	\"between(ID,[Expresion;Expresion])\" es un Between\n");
											 agregarId(&tablaDeSimbolos, "@auxBetween", "string");
											 insertarEnPolaca("CMP");
											 insertarEnPolaca("BGT");
											 avanzarEnPolaca();
											 insertarEnPolaca("true");
											 insertarEnPolaca("@auxBetween");
											 insertarEnPolaca(":");
											 insertarEnPolaca("BI");
											 escribirPunteroOffset(1);
											 escribirPunteroOffset(1);
											 avanzarEnPolaca();
											 insertarEnPolaca("false");
											 insertarEnPolaca("@auxBetween");
											 insertarEnPolaca(":");
 											 insertarEnPolaca("@auxBetween");
											 escribirPuntero();
											 }
	;



func_avg:
	  PR_AVG APAR ACOR lista CCOR CPAR		{printf("	\"avg([lista])\" es un Avg\n");
											 char contadorChar[5];
											 sprintf(contadorChar, "%d", contadorAvg);
											 insertarEnPolaca(contadorChar);
											 agregarNumero(&tablaDeSimbolos, contadorChar, "int");
											 insertarEnPolaca("/");}
	;

lista:
	  lista COMA factor			{printf("	\"Lista, Factor\" es una Lista\n");
								 contadorAvg++;
								 insertarEnPolaca("+");
								}
	| factor					{printf("	\"Factor\" es una Lista\n");
								 contadorAvg = 1;
								}
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
									 agregarNumero(&tablaDeSimbolos, $1, "int");
									 insertarEnPolaca($1);
									}
	| CONS_FLOAT					{printf("	\"ConstanteReal\" es una Factor\n");
									 agregarNumero(&tablaDeSimbolos, $1, "float");
									 insertarEnPolaca($1);
									}
	| ID							{printf("	\"ID\" es una Factor\n");
									 if(idDeclarado($1) == 1) return 1;
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
	
	crearPila(&varDeclaracion);
	crearTablaSimbolos(&tablaDeSimbolos);
	crearPolacaInversa();
    yyparse();   
	imprimirTabla(&tablaDeSimbolos);
	imprimirCodigoIntermedio();

	fclose(yyin);
    return 0;
}

int yyerror(void)
{
	printf("Error Sintactico\n");
	exit (1);
}

void negarOperador()
{
	char op_negado[4];
	
	if(strcmp(aux_operador, "BLE") == 0)
        strcpy(op_negado, "BGT");
	if(strcmp(aux_operador, "BGE") == 0)
        strcpy(op_negado, "BLT");
	if(strcmp(aux_operador, "BNE") == 0)
        strcpy(op_negado, "BEQ");
	if(strcmp(aux_operador, "BEQ") == 0)
        strcpy(op_negado, "BNE");
	if(strcmp(aux_operador, "BGT") == 0)
        strcpy(op_negado, "BLE");
	if(strcmp(aux_operador, "BLT") == 0)
        strcpy(op_negado, "BGE");
		
	strcpy(aux_operador, op_negado);
}

int idDeclarado(char* id)
{
	char nombre[41];
	strcpy(nombre, "_");
	strcat(nombre, id);
	if(existeSimbolo(&tablaDeSimbolos, nombre) != 0)
	{
		printf("Error. El identificador %s no fue declarado.\n\n", id);
		return 1;
	}
}