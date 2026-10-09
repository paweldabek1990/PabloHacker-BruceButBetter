# Rugged A1 CASE_REVIEW

This folder contains the current OpenSCAD review outputs and source copies.

Status: prototype review only. The enclosure is not dimension-verified and must not be treated as final-print-ready.

## Outputs

- `generated/rugged-a1-comparison-board.png` — four existing CAD views.
- `generated/rugged-a1-exploded.png` — exploded component placement review.
- `generated/RuggedA1_PROTOTYPE_ONLY_TFT_USB_coupon.stl` — only STL, for fit testing.
- `comparison-board.html` — local review page.

## Placeholder status

The TFT, ESP32, battery, USB-C openings, microSD clearance, wire volume and stylus geometry are based partly on PHOTO_ESTIMATE values. The colored component envelopes in the exploded view are review placeholders, not measured CAD bodies. No physical fit test has been performed.

## Critical measurements before a full enclosure print

1. TFT hole diameter, centers and PCB thickness.
2. TFT active-window offsets and header/microSD envelope.
3. ESP32 dual USB-C center positions and opening height/width.
4. Complete board/wire/battery stack height and protected 18650 holder dimensions.
5. Stylus tip, body taper and clip geometry.

## PETG coupon print

Print flat on the bed, 0.20 mm layers, 4 walls, 30% infill, 0.20–0.30 mm XY clearance target. Measure the printed holes and openings before changing the enclosure parameters. This is a coupon only, not a final enclosure.
