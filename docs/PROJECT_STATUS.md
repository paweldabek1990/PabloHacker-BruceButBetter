# Project status

This document separates source availability, build evidence and physical verification. A compiled feature is not automatically a tested feature.

## Confirmed

- ESP32-S3 N16R8 target builds with PlatformIO environment `esp32-s3-n16r8-ili9341-touch`.
- ILI9341 240x320: physical colour/text test passed.
- XPT2046: physical coordinate response passed; touch navigation works.
- USB-Serial/JTAG runtime logging on COM18 was observed.
- Bruce boot, main menu navigation and Wi-Fi scanning were physically exercised.
- Shared SPI pins are MOSI 11, MISO 13, SCK 12.

## Compiled but not independently verified on every peripheral

Wi-Fi/BLE, USB features, CC1101/Sub-GHz, RFID/NFC, NRF24, Si5351, IR and SD code remain present according to conditional compilation and menus. Their hardware operation is not claimed here unless the user has physically tested that module.

## Current limitation

Submenu and main-menu geometry has required a custom ESP32-S3/TFT port fix. The latest source contains the `SMOOTH_FONT` override correction and explicit text-state initialization; physical confirmation after the latest flash remains required.

## Evidence

Latest build/runtime records are retained locally under `logs/` and intentionally excluded from a future public repository. The latest verified build is documented in `DIAGNOSTYKA.md`.
