#ifndef WAMBODY_H
#define WAMBODY_H

#include "WAMMath.h"

struct wBody
{
	//Declaramos el constructor de la clase.
	wBody();

	//Declaramos la masa del objeto y el reciproco de la masa.
	float mass;
	float invMass;

	//Declaramos la posicion lineal del objeto.
	vec2D position;

	//Declaramos la velocidad lineal del objeto.
	vec2D velocity;

	//Declaramos la fuerza aplicada al objeto.
	vec2D force;

	//Creamos una funcion que muestre las propiedades del objeto.
	void displayBodyInfo();

	//Creamos una funcion para agregar masa al objeto.
	void setMass(const float &m);

	//Creamos funcion para agregar fuerza al objeto.
	void addForce(const vec2D &f);
};

#endif /* WAMBODY_H */
