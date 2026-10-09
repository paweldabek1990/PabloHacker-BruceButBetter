# BruceButBetter ESP32-S3 DIY Touch

## Hardware

- MCU: ESP32-S3-WROOM-1 N16R8, 16 MB flash, 8 MB PSRAM
- Display: TPM408-2.8, ILI9341, 240x320, SPI
- Touch: XPT2046, resistive, shared SPI, IRQ not connected

## Pinout

| Module | Signal | ESP32-S3 |
|---|---|---:|
| ILI9341 | CS | GPIO15 |
| ILI9341 | RST | GPIO16 |
| ILI9341 | DC | GPIO17 |
| SPI bus | MOSI / MISO / SCK | GPIO11 / GPIO13 / GPIO12 |
| XPT2046 | CS | GPIO10 |
| XPT2046 | IRQ | not connected |
| Display | VCC / LED | 3V3 |
| Display | GND | GND |
| microSD | CS | GPIO14 |

The SPI data lines are shared by the display, touch, SD, CC1101 and NRF24 devices; each device uses its own chip-select. Do not use GPIO26-32 (flash), GPIO33-37 (OPI PSRAM), GPIO19-20 (native USB), or GPIO45-46 without board-specific verification.

## Verification status

The ILI9341 color/text test and XPT2046 raw touch test were physically verified. Other Bruce peripherals are configured or compiled but are not claimed as physically verified in this variant.
