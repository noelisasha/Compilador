#include <stdlib.h>
#include <stdio.h>
#include <string.h>


typedef struct posicion{
    char elemento[100];
} t_posicion;

t_posicion polacaInversa[1000];
int puntero;

void crearPolacaInversa();
void insertarEnPolaca(char *elemento);
void imprimirCodigoIntermedio();

void crearPolacaInversa()
{
	puntero = 0;
	//TODO --- ---- inicializar pila
}

void insertarEnPolaca(char *elemento)
{
	strcpy(polacaInversa[puntero].elemento, elemento);
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
		fprintf(arch, "%s,  \n", polacaInversa[i].elemento);
	}

    fclose(arch);
}