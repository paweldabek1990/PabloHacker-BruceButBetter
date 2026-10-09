# Wiring — as built

Status vocabulary: `CONFIRMED_FROM_PHOTO`, `CONFIRMED_FROM_CODE_ONLY`, `NEEDS_VISUAL_CONFIRMATION`, `CONFLICT`.

This is a conservative record. The firmware configuration is not proof that a particular Dupont wire is physically plugged into that GPIO. The photographs show the modules and a bundled connection, but not enough detail to trace each conductor from source to destination.

| Signal | ESP32 GPIO | ESP32 physical pin | TFT/module pin | Wire colour | Start | End / intermediate | Status |
|---|---:|---|---|---|---|---|---|
| SPI SCK | 12 | Not identified from photos | TFT SCK / touch T_CLK | Not certified | ESP32 header | Shared SPI bundle / TFT header | NEEDS_VISUAL_CONFIRMATION |
| SPI MOSI | 11 | Not identified from photos | TFT MOSI/SDA / touch T_DIN | Not certified | ESP32 header | Shared SPI bundle / TFT header | NEEDS_VISUAL_CONFIRMATION |
| SPI MISO | 13 | Not identified from photos | TFT MISO/SDO / touch T_DO | Not certified | ESP32 header | Shared SPI bundle / TFT header | NEEDS_VISUAL_CONFIRMATION |
| TFT CS | 15 | Not identified from photos | TFT CS | Not certified | ESP32 header | TFT header, exact socket obscured | NEEDS_VISUAL_CONFIRMATION |
| TFT DC | 17 | Not identified from photos | TFT DC/RS | Not certified | ESP32 header | TFT header, exact socket obscured | NEEDS_VISUAL_CONFIRMATION |
| TFT RESET | 16 | Not identified from photos | TFT RST | Not certified | ESP32 header | TFT header, exact socket obscured | NEEDS_VISUAL_CONFIRMATION |
| Touch CS | 10 | Not identified from photos | XPT2046 T_CS | Not certified | ESP32 header | TFT touch header, exact socket obscured | NEEDS_VISUAL_CONFIRMATION |
| Touch IRQ | NC | N/A | XPT2046 T_IRQ | N/A | N/A | Not connected in firmware design | CONFIRMED_FROM_CODE_ONLY |
| TFT VCC / BL | 3V3 | Not identified from photos | VCC / LED | Not certified | 3V3 rail | TFT power pins | NEEDS_VISUAL_CONFIRMATION |
| TFT GND | GND | Not identified from photos | GND | Not certified | ESP32 ground | TFT ground rail | NEEDS_VISUAL_CONFIRMATION |
| SD CS | 14 | Not identified from photos | SD CS, if an SD module is fitted | Not certified | ESP32 configuration | No SD module/end-to-end wire proven in photos | CONFIRMED_FROM_CODE_ONLY |

## Code-only peripheral assignments

These are configuration values, not claims that the modules are physically installed in the photographed assembly: CC1101 CS/GDO0 = GPIO10/9 with shared SPI; NRF24 #1 CE/CSN = GPIO4/5; NRF24 #2 CE/CSN = GPIO6/7; I2C SDA/SCL = GPIO8/18; IR RX/TX = GPIO1/2; buzzer = GPIO47. The target configuration also reserves native USB GPIO19/20, UART0 GPIO43/44, flash/PSRAM pins, and strapping pins. No end-to-end physical route for these optional peripherals is certified by the five photos.

## Physical-pin limitation

The ESP32 module's board-level header position and the exact numbered TFT header sockets are obscured or out of focus. Therefore this record intentionally leaves physical pin numbers and wire colours unclaimed.
