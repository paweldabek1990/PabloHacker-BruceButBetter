# Validation status

## Physically confirmed

- Adafruit ILI9341 color/text test on the documented SPI wiring.
- XPT2046 returned changing X/Y/Z readings.
- Full firmware menu and touch navigation operate on the ESP32-S3 target.
- Wi-Fi scan list rendered and could be navigated.
- Terminal Green menu theme works.
- Pablo Hacker splash timing and menu transition were observed.

## Code/build confirmed

- `esp32-s3-n16r8-ili9341-touch` builds with Arduino-ESP32 3.3.6.
- RGB565 bitmap transfer uses local `setSwapBytes(true)` around `pushImage()`.
- Latest flash was verified by esptool on the confirmed ESP32-S3 COM18.

## Not physically verified here

RF/CC1101, both NRF24 modules, PN532/RFID, Si5351, IR, microSD, BLE attack features, USB HID peripherals, and official Bruce App mirroring.
