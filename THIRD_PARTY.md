# Third-party software and assets

This repository inherits a large dependency set from Bruce/BruceButBetter. The authoritative dependency declarations are in `platformio.ini` and the board-specific `.ini` files. Important examples include Arduino-ESP32/pioarduino, NimBLE-Arduino, FastLED, ArduinoJson, Adafruit PN532, RF24, RadioLib, SmartRC CC1101, JPEGDecoder, PNGdec, ESPAsyncWebServer and Si5351.

Each dependency remains governed by its own license. Before a public redistribution, review the resolved dependency metadata produced by PlatformIO and retain any required notices. The root `LICENSE` applies to the inherited firmware source and is AGPL-3.0; it does not silently relicense third-party libraries.

The Pablo Hacker bitmap is a project-specific asset stored under `src/assets/` and is not a copied upstream logo. CAD renders are generated from the included OpenSCAD sources and are marked prototype-only where appropriate.
