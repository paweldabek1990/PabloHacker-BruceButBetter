# Dolphin One (D1)
ESP32-S3 N16R8 • ILI9341 240×320 • XPT2046 • BruceButBetter derivative

[Polski](README_PL.md) · [Project status](docs/software/PROJECT_STATE.md) · [Code map and features](docs/software/CODE_MAP.md) · [Build](docs/software/build.md)

## Visual reference
![Dolphin One branding reference](docs/showcase/dolphin-one-d2-reference.png)

This is the existing Dolphin One D2 branding reference imported from the documentation branch. It is design artwork, not a photograph or verified screenshot of the installed firmware. D1 is the product abbreviation; D2 in this asset filename identifies the reference, not a second hardware model. The later V8 menu references are not available in this checkout.

## What is actually available
The firmware source on this public branch is the historical hardware baseline from 9 October 2026. Documentation was reconciled on 17 October 2026. **This is not a release of the later locally flashed D1 firmware.** The firmware still contains historical branding.

Display, touch and menu/Wi-Fi navigation were exercised during development. These historical results do not certify every menu path in the current device. The precise local D1 source-to-binary mapping remains to be imported.

| Capability | This board target |
|---|---|
| ILI9341 / XPT2046 | Configured; historically exercised |
| Wi-Fi / BLE | Source present; full physical regression pending |
| USB/HID | Enabled in configuration; physical acceptance pending |
| RFID/NFC, Sub-GHz, NRF24, IR | Source/configuration present; require compatible peripherals and testing |
| SD / filesystem | Source present; SD mount issues recorded |
| LoRa / GPS / Ethernet / FM | Disabled by this target's build flags |

See the [code map](docs/software/CODE_MAP.md) for source locations and verification limits.

## Hardware and build
16 MB flash, 8 MB PSRAM. Shared SPI: MOSI 11, SCK 12, MISO 13. TFT CS 15, DC 17, RESET 16; touch CS 10; SD CS 14 (unverified).

```powershell
pio run -e esp32-s3-n16r8-ili9341-touch
```

[Wiring](HARDWARE_WIRING.md) · [Build and flash procedure](docs/software/build.md) · [Physical wiring evidence](docs/hardware/AS_BUILT/VERIFICATION_REPORT.md)

## Documentation
- [Current status, provenance and local recovery sources](docs/software/PROJECT_STATE.md)
- [Module and code reference](docs/software/CODE_MAP.md)
- [Current validation summary](docs/testing/validation-status.md)
- [Known issues](KNOWN_ISSUES.md)
- [Visual asset provenance](docs/showcase/ASSET_MANIFEST.md)
- [Historical changelog](CHANGELOG.md)

Unofficial derivative of [BruceButBetter](https://github.com/Yoursel71/BruceButBetter). Original attribution and [AGPL-3.0 license](LICENSE) are retained.
