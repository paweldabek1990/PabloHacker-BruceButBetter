# Repository audit — 2026-10-09

## Git history found

- `78d8c35` — `docs: document ESP32-S3 touch wiring`
- `7de9cd3` — `feat: add Pablo Hacker splash and hardware docs`
- `afbc065` — `fix: correct Pablo RGB565 byte order`

The working tree is the local `C:\BruceTouch` checkout. No push was performed. The repository contains upstream BruceButBetter source plus this hardware variant; it is not a clean upstream clone and should be reviewed before a public fork.

## Verified firmware evidence

Target: `esp32-s3-n16r8-ili9341-touch`, Arduino-ESP32 3.3.6, pioarduino 55.03.36.

- Last recorded build: SUCCESS.
- Last recorded flash: SUCCESS with esptool hash verification on the confirmed ESP32-S3 COM18.
- Last recorded runtime: splash reached 3201 ms and entered the main menu without a crash.
- Current source contains the local RGB565 byte-swap correction in `src/main.cpp`.

Generated `.pio` output, firmware binaries, backups, and local logs are intentionally excluded from publication. The actual build and flash evidence remains summarized in `DIAGNOSTYKA.md`.

## Publication review

No literal Wi-Fi credentials, API tokens, private keys, or captured network data were found by the targeted scan. Strings such as `password` in the embedded web UI are form labels, not stored credentials. Review newly generated logs manually before publication.

The repository retains the AGPL-3.0 license file and upstream attribution. Third-party notices should be reviewed again before a public release because this project inherits a large dependency set from BruceButBetter.
