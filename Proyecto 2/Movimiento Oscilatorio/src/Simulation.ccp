#include "Simulation.h"
#include "TextureManager.h"
#include "GameObject.h"

GameObject* boxTest;
GameObject* boxTest2;
GameObject* boxTest3;

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
	boxTest2 = new GameObject("assets/BoxTest 2.png", renderer);
	boxTest3 = new GameObject("assets/BoxTest 3.png", renderer);

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
	//Se crea contador para generar el movimiento
	timeCount += dt;
	//Se crea distintas variables "x" y "y" para generar el movimiento de varias cajas por separadas, y con modificaciones en sus valores para obtener distintas velocidades y amplitudes distintas
	float y1 = 300.0f + 200.0f * sin(5.0f * timeCount);
	float y2 = 300.0f + 100.0f * sin(2.0f * timeCount);
	float x1 = 300.0f + 200.0f * sin(4.0f * timeCount);
	boxTest->update(500.0, y1, 92.5f, 52.0f);
	boxTest2->update(700.0, y2, 92.5f, 52.0f);
	boxTest3->update(x1, 600.0, 92.5f, 52.0f);
}

void Simulation::render()
{
	SDL_RenderClear(renderer);
	boxTest->render();
	boxTest2->render();
	boxTest3->render();
	SDL_RenderPresent(renderer);
}

void Simulation::clean()
{
	SDL_DestroyWindow(window);
	SDL_DestroyRenderer(renderer);
	SDL_Quit();
	std::cout << "Simulation cleaned..." << std::endl;
}
