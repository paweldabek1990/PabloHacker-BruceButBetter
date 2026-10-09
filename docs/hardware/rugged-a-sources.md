# Rugged A dimensional sources

## Verified reference information

- The YD-ESP32-S3 page identifies the dual-USB-C ESP32-S3-WROOM-1 board and publishes an envelope of **57.15 × 27.94 mm** with **2.54 mm pin pitch**: [ESPboards.dev YD-ESP32-S3](https://www.espboards.dev/esp32/yd-esp32-s3/). This is an external reference drawing, not a caliper measurement of the user's V1.4 board, so CAD marks it as `VERIFIED REFERENCE` and still requires physical confirmation.
- The TPM408-2.8 product page confirms **2.8 inch, 240×320, ILI9341, 4-wire resistive touch, SPI and 3.3–5 V input**, but does not publish a mechanical drawing of this exact red PCB's outline, mounting holes or connector offsets: [UralTone TPM408-2.8](https://en.uraltone.com/modules/displays-oled-lcd-led/28-inch-tft-lcd-touchscreen-tpm408-28-med-120.html).
- The official YD-ESP32-S3 repository contains the V1.4 schematic PDF, but the accessible page does not provide a mechanical board drawing: [VCC-GND YD-ESP32-S3 hardware info](https://github.com/vcc-gnd/YD-ESP32-S3/tree/main/5-public-YD-ESP32-S3-Hardware%20info).

## Not treated as exact dimensions

- A third-party ESP32-2432S028 repository identifies the TPM408-2.8 marking and electrical pin examples, but it is a different integrated CYD board and its pinout is not applicable to this project: [rockebest calibration repository](https://github.com/rockebest/ESP32-2432S028-LCD-Touch-Calibration).
- Product listings that only state screen diagonal/resolution are not sufficient for the red TPM408 PCB's mounting geometry.
