#include "../ESP-General/pins_arduino.h"
#undef CC1101_SS_PIN
#define CC1101_SS_PIN 3
#undef TFT_CS
#define TFT_CS 15
#undef TFT_DC
#define TFT_DC 17
#undef TFT_RST
#define TFT_RST 16
#undef TOUCH_CS
#define TOUCH_CS 10
#undef TFT_MISO
#define TFT_MISO 13
#undef TFT_MOSI
#define TFT_MOSI 11
#undef TFT_SCLK
#define TFT_SCLK 12
#undef TFT_WIDTH
#define TFT_WIDTH 240
#undef TFT_HEIGHT
#define TFT_HEIGHT 320
#undef SMOOTH_FONT
#define SMOOTH_FONT 1
#define HAS_TOUCH 1
#define USE_TFT_eSPI_TOUCH 1
#define ILI9341_DRIVER 1
