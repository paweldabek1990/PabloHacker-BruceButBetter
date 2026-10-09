# Changelog — DIY Touch variant

This file records confirmed local changes; it is not a replacement for the upstream Bruce history.

## Unreleased

- Removed the redundant pre-rotation full-screen clear immediately after `tft.init()` and added timestamped startup markers for regression timing. No hardware mapping or user-facing feature was changed.
- Added an immediate Pablo frame after TFT initialization so storage/configuration loading does not leave the backlit panel blank.
- Verified the early-frame path on COM18: first frame at 506 ms application time; normal storage and the 3200 ms splash timing remain intact.
- Eliminated the second Pablo splash draw and the intermediate `begin_tft()` full-screen clear by reusing the early frame for the normal splash exposure. Build succeeded; flash awaits restoration of the ESP32-S3 COM port.
- Completed flash after COM18 returned. Runtime verified one bitmap draw and one 3200 ms splash exposure with normal menu entry.

- Added geometry/render diagnostics for main menu, submenu and first menu item rendering.
- Added project-specific hardware, build and contribution documentation.
- Replaced the three submenu-item `drawCentreString()` calls with explicit centered `drawString()` calls using measured text widths; added coordinate/color diagnostics. Awaiting physical confirmation.
- Added a one-shot three-method submenu text probe and detailed `drawOptions()`/`drawSubmenu()` runtime diagnostics after the previous renderer change did not solve invisible submenu entries.
- Identified and corrected the inherited `SMOOTH_FONT=0` override for the TFT target; added explicit text-state reset and corrected initial portrait geometry. Build is pending because the dependency recompilation did not reach linking.
- Completed the long clean rebuild after correcting the private TFT_eSPI API calls; flashed verified firmware on COM18 and captured runtime startup.

## Confirmed fixes

- Corrected ESP32-S3 TFT_eSPI register selection with `SPI_PORT=2`.
- Recovered from persisted color inversion and disabled it for the ILI9341 startup path.
- Removed the duplicate XPT2046 rotation transform in the TFT_eSPI touch path.
- Made the touch footer geometry fit the 240x320 panel and tied calibration to the active rotation.

## Verification policy

LCD color/text drawing and basic XPT2046 response are physically verified. Full peripheral support remains subject to separate hardware tests.
## Unreleased — Terminal Green

- Added the default Terminal Green RGB565 palette and a named `Terminal Green` UI Color entry.
- Added the procedural `Pablo Signal` startup mark and a lightweight initialization progress bar.
- Preserved the existing ESP32-S3 SPI, TFT, touch, geometry and SMOOTH_FONT fixes.
- Built and flashed successfully to the tested ESP32-S3 target; physical visual confirmation is still pending.
- Corrected persistent colour migration for existing `A80F/880F` configurations using `uiColorPreset`.
- Cleared the TFT immediately after initialization to suppress the transient blue panel.
- Extended the Pablo Hacker splash to 3.2 seconds.
- Fixed the splash renderer clearing the generated Pablo Signal logo after drawing; exposure timing now starts after the final logo render and uses a decorative moving pulse instead of fake progress.
- Added timestamped `STARTUP` diagnostics for splash rendering and exposure boundaries.
- Replaced the Pablo Signal mark with a larger procedural cyber-mask/shield emblem inspired by the accepted cyber/hacker concept; no bitmap asset or heavy dependency was added.
- Build/flash of this correction is pending because PlatformIO was interrupted while installing cached/missing dependencies before source compilation.
# Unreleased — 2026-10-09

- Added hardware wiring documentation, SVG diagram, reassembly checklist, and Bruce App compatibility notes.
- Replaced the procedural Pablo splash emblem with a 160x155 RGB565 hooded cyber-hacker bitmap: green eyes, large `P`, and circuit details.
- Added an exact 240x320 splash preview tied to the firmware asset and splash coordinates.
- Built and flashed the `esp32-s3-n16r8-ili9341-touch` target successfully on the confirmed ESP32-S3 COM18. Physical visual confirmation of the new logo is still pending.
- Corrected the Pablo RGB565 bitmap transfer by enabling byte swapping only for its `pushImage()` call; Terminal Green rendering is unaffected.
- Flashed and runtime-checked the RGB565 byte-order correction on ESP32-S3 COM18; physical color confirmation remains pending.
