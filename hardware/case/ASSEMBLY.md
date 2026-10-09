# Rugged A assembly plan

1. Measure and record all `MEASURE_REQUIRED` values in `rugged_a.scad`.
2. Print only a low-height fit coupon for the TFT opening and USB openings.
3. Confirm the TFT sits flat without pressure on the glass or flex cable.
4. Confirm both ESP32 USB-C connectors can be inserted with the board installed.
5. Install the protected 18650 holder mechanically; keep it isolated from exposed GPIO and solder joints.
6. Route TFT/touch wires with strain relief and preserve the documented SPI/CS mapping.
7. For A2, install buttons only after selecting genuinely free GPIO. This repository does not authorize GPIO15/16 because they conflict with TFT CS/RESET.
8. Test USB, reset/boot access, TFT, touch and battery protection separately before closing the case.
