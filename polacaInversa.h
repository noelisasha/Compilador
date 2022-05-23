#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include "pila.h"

typedef struct posicion{
    char elemento[100];
} t_posicion;

t_posicion polacaInversa[1000];
int puntero;

void crearPolacaInversa();
void insertarEnPolaca(char *elemento);
void avanzarEnPolaca();
void apilarEnPolaca();
void escribirPuntero();
void escribirPunteroOffset(int offset);
void escribirEnCeldaActual();
void imprimirCodigoIntermedio();

void crearPolacaInversa()
{
	puntero = 0;
}

void insertarEnPolaca(char *elemento)
{
	strcpy(polacaInversa[puntero].elemento, elemento);
    puntero++;
}

void avanzarEnPolaca()
{
	apilar(puntero);
	puntero++;
}

void apilarEnPolaca()
{
	apilar(puntero);
}

void escribirPuntero()
{
	int espacio = desapilar();
	char punteroChar[5];
	sprintf(punteroChar, "%d", puntero);
	strcpy(polacaInversa[espacio].elemento, punteroChar);
}

void escribirPunteroOffset(int offset)
{
	int espacio = desapilar();
	char punteroChar[5];
	int punteroOffset = puntero + offset;
	sprintf(punteroChar, "%d", punteroOffset);
	strcpy(polacaInversa[espacio].elemento, punteroChar);
}

void escribirEnCeldaActual()
{
	int espacio = desapilar();
	char espacioChar[5];
	sprintf(espacioChar, "%d", espacio);
	strcpy(polacaInversa[puntero].elemento, espacioChar);
	puntero++;
}

void imprimirCodigoIntermedio()
{
    FILE *arch = fopen("intermedia.txt", "w");
	
	if(arch == NULL)
    {
        printf("\nNo se pudo abrir el archivo intermedia.txt \n");
        return;
    }

	int i;
	for(i = 0; i < puntero; i++){
		fprintf(arch, "%4d \t %s,  \n", i, polacaInversa[i].elemento);
	}

    fclose(arch);
}