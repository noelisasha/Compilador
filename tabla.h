#include <stdlib.h>
#include <stdio.h>
#include <string.h>

typedef struct simbolo
{
	struct simbolo * sig;
	char nombre[40];
	char tipo[20];
	char valor[40];
	int longitud;
} tSimbolo;

typedef tSimbolo* tabla;

void crearTablaSimbolos(tabla *t);
void agregarId(tabla *t, char* id, char* tipo);
void agregarNumero(tabla *t, char* numero, char* tipo);
void agregarConsString(tabla *t, char* consStr);
int existeSimbolo(tabla *t, char* simb);
void agregarSimbolo(char* nombre, char* tipo, char* valor, int longitud, tabla *t);
char* substring(char *destino, const char *origen, int inicio, int largo);
void removeSpacesInPlace(char* str);
void imprimirTabla(tabla *t);
void generarCabeceraAssembler(tabla *t);

void crearTablaSimbolos(tabla *t)
{
	*t = NULL;
}

void agregarId(tabla *t, char* id, char* tipo)
{
	char nombre[41];
	strcpy(nombre, "_");
	strcat(nombre, id);
	
	if(existeSimbolo(t, nombre) == 0)
	{
		//printf("Lexema %s repetido\n", id);
		return;
	}
	else
	{
		agregarSimbolo(nombre, tipo, "", 0, t);
	}
}

void agregarNumero(tabla *t, char* numero, char* tipo)
{
	char nombre[41];
	strcpy(nombre, "_");
	strcat(nombre, numero);
	removeSpacesInPlace(nombre);
	
	if(existeSimbolo(t, nombre) == 0)
	{
		//printf("Lexema %s repetido\n", numero);
		return;
	}
	else
	{
		agregarSimbolo(nombre, tipo, numero, 0, t);
	}
}


void agregarConsString(tabla *t, char* consStr)
{
	char nombre[41];
	strcpy(nombre, "_");
	char nombre2[41];
	substring(nombre2, consStr, 1, strlen(consStr)-2);
	strcat(nombre, nombre2);
	removeSpacesInPlace(nombre);
	
	if(existeSimbolo(t, nombre) == 0)
	{
		//printf("Lexema %s repetido\n", consStr);
		return;
	}
	else
	{
		agregarSimbolo(nombre, "string", nombre2, strlen(nombre), t);
	}
}

int existeSimbolo(tabla *t, char* simb)
{
	int coincidencia = 1;
	while(*t && (coincidencia = strcmp((*t)->nombre, simb) != 0))
	{
        t = &(*t)->sig;
	}
	
	return coincidencia;
}

void agregarSimbolo(char* nombre, char* tipo, char* valor, int longitud, tabla *t)
{
	tSimbolo* simboloNuevo = (tSimbolo*)malloc(sizeof(tSimbolo));
	if(!simboloNuevo)
	{
		printf("No hay memoria para agregar %s a la tabla de simbolos\n", nombre);
		return;
	}
	
	strcpy(simboloNuevo->nombre, nombre);
	strcpy(simboloNuevo->tipo, tipo);
	strcpy(simboloNuevo->valor, valor);
	simboloNuevo->longitud = longitud;
	simboloNuevo->sig = *t;
	*t = simboloNuevo;
}

char* substring(char *destino, const char *origen, int inicio, int largo)
{
    while (largo > 0)
    {
        *destino = *(origen + inicio);
        destino++;
        origen++;
        largo--;
    }
 
    *destino = '\0';
 
    return destino;
}

void removeSpacesInPlace(char* str) 
{ 
	int i; 
	for (i = 0; i < strlen(str); i++) 
	{ 
		if (str[i] == ' ' || str[i] == '.' || str[i] == ':') 
		{ 
			str[i] = '_'; 
		} 
		else if( str[i] == '>')
		{
			str[i] = 'M'; 
		}
		else if(str[i] == '<')
		{
			str[i] = 'm'; 
		}
		else if(str[i] == '=')
		{
			str[i] = 'I'; 
		}
		else if(str[i] == '!')
		{
			str[i] = 'N'; 
		}
	} 	
}


void imprimirTabla(tabla *t)
{
    FILE *arch = fopen("ts.txt", "w");
	
	if(arch == NULL)
    {
        printf("\nNo se pudo abrir el archivo ts.txt \n");
        return;
    }

    fprintf(arch, "\n                                                         Tabla de Símbolos\n\n");
    fprintf(arch, "|%-40s|%-14s|%-40s|%-10s|\n\n", "NOMBRE", "TIPO DE DATO", "VALOR", "LONGITUD");

    while(*t)
    {
        fprintf(arch, "|%-40s|%-14s|%-40s|%-10d|\n", (*t)->nombre, (*t)->tipo, (*t)->valor, (*t)->longitud);
        t = &(*t)->sig;
    }

    fclose(arch);
}

void generarCabeceraAssembler(tabla *t)
{
	FILE *arch = fopen("Final.asm", "w");
	
	if(arch == NULL)
    {
        printf("\nNo se pudo abrir el archivo Final.asm \n");
        return;
    }
	
	fprintf(arch, "include macros2.asm\n");
	fprintf(arch, "include number.asm\n\n");
	
	fprintf(arch, ".MODEL  LARGE\n");
	fprintf(arch, ".386\n");
	fprintf(arch, ".STACK 200h\n\n");
	
	fprintf(arch, "MAXTEXTSIZE equ 30\n\n");
	
	fprintf(arch, ".DATA\n\n");
	
	while(*t)
    {
		if( strcmp((*t)->valor, "") == 0 )
		{
			if( strcmp((*t)->tipo, "int") == 0 )
			{
				fprintf(arch, "    %-35s         %s    %s\n", (*t)->nombre, "dq", "?");
			}
			else if( strcmp((*t)->tipo, "float") == 0 )
			{
				fprintf(arch, "    %-35s         %s    %s\n", (*t)->nombre, "dt", "?");
			} 
			else if( strcmp((*t)->tipo, "string") == 0 )
			{
				fprintf(arch, "    %-35s         %s\n", (*t)->nombre, "db    MAXTEXTSIZE dup (?),'$'");
			}
		}
		else
		{
			if( strcmp((*t)->tipo, "int") == 0 )
			{
				fprintf(arch, "    %-35s         %s    %s\n", (*t)->nombre, "dq", (*t)->valor);
			}
			else if( strcmp((*t)->tipo, "float") == 0 )
			{
				fprintf(arch, "    %-35s         %s    %s\n", (*t)->nombre, "dt", (*t)->valor);
			}
			else if( strcmp((*t)->tipo, "string") == 0 )
			{
				fprintf(arch, "    %-35s         %s    \"%s\"\n", (*t)->nombre, "db", (*t)->valor);
			}
		}
        t = &(*t)->sig;
    }
	
	fprintf(arch, "\n.CODE\n\n");

}
