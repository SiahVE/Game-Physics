#include "WAMBody.h"
#include <iostream>

//Declaracion del cuerpo, donde utilizamos la funcion setZero para darle valores de 0 a position, velocity y force. Y declaramos mass y invMass. Este construct se encarga de inicializar el cuerpo.
wBody::wBody()
{
	position.setZero();
	velocity.setZero();
	force.setZero();
	mass = 1.0f;
	invMass = 1.0f;
}

//Funcion que transforma mass para el invMass, para la funcion setMass.
void wBody::setMass(const float& m)
{
	mass = m;
	invMass = 1 / m;
}

//Funcion que se encarga de a;adir force a la funcion addForce.
void wBody::addForce(const vec2D &f)
{
	force += f;
}

//Funcion que se encarga de mostrar la informacion de los cuerpos en pantalla. 
void wBody::displayBodyInfo()
{
	std::cout << "m: " << mass << std::endl;
	std::cout << "Inv mass: " << invMass << std::endl;
	std::cout << "pos: ", position.displayVector();
	std::cout << "vel: ", velocity.displayVector();
	std::cout << "\n" << std::endl;
}
