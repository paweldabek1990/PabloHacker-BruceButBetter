# Boot sequence and startup transition

This document records the startup path for the `esp32-s3-n16r8-ili9341-touch` target.

## Sequence

1. `setup()` starts Serial and reports `SETUP START`.
2. GPIO setup deselects TFT, touch, SD, CC1101 and NRF24 chip-select lines.
3. `tft.init()` initializes the ILI9341. The source emits `STARTUP <ms> TFT_INIT_BEGIN` and `TFT_INIT_DONE`.
4. An early Pablo frame is drawn immediately after TFT init using the target's default rotation and dimensions. This keeps a valid dark frame visible while storage/configuration loading runs.
5. `begin_storage()` runs without an additional TFT initialization.
6. `begin_tft()` applies the configured rotation, clears the display through `resetTftDisplay()` using the persisted Terminal Green background, sets the logical dimensions and brightness, and emits timestamped markers.
7. `boot_screen_anim()` calls `boot_screen()`, which clears the screen, draws the Pablo Hacker RGB565 bitmap with local `setSwapBytes(true)`, and draws the two labels. The splash remains visible for approximately 3200 ms.
8. The splash is cleared once at the end of exposure. `setup()` then finishes services and enters the normal menu loop, where the menu performs its own logical background clear before drawing.

## Single-splash correction

The early frame is now the same frame used by the timed splash when no external boot image is selected. `boot_screen_anim()` no longer calls `boot_screen()` a second time, and `begin_tft()` does not clear the panel while that frame is active. This removes the duplicate bitmap draw and the intermediate full-screen clear. If an external boot image is selected from SD/LittleFS/theme, that image remains an intentional separate boot-image path.

The fresh COM18 runtime capture showed one `BOOT_DRAW_BEGIN`, one `BOOT_DRAW_DONE`, `SPLASH_REUSE_EARLY_FRAME`, `SPLASH_EXPOSURE_END elapsed=3200`, and normal menu entry without a panic.

## Controlled startup change

The former `tft.fillScreen(TERMINAL_GREEN_BG)` directly after `tft.init()` was removed. It happened before `begin_tft()`'s final rotation and before configuration loaded from storage, so it could create an unnecessary full-screen transition. The existing second `setRotation()` in `begin_tft()` remains because it is documented as required for occasional missed first commands on this panel.

## Hardware limitation

The TFT backlight is connected directly to 3V3 and has no firmware-controlled BL GPIO. Therefore the panel may visibly illuminate during the controller's reset/init phase before the first accepted TFT command. Firmware can remove redundant post-init clears, but cannot guarantee suppression of that pre-command flash without hardware backlight control.

## Runtime markers

Relevant markers include `TFT_INIT_BEGIN`, `TFT_INIT_DONE`, `BEGIN_TFT_ENTER`, `TFT_ROTATION_READY`, `TFT_BACKGROUND_READY`, `BEGIN_TFT_EXIT`, `BOOT_DRAW_BEGIN`, `BOOT_DRAW_DONE`, `SPLASH_EXPOSURE_BEGIN`, `SPLASH_EXPOSURE_END`, `SPLASH_CLEAR_DONE`, and `MAIN LOOP MENU ENTER`.

## Measured run

On the 2026-10-09 firmware run via COM18: TFT init began at 26 ms and completed at 323 ms. The early Pablo frame began at 324 ms and completed at 506 ms. Storage/configuration completed sufficiently for `BEGIN_TFT_ENTER` at 3051 ms. The normal splash ran for 3200 ms and the menu path was reached at 6713 ms. These are application-relative times; ROM bootloader, reset and USB enumeration time are not included.
