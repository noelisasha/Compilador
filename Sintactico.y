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
	  PR_IF condicion ALLV programa CLLV
	| PR_IF condicion sentencia
	| PR_IF condicion ALLV programa CLLV PR_ELSE ALLV programa CLLV
	;
	
	
	
iteracion:
	  PR_WHILE condicion ALLV programa CLLV
	;
	
	
	
condicion:
	  comparacion
	| condicion OP_AND comparacion
	| condicion OP_OR comparacion
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
	;
/**********************************************/

/*
sentencia:  	   
	asignacion {printf(" FIN\n");} ;

asignacion: 
          ID OP_ASIG expresion {printf("    ID = Expresion es ASIGNACION\n");}
	  ;

expresion:
         termino {printf("    Termino es Expresion\n");}
	 |expresion OP_SUMA termino {printf("    Expresion+Termino es Expresion\n");}
	 |expresion OP_REST termino {printf("    Expresion-Termino es Expresion\n");}
	 ;

termino: 
       factor {printf("    Factor es Termino\n");}
       |termino OP_PROD factor {printf("     Termino*Factor es Termino\n");}
       |termino OP_DIVI factor {printf("     Termino/Factor es Termino\n");}
       ;

factor: 
      ID {printf("    ID es Factor \n");}
      | CONS_ENTERO {printf("    CONS_ENTERO es Factor\n");}
	| APAR expresion CPAR {printf("    Expresion entre parentesis es Factor\n");}
     	;
		
*/
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
	fclose(yyin);
        return 0;
}
int yyerror(void)
     {
       printf("Error Sintactico\n");
	 exit (1);
     }