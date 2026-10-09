# Reassembly — working procedure

This is not yet a complete row-level reconstruction. The current photos do not support reconnecting every wire safely without additional inspection.

1. Disconnect both USB cables and wait until all LEDs are off.
2. Place the three boards as in photo 5: ESP32 carrier, TFT carrier, and the intermediate board.
3. Wire common ground and 3V3 only after checking continuity and confirming there is no 3V3-to-GND short.
4. Recreate the shared SPI bus: SCK 12, MOSI 11, MISO 13; then TFT CS 15, DC 17, RST 16, and touch CS 10.
5. Do not infer colours or holes. Label each conductor at both ends.
6. Perform an unplugged continuity check for every conductor.
7. Connect USB only after the power check; test the display first and touch second.
