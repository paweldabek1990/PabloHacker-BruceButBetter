# Known issues

## Resolved

- ESP32-S3 TFT_eSPI crash caused by the old `SPI_PORT=FSPI` register index; the local S3 configuration now uses `SPI_PORT=2`.
- Saved `colorInverted=1` caused a blank white panel after TFT initialization; the recovery path stores inversion off for the ILI9341 target.
- XPT2046 coordinates were rotated twice in the CYD-derived input path; the extra transform was removed for `USE_TFT_eSPI_TOUCH`.
- The touch footer reserved 20 px although it is 43 px high; the geometry reserve is now 45 px.

## Under investigation

- Some icons, labels and frames may still be clipped or partially refreshed.
- WiFi, Config and other submenu contents remain invisible despite valid navigation; a one-shot three-method renderer probe is flashed and requires physical observation/log capture.
- The `SMOOTH_FONT` override and initial geometry fix are now built and flashed; physical confirmation of submenu geometry is still required.
- SD is not physically verified and has reported mount failures in runtime logs.
- RFID, Sub-GHz, NFC, IR, CC1101, NRF24 and other optional modules are not claimed as physically tested in this DIY build.
## Current verification status

- Terminal Green and Pablo Signal are flashed and the runtime reaches the main menu on COM18.
- Physical confirmation of the new palette, logo legibility and startup timing is still required.
- Existing inherited macro redefinition warnings remain in the ESP-General compatibility header; they did not prevent the build or flash.
- Final physical confirmation of the corrected Terminal Green colours, 3.2-second splash duration and blue-screen removal is still pending.
- Splash correction is present in source but not yet flashed: the current PlatformIO environment stops during dependency installation with Windows code `0xC000013A` before compilation.
- Aktualny splash został skompilowany, ale flash przez COM18 nie został zweryfikowany: port stał się zajęty/niedostępny po przerwanej próbie zapisu przy 83.1%.
# Current known issues

- The new Pablo Hacker bitmap has been compiled and flashed, but its final appearance on the physical TFT is not yet confirmed in this session.
- `runtime.log` contains repeated `CUSTOM_BOOT_IMAGE_DRAWN type=0` diagnostic lines during splash exposure from an earlier diagnostic path; this is log noise, not a confirmed display failure.
- Hardware documentation identifies inherited GPIO ambiguities: GPIO15/16 also occur in inherited button definitions, and the target overrides the inherited CC1101 CS default from GPIO10 to GPIO3.
- Official Bruce App serial/mirroring compatibility with this fork is not physically verified. Native USB CDC is enabled and serial output works, but the app's live-mirror protocol has not been tested.
- RGB565 byte-order fix has been flashed for physical verification; the PNG alone is not treated as proof of correct TFT colors.
- Because TFT BL is hardwired to 3V3, a short white/blue flash before the ILI9341 accepts commands may remain a hardware limitation; firmware now avoids the additional post-init pre-rotation clear.
- Early-splash latency experiment is pending physical confirmation; the later normal splash and menu path are intentionally preserved.
- The ROM/bootloader/USB-enumeration time before the first application `millis()` marker is not measured. A brief pre-command flash may remain because BL is hardwired to 3V3, but the multi-second post-init blank storage interval is covered by the early splash.
- Single-splash firmware build is ready, but COM18 disappeared before flashing and no serial ports are currently enumerated; physical/runtime confirmation is pending.
- The single-splash firmware is now flashed and runtime-verified. Visual confirmation of the absence of residual hardware backlight flashes still requires observation on the physical TFT.
- Runtime reaches the menu after the RGB565 fix without a crash; the actual logo color result still requires a physical screen check.
