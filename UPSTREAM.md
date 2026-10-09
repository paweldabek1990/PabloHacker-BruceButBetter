# Upstream and licensing

## Provenance

This project is an unofficial downstream hardware variant of **BruceButBetter**, which is itself a downstream fork of the Bruce firmware.

- BruceButBetter: https://github.com/Yoursel71/BruceButBetter
- Bruce upstream: https://github.com/BruceDevices/firmware (historically referenced as `pr3y/Bruce`)
- Project site: https://bruce.computer/
- License in this checkout: GNU Affero General Public License v3, retained in `LICENSE`.

The local Git history does not contain a recorded upstream commit hash for the complete imported source tree. Therefore this repository must not claim to be a clean fork at a specific upstream revision. The local hardware-port history begins with the commits documented in `CHANGELOG.md` and the stable tag `stable-single-splash-20261009`.

## Downstream changes

This variant adds the ESP32-S3 N16R8 + TPM408-2.8 ILI9341/XPT2046 target, GPIO/SPI configuration, display initialization fixes, Terminal Green theme, Pablo Hacker splash, geometry fixes and hardware/CAD documentation. The BLE diagnostic branch also adds a standard `BRUCE-BLE-TEST` beacon; it is not part of the stable tag unless explicitly merged.

## Redistribution obligations

Preserve `LICENSE`, upstream copyright notices and third-party notices. Review each dependency and bundled asset before public redistribution. Do not silently relicense the inherited firmware. This repository does not include private backups, local build logs, NVS data or the stable BIN as tracked source files.
