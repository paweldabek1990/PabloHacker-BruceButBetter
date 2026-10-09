# Rugged A enclosure plan

The Rugged A design has two variants sharing one measured mechanical base:

- **A1:** touch-only, right-side stylus cradle, no external controls.
- **A2:** same base with two mechanical BACK/SELECT provisions. Firmware and GPIO are unchanged; the pins must be selected later from a verified free-pin audit.

The parametric source is [hardware/case/rugged_a.scad](../../hardware/case/rugged_a.scad). It deliberately labels all unmeasured component dimensions. The current repository has no verified TPM408 hole-center drawing, carrier outline, USB offsets, or stylus dimensions. Therefore no final STL is claimed.

## Common mechanical goals

- Four TFT mounting points without stressing the display glass.
- Front access to the touch panel and bottom pin header clearance.
- Access to both USB-C ports and BOOT/RESET controls.
- Protected 18650 holder and a separately verified charging/protection/power-regulation path.
- Right-side removable stylus cradle.
- PETG baseline, ASA option; rounded rugged corners and replaceable back cover.

## First print

Print only the fit coupon after measuring the hardware. Check TFT aperture, four mounting holes, USB insertion and stylus retention before printing the complete shell.
