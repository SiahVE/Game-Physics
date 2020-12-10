#include <WAMWorld.h>

int main()
{
	//Declaramos el world de la simulacion y le pasamos los vectores "x" y "y" a utilizar, en este caso x = 0 y y = 9.81 la gravedad de la tierra.
	wWorld firstSimulation(vec2D(0.0f, 9.81f));

	//Declaramos los cuerpos que estaran presente dentro de la simulacion.
	wBody firstBody;
	wBody secondBody;

	//Aqui declaramos el position y el velocity de secondbody que se a;adio al world.
	secondBody.position = vec2D(5.0f, 10.0f);
	secondBody.velocity = vec2D(7.0f, 3.8f);

	//A;adimos los cuerpos dentro de la simulacion con addBody como referencias.
	firstSimulation.addBody(&firstBody);
	firstSimulation.addBody(&secondBody);

	//Declaramos el frametime determina el tiempo de cada frame a utilizar en el step.
	float frameTime = 0.05f;

	//Un simple contador utiliado en el siguiente while
	int counter = 0;

	//En este while utilizando la funcion creada en Body.ccp nos mostrara como los valores que los cuerpos tienen durante el frame.
	while (counter < 10)
	{
		firstBody.displayBodyInfo();
		secondBody.displayBodyInfo();
		firstSimulation.Step(frameTime);
		counter++;
	}

	return 0;
}
