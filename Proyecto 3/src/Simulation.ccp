#include "Simulation.h"
#include "TextureManager.h"
#include "GameObject.h"

GameObject* tilemap;
GameObject* character;
GameObject* platform4;
SDL_Event Simulation::event;

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
		window = SDL_CreateWindow(title, xpos, ypos, width, height, flags | SDL_WINDOW_RESIZABLE);

		if (window)
		{
			std::cout << "Window created!" << std::endl;
		}

		renderer = SDL_CreateRenderer(window, -1, 0);

		if (renderer)
		{
			std::cout << "Renderer created!" << std::endl;
		}

		isRunning = true;
	}
	else
	{
		std::cout << "Couldn't initiate SDL..." << std::endl;
		isRunning = false;
	}

	tilemap = new GameObject("assets/space background.png", renderer);
	character = new GameObject("assets/char.png", renderer);
	platform4 = new GameObject("assets/platform4.png", renderer);

	for (int i = 0; i < 322; i++)
	{
		KEYS_DOWN[i] = false;
		KEYS_UP[i] = false;
		APPLIED[i] = false;
	}
}

void Simulation::handleEvents(b2Body* characterBody, bool onAir)
{

	if (SDL_PollEvent(&event))
	{
		switch (event.type)
		{
		case SDL_QUIT:
			isRunning = false;
			break;

		case SDL_KEYDOWN:
			KEYS_DOWN[event.key.keysym.sym] = true;
			KEYS_UP[event.key.keysym.sym] = false;
			break;

		case SDL_KEYUP:
			KEYS_DOWN[event.key.keysym.sym] = false;
			KEYS_UP[event.key.keysym.sym] = true;
			break;

		default:
			break;
		}
	}

	if (!onAir)
	{
		if (KEYS_DOWN[SDLK_d] && !APPLIED[SDLK_d])
		{
			characterBody->SetLinearVelocity(characterBody->GetLinearVelocity() + b2Vec2(movingSpeed, 0.0f));
			APPLIED[SDLK_d] = true;
		}
		else if (KEYS_UP[SDLK_d])
		{
			characterBody->SetLinearVelocity(b2Vec2(0.0f, 0.0f));
			KEYS_UP[SDLK_d] = false;
			APPLIED[SDLK_d] = false;
		}

		if (KEYS_DOWN[SDLK_a] && !APPLIED[SDLK_a])
		{
			characterBody->SetLinearVelocity(characterBody->GetLinearVelocity() - b2Vec2(movingSpeed, 0.0f));
			APPLIED[SDLK_a] = true;
		}
		else if (KEYS_UP[SDLK_a])
		{
			characterBody->SetLinearVelocity(b2Vec2(0.0f, 0.0f));
			KEYS_UP[SDLK_a] = false;
			APPLIED[SDLK_a] = false;
		}

		APPLIED[SDLK_SPACE] = false;
		doubleJumpControl = false;
	}

	if (KEYS_DOWN[SDLK_SPACE] && !APPLIED[SDLK_SPACE] && !jumping)
	{
		if (characterBody->GetLinearVelocity().x == 0)
		{
			characterBody->SetLinearVelocity(characterBody->GetLinearVelocity() + b2Vec2(0.0f, -400.0f / ppm));
		}
		else if (characterBody->GetLinearVelocity().x > 0)
		{
			characterBody->SetLinearVelocity(characterBody->GetLinearVelocity() + b2Vec2(50.0f / ppm, -400.0f / ppm));
		}
		else if (characterBody->GetLinearVelocity().x < 0)
		{
			characterBody->SetLinearVelocity(characterBody->GetLinearVelocity() + b2Vec2(-50.0f / ppm, -400.0f / ppm));
		}
		jumping = true;
	}

	else if (KEYS_UP[SDLK_SPACE] && onAir)
	{
		doubleJumpControl = true;
	}

	else if (KEYS_DOWN[SDLK_SPACE] && !APPLIED[SDLK_SPACE] && jumping && doubleJumpControl && onAir)
	{
		std::cout << "SECOND JUMP DETECTED" << std::endl;

		if (characterBody->GetLinearVelocity().x == 0)
		{
			characterBody->SetLinearVelocity(characterBody->GetLinearVelocity() + b2Vec2(0.0f, -200.0f / ppm));
		}
		else if (characterBody->GetLinearVelocity().x > 0)
		{
			characterBody->SetLinearVelocity(characterBody->GetLinearVelocity() + b2Vec2(50.0f / ppm, -200.0f / ppm));
		}
		else if (characterBody->GetLinearVelocity().x < 0)
		{
			characterBody->SetLinearVelocity(characterBody->GetLinearVelocity() + b2Vec2(-50.0f / ppm, -200.0f / ppm));
		}
		APPLIED[SDLK_SPACE] = true;
		jumping = false;
	}
}

void Simulation::update(float x, float y, float rot, float dt)
{
	SDL_GetWindowSize(window, &wWindow, &hWindow);
	xScale = wWindow / 640.0f;
	yScale = hWindow / 360.0f;
	character->update((x - 24.0f) * xScale, (y - 24.0f) * yScale, 48.0f * xScale, 48.0f * yScale);
	platform4->update((270.0f - 69.0f) * xScale, (158.0f - 24.5f) * yScale, 138.0f * xScale, 49.0f * yScale);
}

void Simulation::render()
{
	SDL_RenderClear(renderer);
	tilemap->render(true);
	character->render();
	platform4->render();
	SDL_RenderPresent(renderer);
}

void Simulation::clean()
{
	SDL_DestroyWindow(window);
	SDL_DestroyRenderer(renderer);
	SDL_Quit();
	std::cout << "Simulation cleaned..." << std::endl;
}
