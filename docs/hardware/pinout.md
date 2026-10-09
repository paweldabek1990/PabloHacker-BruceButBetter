# Pinout reference

Target: `esp32-s3-n16r8-ili9341-touch`.

Najważniejsza tabela znajduje się w [HARDWARE_WIRING.md](../../HARDWARE_WIRING.md). Ten plik jest skróconą kartą montażową.

```text
ILI9341 / XPT2046 / SD shared SPI

GPIO11  MOSI  -> TFT MOSI, T_DIN, SD MOSI
GPIO12  SCK   -> TFT SCK,  T_CLK, SD SCK
GPIO13  MISO  -> TFT MISO, T_DO,  SD MISO
GPIO15  TFT_CS
GPIO17  TFT_DC
GPIO16  TFT_RST
GPIO10  TOUCH_CS
GPIO14  SD_CS
T_IRQ   NC
VCC/BL  3V3
GND     GND
```

## Sygnały dodatkowe

```text
I2C: SDA=GPIO8, SCL=GPIO18
CC1101: GDO0=GPIO9, CS declared GPIO3, SPI=11/12/13
NRF24 #1: CE=GPIO4, CSN=GPIO5, SPI=11/12/13
NRF24 #2: CE=GPIO6, CSN=GPIO7, SPI=11/12/13
IR: RX=GPIO1, TX=GPIO2
Buzzer: GPIO47
Buttons: GPIO15,16,38,39,40,41 to GND, active LOW
```

`CC1101_CS=GPIO3` jest deklaracją targetu. Kompilacja zgłasza redefinicję w odziedziczonym `boards/ESP-General/pins_arduino.h`, który zawiera `CC1101_SS_PIN=10`; przed podłączeniem CC1101 należy traktować ten element jako niejednoznaczny.

Nie podano numerów fizycznych pinów headera, ponieważ kod ich nie zawiera.
