# BruceButBetter DIY Touch — okablowanie

Dokument opisuje konfigurację targetu `esp32-s3-n16r8-ili9341-touch` odczytaną z repozytorium oraz elementy potwierdzone testami fizycznymi. Numery poniżej są numerami **GPIO**, nie numerami fizycznych wyprowadzeń płytki.

## TFT TPM408-2.8

| Pin modułu | ESP32 GPIO | Funkcja | Źródło / status |
|---|---:|---|---|
| VCC | 3V3 | zasilanie modułu | połączenie fizyczne podane przez użytkownika; napięcie modułu nie wynika z kodu |
| GND | GND | masa | fizycznie potwierdzone |
| SCK | 12 | wspólny SPI clock | `boards/esp32-s3-n16r8-ili9341-touch/esp32-s3-n16r8-ili9341-touch.ini` |
| MOSI / SDA | 11 | SPI controller → TFT | jw. |
| MISO | 13 | TFT/urządzenia → ESP32 | jw. |
| CS | 15 | TFT chip select | jw.; fizyczny test ILI9341 działał |
| DC | 17 | data/command | jw.; fizyczny test działał |
| RESET | 16 | reset kontrolera TFT | jw.; fizyczny test działał |
| BL / LED | 3V3 | podświetlenie | podłączone fizycznie przez użytkownika; firmware ma `TFT_BL=-1`, więc nie steruje BL |

## XPT2046

| Pin modułu | ESP32 GPIO | Funkcja | Status |
|---|---:|---|---|
| T_CS | 10 | touch chip select | `TOUCH_CS=10`; fizyczny test współrzędnych działał |
| T_CLK | 12 | wspólny SPI clock | konfiguracja TFT/SPI |
| T_DIN | 11 | MOSI do touch | wspólna magistrala |
| T_DO | 13 | MISO z touch | wspólna magistrala |
| T_IRQ | NC | przerwanie | niepodłączone; wejście jest odczytywane pollingiem |
| VCC | 3V3 | zasilanie | fizycznie użyte; BRAK niezależnej specyfikacji modułu w repo |
| GND | GND | masa | fizycznie użyte |

## Pozostałe sygnały targetu

| Funkcja | GPIO | Uwagi |
|---|---:|---|
| I2C SDA | 8 | OLED/PN532/Si5351 wspólny bus; OLED jest nieużywany/uszkodzony |
| I2C SCL | 18 | jw. |
| Si5351 | 8/18, 0x60 | I2C; obecność modułu fizycznie niezweryfikowana |
| PN532 | 8/18, 0x24 | konfiguracja I2C; obecność fizycznie niezweryfikowana |
| CC1101 GDO0 | 9 | kod targetu |
| CC1101 CS | 3 deklarowany w target | `pins_arduino.h` ma 3, ale odziedziczony nagłówek redefiniuje 10; patrz konflikty |
| CC1101 MOSI/SCK/MISO | 11/12/13 | wspólny SPI |
| microSD CS | 14 | slot na module TFT; karta/montaż niezweryfikowane, runtime raportował mount failure |
| microSD MOSI/SCK/MISO | 11/12/13 | wspólny SPI |
| NRF24 #1 CE/CSN | 4/5 | wspólny SPI 11/12/13 |
| NRF24 #2 CE/CSN | 6/7 | wspólny SPI; drugi moduł nie jest fizycznie zweryfikowany |
| IR RX/TX | 1/2 | target flags; moduł IR niezweryfikowany |
| buzzer | 47 | target flags; fizycznie niezweryfikowany |
| buttons | 15,16,38,39,40,41 | aktywne LOW do GND; 15/16 kolidują z TFT CS/RESET, dlatego konfiguracja przycisków odziedziczona z ESP-General wymaga ostrożności |

## SPI i konflikty

Główna magistrala SPI jest współdzielona:

```text
ESP32 GPIO11 MOSI ── TFT MOSI, XPT2046 DIN, SD MOSI, CC1101 MOSI, NRF MOSI
ESP32 GPIO12 SCK  ── TFT SCK,  XPT2046 CLK, SD SCK,  CC1101 SCK,  NRF SCK
ESP32 GPIO13 MISO ── TFT MISO, XPT2046 DO,  SD MISO, CC1101 MISO, NRF MISO

CS: TFT=15, TOUCH=10, SD=14, NRF1=5, NRF2=7, CC1101=3 declared
CE: NRF1=4, NRF2=6
```

Każde urządzenie SPI musi pozostawać nieaktywne przez własny CS. `src/main.cpp` ustawia CS TFT, touch, SD, CC1101 i NRF przed `tft.init()`.

## Fizyczne numery pinów płytki

Repozytorium opisuje GPIO, nie numerację otworów/headera. Fizyczny numer pinu ESP32-S3 należy odczytywać z nadruku konkretnej płytki YD-ESP32-S3 / VCC-GND Studio. Nie wolno utożsamiać numeru GPIO z numerem pinu modułu WROOM.

## Checklist demontażu i montażu

1. Odłącz oba USB-C i zasilanie z breadboardu.
2. Zrób zdjęcie obu stron breadboardu przed wyjęciem przewodów.
3. Oznacz przewody SPI: MOSI 11, SCK 12, MISO 13.
4. Oznacz osobno każdy CS/CE: 15, 10, 14, 5, 7, 3, 4, 6.
5. Nie używaj GPIO 26–32 (flash), 33–37 (OPI PSRAM), 19–20 (native USB), 43–44 (UART0), 45–46 (strapping).
6. Najpierw podłącz GND, potem 3V3, następnie SPI i CS.
7. Przed USB sprawdź ciągłość przewodów i brak zwarcia 3V3–GND.
8. Po podłączeniu USB użyj COM18 jako natywnego USB ESP32-S3; CH343 COM13 jest osobnym interfejsem UART i nie jest tym samym portem runtime.
9. Testuj kolejno LCD, touch, SD i dopiero moduły radiowe.
