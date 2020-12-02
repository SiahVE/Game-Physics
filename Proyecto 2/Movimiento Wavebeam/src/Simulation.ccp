#include "Simulation.h"
#include "TextureManager.h"
#include "GameObject.h"

GameObject* packMan;
GameObject* ghost;

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

	packMan = new GameObject("assets/Packman.png", renderer);
	ghost = new GameObject("assets/Ghost.png", renderer);

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
	//Se crean 2 timecount distinto para cada asset
	timeCount1 += dt;
	timeCount2 += dt;
	//Se crean las variables de velocidad (v) y amplitud(a)
	const float v = 150.0f;
	const float a = 150.0f;
	//Para generar movimiento en X, se multiplica la velocidad por el timecount.
	float xp = v * timeCount1;
	float xg = v * timeCount2;
	//Para generar el movimiento de wavebeam se multiplica la amplitud por seno y la W y timecount (el 0.2 en ambas y representan la distancia en que se mueven cada assets separado) y le sumamos 350 que seria su posicion.
	float yp = a * sin(5.0f * timeCount1 + 0.2) + 350.0f;
	float yg = a * sin(5.0f * timeCount2 - 0.2) + 350.0f;

	//If por el cual dara inicio al movimiento de ambos assets (con resta de pixeles para que inicien fuera de pantalla y separados uno del otro)
	if (xp && xg < 1500)
	{
		packMan->update(xp - 100.0, yp, 64, 64);
		ghost->update(xg - 175.0, yg, 64, 64);
	}
	//Else if que una vez los assets salgan de pantalla reinicia el timecount y los ubica en su posicion de inicio nuevamente.
	else if (xp && xg > 1500)
	{
		timeCount1 = timeCount1 - timeCount1;
		timeCount2 = timeCount2 - timeCount2;
		packMan->update(xp - 100.0, yp, 64, 64);
		ghost->update(xg - 175.0, yg, 64, 64);
	}
}

void Simulation::render()
{
	SDL_RenderClear(renderer);
	packMan->render();
	ghost->render();
	SDL_RenderPresent(renderer);
}

void Simulation::clean()
{
	SDL_DestroyWindow(window);
	SDL_DestroyRenderer(renderer);
	SDL_Quit();
	std::cout << "Simulation cleaned..." << std::endl;
}
