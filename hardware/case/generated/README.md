# Rugged A1 CAD outputs

Generated with the official portable OpenSCAD 2021.01 CLI.

## Status

- The PNGs are inspection renders of the current parametric A1 prototype.
- `RuggedA1_PROTOTYPE_ONLY_TFT_USB_coupon.stl` is the only exported STL.
- The coupon is **PROTOTYPE_ONLY** and is not a final enclosure or verified mounting jig.
- All photo-derived dimensions remain `PHOTO_ESTIMATE` until measured with calipers.

## Outputs

- `rugged-a1-front.png`
- `rugged-a1-back.png`
- `rugged-a1-perspective.png`
- `rugged-a1-layout.png` — component placement preview (TFT, ESP32, 18650 envelope, stylus)
- `RuggedA1_PROTOTYPE_ONLY_TFT_USB_coupon.stl`

Validation logs are stored beside these outputs. The coupon was accepted by OpenSCAD as a simple 3D object with two volumes; it has not been printed or physically fit-tested.

## Still required before final enclosure export

Measure TFT hole diameter/insets, PCB thickness, active-window offsets, ESP32 USB-C offsets and opening dimensions, 18650 holder envelope, complete stack height, and stylus tip/clip geometry.
