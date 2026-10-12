<p align="center"><img src="docs/showcase/pablo-hacker-reference.png" width="100%" alt="BruceButBetter — Dolphin One"></p>

> **Branding transition / Zmiana nazwy:** Dolphin One (D1) is the new project name. The historical artwork above still contains the old logo and will be replaced, not falsely presented as the new brand.
<p align="center"><a href="README_PL.md">🇵🇱 Polski</a> · <a href="README.md">🇬🇧 English</a></p>

# BruceButBetter / Dolphin One

**Cyber Dashboard V2** · ESP32-S3-WROOM-1 N16R8 · ILI9341 240×320 · XPT2046

![Status](https://img.shields.io/badge/status-active_development-00bfa8?style=for-the-badge) ![ESP32-S3](https://img.shields.io/badge/MCU-ESP32--S3-00a5cb?style=for-the-badge) ![ILI9341](https://img.shields.io/badge/display-ILI9341_240%C3%97320-10ae97?style=for-the-badge) ![PlatformIO](https://img.shields.io/badge/build-PlatformIO-f58220?style=for-the-badge)

> A real hardware and interface development log, from a small SH1106 OLED experiment to the Dolphin One touchscreen direction. The artwork is preserved as artwork; it is not presented as proof of a finished enclosure or completed hardware.

## Our development journey

The five stages below describe the progression without inventing historical photographs. Only assets with known provenance are presented as project exports.

| 1 · SH1106 OLED | 2 · First ILI9341 | 3 · Raw menu | 4 · Improved tiles | 5 · Cyber Dashboard V2 |
|---|---|---|---|---|
| First prototype, small screen, visible artefacts and hard limits. | Wiring and driver experiments around the 240×320 TFT. | Working foundations, clipped elements and navigation bugs. | Layout and illustration work moved toward readable touch tiles. | Approved visual direction; integration and testing remain in progress. |

<p align="center"><img src="docs/showcase/screens/overview.png" width="100%" alt="Cyber Dashboard V2 overview export"></p>

## Current interface · authentic 240×320 exports

<table>
<tr><td align="center"><strong>Main Menu</strong><br><img src="docs/showcase/screens/overview.png" width="240" alt="Main Menu"></td><td align="center"><strong>Bluetooth</strong><br><img src="docs/showcase/screens/bluetooth-final-preview.png" width="240" alt="Bluetooth screen"></td><td align="center"><strong>BLE Scanner</strong><br><img src="docs/showcase/screens/scanner-final-preview.png" width="240" alt="BLE Scanner"></td></tr>
<tr><td align="center"><strong>Scan Results</strong><br><img src="docs/showcase/screens/results-final-preview.png" width="240" alt="Scan Results"></td><td align="center"><strong>Settings</strong><br><img src="docs/showcase/screens/settings-final-preview.png" width="240" alt="Settings"></td><td align="center"><strong>BLE / iBeacon cards</strong><br><img src="docs/showcase/screens/ble-scan-card.png" width="240" alt="BLE scan card"><br><img src="docs/showcase/screens/ibeacon-card.png" width="240" alt="iBeacon card"></td></tr>
</table>

## Hardware & documentation

| Component | Current project definition |
|---|---|
| Controller | ESP32-S3-WROOM-1 N16R8 · 16 MB Flash · 8 MB PSRAM |
| Display | ILI9341 240×320 |
| Touch | XPT2046 resistive touch controller |
| Build | PlatformIO environment `esp32-s3-n16r8-ili9341-touch` |
| Wiring | [GPIO and hardware wiring](HARDWARE_WIRING.md) |

**Confirmed project state:** the display bring-up, touch path on tested screens, and firmware build/flash workflow are documented. Full menu flow, BLE Back behavior, submenu behavior, visual consistency and final physical acceptance testing are still under development. No finished 3D enclosure or fictional test result is claimed here.

## Next steps

- complete and verify the remaining menu/navigation paths;
- continue hardware integration and physical acceptance tests;
- keep the 240×320 exports and provenance notes synchronized with the implementation;
- document changes in the [changelog](CHANGELOG.md).

## Documentation

[Build Guide](docs/software/build.md) · [Diagnostics](DIAGNOSTYKA.md) · [Known Issues](KNOWN_ISSUES.md) · [Changelog](CHANGELOG.md) · [Asset Manifest](docs/showcase/ASSET_MANIFEST.md)

<sub>Unofficial variant of <a href="https://github.com/Yoursel71/BruceButBetter">BruceButBetter</a>. Original authorship, attribution and <a href="LICENSE">license</a> are retained. Security features are for authorized testing and education.</sub>
