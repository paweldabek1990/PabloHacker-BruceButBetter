# BruceButBetter — ESP32-S3 N16R8 + TPM408-2.8

Data aktualizacji: 2026-10-08

## Stan

Robocza kopia projektu: `C:\BruceTouch`. Oryginalny `C:\Bruce` pozostaje nietknięty.

Pełny target PlatformIO: `esp32-s3-n16r8-ili9341-touch`.

## Potwierdzony sprzęt

- MCU: ESP32-S3-WROOM-1 N16R8, 16 MB Flash, 8 MB PSRAM.
- LCD: TPM408-2.8, 240x320, SPI, ILI9341 — fizycznie przetestowany przez użytkownika.
- Touch: XPT2046 — fizycznie przetestowany przez użytkownika.
- Touch IRQ: niepodłączony; obsługa używa odczytu bez IRQ.
- VCC LCD i LED: 3V3 według nowego, potwierdzonego połączenia użytkownika.

## Aktualna mapa GPIO

| Funkcja | GPIO | Uwagi |
|---|---:|---|
| SPI MOSI | 11 | wspólna magistrala |
| SPI MISO | 13 | wspólna magistrala |
| SPI SCK | 12 | wspólna magistrala |
| LCD CS | 15 | nowy pin potwierdzony |
| LCD RST | 16 | nowy pin potwierdzony |
| LCD DC | 17 | nowy pin potwierdzony |
| Touch CS | 10 | nowy pin potwierdzony |
| Touch IRQ | — | niepodłączony |
| microSD CS | 14 | wspólna magistrala |
| CC1101 CS | 3 | przeniesiony z GPIO10 z powodu kolizji z Touch CS |
| CC1101 GDO0 | 9 | zachowany |
| NRF24 #1 CE/CSN | 4/5 | zachowane |
| NRF24 #2 CE/CSN | 6/7 | zachowane |
| I2C SDA/SCL | 8/18 | zachowane |
| IR RX/TX | 1/2 | zachowane w konfiguracji |
| Buzzer | 47 | zachowany w konfiguracji; dostępność fizyczna do potwierdzenia |

## Konflikty rozwiązane

- Poprzednia konfiguracja miała Touch CS=17, LCD DC=16, LCD RST=3 i CC1101 CS=10.
- Nowy pinout wymaga LCD RST=16, LCD DC=17 i Touch CS=10.
- GPIO10 kolidował wtedy z CC1101 CS; CC1101 CS przeniesiono programowo na GPIO3.
- W trakcie kompilacji wykryto, że dziedziczony nagłówek nadpisywał CC1101 CS z powrotem na GPIO10; poprawiono targetowy nagłówek przez ponowne `#undef/#define` po include.
- SPI MOSI/SCK/MISO jest współdzielone przez LCD, Touch, SD, CC1101 i NRF24; każde urządzenie ma osobny CS.

## Testy

- Audyt różnicy względem działającego testu Adafruit: target wymuszał wcześniej `USE_HSPI_PORT`, podczas gdy test i reszta konfiguracji używają domyślnej magistrali SPI/FSPI. Usunięto to wymuszenie; LCD, touch i pozostałe urządzenia mają teraz wspólną magistralę GPIO11/12/13.
- Przed `tft.init()` wszystkie znane CS są jawnie ustawiane jako wyjścia w stanie nieaktywnym HIGH.
- Najnowszy build po tych poprawkach: SUCCESS; RAM 125708/327680 (38.4%), Flash 3557779/4653056 (76.5%), merged BIN 3623856 B.
- Najnowszy plik do wgrania: `C:\BruceTouch\Bruce-esp32-s3-n16r8-ili9341-touch.bin`.
- Próba flashowania przez COM13: port wykryty, ale otwarcie zakończyło się `PermissionError: port is busy`; firmware nie został w tej próbie wgrany.
- Flashowanie po ponownym otwarciu COM13: esptool połączył się z ESP32-S3, zapisał obraz od 0x0 i wykonał reset przez RTS. Weryfikacja po zapisie odczytała flash 16 MB (producent 0x68, urządzenie 0x4018). Zapis potwierdzony na poziomie bootloadera; obraz LCD/UI wymaga teraz obserwacji fizycznego ekranu.

- PlatformIO pełnego targetu: SUCCESS.
- Ostatni build: RAM 125708/327680 (38.4%), Flash 3557779/4653056 (76.5%).
- Finalny build po usunięciu diagnostycznego `return`: SUCCESS; RAM 125724/327680 (38.4%), Flash 3579595/4653056 (76.9%), merged BIN 3645680 B.
- Ostatni merged binary przed zmianą finalnego pinoutu: `C:\BruceTouch\Bruce-esp32-s3-n16r8-ili9341-touch.bin`, 3624432 B.
- Wcześniejsze testy z TFT_eSPI i ILI9341 wykonywały inicjalizację, ale przy starym mapowaniu LCD nie wyświetlały kolorów.
- Dodano bezpośredni test SPI ILI9341 z resetem, Sleep Out, ustawieniem okna 240x320 i czerwonym wypełnieniem.
- Test diagnostyczny został usunięty ze ścieżki startowej finalnego firmware; pełny start przechodzi teraz do `begin_storage()`, `begin_tft()` i reszty menu BruceButBetter.
- Flashowanie finalnego buildu przez COM13: SUCCESS; zapisano 3645680 B, hash data verified, urządzenie zresetowane przez RTS.

## Następny etap

1. Wgrać najnowszy target przez COM13 bez zmiany połączeń fizycznych.
2. Zweryfikować, czy po starcie pojawia się kalibracja/pełne UI zamiast jednolitego ekranu.
3. Jeśli obraz nadal będzie jednolity, zebrać log startowy i rozdzielić problem inicjalizacji od problemu rysowania; nie zmieniać pinów bez dowodu.

## Nierozwiązane

- Fizyczna dostępność GPIO3 dla nowego CS CC1101 musi odpowiadać przewodowi CC1101; oprogramowanie nie może zmienić fizycznego przewodu.
- Współdzielenie SPI wymaga poprawnego odłączania CS przez wszystkie moduły; jeśli któryś moduł trzyma CS w stanie niskim, będzie wymagał korekty sprzętowej lub programowej.
- Audyt wykazał, że wcześniejszy target wymuszał `USE_HSPI_PORT`, podczas gdy pozostała konfiguracja Bruce używa domyślnego SPI/FSPI. Usunięto wymuszenie HSPI, aby LCD, Touch i moduły korzystały z jednej magistrali GPIO11/12/13 zgodnie z założeniem i działającym testem Arduino.
- Dodano jawne ustawienie CS wszystkich urządzeń SPI w stan nieaktywny przed `tft.init()`, aby żaden moduł nie odpowiadał podczas inicjalizacji ILI9341.
- Buzzer GPIO47 oraz IR GPIO1/2 nie są na podanej lewej liście dostępnych pinów; funkcje pozostają w konfiguracji, ale wymagają dostępnego połączenia fizycznego.
