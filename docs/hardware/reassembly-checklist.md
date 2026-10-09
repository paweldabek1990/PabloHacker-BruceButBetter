# Reassembly checklist

## Before removing wires

- Disconnect both USB-C cables and external power.
- Photograph the breadboard from above and label each jumper.
- Save the current firmware and keep the TFT flat; do not pull on the display header.
- Treat GPIO numbers as GPIO numbers, not physical header positions.

## Reconnect power and common SPI

1. ESP32 3V3 → TFT `VCC` and `LED/BL` (the tested module wiring).
2. ESP32 GND → TFT `GND`.
3. GPIO12 → TFT `SCK` and touch `T_CLK`.
4. GPIO11 → TFT `SDA/MOSI` and touch `T_DIN`.
5. GPIO13 → TFT `SDO/MISO` and touch `T_DO`.

## Reconnect chip-select/control lines

| TFT/touch signal | ESP32 GPIO |
|---|---:|
| TFT CS | 15 |
| TFT DC | 17 |
| TFT RESET | 16 |
| Touch T_CS | 10 |
| Touch T_IRQ | NC |

The firmware also reserves SD CS 14, CC1101 CS 3 for this target, NRF24 #1 CE/CSN 4/5 and NRF24 #2 CE/CSN 6/7. Reconnect those only according to the corresponding module wiring. Do not short CS lines together.

## Power-up check

- Inspect every jumper against `wiring.svg` before connecting USB.
- Connect one known USB-UART/native USB cable only.
- Confirm the ESP32-S3 by VID/PID before flashing; do not assume COM18.
- Verify that the screen backlight is on and that the firmware splash/menu appears.
- If the display is white/blue or the board resets, disconnect power and re-check VCC/GND first.
