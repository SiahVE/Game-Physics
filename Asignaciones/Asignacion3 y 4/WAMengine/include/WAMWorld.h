#ifndef WAMWORLD_H
#define WARWORLD_H

#include "WAMBody.h"
#include <vector>

struct wWorld
{
	//Definimos el constructor de la clase.
	wWorld() {}
	wWorld(vec2D gravity) : gravity(gravity) {}

	//Declaramos la variable gravedad del world.
	vec2D gravity;

	//Declaramos un vector que contenga todos los cuerpos de este world.
	std::vector<wBody*> bodies;

	//Creamos una funcion para establecer la gravedad del world.
	void setGravity(const vec2D &g);

	//Creamos una funcion para agregar un cuerpo a este world.
	void addBody(wBody* b);

	//Creamos la funcion Step. Esta es al encargada de la simulacion.
	void Step(float dt); //El dt suele ser el tiempo que toma pasar de un frame al otro.
};

#endif /*WAMWORLD_H*/
