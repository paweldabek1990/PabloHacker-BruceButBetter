# Reproducible build

The supported target is `esp32-s3-n16r8-ili9341-touch`. The project pins pioarduino platform release 55.03.36 with Arduino-ESP32 3.3.6 in `platformio.ini`.

```powershell
pio run -e esp32-s3-n16r8-ili9341-touch
```

The merged image is written by the project post-build script as `Bruce-esp32-s3-n16r8-ili9341-touch.bin`. Do not commit generated `.pio` output or firmware binaries.

## Flashing

Identify the ESP32-S3 by VID/PID and `esptool chip-id` first. The previous verified device appeared as COM18, USB VID `303A`, PID `1001`. Use the actual current port, never assume COM18 and never use `erase_flash` for normal updates.
