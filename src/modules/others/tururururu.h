#include "core/display.h"
#include <globals.h>

// ConfiguraÃ§Ã£o do personagem principal (tubarÃ£o)
extern int sharkX;
extern int sharkY;
extern int sharkSize;

// ConfiguraÃ§Ã£o de pontuaÃ§Ã£o
extern int score;

// FunÃ§Ãµes para manipulaÃ§Ã£o do jogo
void drawShark();
// void drawFish(Fish &f);
void drawFish();
void moveShark();
// void moveFish(Fish &f);
void moveFish();
void checkCollisions();
void displayScore();
void shark_setup();
void shark_loop();

