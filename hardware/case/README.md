# Rugged A enclosure — parametric design

This directory contains a printable-design starting point for the Pablo Hacker Rugged A enclosure. It is not yet a final print-ready design: the repository does not contain verified mechanical measurements for the TPM408-2.8 PCB, ESP32-S3 carrier, stylus or USB connector positions.

## Variants

- **A1** — touch-only, right-side stylus holder, no external controls.
- **A2** — same base envelope, with two optional BACK/SELECT button provisions. The button GPIO assignment is intentionally not part of firmware and must be selected only after a free-GPIO audit.

The common shell source is [rugged_a.scad](rugged_a.scad). Convenience wrappers are [rugged_a1.scad](rugged_a1.scad) and [rugged_a2.scad](rugged_a2.scad).

## Measurement status

All values marked `MEASURE_REQUIRED` in the SCAD file are placeholders. Do not print a final enclosure until these are measured:

- TFT PCB outer width/height/thickness, hole centers and hole diameter;
- TFT active-window offset from PCB edges;
- ESP32 carrier outer dimensions, mounting holes and both USB-C positions;
- 18650 holder dimensions and cable exit;
- stylus length, diameter and tip clearance;
- desired wall, gasket and connector clearances.

No STL is committed because OpenSCAD is not installed in the current environment and an STL generated from unverified dimensions would be misleading. After measurements are entered, export A1 and A2 from OpenSCAD and record the slicer settings.

## Material and print assumptions

PETG is the baseline; ASA is preferred for heat/UV resistance. Suggested starting values are 0.20 mm layer height, 4 perimeter walls, 25–35% infill and 5 mm corner radii, but these are print recommendations, not verified mechanical requirements.

## Power safety

Use a protected 18650 in a proper holder with a charge/protection module. Do not place a bare cell loose in the enclosure. The battery and charger are not connected to the ESP32 design until voltage regulation and protection are verified.
