# Pablo Hacker — BruceButBetter

Nieoficjalny wariant sprzętowy BruceButBetter dla ESP32-S3-WROOM-1 N16R8 z ekranem TPM408-2.8 ILI9341 240×320 oraz dotykiem XPT2046.

## Status

Firmware uruchamia pełne menu, Terminal Green, ekran startowy Pablo Hacker i obsługę dotyku. Fizycznie potwierdzono TFT, dotyk, menu, skanowanie Wi-Fi oraz standardową reklamę BLE `BRUCE-BLE-TEST`. Moduły CC1101, NRF24, PN532/RFID, IR, Si5351, SD i pozostałe rozszerzenia pozostają niezweryfikowane fizycznie, jeśli nie wskazano inaczej w dokumentacji.

## Sprzęt i GPIO

Pełna tabela znajduje się w [HARDWARE_WIRING.md](HARDWARE_WIRING.md) oraz [docs/hardware/pinout.md](docs/hardware/pinout.md). Główne SPI: MOSI GPIO11, SCK GPIO12, MISO GPIO13; TFT CS15/DC17/RST16; Touch CS10; SD CS14.

## Budowanie

```powershell
pio run -e esp32-s3-n16r8-ili9341-touch
```

Konfiguracja używa pioarduino / Arduino-ESP32 3.3.6. Przed flashowaniem zawsze zidentyfikuj układ przez `esptool chip-id`; nie używaj `erase_flash` i nie kasuj NVS.

## Dokumentacja

- [README.md](README.md) — wersja angielska
- [UPSTREAM.md](UPSTREAM.md) — pochodzenie i licencja
- [HARDWARE_WIRING.md](HARDWARE_WIRING.md) — okablowanie
- [docs/hardware/rugged-a.md](docs/hardware/rugged-a.md) — obudowa Rugged A1
- [DIAGNOSTYKA.md](DIAGNOSTYKA.md) — dziennik techniczny
- [KNOWN_ISSUES.md](KNOWN_ISSUES.md) — znane ograniczenia
- [docs/hardware/AS_BUILT/VERIFICATION_REPORT.md](docs/hardware/AS_BUILT/VERIFICATION_REPORT.md) — ostrożna dokumentacja ze zdjęć rzeczywistego zestawu

Zdjęcia potwierdzają obecność trzech płytek stykowych i modułów, ale nie pozwalają jeszcze jednoznacznie odtworzyć każdego przewodu, rzędu ani mostka zasilania. Nie rozłączaj działającego zestawu wyłącznie na podstawie roboczej dokumentacji AS_BUILT.

Projekt jest przeznaczony wyłącznie do autoryzowanych testów, edukacji i pracy na własnym sprzęcie/sieci.
