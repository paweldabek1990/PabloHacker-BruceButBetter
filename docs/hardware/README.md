# Hardware reference

## Controller

- ESP32-S3-WROOM-1 N16R8
- 16 MB flash, 8 MB OPI PSRAM
- Board marking: ESP32-S3 2025-V1.4
- Two USB-C connectors; the tested runtime/debug interface was USB-Serial/JTAG on COM18.

## Display and touch

- 2.8-inch 240x320 ILI9341 SPI TFT
- XPT2046 resistive touch controller
- Touch IRQ is not connected; touch is polled over SPI.
- Shared SPI: MOSI GPIO11, MISO GPIO13, SCK GPIO12.

| Display/module signal | ESP32-S3 GPIO |
|---|---:|
| TFT CS | 15 |
| TFT DC | 17 |
| TFT RST | 16 |
| TFT MOSI/SDA | 11 |
| TFT MISO/SDO | 13 |
| TFT SCK/SCL | 12 |
| Touch CS/T_CS | 10 |
| Touch IRQ | not connected |
| VCC / LED | 3V3, as physically tested |
| GND | GND |

## Existing module map

| Module | Pins |
|---|---|
| I²C SDA/SCL | GPIO8 / GPIO18 |
| microSD CS | GPIO14; shared SPI 11/12/13 |
| CC1101 | CS GPIO3 in the active target header; GDO0 GPIO9; shared SPI |
| NRF24 #1 | CE GPIO4, CSN GPIO5; shared SPI |
| NRF24 #2 | CE GPIO6, CSN GPIO7; shared SPI |
| IR | RX GPIO1, TX GPIO2 |
| Buttons | GPIO15/16/38/39/40/41 definitions are inherited/configured; verify board wiring before populating a case |

GPIO 26–32 are flash, 33–37 are OPI PSRAM, 19–20 are native USB, 43–44 are UART0 and 45–46 are strapping/reserved. Do not use them for new peripherals without a board-specific review.

## Important limitations

The display board's exact power/LED electrical design is module-specific. This repository records the tested 3V3 connection; do not generalize it to another display board without checking its silkscreen/datasheet.
