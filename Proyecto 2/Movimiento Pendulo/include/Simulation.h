#ifndef SIMULATION_H
#define SIMULATION_H

#include <iostream>
#include <SDL.h>
#include <SDL_image.h>

class Simulation
{
public:
	Simulation();
	~Simulation();

	void init(const char* title, int xpos, int ypos, int width, int heigth, bool fullscreen);

	void handleEvents();
	void update(float dt = 0.0f);
	void render();
	void clean();

	bool running() { return isRunning; }

private:
	int count = 0;
	bool isRunning;
	float timeCount = 0.0f;
	float x, y;
	SDL_Window* window;
	SDL_Renderer* renderer;
};

#endif /*SIMULATION_H*/
