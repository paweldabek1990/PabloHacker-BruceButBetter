# Breadboard map — as built

## Confirmed from the photographs

The photographs show three breadboards: an ESP32 carrier board, a TFT carrier board, and a larger/intermediate board used by the wire bundle and/or rails. Photo 5 establishes the overall three-board topology; photos 1–4 provide close views of the ESP32 and TFT areas.

## Not recoverable from these photographs

The following cannot be certified without a dedicated row-level photo or continuity check:

- exact breadboard row and column for every Dupont end;
- which numbered holes are electrically bridged between boards;
- which power rails are split or bridged;
- the exact TFT header socket for each signal;
- whether any optional SD/RF/IR module is physically connected;
- the physical ESP32 board header number corresponding to each GPIO.

Every item above is `NEEDS_VISUAL_CONFIRMATION`. Do not disassemble the assembly using this file as a complete reconstruction map.

## Required row-level capture

Before removal, photograph each board square-on with the row numbers visible, one connector at a time, and label both ends of each wire. A continuity table should then replace the placeholders in `WIRING_AS_BUILT.md`.
