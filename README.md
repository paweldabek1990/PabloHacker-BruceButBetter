<p align="center"><img src="docs/showcase/hero.svg" width="100%" alt="BruceButBetter Pablo Hacker Edition — Cyber Dashboard V2"></p>
<p align="center"><a href="README_PL.md">🇵🇱 Polski</a> · <a href="README.md">🇬🇧 English</a></p>
# BruceButBetter / Pablo Hacker Edition

**Cyber Dashboard V2** · ESP32-S3-WROOM-1 N16R8 · ILI9341 240×320 · XPT2046

![Development](https://img.shields.io/badge/status-active_development-00bfa8?style=for-the-badge) ![ESP32](https://img.shields.io/badge/MCU-ESP32--S3-00a5cb?style=for-the-badge) ![Touch](https://img.shields.io/badge/Touch-XPT2046-10ae97?style=for-the-badge)

> **From a tiny OLED to a distinctive touchscreen handheld.** This unofficial BruceButBetter variant documents a real DIY hardware and UI development journey. Concept artwork is not presented as hardware proof.

## The journey: five iterations

| 01 · Small OLED | 02 · First TFT | 03 · Raw menu | 04 · Illustrated tiles | 05 · Cyber Dashboard V2 |
|:---:|:---:|:---:|:---:|:---:|
| I²C SH1106 tests; tiny display, glitches | ILI9341 2.8″ wired on breadboard; touch integration | UI clipping, alignment and navigation problems | Distinct tile illustrations and recognizable Pablo Hacker style | Current visual direction, submenu and touch refinement |
| Historical prototype | Hardware bring-up | Early functional UI | Design iteration | **Work in progress** |

**Photo archive is being assembled:** authentic OLED wiring photo → first TFT on breadboard → clipped UI → first illustrated tiles → approved V2 screen exports. Historical images will only be labeled as physical evidence if actually photographed; see [image provenance and integration plan](docs/showcase/ASSET_MANIFEST.md).

## What Cyber Dashboard V2 looks like

<table><tr><td width="35%"><img src="docs/assets/pablo-splash-preview.png" width="100%" alt="Pablo splash preview"></td><td><strong>Illustrated, but fully usable.</strong><p>Wi-Fi, BLE, Sub-GHz, RFID, IR and tool tiles designed specifically for a 240×320 portrait touchscreen. The approved reference also includes Bluetooth menus, BLE scanner, scan results and settings.</p><p><em>Left: earlier splash asset preview, not a photo of the completed V2.</em></p></td></tr></table>

The original 240×320 source screenshots supplied by the project owner will be placed in `docs/showcase/screens/` by Codex once available. They are intentionally **not replaced with fabricated screenshots**.

## Hardware & current status

| Component | Implementation |
|---|---|
| Controller | ESP32-S3-WROOM-1 N16R8, 16 MB Flash, 8 MB PSRAM |
| Display | TPM408-2.8 / ILI9341 240×320 |
| Touch | Resistive XPT2046 |
| Firmware environment | `esp32-s3-n16r8-ili9341-touch` |
| Early experiment | SH1106 OLED 128×64 — historical stage, later returned |

**Verified:** ESP32-S3 display bring-up, touch path on tested screens, firmware builds and flashes. **Still under development:** reliable full menu flow, BLE Back, submenu behavior, visual consistency and physical acceptance testing. Including a function in source code does not prove its peripheral is physically present.

## Documentation

[Wiring](HARDWARE_WIRING.md) · [Build](docs/software/build.md) · [Diagnostics](DIAGNOSTYKA.md) · [Known issues](KNOWN_ISSUES.md) · [Changelog](CHANGELOG.md) · [Visual asset map](docs/showcase/ASSET_MANIFEST.md)

<sub>Unofficial variant of [BruceButBetter](https://github.com/Yoursel71/BruceButBetter). Upstream attribution and [license](LICENSE) retained. Security features are for authorized testing and education.</sub>
