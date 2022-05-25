#include <stdio.h>
#include <stdlib.h>

typedef struct nodoChar {
    struct nodoChar *anterior;
    char dato[100];
}t_nodoChar;

typedef t_nodoChar *superiorChar;

void crearPila(superiorChar *sup);
void apilarChar(superiorChar *sup, char *elemento);
int desapilarChar();

void crearPila(superiorChar *sup)
{
	*sup = NULL;
}

void apilarChar(superiorChar *sup, char *elemento)
{
    t_nodoChar *nuevoNodo = (t_nodoChar*)malloc(sizeof(t_nodoChar));
	strcpy(nuevoNodo->dato, elemento);
    nuevoNodo->anterior = *sup;
    *sup = nuevoNodo;
}

int desapilarChar(superiorChar *sup, char *elemento)
{
    if (*sup == NULL)
		return -1;
	
    t_nodoChar *temporal = (t_nodoChar*)malloc(sizeof(t_nodoChar)); 
	temporal = *sup;
	strcpy(elemento, temporal->dato);
    *sup = temporal->anterior;

    free(temporal);
	return 0;
    
}