#include "Simulation.h"
#include "TextureManager.h"
#include "GameObject.h"

GameObject* boxTest;
GameObject* circle1;
GameObject* circle2;
GameObject* circle3;

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

		renderer = SDL_CreateRenderer(window,-1,0);

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
	circle1 = new GameObject("assets/small circle.png", renderer);
	circle2 = new GameObject("assets/small circle 2.png", renderer);
	circle3 = new GameObject("assets/small circle 3.png", renderer);

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
	//Se crean varias variables "x" y "y" para cada uno de los objetos en pantalla
	//La formula utiliza la ubicacion del objeto multipliada por el radio, por el seno o coseno de la W por el timecount.
	float x1 = 640 + 100 * cos(3 * timeCount);
	float x2 = 640 + 200 * cos(1 * timeCount);
	float x3 = 640 + 300 * cos(2 * timeCount);
	float y1 = 400 + 100 * sin(3 * timeCount);
	float y2 = 400 + 200 * sin(1 * timeCount);
	float y3 = 400 + 300 * sin(2 * timeCount);
	boxTest->update(640-46.25, 400-26, 92.5, 52);
	circle1->update(x1-16, y1-16, 32, 32);
	circle2->update(x2-24, y2-24, 48, 48);
	circle3->update(x3-32, y3-32, 64, 64);
}

void Simulation::render()
{
	SDL_RenderClear(renderer);
	boxTest->render();
	circle1->render();
	circle2->render();
	circle3->render();
	SDL_RenderPresent(renderer);
}

void Simulation::clean()
{
	SDL_DestroyWindow(window);
	SDL_DestroyRenderer(renderer);
	SDL_Quit();
	std::cout << "Simulation cleaned..." << std::endl;
}
