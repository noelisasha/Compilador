#include <stdio.h>
#include <stdlib.h>

struct nodo {
    int numero;
    struct nodo *siguiente;
};

struct nodo *superior = NULL;

void apilar(int numero);
int desapilar();

void apilar(int numero)
{
    struct nodo *nuevoNodo = malloc(sizeof(struct nodo));
    nuevoNodo->numero = numero;
    nuevoNodo->siguiente = superior;
    superior = nuevoNodo;
}

int desapilar()
{
    if (superior != NULL)
	{
        struct nodo *temporal = superior;
		int topePila = temporal->numero;
        superior = superior->siguiente;

        free(temporal);
		return topePila;
    }
	return -1;
}