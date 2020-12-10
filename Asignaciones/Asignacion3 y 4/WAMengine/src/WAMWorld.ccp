#include "WAMWorld.h"

//Funcion para declarar la constante de gravedad.
void wWorld::setGravity(const vec2D& g)
{
	gravity = g;
}

//Funcion para a;adir mas cuerpos al world utilizando el push_back.
void wWorld::addBody(wBody* b)
{
	bodies.push_back(b);
}

//Funcion que utiliza el metodo de Euler, utilizando un vector de puntero bodies, para actualizar la propiedad de cada uno.
void wWorld::Step(float dt)
{
	//Declaramos un for que se encarga de navegar por todos los cuerpos en la lista de bodies.
	for (int counter = 0; counter < bodies.size(); counter++)
	{
		//Aqui la funcion realizara la ecuacion  para la velocidad en "x" y "y" para el bodies. La aceleracion vendria siendo la gravedad la cual se le suma las fuerzas y se multiplica pa la masa inversa.
		//Toda la ecuacion se multiplica finalmente por el tiempo para obtener la velocidad de los bodies.
		bodies[counter]->velocity.x += (gravity.x + bodies[counter]->force.x * bodies[counter]->invMass) * dt;
		bodies[counter]->velocity.y += (gravity.y + bodies[counter]->force.y * bodies[counter]->invMass) * dt;
	}

	for (int counter = 0; counter < bodies.size(); counter++)
	{
		//Aqui la funcion realizara la ecuacion para determinar la posicion "x" y "y" de los bodies. Tomando el velocity de la ecuacion anterior multiplicado por el tiempo mas la posicion del cuerpo.
		//De esta manera obtenemos las posiciones del cuerpo.
		bodies[counter]->position.x = bodies[counter]->velocity.x * dt + bodies[counter]->position.x;
		bodies[counter]->position.y = bodies[counter]->velocity.y * dt + bodies[counter]->position.y;

		bodies[counter]->force.setZero();
	}
}
