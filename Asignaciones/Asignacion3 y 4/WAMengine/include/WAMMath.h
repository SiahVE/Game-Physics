#ifndef WAMMATH_H
#define WAMMATH_H

#include <math.h>
#include <float.h>
#include <stdlib.h>

struct vec2D
{
	//Declaramos los componentes del vector
	float x, y;

	//Creamos un constructor DEFAULT.
	vec2D() {}

	//Creamos un constructor para pasar los componentes del vector.
	vec2D(float x, float y) : x(x), y(y) {}

	//Creamos una funcion para establecer el vector como 0.
	void setZero();

	//Creamos una funcion que nos permita cambiar el valor de ambas compoenentes.
	void Set(const float &x_, const float &y_);

	//Creamos una funcion que se encargue de imprimir las componentes del vector.
	void displayVector() const;

	//Definimos una funcion que calcule la longitud CUADRADA del vector.
	float lenghtSquared() const;

	//Definimos una funcion que calcula la longitud del vector.
	float lenght() const;

	//Creamos un metodo para sumarle un vector al vector actual.
	void operator += (const vec2D &v);

	//Creamos un metodo para restarle un vector al vector actual.
	void operator -= (const vec2D &v);

	//Creamos un metodo para multiplicar el vector por un escalar.
	void operator *= (const float &k);
};

inline vec2D operator + (const vec2D &a, const vec2D &b)
{
	return vec2D(a.x + b.x, a.y + b.y);
}

inline vec2D operator - (const vec2D &a, const vec2D &b)
{
	return vec2D(a.x - b.x, a.y - b.y);
}

inline vec2D operator * (const float &k, const vec2D &v)
{
	return vec2D(k * v.x, k * v.y);
}

#endif /*WAMMATH_H*/
