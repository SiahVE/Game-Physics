#include "Simulation.h"
#include "TextureManager.h"
#include "GameObject.h"

GameObject* boxTest;
GameObject* pin;
const float pi = 3.141592653589793f;

Simulation::Simulation()
{}

Simulation::~Simulation()
{}

void Simulation::init(const char* title, int xpos, int ypos, int width, int height, bool fullscreen)
{
	int flags = 0;
	if (fullscreen)
	{
		flags = SDL_WINDOW_FULLSCREEN;
	}

	if (SDL_Init(SDL_INIT_EVERYTHING) == 0)
	{
		std::cout << "SDL Initialized!" << std::endl;
		window = SDL_CreateWindow(title, xpos, ypos, width, height, flags);

		if (window)
		{
			std::cout << "Window Created!" << std::endl;
		}

		renderer = SDL_CreateRenderer(window, -1, 0);

		if (renderer)
		{
			std::cout << "Renderer Created!" << std::endl;
		}

		isRunning = true;
	}
	else
	{
		std::cout << "Couldn't initiate SDL..." << std::endl;
		isRunning + false;
	}

	boxTest = new GameObject("assets/BoxTest.png", renderer);
	pin = new GameObject("assets/small circle.png", renderer);

}

void Simulation::handleEvents()
{
	SDL_Event event;
	SDL_PollEvent(&event);

	switch (event.type)
	{
	case SDL_QUIT:
		isRunning = false;
		break;

	default:
		break;
	}
}

void Simulation::update(float dt)
{
	//Se crea timecount para generar el movimiento
	timeCount += dt;
	//Constante l que representa la longitud de la cuerda
	const float l = 200.0f;
	//constante a que representa el angulo que se generara al transformarlo a radian
	const float a = 15.0f * (pi / 180.0f);
	//Variable t que representara el movimiento al multiplicar el resultado de la W por el timecount por coseno y el angulo.
	float t = a * (cos(0.77460f * timeCount));
	//Variables "x" y "y" que se le colocaran en el update del objeto que se movera y que lo realizara al multiplicar la longitud de la cuerda por el seno o coseno del resultado de la variable t.
	x = l * sin (t) + 640.0f;
	y = l * cos (t) + 400.0f;
	boxTest->update(x - 46.25, y - 26, 92.5f, 52.0f);
	//Se agrega el pin que ayudara a representar el pendulo.
	pin->update(640 - 8, 400 - 8, 16, 16);
}

void Simulation::render()
{
	SDL_RenderClear(renderer);

	SDL_SetRenderDrawColor(renderer, 255, 255, 255, SDL_ALPHA_OPAQUE);
	SDL_RenderDrawLine(renderer, 640, 400, x, y);

	SDL_SetRenderDrawColor(renderer, 0, 0, 0, SDL_ALPHA_OPAQUE);

	boxTest->render();
	pin->render();
	SDL_RenderPresent(renderer);
}

void Simulation::clean()
{
	SDL_DestroyWindow(window);
	SDL_DestroyRenderer(renderer);
	SDL_Quit();
	std::cout << "Simulation cleaned..." << std::endl;
}
