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
void agregarId(tabla *t, char* id);
void agregarNumero(tabla *t, char* numero);
int existeSimbolo(tabla *t, char* simb);
void agregarSimbolo(char* nombre, char* tipo, char* valor, int longitud, tabla *t);
char* substring(char *destino, const char *origen, int inicio, int largo);
void imprimirTabla(tabla *t);

void crearTablaSimbolos(tabla *t)
{
	*t = NULL;
}

void agregarId(tabla *t, char* id)
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
		agregarSimbolo(nombre, " ", " ", 0, t);
	}
}

void agregarNumero(tabla *t, char* numero)
{
	char nombre[41];
	strcpy(nombre, "_");
	strcat(nombre, numero);
	
	if(existeSimbolo(t, nombre) == 0)
	{
		//printf("Lexema %s repetido\n", numero);
		return;
	}
	else
	{
		agregarSimbolo(nombre, " ", numero, 0, t);
	}
}


void agregarConsString(tabla *t, char* consStr)
{
	char nombre[41];
	strcpy(nombre, "_");
	char nombre2[41];
	substring(nombre2, consStr, 1, strlen(consStr)-2);
	strcat(nombre, nombre2);
	
	if(existeSimbolo(t, nombre) == 0)
	{
		//printf("Lexema %s repetido\n", consStr);
		return;
	}
	else
	{
		agregarSimbolo(nombre, " ", nombre2, strlen(nombre), t);
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