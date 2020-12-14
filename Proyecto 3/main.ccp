#include <Box2D/include/box2d.h>
#include "Simulation.h"

int main(int argc, char* args[])
{
	const float FPS = 60;
	const float frameDelay = 1000 / FPS;

	Uint32 frameStart;
	Uint32 frameEnd;
	float frameTime = 0.0f;

	Simulation* simulation = nullptr;
	simulation = new Simulation();
	simulation->init("WAM Engine", SDL_WINDOWPOS_CENTERED, SDL_WINDOWPOS_CENTERED, 640.0, 360.0, false);

	/*
		PIXEL PER METER VALUE
		PPM = Pixer Per Meter
	*/

	float ppm = 16.0f;

	/*
		CREAMOS EL WORLD
	*/

	b2World gameWorld(b2Vec2(0.0f, 3.6f));

	/*
		CREAMOS EL CONTACT LISTENER
	*/

	MyContactListener mainListener;
	gameWorld.SetContactListener(&mainListener);

	/*
		CREAR EL CUERPO DEL PERSONAJE
	*/

	b2BodyDef charBodyDef;
	charBodyDef.position.Set(100.0f / ppm, 182.0f / ppm);
	charBodyDef.type = b2_dynamicBody;

	b2Body* charBody = gameWorld.CreateBody(&charBodyDef);

	b2PolygonShape charBox;
	charBox.SetAsBox(23.0f * 0.5f / ppm, 44.0f * 0.5f / ppm);

	b2FixtureDef charBodyFixtures;
	charBodyFixtures.shape = &charBox;
	charBodyFixtures.density = 1.0f;
	charBodyFixtures.friction = 0.0f;

	charBody->CreateFixture(&charBodyFixtures);
	charBody->SetFixedRotation(true);

	//SENSOR PARA EL PERSONAJE

	charBodyFixtures.isSensor = true;
	b2Fixture* sensorFixture = charBody->CreateFixture(&charBodyFixtures);
	b2FixtureUserData* sensor_data = &sensorFixture->GetUserData();
	sensor_data->pointer = 25;

	/*
		CREAMOS EL SUELO
	*/

	b2BodyDef floorDef;
	floorDef.position.Set(320.0f / ppm, 329.f / ppm);

	b2Body* floorBody = gameWorld.CreateBody(&floorDef);

	b2PolygonShape floorBox;
	floorBox.SetAsBox(2000.0f * 0.5f / ppm, 37.0f * 0.5 / ppm);

	b2FixtureDef floorFixtures;
	floorFixtures.shape = &floorBox;
	floorFixtures.density = 0.0f;
	
	floorBody->CreateFixture(&floorFixtures);

	/*
		SENSOR PARA EL SUELO
	*/

	floorFixtures.isSensor = true;
	b2Fixture* floorsensorFixture = floorBody->CreateFixture(&floorFixtures);
	b2FixtureUserData* floor_sensor_data = &floorsensorFixture->GetUserData();
	floor_sensor_data->pointer = 35;

	/*
		PLATAFORMA 1
	*/

	b2BodyDef plat1Def;
	plat1Def.position.Set(80.0f / ppm, 211.0 / ppm);

	b2Body* plat1Body = gameWorld.CreateBody(&plat1Def);

	b2PolygonShape plat1Box;
	plat1Box.SetAsBox(88.0f * 0.5f / ppm, 10.0f * 0.5 / ppm);

	b2FixtureDef plat1Fixtures;
	plat1Fixtures.shape = &plat1Box;
	plat1Fixtures.density = 0.0f;

	plat1Body->CreateFixture(&plat1Fixtures);

	/*
		SENSOR PARA PLAT1
	*/

	plat1Fixtures.isSensor = true;
	b2Fixture* plat1sensorFixture = plat1Body->CreateFixture(&plat1Fixtures);
	b2FixtureUserData* plat1_sensor_data = &plat1sensorFixture->GetUserData();
	plat1_sensor_data->pointer = 1;

	/*
		PLATAFORMA 2
	*/

	b2BodyDef plat2Def;
	plat2Def.position.Set(475.0f / ppm, 105.0f / ppm);

	b2Body* plat2Body = gameWorld.CreateBody(&plat2Def);

	b2PolygonShape plat2Box;
	plat2Box.SetAsBox(128.0f * 0.5f / ppm, 10.0f * 0.5f / ppm);

	b2FixtureDef plat2Fixtures;
	plat2Fixtures.shape = &plat2Box;
	plat2Fixtures.density = 0.0f;

	plat2Body->CreateFixture(&plat2Fixtures);

	/*
		SENSOR PARA PLAT2
	*/

	plat2Fixtures.isSensor = true;
	b2Fixture* plat2sensorFixture = plat2Body->CreateFixture(&plat2Fixtures);
	b2FixtureUserData* plat2_sensor_data = &plat2sensorFixture->GetUserData();
	plat2_sensor_data->pointer = 2;

	/*
		PLATAFORMA 3
	*/

	b2BodyDef plat3Def;
	plat3Def.position.Set(544.0f / ppm, 217.0 / ppm);

	b2Body* plat3Body = gameWorld.CreateBody(&plat3Def);

	b2PolygonShape plat3Box;
	plat3Box.SetAsBox(128.0f * 0.5f / ppm, 10.0f * 0.5 / ppm);

	b2FixtureDef plat3Fixtures;
	plat3Fixtures.shape = &plat3Box;
	plat3Fixtures.density = 0.0f;

	plat3Body->CreateFixture(&plat3Fixtures);

	/*
		SENSOR PARA PLAT3
	*/

	plat3Fixtures.isSensor = true;
	b2Fixture* plat3sensorFixture = plat3Body->CreateFixture(&plat3Fixtures);
	b2FixtureUserData* plat3_sensor_data = &plat3sensorFixture->GetUserData();
	plat3_sensor_data->pointer = 3;


	/*
		PLATAFORMA 4
	*/

	b2BodyDef plat4Def;
	plat4Def.position.Set(270.0f / ppm, 158.0 / ppm);

	b2Body* plat4Body = gameWorld.CreateBody(&plat4Def);

	b2PolygonShape plat4Box;
	plat4Box.SetAsBox(128.0f * 0.5f / ppm, 10.0f * 0.5 / ppm);

	b2FixtureDef plat4Fixtures;
	plat4Fixtures.shape = &plat4Box;
	plat4Fixtures.density = 0.0f;

	plat4Body->CreateFixture(&plat4Fixtures);

	/*
		SENSOR PARA PLAT4
	*/

	plat4Fixtures.isSensor = true;
	b2Fixture* plat4sensorFixture = plat4Body->CreateFixture(&plat4Fixtures);
	b2FixtureUserData* plat4_sensor_data = &plat4sensorFixture->GetUserData();
	plat4_sensor_data->pointer = 4;


	/*
		INICIA LA SIMULACIÓN.
	*/

	while (simulation->running()) 
	{
		frameStart = SDL_GetTicks();

		simulation->handleEvents(charBody, mainListener.onAir);
		simulation->update(charBody->GetPosition().x * ppm, charBody->GetPosition().y * ppm);
		simulation->render();


		/*
			AQUÍ VA EL STEP() DEL WORLD.
		*/

		gameWorld.Step(frameTime / 1000.0f, 6, 2);

		/*
			SE CALCULA EL FRAMETIME Y SE CORRIGE EL FRAMERATE SI ES NECESARIO.
		*/

		frameEnd = SDL_GetTicks();
		frameTime = frameEnd - frameStart;

		if (frameTime < frameDelay)
		{
			SDL_Delay(frameDelay - frameTime);
		}

		frameTime = SDL_GetTicks() - frameStart;
	}

	simulation->clean();

	return 0;
}
