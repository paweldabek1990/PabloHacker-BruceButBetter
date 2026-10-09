# Changelog — DIY Touch variant

This file records confirmed local changes; it is not a replacement for the upstream Bruce history.

## Unreleased

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
