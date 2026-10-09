# Rugged A1 — minimum measurements before first print

The photo estimates are sufficient to lay out a visual prototype, but not enough for a safe first physical print. Measure these items with calipers:

1. TFT PCB width, height and total stack thickness.
2. Each of the four TFT hole centers from two reference edges, plus hole diameter.
3. TFT active-window width/height and its X/Y offset from the PCB edges.
4. Bottom header total width, pin pitch, pin height and required wire bend radius.
5. microSD slot opening position, width, height and card insertion direction.
6. ESP32-S3 exact outline, component height, BOOT/RESET button positions and both USB-C center coordinates/orientation.
7. 18650 holder outer W/L/H and charging-board dimensions, connector clearance and cable exit.
8. Stylus tip diameter, body diameter at several points, clip width/height and the desired extraction opening.

The minimum safe first print is the fit coupon in `hardware/case/tft-usb-fit-coupon.scad`, after replacing its placeholder values. Do not export the full shell until the TFT holes and USB-C openings pass that coupon test.
