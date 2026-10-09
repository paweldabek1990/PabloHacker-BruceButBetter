# Pablo Hacker — BruceButBetter

Unofficial hardware variant of [BruceButBetter](https://github.com/Yoursel71/BruceButBetter) for an ESP32-S3-WROOM-1 N16R8 with a 2.8-inch ILI9341 TFT and XPT2046 resistive touch controller. The full Bruce source tree is retained; this repository adds a reproducible DIY hardware target.

> Security features are for authorized testing, education, and devices/networks you own.

## Status

The target `esp32-s3-n16r8-ili9341-touch` builds, boots into the full menu, uses Terminal Green, and supports touch navigation. ILI9341 color/text and XPT2046 coordinate tests were physically confirmed. The last firmware was flashed and verified on an ESP32-S3 over COM18. The latest RGB565 bitmap byte-order fix still requires final physical color confirmation.

## Hardware and GPIO

- ESP32-S3-WROOM-1 N16R8: 16 MB flash, 8 MB PSRAM, two USB-C connectors.
- TPM408-2.8: ILI9341, 240×320, resistive XPT2046 touch, SD slot.
- Shared SPI: GPIO11 MOSI, GPIO12 SCK, GPIO13 MISO.

| Signal | GPIO | Module pin | Evidence |
|---|---:|---|---|
| TFT SCK / touch T_CLK | 12 | SCK / T_CLK | physical |
| TFT MOSI / touch T_DIN | 11 | SDA/MOSI / T_DIN | physical |
| TFT MISO / touch T_DO | 13 | SDO/MISO / T_DO | physical |
| TFT CS | 15 | CS | physical |
| TFT DC | 17 | DC | physical |
| TFT RESET | 16 | RST | physical |
| Touch CS | 10 | T_CS | physical |
| Touch IRQ | — | T_IRQ | NC |
| Power | 3V3/GND | VCC/LED/GND | physical |
| SD CS | 14 | SD CS | configured, unverified |

See [HARDWARE_WIRING.md](HARDWARE_WIRING.md), [pinout](docs/hardware/pinout.md), [SVG](docs/hardware/wiring.svg), and [reassembly checklist](docs/hardware/reassembly-checklist.md). GPIO15/16 also occur in inherited button definitions; CC1101 CS is overridden to GPIO3 for this target.

The newly supplied photographs are documented in [AS_BUILT](docs/hardware/AS_BUILT/VERIFICATION_REPORT.md). They confirm the three-board assembly, but do **not** yet prove every wire endpoint or breadboard row. Do not disassemble the working setup using the AS_BUILT draft as a complete reconstruction map.

## Features and evidence

The source contains Wi-Fi, BLE, USB/HID, Sub-GHz/CC1101, NRF24, PN532/RFID, IR, Si5351, filesystem, Ethernet, GPS, LoRa, and other Bruce modules. Compilation proves inclusion, not physical operation. Physically exercised: display, touch, full menu navigation, Wi-Fi scan/navigation, Terminal Green, and splash timing. RF, NFC/RFID, IR, SD, optional radios, and Bruce App mirroring remain unverified.

## Build and flash

```powershell
pio run -e esp32-s3-n16r8-ili9341-touch
```

The project pins pioarduino release 55.03.36 / Arduino-ESP32 3.3.6. The merged image is `Bruce-esp32-s3-n16r8-ili9341-touch.bin`. Identify the board with `esptool chip-id` first; the previous confirmed device was ESP32-S3, VID `303A`, PID `1001`, COM18. Never assume the port, flash an ESP32-CAM, use `erase_flash`, or erase NVS.

## Pablo Hacker splash

The 160×155 RGB565 `PROGMEM` asset is [src/assets/pablo_logo.h](src/assets/pablo_logo.h). `src/main.cpp::boot_screen()` draws it on the 240×320 panel, then `PABLO HACKER` and `PABLO SIGNAL`, preserving approximately 3.2 seconds. [Preview](docs/assets/pablo-splash-preview.png) is not physical proof.

## Documentation

[DIAGNOSTYKA.md](DIAGNOSTYKA.md) · [CHANGELOG.md](CHANGELOG.md) · [KNOWN_ISSUES.md](KNOWN_ISSUES.md) · [build guide](docs/software/build.md) · [validation](docs/testing/validation-status.md) · [Bruce App analysis](docs/hardware/remote-diagnostics.md) · [CONTRIBUTING.md](CONTRIBUTING.md)

The audit of the local checkout, commits, tests, and publication hygiene is in [docs/software/repository-audit.md](docs/software/repository-audit.md).

## Actions and roadmap

`.github/workflows/platformio.yml` builds the real target and uploads artifacts; it never flashes hardware. Roadmap: complete row-level AS_BUILT verification, test SD/peripherals, test Bruce App compatibility, resolve inherited GPIO ambiguities, then publish a reviewed public repository.

## Provenance and license

Upstream attribution and the repository `LICENSE` are retained. BruceButBetter is associated with Yoursel71; Bruce firmware is maintained by BruceDevices. This is an unofficial, unpublished variant. Review the full [AGPL-3.0 license](LICENSE) before redistribution and preserve source/license obligations.
