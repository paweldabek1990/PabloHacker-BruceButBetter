# Contributing

This repository is an unofficial hardware variant of BruceButBetter. Keep changes reproducible and preserve upstream attribution and the AGPL-3.0-or-later license.

Before opening a pull request:

- build `esp32-s3-n16r8-ili9341-touch` with the pinned PlatformIO configuration;
- describe whether a result is code-verified or physically tested;
- do not include Wi-Fi credentials, captured traffic, private logs, or local machine paths;
- do not change GPIO, touch calibration, or SPI behavior without documenting the hardware impact;
- include a short entry in `CHANGELOG.md` for user-visible changes.

Hardware reports should include board revision, display/controller marking, wiring photo, and serial/runtime evidence. Security features must only be tested on systems and networks you own or are authorized to assess.
