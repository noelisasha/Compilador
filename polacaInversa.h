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
int escribirPuntero();
void escribirPunteroCompOr();
int escribirPunteroOffset(int offset);
void escribirEnCeldaActual();
void imprimirCodigoIntermedio();
void generarCodigoAssembler();
void negarOp(char *elemento);

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

int escribirPuntero()
{
	int espacio = desapilar();
	char punteroChar[5];
	sprintf(punteroChar, "%d", puntero);
	strcpy(polacaInversa[espacio].elemento, punteroChar);
	return espacio;
}

void escribirPunteroCompOr(int offset)
{
	int espacio = desapilar();
	char punteroChar[5];
	sprintf(punteroChar, "%d", offset+1);
	strcpy(polacaInversa[espacio].elemento, punteroChar);
	
	char espacioComparador[5];
	strcpy(espacioComparador, polacaInversa[espacio-1].elemento);
	negarOp(espacioComparador);
	strcpy(polacaInversa[espacio-1].elemento, espacioComparador);
}

int escribirPunteroOffset(int offset)
{
	int espacio = desapilar();
	char punteroChar[5];
	int punteroOffset = puntero + offset;
	sprintf(punteroChar, "%d", punteroOffset);
	strcpy(polacaInversa[espacio].elemento, punteroChar);
	return espacio;
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
		fprintf(arch, "%4d \t %s\n", i, polacaInversa[i].elemento);
	}

    fclose(arch);
}

void generarCodigoAssembler()
{
	FILE *arch = fopen("Final.asm", "a");
	
	if(arch == NULL)
    {
        printf("\nNo se pudo abrir el archivo Final.asm \n");
        return;
    }
	
	fprintf(arch, "START:\n");
	fprintf(arch, "    mov AX,@DATA\n");
	fprintf(arch, "    mov DS,AX\n");
	fprintf(arch, "    mov es,ax\n");
	
	int i;
	for(i = 0; i < puntero; i++){
		//fprintf(arch, "%4d \t %s\n", i, polacaInversa[i].elemento);
		
	}
	
	fprintf(arch, "    mov ax, 4C00h\n");
	fprintf(arch, "    int 21h\n");
	fprintf(arch, "END START\n");
	    
    fclose(arch);
}

void negarOp(char *elemento)
{
	char op_negado[4];
	
	if(strcmp(elemento, "BLE") == 0)
        strcpy(op_negado, "BGT");
	if(strcmp(elemento, "BGE") == 0)
        strcpy(op_negado, "BLT");
	if(strcmp(elemento, "BNE") == 0)
        strcpy(op_negado, "BEQ");
	if(strcmp(elemento, "BEQ") == 0)
        strcpy(op_negado, "BNE");
	if(strcmp(elemento, "BGT") == 0)
        strcpy(op_negado, "BLE");
	if(strcmp(elemento, "BLT") == 0)
        strcpy(op_negado, "BGE");
		
	strcpy(elemento, op_negado);
}