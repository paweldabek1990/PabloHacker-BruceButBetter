# Function status

| Area | In source/build | Physical evidence on this target |
|---|---|---|
| ILI9341 display | Enabled | Confirmed: color/text/menu |
| XPT2046 touch | Enabled | Confirmed: coordinates and navigation |
| Terminal Green / Pablo Hacker splash | Enabled | Confirmed visually in prior tests |
| Wi-Fi scan/navigation | Enabled | Confirmed |
| BLE advertising / iBeacon | Enabled | Confirmed; `BRUCE-BLE-TEST` detected at about -34 dBm |
| BLE Spam | Enabled in full build | No iOS popup confirmation; compatibility remains unresolved |
| USB / Serial logging | Enabled | COM18 runtime logging confirmed |
| CC1101 / Sub-GHz | Enabled/configured | Not physically verified on this target |
| NRF24 #1/#2 | Enabled/configured | Not physically verified |
| PN532 / RFID / NFC | Enabled/configured | Not physically verified |
| IR | Enabled/configured | Not physically verified |
| Si5351 | Enabled/configured | Not physically verified |
| microSD | Configured | Mounting/operation not physically verified |
| LittleFS | Enabled | Build/runtime support present; feature coverage not exhaustive |
| GPS, LoRa, Ethernet, FM | Disabled for this target | Intentionally disabled in target configuration |
| Rugged A1 enclosure | CAD prototype | Not fit-verified; no final STL claim |

Compilation or menu presence is not physical verification.
