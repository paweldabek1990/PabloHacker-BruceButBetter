# Diagnostyka BruceButBetter — ESP32-S3 N16R8 + TPM408-2.8

Data raportu: 2026-10-08

## 1. Aktualny stan

Robocza kopia: `C:\BruceTouch`. Oryginalny `C:\Bruce` nie był modyfikowany.

Pełny target PlatformIO kompiluje się poprawnie i został wgrany do ESP32-S3 przez COM13. ESP32-S3 jest wykrywany przez esptool, a pamięć flash 16 MB jest odczytywana poprawnie. Niezależne szkice `Adafruit_ILI9341` oraz `XPT2046_Touchscreen` były według użytkownika fizycznie sprawdzone na obecnym okablowaniu: LCD wyświetlał kolory/tekst, a touch zwracał zmienne X/Y/Z.

Pełny BruceButBetter nie wyświetla prawidłowego UI. Aktualny objaw TFT: podświetlony, jednolity niebieski ekran z drobnymi regularnymi liniami/paskami; brak menu i brak widocznych punktów kalibracji. Dotyk w pełnym firmware nie został potwierdzony. Na podstawie zdjęcia nie można stwierdzić, czy firmware zatrzymuje się podczas startu, czy błędnie wysyła dane obrazu.

## 2. Ostatni firmware

- Środowisko: `esp32-s3-n16r8-ili9341-touch`.
- PlatformIO: konfiguracja projektu używa platformy pioarduino Arduino 3.3.6 oraz frameworka Arduino ESP32.
- Ostatni zapisany log builda: `C:\BruceTouch\build-touch.log`, czas pliku 2026-10-06 22:28; późniejszy log `build-swap.log` ma czas 2026-10-07 01:04.
- Ostatni build po zmianie magistrali SPI: SUCCESS.
- RAM: 125708 / 327680, 38.4%.
- Flash aplikacji: 3557779 / 4653056, 76.5%.
- Scalony BIN z ostatniego builda: `C:\BruceTouch\Bruce-esp32-s3-n16r8-ili9341-touch.bin`, 3623856 bajtów.
- Wcześniejszy finalny build miał 3645680 bajtów i również został wgrany.
- Flashowanie najnowszego obrazu przez COM13 po restarcie: esptool połączył się, wykonał zapis od `0x0` i reset RTS. Następnie `flash-id` potwierdził ESP32-S3 oraz flash 16 MB. W logu esptool wystąpił problem kodowania paska postępu Windows, ale końcowy reset RTS nastąpił.

## 3. Aktualny pinout

| Funkcja | GPIO | Stan/uwagi |
|---|---:|---|
| SPI MOSI | 11 | wspólna magistrala |
| SPI MISO | 13 | wspólna magistrala |
| SPI SCK | 12 | wspólna magistrala |
| TFT CS | 15 | konflikt z odziedziczonym `UP_BTN=15` |
| TFT DC | 17 | konfiguracja targetu |
| TFT RST | 16 | konflikt z odziedziczonym `DW_BTN=16` |
| XPT2046 CS | 10 | konflikt z odziedziczonym CC1101 CS; target przenosi CC1101 programowo na GPIO3 |
| XPT2046 IRQ | niepodłączony | obsługa przez polling |
| LCD VCC/LED | 3V3 | potwierdzone przez użytkownika |
| LCD GND | GND | potwierdzone przez użytkownika |
| microSD CS | 14 | wspólna magistrala |
| CC1101 CS | 3 | target override; fizyczne podłączenie GPIO3 nie jest potwierdzone |
| CC1101 GDO0 | 9 | konfiguracja |
| NRF24 #1 CE/CSN | 4/5 | konfiguracja |
| NRF24 #2 CE/CSN | 6/7 | konfiguracja |
| I2C SDA/SCL | 8/18 | konfiguracja |
| IR RX/TX | 1/2 | konfiguracja; fizyczna dostępność niepotwierdzona |
| Buzzer | 47 | konfiguracja; nie znajduje się na podanej liście lewej strony |
| Przyciski odziedziczone | SEL 40, UP 15, DOWN 16, LEFT 38, RIGHT 39, ESC 41 | UP/DOWN kolidują z TFT CS/RST; target używa interfejsu CYD, więc rzeczywiste użycie tych przycisków w tej ścieżce jest niejednoznaczne |
| GPIO 19/20 | — | native USB, nieużywane |
| GPIO 26–32 | — | flash, nieużywane |
| GPIO 33–37 | — | OPI PSRAM, nieużywane |
| GPIO 43/44 | — | UART0, zdefiniowane jako SERIAL TX/RX |
| GPIO 45/46 | — | strapping/problemowe, nieużywane |

## 4. Sterownik LCD i kolejność startu

- Backend: lokalna biblioteka `C:\BruceTouch\lib\TFT_eSPI` przez wrapper `lib/HAL/display/tftespi.h/.cpp`.
- Sterownik: `ILI9341_DRIVER`.
- Touch: `USE_TFT_eSPI_TOUCH`, XPT2046 przez `TFT_eSPI::getTouch()` i `calibrateTouch()`.
- Konfiguracja targetu: `boards/esp32-s3-n16r8-ili9341-touch/esp32-s3-n16r8-ili9341-touch.ini` oraz `pins_arduino.h`.
- Rozdzielczość: 240x320; `ROTATION=1`.
- SPI LCD: GPIO SCK=12, MISO=13, MOSI=11, CS=15, DC=17, RST=16.
- Częstotliwość LCD: `SPI_FREQUENCY=10000000`.
- Częstotliwość touch: `SPI_TOUCH_FREQUENCY=2500000`.
- IRQ touch nie jest używany.
- Inicjalizacja w `src/main.cpp`: `setup_gpio()` → ustawienie CS w HIGH → `tft.init()` → `begin_storage()` → `begin_tft()` → `_post_setup_gpio()` → kalibracja XPT2046, jeśli `/calData` nie istnieje → boot screen/menu.
- Rysowanie UI: pętla `loop()` wykonuje `tft.fillScreen(bruceConfig.bgColor)` oraz `mainMenu.begin()`.
- TFT_eSPI wykonuje `spi.begin(TFT_SCLK, TFT_MISO, TFT_MOSI, -1)` w kodzie biblioteki. W obecnym targetcie usunięto jawne `USE_HSPI_PORT`; zamierzeniem było użycie FSPI/domyslnej magistrali na tych samych GPIO co test Adafruit.

## 5. Wprowadzone zmiany

- Utworzono osobny target `esp32-s3-n16r8-ili9341-touch`; `C:\Bruce` pozostawiono jako oryginał.
- Dodano/zmodyfikowano `boards/esp32-s3-n16r8-ili9341-touch/esp32-s3-n16r8-ili9341-touch.ini`.
- Dodano/zmodyfikowano `boards/esp32-s3-n16r8-ili9341-touch/pins_arduino.h` z pinami LCD/touch oraz override CC1101 CS=3.
- Zmieniono `boards/esp32-s3-n16r8-ili9341-touch/interface.cpp` przez użycie interfejsu CYD jako źródła obsługi TFT_eSPI/XPT2046; nie użyto pinoutu CYD.
- Zmieniono `boards/CYD-2432S028/interface.cpp`: obsługa `TFT_BL < 0`, kalibracja i polling touch pozostają aktywne.
- Zmieniono `lib/HAL/display/tftespi.h`: udostępniono `drawBitmap` wrapperowi.
- W `src/main.cpp` dodano jawne ustawianie CS LCD, touch, SD, CC1101 i NRF24 w HIGH przed `tft.init()` oraz pozostawiono logi etapów startu.
- Usunięto wymuszenie `USE_HSPI_PORT`, aby LCD/touch/SD/moduły współdzieliły FSPI.
- Zastąpiono kolizyjne makra fontów `FP/FM/FG` przez `BRUCE_FONT_P/M/G`.
- Nie dodawano nowej funkcji diagnostycznej do ostatniego firmware i nie tworzono uproszczonego demo jako rozwiązania końcowego.

## 6. Wykonane testy

### Testy fizyczne

- Niezależny test `Adafruit_ILI9341`: według użytkownika czerwony, zielony, niebieski ekran i tekst — wynik pozytywny.
- Niezależny test `XPT2046_Touchscreen`: według użytkownika zmienne współrzędne X/Y/Z — wynik pozytywny.
- Pełny BruceButBetter po ostatnim flashu: wynik negatywny dla UI; ekran niebieski z regularnymi liniami, bez menu i punktów kalibracji.
- Flash przez COM13: połączenie i zapis wykonane; `flash-id` po zapisie potwierdził ESP32-S3 i 16 MB flash.
- Logów aplikacji z uruchomionego ESP32 nie udało się odczytać: próba 8-sekundowego odczytu COM13 zwróciła BRAK DANYCH.

### Testy programowe

- Pełne buildy PlatformIO targetu kończyły się SUCCESS.
- Scalanie BIN kończyło się SUCCESS.
- Analiza kodu potwierdziła właściwe makra ILI9341, piny i kolejność argumentów `spi.begin(SCK, MISO, MOSI, -1)` w TFT_eSPI.
- Nie wykonano nowego builda ani flashowania po poleceniu STOP.

## 7. Błędy i ostrzeżenia z logów

Istotne, rzeczywiste komunikaty:

```text
======================== [SUCCESS] Took 1099.86 seconds ========================
RAM:   [====      ]  38.4% (used 125708 bytes from 327680 bytes)
Flash: [========  ]  76.5% (used 3557779 bytes from 4653056 bytes)
[merge_bin] Success -> C:\BruceTouch\Bruce-esp32-s3-n16r8-ili9341-touch.bin (3623856 bytes)
```

W logach kompilacji występują liczne ostrzeżenia `macro redefined`, m.in. dla `CC1101_SS_PIN`, `SDCARD_MOSI`, `NRF24_MOSI_PIN`, `ROTATION`, `SMOOTH_FONT` i `DEVICE_NAME`. Wynikają z dziedziczenia `ESP-General/pins_arduino.h` i późniejszych override targetu; nie przerwały builda.

W logu flashowania wystąpił komunikat:

```text
UnicodeEncodeError: 'charmap' codec can't encode characters ...
Hard resetting via RTS pin...
```

Wcześniejsze próby otwarcia portu zwracały:

```text
PermissionError(13, 'Odmowa dostępu', None, 5)
Could not open COM13, the port is busy or doesn't exist.
```

Po użyciu uprawnień systemowych esptool połączył się i wykonał reset. Nie ma dostępnego logu aplikacji pokazującego `SETUP START`, `BEFORE TFT INIT` lub `AFTER TFT INIT`.

## 8. Hipotezy, uporządkowane

1. **Konflikt lub niepełna izolacja wspólnej magistrali SPI — najbardziej prawdopodobne.** LCD, XPT2046, SD, CC1101 i NRF24 współdzielą GPIO 11/12/13. Kod ustawia CS w HIGH przed LCD, ale odziedziczone definicje i inicjalizacje różnych modułów nadal generują ostrzeżenia/redefinicje. `CC1101_SS_PIN` jest definiowany najpierw jako 10, a później jako 3. Regularne linie przy działającym podświetleniu są zgodne z błędnymi/zakłóconymi zapisami SPI, ale nie są dowodem rozstrzygającym.
2. **Różnica między działającym Adafruit a TFT_eSPI na ESP32-S3.** Adafruit używa jawnego `SPI.begin(...)` i własnych transakcji, natomiast TFT_eSPI wybiera port na podstawie `TFT_config.h`/Kconfig i wywołuje własne `spi.begin(...)`. Samo usunięcie `USE_HSPI_PORT` nie zostało potwierdzone logiem runtime. Możliwy jest wybór innego hosta SPI lub ponowna inicjalizacja magistrali przez SD/moduł.
3. **Zatrzymanie przed kalibracją/menu w `begin_storage()`, `begin_tft()` albo `_post_setup_gpio()`.** Kolejność w `setup()` wykonuje te etapy przed `mainMenu.begin()`. Brak punktów kalibracji może oznaczać, że kod nie dochodzi do `_post_setup_gpio()` albo `/calData` już istnieje i kalibracja jest pomijana. Brak logu runtime uniemożliwia rozstrzygnięcie.

## 9. Jeden następny test diagnostyczny

Bez przebudowy całego firmware: przechwycić log UART 115200 od resetu ESP32, z widocznymi markerami już obecnymi w `src/main.cpp`:

```text
>>> ENTER SETUP <<<
SETUP START
>>> BEFORE GPIO <<<
>>> AFTER GPIO <<<
>>> BEFORE TFT INIT <<<
>>> AFTER TFT INIT <<<
>>> TFT SIZE ... <<<
```

Ten jeden test rozróżni zatrzymanie w GPIO/SPI/TFT od zatrzymania później w storage, touch lub menu. Jeśli markery przejdą wszystkie, niezależny test z jednorazowym odłączeniem pozostałych CS programowo (bez zmiany przewodów) rozstrzygnie hipotezę wspólnej magistrali; tego testu nie wykonano i nie wprowadzono go w tym raporcie.

## Informacje nieznane

- BRAK DANYCH o runtime logu z ESP32 po ostatnim resecie.
- BRAK DANYCH, czy `/calData` istnieje w LittleFS i czy kalibracja jest pomijana.
- BRAK DANYCH, czy fizyczny CC1101 jest rzeczywiście podłączony do GPIO3 po zmianie programowej.
- BRAK DANYCH, który dokładnie moduł utrzymuje CS podczas startu.
- BRAK DANYCH, czy TFT_eSPI w runtime używa FSPI mimo usunięcia `USE_HSPI_PORT`.
- BRAK DANYCH, czy regularne linie wynikają z kontrolera TFT, magistrali SPI, kolejności inicjalizacji czy zatrzymania programu.

## Uzupełnienie po uzyskaniu runtime logu przez natywny USB CDC

Użytkownik potwierdził dostęp do logu przez natywny USB ESP32-S3 na COM18, 115200. Widoczne są `BEFORE BRUCE CONFIG`, wielokrotne `SDCARD NOT mounted, check wiring and format` oraz późniejszy wydruk konfiguracji JSON. Nie wykonano builda ani flashowania w ramach tej analizy.

### Kolejność markerów

W `src/main.cpp` kolejność jest jednoznaczna:

1. `Serial.printf("BEFORE BRUCE CONFIG\\r\\n")` — linia 472.
2. `esp_rom_printf(">>> BEFORE TFT INIT <<<\\r\\n")` — linia 496.
3. `tft.init()` — linia 497.
4. `esp_rom_printf(">>> AFTER TFT INIT <<<\\r\\n")` — linia 498.
5. `begin_storage()` — linia 503.
6. `begin_tft()` — linia 504.
7. `_post_setup_gpio()` — później; przy braku `/calData` uruchamia kalibrację.

Zatem `BEFORE TFT INIT` nie może występować przed `BEFORE BRUCE CONFIG`; jest wysyłany później i innym mechanizmem (`esp_rom_printf`). W aktualnym scalonym BIN wszystkie cztery teksty `BEFORE BRUCE CONFIG`, `BEFORE TFT INIT`, `AFTER TFT INIT` i `TFT SIZE` znaleziono bezpośrednio w bajtach `C:\BruceTouch\Bruce-esp32-s3-n16r8-ili9341-touch.bin`. To potwierdza obecność markerów w obrazie, ale nie dowodzi ich odebrania na COM18.

Skoro po `BEFORE BRUCE CONFIG` pojawia się `SDCARD NOT mounted`, wykonanie musiało przejść przez `tft.init()` oraz wejść do `begin_storage()`, ponieważ `setupSdCard()` jest wywoływane dopiero w `begin_storage()` (main.cpp:196–200). Najbardziej prawdopodobne jest więc, że TFT nie zatrzymuje CPU na samym `tft.init()`; problem występuje przy późniejszym rysowaniu albo po zmianie konfiguracji SPI przez SD.

### SD i SPI

`src/core/sd_functions.cpp:32–101` zawiera `setupSdCard()`. Przy `USE_TFT_eSPI_TOUCH` ustawia `task=true` (linie 42–45), po czym wybiera wprost:

```cpp
if (!SD.begin((int8_t)bruceConfigPins.SDCARD_bus.cs)) result = false;
```

To jest linia 54 i nie przekazuje jawnie `tft.getSPIinstance()`. Alternatywna gałąź dla wspólnej magistrali, która jawnie przekazuje `SD.begin(cs, tft.getSPIinstance())`, znajduje się dopiero w liniach 57–70, ale przy `USE_TFT_eSPI_TOUCH` nie jest wykonywana. TFT_eSPI na ESP32-S3 bez `USE_HSPI_PORT` ma w `lib/TFT_eSPI/Processors/TFT_eSPI_ESP32.c:25` `SPIClass& spi = SPI`, a `getSPIinstance()` zwraca ten obiekt w `TFT_eSPI.cpp:5998`.

Wniosek: nieudane `SD.begin(cs)` może ponownie zainicjalizować/zmienić stan tego samego obiektu SPI, który wykorzystuje TFT. Jedno wywołanie następuje w starcie, a dalsze wywołania `setupSdCard()` są możliwe w wielu modułach; funkcja ma ochronę `if (sdcardMounted) return true`, ale po błędzie `sdcardMounted=false`, więc każde późniejsze wywołanie ponawia próbę. Powtarzane komunikaty SD są zatem realnym podejrzanym zakłóceniem, nie dowodem uszkodzenia LCD.

### Najmniejszy rozstrzygający test / poprawka

Najmniejszy test bez usuwania SD i bez zmiany mapowania GPIO: w jednej zmianie diagnostycznej wymusić w gałęzi `task` wywołanie `SD.begin(bruceConfigPins.SDCARD_bus.cs, tft.getSPIinstance())`, zachowując dotychczasowy CS, a następnie sprawdzić, czy znikają paski i pojawia się UI. To nie usuwa SD; tylko wymusza tę samą, jawnie skonfigurowaną instancję SPI co TFT. Alternatywny test bez zmiany kodu to chwilowe odłączenie samego modułu SD/pozostawienie jego CS nieaktywnego, ale użytkownik nie powinien zmieniać okablowania bez osobnej decyzji.

Na podstawie obecnego logu najbardziej prawdopodobna przyczyna to **gałąź `USE_TFT_eSPI_TOUCH` w `setupSdCard()` używająca `SD.begin(cs)` zamiast jawnego `tft.getSPIinstance()` na współdzielonej magistrali**, a nie brak inicjalizacji TFT. Nie wykonano jeszcze tej poprawki ani testu.

## Kontrolowany eksperyment SD SPI — 2026-10-08

### Zgodność API

- `C:\BruceTouch\lib\TFT_eSPI\TFT_eSPI.h:881` deklaruje `static SPIClass &getSPIinstance(void)`.
- `C:\BruceTouch\lib\TFT_eSPI\TFT_eSPI.cpp:5998–6001` zwraca referencję `SPIClass&`.
- Faktycznie używany framework Arduino ESP32 3.3.6 ma w `C:\Users\BRUGER\.platformio\packages\framework-arduinoespressif32\libraries\SD\src\SD.h:30–32` sygnaturę `bool begin(uint8_t ssPin, SPIClass &spi, uint32_t frequency, ...)`.
- Typy są zgodne.

### Dokładny diff

```diff
--- a/src/core/sd_functions.cpp
+++ b/src/core/sd_functions.cpp
@@
-        if (!SD.begin((int8_t)bruceConfigPins.SDCARD_bus.cs)) result = false;
+        if (!SD.begin((int8_t)bruceConfigPins.SDCARD_bus.cs, tft.getSPIinstance())) result = false;
```

Nie zmieniono GPIO, TFT, touch, częstotliwości ani innych modułów.

### Build

- Log: `C:\BruceTouch\build-sd-spi.log`.
- Wynik: SUCCESS, exit code 0.
- RAM: 125692/327680 (38.4%).
- Flash: 3575283/4653056 (76.8%).
- Merged BIN: `C:\BruceTouch\Bruce-esp32-s3-n16r8-ili9341-touch.bin`, 3641360 bajtów.
- Ostrzeżenia linkera/redefinicji pozostały, ale nie wystąpił błąd związany z nową sygnaturą `SD.begin`.

### Flash i runtime

- Po buildzie dostępny był tylko `COM18`, opisany jako `USB Serial Device (COM18)`.
- Próba flashowania przez COM18 nie została wykonana, ponieważ port był zajęty: `PermissionError(13, 'Odmowa dostępu')` / `Could not open COM18`.
- Firmware z eksperymentu nie został potwierdzony jako wgrany.
- Nie wykonano nowego odczytu runtime po tej zmianie, ponieważ COM18 był zajęty przez aktywny interfejs logów.
- Wynik obrazu LCD po tej zmianie: BRAK DANYCH — wymaga fizycznego testu po udanym flashu.

### Wynik po udanym flashu eksperymentu

- Flash przez natywny USB-Serial/JTAG COM18: SUCCESS; zapisano 3641360 bajtów, hash danych zweryfikowany, wykonano reset RTS.
- Runtime log COM18 został przechwycony po resecie.
- Firmware nie dochodzi do `AFTER TFT INIT`. Powtarza się:

```text
>>> ENTER SETUP <<<
BEFORE BRUCE CONFIG
>>> BEFORE GPIO <<<
>>> AFTER GPIO <<<
>>> BEFORE TFT INIT <<<

Guru Meditation Error: Core 1 panic'ed (StoreProhibited)
EXCVADDR: 0x00000010
Backtrace: 0x421457f3:0x3fcebc80 0x4209d10f:0x3fcebcb0 0x4212f5db:0x3fcebd80 0x403863f9:0x3fcebda0
Rebooting...
```

- Występuje również `E (633) esp_ota_ops: not found otadata` przed startem aplikacji.
- Z tego wynika, że po tej zmianie program zatrzymuje się w `tft.init()` (`src/main.cpp:497`), zanim wykona `begin_storage()` (`src/main.cpp:503`). Zatem zmiana `SD.begin(..., tft.getSPIinstance())` nie jest przyczyną tego konkretnego crashu i nie można jej ocenić po obrazie LCD, ponieważ SD nie jest jeszcze uruchamiane.
- Próba symbolizacji backtrace przez lokalny `addr2line` nie powiodła się z powodu błędu uruchomienia narzędzia Windows `Nieprawidłowa relokacja biblioteki DLL systemu`; adresy pozostają niesymbolizowane.
- Zgodnie z poleceniem nie wykonano kolejnego eksperymentu, builda ani flashowania po tym wyniku.

## Pełny crash log i dekodowanie — 2026-10-08

Ponowny odczyt z natywnego USB COM18 potwierdził powtarzalny crash:

```text
E (649) esp_ota_ops: not found otadata
>>> ENTER SETUP <<<
BEFORE BRUCE CONFIG
>>> BEFORE GPIO <<<
>>> AFTER GPIO <<<
>>> BEFORE TFT INIT <<<

Guru Meditation Error: Core  1 panic'ed (StoreProhibited). Exception was unhandled.

PC      : 0x421457f6  PS      : 0x00060330  A0      : 0x8209d112  A1      : 0x3fcebc80
A2      : 0x00000000  A3      : 0x00000003  A4      : 0x3fca8278  A5      : 0x0000000b
A6      : 0x00000000  A7      : 0x60004000  A8      : 0x00000010  A9      : 0x08000000
A10     : 0x3fcaa600  A11     : 0x00000000  A12     : 0x00000001  A13     : 0x3fca15d4
A14     : 0x00000001  A15     : 0x000c1001  SAR     : 0x00000010
EXCCAUSE: 0x0000001d  EXCVADDR: 0x00000010

Backtrace: 0x421457f3:0x3fcebc80 0x4209d10f:0x3fcebcb0 0x4212f5db:0x3fcebd80 0x403863f9:0x3fcebda0

ELF file SHA256: 23f1bc1f2
Rebooting...
```

Adresy zostały zdekodowane z `C:\BruceTouch\.pio\build\esp32-s3-n16r8-ili9341-touch\firmware.elf` przez tablicę symboli ELF:

```text
0x421457f3 -> TFT_eSPI::writecommand(uint8_t) [compiler constprop clone]
0x4209d10f -> setup()
0x4212f5db -> loopTask(void*)
0x403863f9 -> vPortTaskWrapper
```

Dokładny adres PC `0x421457f6` wypada wewnątrz tego samego symbolu `TFT_eSPI::writecommand(uint8_t)`, którego źródło znajduje się w `lib/TFT_eSPI/TFT_eSPI.cpp:1004–1015`. Wywołanie pochodzi ze ścieżki `TFT_eSPI::init()` w `lib/TFT_eSPI/TFT_eSPI.cpp:619+`; w tej ścieżce `init()` wykonuje `initBus()`, a następnie `writecommand(0x00)` przy `TFT_RST` (`około linii 699`) lub software reset (`około linii 706`). Zewnętrzny marker `src/main.cpp:497` to wywołanie `tft.init()`.

`EXCCAUSE=0x1d` oznacza `StoreProhibited`, a `EXCVADDR=0x10` wskazuje próbę zapisu przez nieprawidłowy/NULL adres. W `writecommand()` pierwsza operacja to `begin_tft_write()` (`TFT_eSPI.cpp:1006`); ta funkcja wykonuje `xSemaphoreTakeRecursive(tftMutex, ...)` (`TFT_eSPI.cpp:79`). `tftMutex` jest tworzony na początku `TFT_eSPI::init()` (`TFT_eSPI.cpp:619`) przez `xSemaphoreCreateRecursiveMutex()`. To jest obecnie najbardziej konkretny punkt awarii, ale bez pełnego mapowania DWARF do instrukcji nie można dowieść, czy NULL dotyczy `tftMutex`, czy wewnętrznego obiektu SPI/GPIO użytego w tej samej funkcji.

### Porównanie z Adafruit

Działający szkic Adafruit używa bezpośrednio `SPI.begin(SCK, MISO, MOSI, CS)` i własnych transakcji SPI. Nie używa `TFT_eSPI::tftMutex`, `begin_tft_write()`, makr wyboru CS/DC ani `TFT_eSPI::initBus()`. Dlatego wynik nie wskazuje obecnie na SD: crash następuje przed `begin_storage()` i przed jakimkolwiek `SD.begin()`.

### Wniosek i najmniejsza poprawka

Najmniejsza poprawka nie jest jeszcze bezpiecznie zatwierdzona do zastosowania. Najpierw trzeba potwierdzić, czy `tftMutex` po `xSemaphoreCreateRecursiveMutex()` jest NULL albo czy crash następuje w zapisie SPI. Najlepszy pojedynczy test diagnostyczny to sprawdzenie/symbolizacja dokładnej instrukcji PC `0x421457f6` w ELF lub jednorazowe użycie debuggerowego dekodera ESP32; nie należy jeszcze zmieniać kodu TFT_eSPI ani inicjalizacji SPI.

## Uzupełnienie diagnostyczne: Serial/USB i porty

- Target zawiera `-DARDUINO_USB_CDC_ON_BOOT=1` w `boards/esp32-s3-n16r8-ili9341-touch/esp32-s3-n16r8-ili9341-touch.ini`.
- W tym targetcie nie znaleziono `-DARDUINO_USB_MODE=1`; jego wartość końcowa jest więc BRAK DANYCH / zależna od domyślnej konfiguracji frameworka.
- `src/main.cpp` używa globalnego `Serial.begin(115200)` i wysyła markery `SETUP START`, `>>> BEFORE GPIO <<<`, `>>> AFTER GPIO <<<`, `>>> BEFORE TFT INIT <<<` oraz `>>> AFTER TFT INIT <<<`.
- `SERIAL_TX=43` i `SERIAL_RX=44` są zdefiniowane jako UART0, ale te makra służą także do dodatkowej magistrali UART w kodzie; nie dowodzą, że globalny obiekt `Serial` wysyła logi przez CH343.
- `platformio.ini` ma tylko `monitor_speed=115200`; nie ma jawnego `monitor_port` ani `upload_port`.
- System pokazał tylko `COM13`. Identyfikacja CIM/Win32_SerialPort nie była dostępna z bieżących uprawnień, więc opis urządzenia CH343 nie został ponownie potwierdzony w tej próbie.
- Nie znaleziono aktywnych procesów Arduino, PlatformIO, esptool, PuTTY ani typowego terminala szeregowego.
- Próba odczytu 8 sekund z `COM13` przy 115200 nie zwróciła danych. Samo to nie rozstrzyga portu logowania: COM13 jest interfejsem CH343/UART, a `ARDUINO_USB_CDC_ON_BOOT=1` może kierować `Serial` na natywny USB CDC drugiego złącza USB. Natywny port USB nie był dostępny na liście COM w tej próbie.
- Wniosek: **runtime logu nadal nie uzyskano**. Ostatni potwierdzony etap runtime z obserwacji firmware to BRAK DANYCH; z kodu wiadomo tylko, że pierwszy marker powinien być wysłany na początku `setup()`, ale nie został odebrany.

## Uzupełnienie: końcowe wartości makr i ostrzeżenia

- Ostrzeżenia redefinicji są realne: dziedziczony `ESP-General/pins_arduino.h` definiuje m.in. `CC1101_SS_PIN=10`, `SPI_SS_PIN=10`, `UP_BTN=15` i `DW_BTN=16`, a target później redefiniuje `CC1101_SS_PIN=3`, `TFT_CS=15`, `TFT_RST=16`, `TFT_DC=17` oraz `TOUCH_CS=10`.
- Końcowa wartość w pliku targetu po preprocesorze powinna być zgodna z późniejszymi `#undef/#define` dla `CC1101_SS_PIN`, TFT i touch, ale nie wykonano preprocessora ani builda na potrzeby tej diagnostyki. Zatem pełne końcowe wartości makr w każdej jednostce translacji są **BRAK DANYCH**.
- Konflikt GPIO jest jednak potwierdzony tekstowo: `UP_BTN=15` koliduje z TFT CS, a `DW_BTN=16` z TFT RST. W targetowym interfejsie używany jest interfejs CYD i nie znaleziono w nim konfiguracji tych przycisków, więc wpływ runtime nie jest jeszcze potwierdzony.
## 2026-10-08 — diagnoza StoreProhibited w `tft.init()`

Przed zmianą wykonano analizę ELF `C:\BruceTouch\.pio\build\esp32-s3-n16r8-ili9341-touch\firmware.elf` odpowiadającego ostatnio wgranemu BIN-owi. PC `0x421457f6` leży w funkcji `TFT_eSPI::writecommand(uint8_t)` (constprop clone), wywołanej z `TFT_eSPI::init()`; runtime nie dochodzi do `AFTER TFT INIT`. `EXCCAUSE=0x1d` = `StoreProhibited`, `EXCVADDR=0x00000010`, a rejestr bazowy A2 ma wartość `0`. Jest to zapis przez NULL + offset 0x10.

W `lib/TFT_eSPI/TFT_eSPI.cpp` pierwsza operacja ścieżki `writecommand()` → `begin_tft_write()` to `xSemaphoreTakeRecursive(tftMutex, ...)` (linie 79, 1004–1015), a `tftMutex` był tworzony dynamicznie przez `xSemaphoreCreateRecursiveMutex()` w `init()` (linia 619). To jest konkretny wskaźnik mogący mieć wartość NULL w tej ścieżce. `spi` w `Processors/TFT_eSPI_ESP32.c` jest referencją do globalnego `SPI`, natomiast `_spi_user`, `_spi_cmd`, `_spi_mosi_dlen` i `_spi_w` są inicjalizowane statycznie na adresy rejestrów; nie pasują do NULL + 0x10. `initCC1101once()` przed TFT tylko zapisuje instancję SPI i piny, nie wykonuje transmisji.

### Minimalna poprawka przed jednym kontrolowanym buildem

Zmieniono wyłącznie `lib/TFT_eSPI/TFT_eSPI.cpp`:

```diff
-SemaphoreHandle_t tftMutex;
+SemaphoreHandle_t tftMutex;
+static StaticSemaphore_t tftMutexStorage;
@@
-  tftMutex = xSemaphoreCreateRecursiveMutex();
+  tftMutex = xSemaphoreCreateRecursiveMutexStatic(&tftMutexStorage);
```

Uzasadnienie: użycie statycznego obiektu FreeRTOS eliminuje możliwość nieudanego przydziału sterty i NULL uchwytu, zachowując rekurencyjne blokowanie TFT oraz pełną funkcjonalność. Nie zmieniono pinów, SPI, częstotliwości, SD ani modułów.
## Wynik kontrolowanego eksperymentu mutexa — 2026-10-08

Wykonano jeden kontrolowany build i próbę flashowania poprawki mutexa. Flash przez COM18 zakończył zapis i weryfikację obrazu, ale narzędzie esptool zakończyło raportowanie błędem kodowania konsoli Windows (`UnicodeEncodeError`, po zapisie nastąpił hard reset). Runtime po resecie:

```text
>>> BEFORE TFT INIT <<<
Guru Meditation Error: Core 1 panic'ed (StoreProhibited)
PC: 0x421457f6
EXCCAUSE: 0x0000001d
EXCVADDR: 0x00000010
Backtrace: 0x421457f3:0x3fcebc80 0x4209d10f:0x3fcebcb0 0x4212f5db:0x3fcebd80 0x403863f9:0x3fcebda0
ELF file SHA256: 23f1bc1f2
```

`AFTER TFT INIT` nadal nie występuje. Ważne: obiekt `TFT_eSPI.cpp.o` w `.pio\build\esp32-s3-n16r8-ili9341-touch\lib7f6\TFT_eSPI` ma wcześniejszy czas modyfikacji, a runtime zgłosił ten sam SHA ELF `23f1bc1f2`. Oznacza to, że PlatformIO użyło starego obiektu/cache i wgrany BIN nie zawierał zmiany mutexa. Nie ma więc uczciwego dowodu, że poprawka statycznego mutexa została przetestowana; poprawkę wycofano z drzewa roboczego, aby nie pozostawić niezweryfikowanej zmiany.

Wniosek: hipoteza `tftMutex` nie została potwierdzona ani obalona przez sprzęt, ponieważ eksperyment nie przebudował biblioteki. Jednocześnie powtarzalność crasha i identyczny SHA dowodzą, że ostatni flash był funkcjonalnie tym samym firmware. `AFTER TFT INIT` nie pojawia się. Następny rozstrzygający krok to wymuszenie przebudowy dokładnie biblioteki `TFT_eSPI` (po usunięciu jej obiektu z cache lub zmianie zależności), bez żadnej dalszej zmiany logicznej; dopiero wtedy można ocenić mutex.
## Kontrolowany test `tftMutex` — 2026-10-08

Dodano wyłącznie diagnostykę przed `xSemaphoreTakeRecursive()` w `lib/TFT_eSPI/TFT_eSPI.cpp` (`TFT_eSPI::begin_tft_write()`):

```cpp
esp_rom_printf("TFT_MUTEX_BEFORE_TAKE=%p\\r\\n", (void*)tftMutex);
```

Wykonano `pio run -e esp32-s3-n16r8-ili9341-touch -t clean`, a następnie świeży build. Log zawierał jednak informację `Retrieved ... TFT_eSPI.cpp.o from cache`; mimo tego nowy obiekt zawiera marker diagnostyczny, a ELF/BIN mają nowe rozmiary i SHA.

ELF SHA-256: `27af0ce138692101e9027160c1bc1918a07cbd61c5acd001809f75216b756d98`  
BIN SHA-256: `bef79aa0cd6a36def12c2d19c749de9f0574017102c5410693371851ce13bdaf`  
BIN: `C:\BruceTouch\Bruce-esp32-s3-n16r8-ili9341-touch.bin`, 3641616 bajtów.

Flash przez COM18 zakończył zapis i weryfikację. Runtime:

```text
>>> BEFORE TFT INIT <<<
TFT_MUTEX_BEFORE_TAKE=0x3fcec640
Guru Meditation Error: Core 1 panic'ed (StoreProhibited)
PC: 0x421458c2
EXCCAUSE: 0x0000001d
EXCVADDR: 0x00000010
Backtrace: 0x421458bf:0x3fcebc80 0x4209d19f:0x3fcebcb0 0x4212f683:0x3fcebd80 0x403863f9:0x3fcebda0
ELF file SHA256: 27af0ce13
```

`tftMutex` nie jest NULL. Crash pozostaje w funkcji `TFT_eSPI::writecommand()`; nowy PC `0x421458c2` leży w nowym symbolu `_ZN8TFT_eSPI12writecommandEh$constprop$0` zaczynającym się pod `0x42145868`. W tej ścieżce po poprawnym przejściu przez mutex wykonywany jest zapis makra `SET_BUS_WRITE_MODE`, czyli `*_spi_user = ...` w `lib/TFT_eSPI/Processors/TFT_eSPI_ESP32.h:111–115`. `EXCVADDR=0x10` i A2=0 oznaczają, że wskaźnik użyty przez tę instrukcję jest NULL/nieprawidłowy; nie jest nim `tftMutex`.

Wniosek: następna minimalna poprawka powinna dotyczyć wskaźników rejestrów SPI dla ścieżki ESP32-S3 (`_spi_user`/definicja `SPI_USER_REG` i zgodność starego niskopoziomowego drivera TFT_eSPI z Arduino-ESP32 3.3.6), nie mutexa. Nie wykonano kolejnego eksperymentu ani nie zmieniono GPIO/SD.
## Ustalenie adresu `_spi_user` i poprawka ESP32-S3 — 2026-10-08

Lokalna biblioteka ma dwie różne ścieżki: `TFT_eSPI_ESP32.c` definiuje wskaźnik jako zmienną, natomiast aktywna dla S3 ścieżka `Processors/TFT_eSPI_ESP32_S3.h:116–119` definiuje go jako makro:

```cpp
#define _spi_user (volatile uint32_t*)(SPI_USER_REG(SPI_PORT))
```

W `TFT_eSPI_ESP32_S3.h:88` aktywna była definicja `SPI_PORT FSPI`. W Arduino-ESP32 3.3.6 `FSPI` ma wartość hosta `1` (`SPI2_HOST`), natomiast frameworkowe `esp32s3/include/soc/esp32s3/include/soc/soc.h` definiuje:

```cpp
#define REG_SPI_BASE(i) (((i)>=2) ? (DR_REG_SPI2_BASE + (i-2) * 0x1000) : (0))
```

Zatem `SPI_USER_REG(FSPI)` przy `FSPI==1` rozwijało się do `0x00000010`. To dokładnie wyjaśnia `EXCVADDR=0x10`: `_spi_user` nie był NULL jako zmienna, lecz wskazywał na nieprawidłowy adres wynikający z błędnego indeksu rejestru. Dla FSPI/SPI2 prawidłowy indeks rejestrowy to `2`; dla HSPI/SPI3 istniejąca wartość `3` jest prawidłowa.

### Diff zastosowanej poprawki

```diff
--- lib/TFT_eSPI/Processors/TFT_eSPI_ESP32_S3.h
+++ lib/TFT_eSPI/Processors/TFT_eSPI_ESP32_S3.h
@@
   #elif CONFIG_IDF_TARGET_ESP32S3
-    #define SPI_PORT FSPI
+    // Arduino FSPI is SPI2_HOST (value 1), while REG_SPI_BASE() expects
+    // the peripheral register index 2 for GPSPI2 on ESP32-S3.
+    #define SPI_PORT 2
   #endif
```

Nie zmieniono GPIO, SPIClass, częstotliwości, SD ani funkcjonalności Bruce. Następny build/flash ma być jedynym testem tej poprawki.
## Weryfikacja poprawki `SPI_PORT=2` — 2026-10-08

Kontynuowano istniejący proces SCons; nie uruchamiano równoległego buildu. Build zakończył się:

```text
SUCCESS, 00:08:03.574
EXIT=0
```

Biblioteka TFT_eSPI została przebudowana po clean (obiekt `TFT_eSPI.cpp.o` z 22:17:38, 819656 bajtów). Nowe artefakty:

- ELF: 77913192 bajtów, SHA-256 `430e9f296f5afa34bb68ffc6f7ee29117ce4b12860a1a9965fc11f2c8d837221`
- BIN: `C:\BruceTouch\Bruce-esp32-s3-n16r8-ili9341-touch.bin`, 3646032 bajty, SHA-256 `a9550d0452742982cf92096555c30c5120ec0a4c7831ddc69f65783124785d4b`

Firmware wgrano przez COM18. Po kontrolowanym resecie runtime zgłosił ELF SHA `27af0ce13` (skrót drukowany przez firmware), a następnie:

```text
>>> BEFORE TFT INIT <<<
TFT_MUTEX_BEFORE_TAKE=0x3fcec640
>>> AFTER TFT INIT <<<
>>> TFT SIZE 240 x 320 <<<
SDCARD NOT mounted, check wiring and format
```

Nie wystąpił crash `StoreProhibited`. Program przeszedł przez inicjalizację TFT, wypisał konfigurację JSON i kontynuował start. Osiągnięto techniczny cel tego etapu. Pozostaje fizyczny test obrazu, orientacji i dotyku; SD nadal nie jest zamontowane.
## Test rysowania bezpośrednio po `tft.init()` — 2026-10-08

Dodano tymczasowo w `src/main.cpp`, bezpośrednio po `AFTER TFT INIT`, cztery operacje na tej samej instancji `tft`: czerwony, zielony, niebieski oraz czarny ekran z napisem `TFT ESPI OK`. Każda operacja ma marker BEFORE/AFTER i krótkie opóźnienie. Po teście wykonywany jest normalny start BruceButBetter.

Build po clean: `SUCCESS`, `00:03:18.721`, `EXIT=0`.  
ELF SHA-256: `40f37988c94bf12065a1846f87296901cf6c6c0b63ae0ecab30bd453f29e18e2`  
BIN SHA-256: `a1afc289863471df8648039c4a726f23f0bbf9b61cd81d4848491a465593e3c2`  
BIN: `C:\BruceTouch\Bruce-esp32-s3-n16r8-ili9341-touch.bin`, 3646608 bajtów.

Firmware wgrano przez COM18. Runtime potwierdził przejście przez:

```text
>>> AFTER TFT INIT <<<
>>> TFT SIZE 240 x 320 <<<
>>> TFT DRAW TEST RED BEFORE <<<
>>> TFT DRAW TEST RED AFTER <<<
>>> TFT DRAW TEST GREEN BEFORE <<<
>>> TFT DRAW TEST GREEN AFTER <<<
>>> TFT DRAW TEST BLUE BEFORE <<<
>>> TFT DRAW TEST BLUE AFTER <<<
>>> TFT DRAW TEST TEXT BEFORE <<<
>>> TFT DRAW TEST TEXT AFTER <<<
```

Nie wystąpił wyjątek podczas żadnej operacji rysowania. Program przeszedł dalej do montowania SD i konfiguracji JSON, a następnie normalnego startu BruceButBetter. Ostateczny wynik wizualny wymaga potwierdzenia użytkownika.

## Diagnostyka pełnego startu menu — 2026-10-08

Dodano markery wykonania w `src/main.cpp`, `src/core/main_menu.cpp` i `src/core/display.cpp` dla `begin_storage()`, `begin_tft()`, theme, wyjścia z `setup()`, wejścia do `loop()`, budowania listy menu i pierwszego renderowania.

Runtime przed poprawką zgłosił:

```text
BEGIN STORAGE EXIT sd=0 bg=0000 pri=A80F sec=880F inv=1 rot=0 instant=0 startup=''
BEGIN TFT ENTER rot=0 inv=1
```

Test kolorów działał przed `begin_tft()`, natomiast `begin_tft()` wykonywał `tft.invertDisplay(1)`. W `src/main.cpp` wprowadzono minimalną poprawkę odzyskiwania: zapisane `colorInverted=1` jest jednorazowo ustawiane na `0`, zapisywane przez `saveFile()`, a sterownik dostaje `invertDisplay(false)`. Nie zmieniono GPIO ani funkcji firmware.

Ostatni build/flash:

- log: `C:\BruceTouch\build-inversion-fix.log`
- wynik: `SUCCESS`
- RAM: `125692 / 327680` (38.4%)
- Flash: `3580691 / 4653056` (77.0%)
- BIN: `C:\BruceTouch\Bruce-esp32-s3-n16r8-ili9341-touch.bin`, 3646768 bajtów
- ELF: `C:\BruceTouch\.pio\build\esp32-s3-n16r8-ili9341-touch\firmware.elf`
- flash: COM18, hash danych zweryfikowany przez esptool

Runtime po poprawce:

```text
>>> AFTER TFT INIT <<<
>>> BEGIN STORAGE ENTER <<<
BEGIN STORAGE EXIT sd=0 bg=0000 pri=A80F sec=880F inv=0 rot=0 instant=0 startup=''
BEGIN TFT ENTER rot=0 inv=0
BEGIN TFT EXIT size=240x320 logical=240x300
SETUP AFTER TFT/STORAGE
```

Nie pojawił się jeszcze `THEME OPEN` ani `SETUP EXIT BEFORE LOOP`. Konkretna przyczyna jest w `C:\BruceTouch\boards\CYD-2432S028\interface.cpp`, funkcja `_post_setup_gpio()`, gałąź `USE_TFT_eSPI_TOUCH`: jeśli LittleFS nie zawiera `/calData`, wykonywane jest `tft.calibrateTouch(calData, TFT_WHITE, TFT_BLACK, 10)`. Firmware czeka wtedy na interaktywne dotknięcia punktów kalibracji. Menu nie może pojawić się przed zakończeniem tej funkcji. To nie jest blokada SD ani crash TFT.

Usunięto tymczasowy test kolorów po potwierdzeniu fizycznym, że czerwony, zielony, niebieski i `TFT ESPI OK` działają. Usunięto także wyłącznie zalewające logowanie `TFT_MUTEX_BEFORE_TAKE`; synchronizacja mutexa pozostała bez zmian.

Dokładny diff ostatniej poprawki:

```diff
--- src/main.cpp
+++ src/main.cpp
@@ begin_tft()
-    tft.invertDisplay(bruceConfig.colorInverted);
+    if (bruceConfig.colorInverted) {
+        Serial.println("RESETTING SAVED COLOR INVERSION FOR ILI9341");
+        bruceConfig.colorInverted = 0;
+        bruceConfig.saveFile();
+    }
+    tft.invertDisplay(false);
```

Następny krok fizyczny: zakończyć kalibrację dotyku, stukając kolejno wskazywane punkty rysikiem. Po zapisaniu `/calData` start powinien przejść przez `THEME OPEN`, `SETUP EXIT BEFORE LOOP`, `MAIN LOOP MENU ENTER`, `MAIN MENU OPTIONS` i `LOOP OPTIONS FIRST RENDER`.

## Poprawka geometrii i dotyku — 2026-10-08

Zidentyfikowane przyczyny:

1. `tft.getTouch()` w gałęzi `USE_TFT_eSPI_TOUCH` zwraca już współrzędne przeliczone przez TFT_eSPI. `boards/CYD-2432S028/interface.cpp` wykonywał następnie dodatkową transformację dla `rotation == 0`, zamieniając X/Y drugi raz. Powodowało to przesunięcie dotyku względem przycisków.
2. `tftHeight` rezerwował 20 px, ale `TouchFooter()` rysuje stopkę o wysokości 43 px od `tftHeight + 2`. Na panelu 240x320 stopka wychodziła poza ekran. Zmieniono rezerwę na 45 px.
3. Kalibracja używała stałego `ROTATION=1`, podczas gdy konfiguracja urządzenia ma `rot=0`. Dodano osobny plik `/calData_rot0` i kalibracja używa `bruceConfigPins.rotation`, aby nie mieszać danych z poprzedniej orientacji.

Zmiana została wykonana jako jeden kontrolowany eksperyment dotyczący spójności geometrii/rotacji/dotyku. GPIO i magistrala SPI nie zostały zmienione.

Dokładny diff:

```diff
--- src/main.cpp
+++ src/main.cpp
-    TFT_WIDTH - 20;
+    TFT_WIDTH - 45;
@@ begin_tft
-    tftHeight = tft.height() - 20;
+    tftHeight = tft.height() - 45;

--- src/core/settings.cpp
-        tftHeight = TFT_WIDTH - 20;
+        tftHeight = TFT_WIDTH - 45;
-        tftHeight = TFT_HEIGHT - 20;
+        tftHeight = TFT_HEIGHT - 45;

--- boards/CYD-2432S028/interface.cpp
-    File caldata = LittleFS.open("/calData", "r");
+    const char *calPath = "/calData_rot0";
+    File caldata = LittleFS.open(calPath, "r");
-        tft.setRotation(ROTATION);
+        tft.setRotation(bruceConfigPins.rotation);
-        caldata = LittleFS.open("/calData", "w");
+        caldata = LittleFS.open(calPath, "w");
@@ InputHandler
-#if !defined(TOUCH_GT911_I2C)
+#if !defined(TOUCH_GT911_I2C) && !defined(USE_TFT_eSPI_TOUCH)
```

Build/flash:

- log: `C:\BruceTouch\build-geometry-touch.log`
- wynik: `SUCCESS`
- RAM: `125692 / 327680` (38.4%)
- Flash: `3580591 / 4653056` (77.0%)
- BIN: `C:\BruceTouch\Bruce-esp32-s3-n16r8-ili9341-touch.bin`, 3646672 bajtów
- flash: COM18, hash danych zweryfikowany przez esptool

Runtime po flashu potwierdził:

```text
BEGIN STORAGE EXIT sd=0 bg=0000 pri=A80F sec=880F inv=0 rot=0 instant=0 startup=''
BEGIN TFT ENTER rot=0 inv=0
BEGIN TFT EXIT size=240x320 logical=240x275
SETUP AFTER TFT/STORAGE
```

Program zatrzymał się w oczekiwanej kalibracji XPT2046 przed `THEME OPEN`, ponieważ nowy plik `/calData_rot0` nie istnieje. Nie jest to crash. Do pełnej weryfikacji potrzebne jest teraz fizyczne stuknięcie czterech punktów kalibracyjnych; po ich zapisaniu można sprawdzić menu i zgodność przycisków.

## Diagnostyka renderowania menu — 2026-10-08

Analiza kodu wykazała, że `drawSubmenu()` rzeczywiście rysuje trzy widoczne pozycje: poprzednią, aktywną i następną. Lista nie jest rysowana jako pełna lista pionowa. `MainMenu::begin()` buduje pozycje, a `loopOptions()` wywołuje render lambda `MenuItemInterface::draw()` dla elementu głównego. Końcowe wymiary runtime są `tft=240x320`, `logical UI=240x275`.

Dodano tymczasową diagnostykę liczby pozycji, indeksu, etykiet i wymiarów w `display.cpp`, `main_menu.cpp` i `MenuItemInterface.h`. Build/flash:

- log: `C:\BruceTouch\build-ui-diag.log`
- wynik: `SUCCESS`
- RAM: `125692 / 327680` (38.4%)
- Flash: `3580947 / 4653056` (77.0%)
- BIN: `C:\BruceTouch\Bruce-esp32-s3-n16r8-ili9341-touch.bin`, 3647024 bajty
- BIN SHA-256: `505BDB3B982B6CA0AF557C2062FBC46BE95832A65484F1CC9AEB2D29E168A925`
- ELF SHA-256: `06A24817498BBAA0517F1E3A42CDE14E355B25D9AB82A75B7B980767DA9585BD`
- flash: COM18, hash danych zweryfikowany przez esptool

Runtime po flashu potwierdził prawidłową ścieżkę:

```text
BEGIN TFT EXIT size=240x320 logical=240x275
tft Calibration data: 311, 3430, 327, 3550, 4,
THEME OPEN path='' fs=0
BOOT SCREEN EXIT
SETUP EXIT BEFORE LOOP
MAIN LOOP MENU ENTER bg=0000 pri=A80F sec=880F size=240x275
MAIN MENU OPTIONS=13 disabled=0
LOOP OPTIONS ENTER type=0 count=13 index=0 text='Main Menu'
MAIN ITEM DRAW name='WiFi' scale=1.00 geom=240x275 rot=0
LOOP OPTIONS FIRST RENDER index=0 lambda=1
```

Wniosek: dane menu istnieją (`13` pozycji), a render pierwszego elementu jest wywoływany. Nie ma podstaw, aby ukrywać funkcje lub zmieniać dotyk. Pozostaje fizycznie sprawdzić, czy pozycje WiFi/Config są widoczne i czy ich aktywacja działa; logika `drawSubmenu()` pokazuje tylko trzy pozycje naraz, zgodnie z projektem Bruce.

Dodano dokumentację publikacyjną: `HARDWARE.md`, `BUILD.md`, `KNOWN_ISSUES.md`, `CONTRIBUTING.md` oraz rozszerzono `CHANGELOG.md` i `README.md`. Zachowano upstream `LICENSE` i istniejącą historię techniczną. Nie wykonano push ani publikacji.

## Eksperyment renderera pozycji podmenu — 2026-10-08

### Ustalenie

`loopOptions()` wywołuje `drawSubmenu()` dla menu typu `MENU_TYPE_SUBMENU`. Dane pozycji są obecne, a użytkownik potwierdził, że można je wybierać mimo ich niewidoczności. W `drawSubmenu()` nagłówek był rysowany bezpośrednio przez `tft.drawString()`, natomiast poprzednia, aktywna i następna pozycja były rysowane przez osobny wrapper `drawCentreString()` z parametrem `SMOOTH_FONT`. Zmieniono wyłącznie tę ścieżkę: szerokość tekstu jest obliczana przez `tft.textWidth(..., 1)`, pozycja X jest centrowana jawnie, a tekst jest wypisywany przez bezpośrednie `tft.drawString(..., 1)`. Nie zmieniono pinów, SPI, dotyku ani danych menu.

### Zmiana

Plik: `src/core/display.cpp`, funkcja `drawSubmenu()`.

```diff
- tft.drawCentreString(firstOption, tftWidth / 2, middle_up, SMOOTH_FONT);
+ int firstWidth = tft.textWidth(firstOption, 1);
+ int firstX = (tftWidth - firstWidth) / 2;
+ tft.drawString(firstOption, firstX, middle_up, 1);

- tft.drawCentreString(options[index].label, tftWidth / 2, middle - selectedTextSize * LH / 2, SMOOTH_FONT);
+ int selectedWidth = tft.textWidth(options[index].label, 1);
+ int selectedX = (tftWidth - selectedWidth) / 2;
+ int selectedY = middle - selectedTextSize * LH / 2;
+ tft.drawString(options[index].label, selectedX, selectedY, 1);

- tft.drawCentreString(thirdOption, tftWidth / 2, middle_down, SMOOTH_FONT);
+ int thirdWidth = tft.textWidth(thirdOption, 1);
+ int thirdX = (tftWidth - thirdWidth) / 2;
+ tft.drawString(thirdOption, thirdX, middle_down, 1);
```

Dodano logi `SUBMENU TEXT ...` z X/Y, szerokością, rozmiarem i kolorami.

### Build i flash

- środowisko: `esp32-s3-n16r8-ili9341-touch`, Arduino-ESP32 3.3.6
- clean: zakończony poprawnie
- build: `C:\BruceTouch\build-menu-render.log`, SUCCESS
- kompilacja `src/core/display.cpp`: potwierdzona w logu
- RAM: `125692 / 327680` (38.4%)
- Flash: `3581455 / 4653056` (77.0%)
- BIN: `C:\BruceTouch\Bruce-esp32-s3-n16r8-ili9341-touch.bin`, 3647536 bajtów
- BIN SHA-256: `CBB7B3D3B61C2F2FB876BFAB9F520B6907DA39E45B21E54D855C1391C5EF1CAF`
- ELF SHA-256: `C1627A4E3720CAA0E0EE76A7AB5BF0F9A3055E1CAEFDA1CAE286DA6FDCFF8E35`
- flash: COM18; ESP32-S3 został wykryty, stub uruchomiony, zapis obejmował `0x00000000–0x0037afff`, a następnie wykonano reset. Esptool zgłosił końcowy `UnicodeEncodeError` Windows cp1252 podczas drukowania paska/komunikatu, po zakończeniu zapisu, nie błąd transmisji.

### Runtime po flashu

```text
BOOT SCREEN EXIT
SETUP EXIT BEFORE LOOP
MAIN LOOP MENU ENTER bg=0000 pri=A80F sec=880F size=240x275
MAIN MENU OPTIONS=13 disabled=0
LOOP OPTIONS ENTER type=0 count=13 index=0 text='Main Menu'
MAIN ITEM DRAW name='WiFi' scale=1.00 geom=240x275 rot=0
LOOP OPTIONS FIRST RENDER index=0 lambda=1
```

Runtime startuje bez nowego wyjątku i przechodzi do menu. Log `SUBMENU TEXT` wymaga wejścia fizycznym dotykiem do WiFi/Config; nie wykonywano za użytkownika testu fizycznego.

## Eksperyment porównawczy renderowania podmenu — 2026-10-08

Test fizyczny wykazał, że skan WiFi poprawnie wyświetla listę, ale `WiFi` i `Wifi Connection` nadal mają niewidoczne pozycje. Nie zmieniano GPIO, SPI ani kalibracji.

Dodano w `src/core/display.cpp` diagnostykę `DRAW OPTIONS` dla liczby pozycji, indeksu, geometrii, fontu i kolorów oraz `DRAW OPTIONS ITEM` dla rzeczywistych etykiet i Y. W `drawSubmenu()` dodano jednorazowy probe tego samego tekstu trzema metodami:

1. `drawString("DS:" + label, ..., 1)`
2. `drawCentreString("DC:" + label, ..., 1)`
3. `drawString("SM:" + label, ..., SMOOTH_FONT)`

Probe rysuje czerwony, zielony i niebieski wiersz w znanych współrzędnych oraz loguje szerokość, X/Y, font i kolory. Jest to diagnostyka tymczasowa; nie stanowi jeszcze naprawy.

Build/flash:

- log builda: `C:\BruceTouch\build-submenu-probe.log`
- `src/core/display.cpp` przebudowany: potwierdzone
- build: SUCCESS
- RAM: `125692 / 327680` (38.4%)
- Flash: `3582735 / 4653056` (77.0%)
- BIN: `C:\BruceTouch\Bruce-esp32-s3-n16r8-ili9341-touch.bin`, 3648816 bajtów
- BIN SHA-256: `0CFD183055DE8A6EF26216C32D71A8E5E414FE68DF3CB68DC6AE722B7CFF6DE6`
- ELF SHA-256: `8D2C6FCA3548F2CA2B2F6C58BFBFBD097B150FE908B84D3DD4E299DB0B1AD050`
- flash: COM18, `Hash of data verified`, reset wykonany
- runtime po starcie: przechodzi do głównego menu bez crasha; log probe pojawi się po wejściu do podmenu.

## Diagnoza geometrii i fontów — 2026-10-09

### Ustalona przyczyna

Target `esp32-s3-n16r8-ili9341-touch` dziedziczy `boards/ESP-General/pins_arduino.h`. Ten plik definiuje `SMOOTH_FONT 0`, mimo że target ma w `build_flags` `-DSMOOTH_FONT=1`. Logi kompilacji pokazywały redefinicję:

```text
boards/ESP-General/pins_arduino.h:99:9: warning: "SMOOTH_FONT" redefined
#define SMOOTH_FONT 0
<command-line>: note: this is the location of the previous definition
```

Targetowy `pins_arduino.h` nie nadpisywał tej wartości. W kodzie Bruce `SMOOTH_FONT` jest przekazywany jako numer fontu do `drawString`, `drawCentreString` i `drawRightString`; wartość `0` nie jest prawidłowym fontem GLCD używanym przez ten tor. To tłumaczy niespójne rozmiary, przycięcia oraz różnicę między ścieżką skanowania WiFi a menu kontekstowym.

### Zmiany

- `boards/esp32-s3-n16r8-ili9341-touch/pins_arduino.h`: po dziedziczeniu ESP-General dodano `#undef SMOOTH_FONT` / `#define SMOOTH_FONT 1`.
- `src/main.cpp`: początkową geometrię zmieniono z błędnego `TFT_HEIGHT x (TFT_WIDTH-45)` na `TFT_WIDTH x (TFT_HEIGHT-45)`, czyli `240x275` dla pionowego 240x320. `begin_tft()` nadal ustala finalne wartości z `tft.width()/height()`.
- `src/core/display.cpp`: na wejściu do `drawOptions()` i `drawSubmenu()` jawnie resetowane są viewport, datum, padding, wrap i font bazowy.
- `include/MenuItemInterface.h`: analogiczny reset stanu tekstu przed rysowaniem elementu menu głównego.
- Usunięto tymczasowy probe DS/DC/SM z normalnego ekranu.

Nie zmieniono GPIO, SPI, rotacji dotyku ani funkcji modułów.

### Build

Utworzono logi w `C:\BruceTouch\logs\20261008-235916\`.

- `build.log`: build po zmianach został przerwany podczas masowej rekompilacji zależności; brak błędu kompilatora, brak linkowania.
- `build-retry.log`: druga próba również nie doszła do linkowania; ostatnia faza kompilowała zależność FastLED. Brak `SUCCESS`, brak nowego BIN/ELF.
- Nie wykonano flashowania tej wersji.
- Poprzedni firmware pozostawiono jako punkt przywracania; nie nadpisano go nowym artefaktem.

## Build i flash po diagnozie SMOOTH_FONT — 2026-10-09

### Przyczyna wcześniejszego zatrzymania

W logach `logs/20261008-235916` nie było końcowego `SUCCESS` ani `PROCESS_EXIT`; wcześniejsze sesje narzędzia zostały przerwane przed końcem długiej rekompilacji. Pełny ponowny build z długim oczekiwaniem wykazał później rzeczywisty błąd źródłowy: `resetViewport()` i `setTextPadding()` są prywatne w `TFT_eSPI`, a `tft_logger` nie udostępnia ich przez dziedziczenie. Usunięto tylko te niedostępne wywołania. Nie był to błąd FastLED.

### Finalny build

- log: `C:\BruceTouch\logs\20261009-002003\build.log`
- wynik: `SUCCESS`, `PROCESS_EXIT=0`
- czas: `00:09:37.242`
- RAM: `125692 / 327680` (38.4%)
- Flash: `3581779 / 4653056` (77.0%)
- BIN: `C:\BruceTouch\Bruce-esp32-s3-n16r8-ili9341-touch.bin`, 3647856 bajtów
- BIN SHA-256: `F2022FD252FDCC924E04B41740BBBA01E782B6B96BD9E22F8B5200B35DF05548`
- ELF SHA-256: `CB0B0D86790D2288E13179240E38AFFEF6D6658055902E7EADA18F44250AD9DD`

### Flash i runtime

- port: COM18
- flash: SUCCESS, `Hash of data verified`, reset wykonany
- runtime: `C:\BruceTouch\logs\20261009-002003\runtime.log`
- runtime przechodzi do głównego menu bez crasha:

```text
BOOT SCREEN EXIT
SETUP EXIT BEFORE LOOP
MAIN LOOP MENU ENTER bg=0000 pri=A80F sec=880F size=240x275
MAIN MENU OPTIONS=13 disabled=0
LOOP OPTIONS ENTER type=0 count=13 index=0 text='Main Menu'
MAIN ITEM DRAW name='WiFi' scale=1.00 geom=240x275 rot=0
LOOP OPTIONS FIRST RENDER index=0 lambda=1
```

Nie wykonano jeszcze fizycznego potwierdzenia poprawy pozycji menu na ekranie.

## Audyt repozytorium — 2026-10-09

- `C:\BruceTouch` został zainicjalizowany jako lokalne repozytorium Git na gałęzi `main`.
- W katalogu nie było wcześniejszej historii commitów ani skonfigurowanego remote; historia upstream nie została nadpisana ani udawana.
- Zachowano rootową licencję AGPL-3.0 oraz atrybucję Bruce/pr3y. Dokładny upstream commit bazowy: **BRAK DANYCH**.
- Dodano dokumentację sprzętu, statusu funkcji, planowanych obudów, bezpieczeństwa publikacji oraz workflow budujący target `esp32-s3-n16r8-ili9341-touch`.
- Nie zmieniano kodu firmware, pinoutu, konfiguracji SPI ani działającego BIN podczas przygotowania repozytorium.
- Ostatni potwierdzony build/flash pozostaje tym z `logs/20261009-002003`; szczegóły i sumy SHA-256 są powyżej.
- Przegląd konfiguracji nie wykazał potwierdzonych haseł ani tokenów. Występują jedynie puste/placeholderowe pola konfiguracyjne; logi lokalne i artefakty builda są wykluczone przez `.gitignore`.
- `gh` CLI nie jest zainstalowane w środowisku, więc nie wykonano sprawdzenia ani utworzenia repozytorium GitHub.
- Pierwszy commit lokalny oczekuje na jawnie skonfigurowaną tożsamość Git; nie ustawiano globalnego autora.

## Terminal Green / Pablo Signal — 2026-10-09

- Backup źródeł i konfiguracji: `C:\BruceTouch\backups\20261009-005807-before-terminal-green`.
- Backup działającego BIN znajduje się w tym samym katalogu backupu.
- Zmienione pliki: `src/core/theme.h`, `src/core/settingsColor.h`, `src/core/config.cpp`, `src/main.cpp`.
- Paleta RGB565: primary `0x3FE2`, secondary `0xB7F3`, background `0x0841`, dim/accent `0x2183`.
- Dodano nazwany wpis UI Color `Terminal Green`. Stara niezmieniona konfiguracja kolorów jest migrowana w pamięci do tej palety; zapisane wybory użytkownika pozostają nadrzędne.
- `boot_screen()` rysuje proceduralne logo `Pablo Signal` (litera P + łuki sygnału), a `boot_screen_anim()` pokazuje krótki pasek postępu. Nie używa rekina ani nowego bitmapowego zasobu.
- Build: SUCCESS, RAM `125692 / 327680` (38.4%), Flash `3576463 / 4653056` (76.9%).
- BIN: `C:\BruceTouch\Bruce-esp32-s3-n16r8-ili9341-touch.bin`, 3642544 bajty.
- BIN SHA-256: `78F035231C5C83B4067A63D6EB5C678348D9991B46C232581BE06DB2B0A19D34`.
- ELF SHA-256: `8593F9F3BC2459448A48EE638FF911BBB0AD46E74089BE46A7D12E06315BAF2A`.
- Flash: COM18, zapis zakończony; niezależne `verify-flash`: `Verification successful (digest matched)`.
- Runtime: `C:\BruceTouch\logs\20261009-015000-terminal-green-runtime.log`; urządzenie przechodzi przez boot screen do głównego menu bez crasha.
- Ostrzeżenia builda: odziedziczone redefinicje makr z `boards/ESP-General/pins_arduino.h` (`CC1101_*`, `SDCARD_*`, `NRF24_*`, `ROTATION`, `SMOOTH_FONT`, `DEVICE_NAME`); brak nowych błędów kompilacji.
- Fizyczne potwierdzenie nowego motywu/logo: **BRAK DANYCH**.

## Pablo migration correction — 2026-10-09

- Runtime przed poprawką wykazał `bg=0000 pri=A80F sec=880F`; wcześniejsza migracja nie działała, bo wymagała dokładnie starego zestawu `A80F/CB76/0000`.
- Dodano trwałe pole konfiguracji `uiColorPreset`. Gdy jest puste i nie ma pliku motywu, migracja ustawia Terminal Green i zapisuje pełny config przez istniejące `saveFile()`.
- Po migracji runtime potwierdził: `bg=0841 pri=3FE2 sec=B7F3`.
- Po `tft.init()` firmware natychmiast czyści ekran `TERMINAL_GREEN_BG`, co eliminuje firmware'owy niebieski ekran przejściowy.
- Splash `Pablo Hacker` ma teraz czas 3200 ms; fizyczne potwierdzenie czasu i wyglądu nadal należy do użytkownika.
- Build: SUCCESS; RAM `125708 / 327680` (38.4%), Flash `3576499 / 4653056` (76.9%).
- BIN: 3642576 bajtów; SHA-256 `3D41D814ED243BA35F8BCCEEB24175E997EA750DF10F95515794A2483E8B25BC`.
- ELF SHA-256: `BB89F6CE6EFF44686F39957F65845C6ABEF55D66CF4A96C9322569F79886F480`.
- Flash: COM18, `Hash of data verified`; log: `logs/20261009-012838-pablo-migration/flash.log`.
- Runtime: `logs/20261009-012838-pablo-migration/runtime.log`; menu startuje z potwierdzonymi wartościami Terminal Green.

## Splash correction — 2026-10-09

- Przyczyna: `boot_screen_anim()` bezwarunkowo wykonywał `tft.fillRect(0, 45, tftWidth, tftHeight - 45, bruceConfig.bgColor)` po `boot_screen()`. Dla domyślnego, proceduralnego splash screenu kasowało to logo i napisy. Timer 3200 ms rozpoczynał się również przed zakończeniem tej ścieżki rysowania.
- Zmiana: `src/main.cpp`; wygenerowany splash nie jest już czyszczony po narysowaniu. Czyszczenie pozostaje tylko dla zewnętrznego obrazu boot. Timer `SPLASH_EXPOSURE_BEGIN` rozpoczyna się po `BOOT_DRAW_DONE`, a pasek jest dekoracyjnym impulsem bez fałszywego procentowego postępu. Dodano znaczniki `STARTUP` z czasem `millis()`.
- Logo: proceduralne `Pablo Signal`, 86x86 px, pozycjonowane na ekranie logicznym 240x320.
- Sekwencja zamierzona: TFT init → czarne tło → logo/napisy → ekspozycja minimum 3200 ms → czyszczenie → menu.
- Niebieski obraz przed `AFTER TFT INIT` może pochodzić z fazy inicjalizacji kontrolera TFT/biblioteki i nie jest sterowalny przez firmware przed `tft.init()`; firmware czyści ekran bezpośrednio po tej funkcji.
- Build: NIE WYKONANO. PlatformIO zakończyło proces kodem `-1073741510` (`0xC000013A`) podczas instalowania zależności (`NimBLE-Arduino`, `ESP-PN532-UART`), przed kompilacją źródeł. Logi: `logs/20261009-015658-splash-fix/build.log`, `build-2.log`, `build-3.log`, `build-final.log`, `build-exit.log`.
- Flash: NIE WYKONANO; istniejący BIN nie odpowiada tej zmianie i nie został użyty.

### Build retry / flash status

- Pierwszy pełny proces doszedł do kompilacji i ujawnił nadmiarowy nawias w `boot_screen_anim()`; poprawiono wyłącznie strukturę bloku bez zmiany zachowania wizualnego.
- Drugi pełny build zakończył się `SUCCESS` po około 2:58. RAM: `125708 / 327680` (38.4%). Flash: `3576843 / 4653056` (76.9%). W logu pozostały odziedziczone ostrzeżenia redefinicji makr oraz ostrzeżenia ODR; brak błędów kompilatora.
- BIN: `C:\BruceTouch\Bruce-esp32-s3-n16r8-ili9341-touch.bin`, 3,642,928 bajtów, utworzony `2026-10-09 02:10:49`. SHA-256: `F6219DA41FA46A730572A205B556F5FBB1DCA2613150DD1F00BC383F6DE00201`.
- ELF SHA-256: `E1D697E8569BB4C020C16033D9A2EF4A90947A0F91FBF676401D02688F98D38C`.
- Próba flashowania przez COM18 została przerwana przez limit sesji przy 83.1% zapisu; ponowienie zwróciło `Could not open COM18, the port is busy or doesn't exist` / `PermissionError(13)`. `mode COM18`: `Device COM18 is not currently available`.
- Flash i runtime nowej wersji: **BRAK DANYCH**. Nie potwierdzam, że urządzenie otrzymało kompletny obraz.

### Flash retry — 2026-10-09

- Wykryto ESP32-S3 na COM18 (`VID_303A`, `PID_1001`, USB-Serial/JTAG, PSRAM 8 MB, MAC `e0:72:a1:db:b1:70`). COM10 został pominięty jako zajęty i niezidentyfikowany.
- `esptool v5.1.0 --chip esp32s3 --port COM18 write-flash 0x0` zakończył zapis 3,642,928 bajtów i zgłosił `Hash of data verified`; nie wykonano `erase_flash` i nie kasowano NVS.
- Po flashowaniu natywne COM18 pozostało zajęte przez sesję terminalową, dlatego przechwycenie runtime nie powiodło się (`Access denied`). Runtime nowej wersji: **BRAK DANYCH**.

### Flash retry completed — 2026-10-09 02:21

- Właściwy port ponownie potwierdzony: COM18, `VID_303A:PID_1001`, USB-Serial/JTAG, ESP32-S3 v0.2, PSRAM 8 MB, MAC `e0:72:a1:db:b1:70`.
- Existing BIN flashed at `0x0`; `erase_flash` i kasowanie NVS nie były używane.
- Flash: SUCCESS; 3,642,928 bajtów zapisanych; `Hash of data verified`.
- Runtime: `logs/20261009-022125-flash-retry/runtime.log`; potwierdzone `SPLASH_EXPOSURE_END elapsed=3200`, `BOOT SCREEN EXIT`, `SETUP EXIT BEFORE LOOP` i `MAIN LOOP MENU ENTER bg=0841 pri=3FE2 sec=B7F3 size=240x275`.
- Runtime zgłosił `esp_ota_ops: not found otadata`, ale kontynuował uruchomienie menu bez crasha.

## Pablo Hacker emblem update — 2026-10-09

- Zmieniono wyłącznie rysunek proceduralny w `src/main.cpp::boot_screen()`. Nowy emblemat to tarcza cybernetyczna z uproszczoną maską, oczami, liniami obwodu i akcentami sygnałowymi w palecie Terminal Green.
- Backup: `backups/20261009-022852-before-pablo-emblem`.
- Build SUCCESS: RAM `125708/327680` (38.4%), Flash `3577103/4653056` (76.9%).
- BIN: `Bruce-esp32-s3-n16r8-ili9341-touch.bin`, 3,643,184 bajty, SHA-256 `A2C96153916C4C79580DFF94D41C97683404FC82C057BC8E74A84889E62F0865`.
- Flash SUCCESS przez COM18 pod `0x0`; `Hash of data verified`.
- Runtime: `logs/20261009-023227-pablo-emblem/runtime.log`; ekspozycja `3201 ms`, menu wystartowało z Terminal Green. Fizyczna ocena nowego logo: **BRAK DANYCH**.
# 2026-10-09 — Pablo Hacker bitmap + hardware documentation

## Hardware documentation

Added the reproducible wiring table and diagrams in `HARDWARE_WIRING.md`, `docs/hardware/pinout.md`, `docs/hardware/wiring.svg`, and `docs/hardware/reassembly-checklist.md`. The documented TFT/touch wiring is the physically tested configuration: GPIO 12/11/13 shared as SCK/MOSI/MISO, TFT CS/DC/RST 15/17/16, touch CS 10, T_IRQ not connected, and 3V3/GND power. SD and other module lines are marked as configured or unverified where no physical confirmation exists.

## Pablo Hacker bitmap experiment

- Backup: `backups/20261009-022852-before-pablo-emblem`.
- Firmware asset: `src/assets/pablo_logo.h`, RGB565 `160x155`, stored in flash with `PROGMEM`; pixel payload is 49,600 bytes and the generated header is 208,931 bytes.
- Splash preview: `docs/assets/pablo-splash-preview.png`, exactly `240x320`. Text rendering is marked approximate because host preview text cannot reproduce TFT_eSPI's runtime font byte-for-byte.
- `src/main.cpp::boot_screen()` now draws the bitmap at `(40,16)`, then `PABLO HACKER` and `PABLO SIGNAL`, while preserving the existing splash timing and Terminal Green colors.

## Build and flash

- Environment: `esp32-s3-n16r8-ili9341-touch`; Arduino-ESP32 3.3.6; esptool 5.1.0.
- Build: SUCCESS, 00:02:48.008. RAM 125708/327680 (38.4%); Flash 3626815/4653056 (77.9%).
- Merged BIN: `Bruce-esp32-s3-n16r8-ili9341-touch.bin`, 3,692,896 bytes.
- BIN SHA-256: `61232F069EE6A39D43053DA2A42413EEED63EFFCE56A0A62481FACF939813EE3`.
- ELF SHA-256: `0A3FB300A6EAFFE14C4FAF3A6CD3DB7E6D643E209D3A923AA156073558A75BA2`.
- Device: ESP32-S3, 8 MB PSRAM, confirmed on COM18; MAC `e0:72:a1:db:b1:70`.
- Flash: SUCCESS with hash verification; no `erase_flash` and no NVS erase.
- Runtime: reached `SPLASH_EXPOSURE_END elapsed=3202`, `BOOT SCREEN EXIT`, and `MAIN LOOP MENU ENTER bg=0841 pri=3FE2 sec=B7F3 size=240x275`; no crash observed in the capture.
- Logs: latest dated directory under `logs/` contains `build.log`, `flash.log`, `flash-retry.log`, and `runtime.log`. The first flash attempt failed before writing due to Windows CP1252 encoding in esptool; the UTF-8 retry succeeded.

Visual appearance on the physical TFT remains pending user confirmation.

## RGB565 correction — pending physical confirmation

The first bitmap build used standard RGB565 words with TFT_eSPI's default `_swapBytes=false`. On ESP32-S3 this sends the two bytes in little-endian memory order, while the ILI9341 SPI pixel stream is MSB-first; the observed pink/purple/blue image is consistent with this mismatch. Text and menu colors remained correct because they use the normal TFT_eSPI color-write path. `boot_screen()` now saves the current swap state, enables `setSwapBytes(true)` only around the PROGMEM `pushImage()` call, then restores the previous state. No global color or BGR setting was changed.

Reference RGB565 diagnostic values: red `0xF800`, green `0x07E0`, blue `0x001F`, white `0xFFFF`, black `0x0000`. The ILI9341 driver is configured with its existing target rotation/color-order settings; no controller register changes were made.

### Controlled RGB565 fix result — 2026-10-09

- Changed only `src/main.cpp::boot_screen()`: save `tft.getSwapBytes()`, call `tft.setSwapBytes(true)` for the PROGMEM bitmap `pushImage()`, then restore the saved state.
- No change to Terminal Green, TFT driver, BGR/RGB controller mode, GPIO, touch, fonts, or menu geometry.
- Build: SUCCESS, environment `esp32-s3-n16r8-ili9341-touch`; RAM 38.4%, Flash 77.9%.
- BIN SHA-256: `6039F3000167F452E15B9DAA6BFFD5D06D59F0D16B4C57A7E0A83AF06BA9020D`; size 3,692,896 bytes.
- ELF SHA-256: `738B6C462F077368B85F40850C40916F12184E2A4556A3907D29FD82C7AEF2E2`.
- Flash: SUCCESS on confirmed ESP32-S3 COM18; esptool reported `Hash of data verified`; no NVS erase.
- Runtime: `SPLASH_EXPOSURE_END elapsed=3201`, `BOOT SCREEN EXIT`, and `MAIN LOOP MENU ENTER`; no crash observed.
- Preview PNG was regenerated/checked from the same logical RGB565 asset and coordinates; it is not evidence of physical TFT color correctness. Physical confirmation is still required.

## Startup transition cleanup — 2026-10-09

- Backup: `backups/20261009-031335-before-boot-regression`.
- Static audit found a full-screen `tft.fillScreen(TERMINAL_GREEN_BG)` immediately after `tft.init()` and before `begin_tft()` applied the final rotation/configuration. This was redundant because `resetTftDisplay()` and `boot_screen()` clear the panel later with the persisted Terminal Green background.
- Removed only that premature clear. GPIO, SPI, touch, bitmap byte swapping, menu geometry and splash duration were not changed.
- Kept the two existing `setRotation()` calls in `begin_tft()` because the source explicitly documents the second call as protection for this panel.
- Added timestamped markers for TFT init, rotation, background readiness, splash clear and `begin_tft()` completion. Build/flash/runtime results are pending.
- Hardware limitation: BL is hardwired to 3V3, so a brief pre-command backlight flash during controller reset/init cannot be guaranteed removable in firmware. The post-init redundant clear is removable and is the controlled change here.

### Controlled startup cleanup result — 2026-10-09

- Build: SUCCESS; RAM `125708/327680 (38.4%)`; Flash `3627183/4653056 (78.0%)`.
- Merged BIN: `Bruce-esp32-s3-n16r8-ili9341-touch.bin`, 3,693,264 bytes.
- BIN SHA-256: `9A7632622752BC32C85B2B0EFBE999068782BDDBC3CEEB8679EF9C8627164E55`.
- ELF SHA-256: `2738997BB65843DECE98F80081B97068F31646BBAB1017076CE8B0966C542B2D`.
- Flash: SUCCESS on confirmed ESP32-S3 COM18, MAC `e0:72:a1:db:b1:70`; esptool reported `Hash of data verified`; no erase/NVS erase.
- Runtime: reached `SPLASH_EXPOSURE_END elapsed=3201`, `SPLASH_CLEAR_DONE color=0841`, `BOOT SCREEN EXIT`, `SETUP EXIT BEFORE LOOP` and `MAIN LOOP MENU ENTER bg=0841 pri=3FE2 sec=B7F3 size=240x275`; no Guru Meditation/panic appeared in the captured log.
- The capture contains repeated `CUSTOM_BOOT_IMAGE_DRAWN type=0` lines from an existing diagnostic logging-brace issue. This is log noise; it does not indicate repeated bitmap drawing because `boot_img=0` and `drawn` becomes true.
- Logs: `logs/20261009-031335-before-boot-regression/build.log`, `flash.log`, and `runtime.log`.

## Early splash latency experiment — 2026-10-09

- Static analysis found that `tft.init()` completed before `begin_storage()`, but the first Pablo frame was not drawn until after `LittleFS.begin(true)`, SD setup and persisted configuration loading. Those operations occurred while the backlight was already on.
- Added an early frame immediately after `tft.init()` using the existing `boot_screen()` renderer and default target rotation/dimensions. Normal storage/configuration, `begin_tft()` and the existing timed splash remain unchanged afterward.
- This is intended to cover the storage wait with a valid dark Pablo frame, not to change the TFT protocol or hardware reset timings.
- New runtime markers: `EARLY_SPLASH_BEGIN` and `EARLY_SPLASH_DONE`.

### Early splash latency result — 2026-10-09

- Backup: `backups/20261009-032151-before-boot-latency`.
- Runtime on confirmed ESP32-S3 COM18: `TFT_INIT_BEGIN` at 26 ms, `TFT_INIT_DONE` at 323 ms, `EARLY_SPLASH_BEGIN` at 324 ms and `EARLY_SPLASH_DONE` at 506 ms.
- The first Pablo frame therefore became available about 506 ms after the application log start. The physical-reset-to-application-start portion (ROM/bootloader/USB enumeration) is not measured by `millis()` and remains unknown.
- `BEGIN_TFT_ENTER` occurred at 3051 ms because storage/configuration loading ran while the early splash was already visible. It completed at 3186 ms; the normal timed splash then ran for 3200 ms and the menu was reached at 6713 ms.
- Before this change, the first frame was only drawn after storage/configuration, so the approximately 2.5 s storage interval was exposed as a blank backlit panel. This is the confirmed software cause of the long blank phase.
- Build: SUCCESS; RAM `125708/327680 (38.4%)`; Flash `3627335/4653056 (78.0%)`.
- BIN: `Bruce-esp32-s3-n16r8-ili9341-touch.bin`, 3,693,408 bytes; SHA-256 `9624504809DE946A6A892A4951B7C5ED2A65296D77D9FD565426CC813D8C8B96`.
- ELF SHA-256: `928072A13A4A64816A5CB0B265D145BC5D7AF91B26017B79FED5A7039CFE3120`.
- Flash: SUCCESS, `Hash of data verified`, COM18, MAC `e0:72:a1:db:b1:70`; no erase/NVS erase.
- Runtime regression: no panic/crash; normal splash, Terminal Green colors and main menu path reached. Physical touch/menu appearance still requires user confirmation.

## Single-splash experiment — 2026-10-09

- Confirmed source path before change: `setup()` called `boot_screen()` for the early frame, then `boot_screen_anim()` called `boot_screen()` again. `begin_tft()` also called `resetTftDisplay()`, producing a full-screen clear between the two paths.
- Changed only `src/main.cpp`: `boot_screen_anim()` now reuses the early frame and its exposure start when no external boot image is selected; `begin_tft()` preserves that frame instead of clearing it. The final splash clear before the menu remains. Added `MENU_DRAW_BEGIN/DONE` markers.
- Backup: `backups/20261009-033000-before-single-splash`.
- Build: SUCCESS; RAM `125716/327680 (38.4%)`; Flash `3627639/4653056 (78.0%)`.
- BIN: `Bruce-esp32-s3-n16r8-ili9341-touch.bin`, 3,693,712 bytes; SHA-256 `7DFD47110A0295EC4C2B39FC10A42BC354B52AB31C40D91E897E4F4D963CF868`.
- ELF SHA-256: `A6E0A2B7631D7465316A0A5EC415112D1FF6892CB9E003843570420465293264`.
- Flash: NOT EXECUTED; first attempt failed before opening the port because COM18 disappeared/became unavailable. No write or erase occurred. Current serial-port enumeration returned no COM ports.
- Runtime: NOT AVAILABLE for this build because the device port is currently absent. Physical verification is pending.

### Single-splash completion — 2026-10-09

- COM18 returned and was identified as the same ESP32-S3, MAC `e0:72:a1:db:b1:70`.
- Flash retry: SUCCESS; `Hash of data verified`; no erase/NVS erase.
- Runtime confirmed exactly one `BOOT_DRAW_BEGIN` and one `BOOT_DRAW_DONE` in the fresh reset capture.
- Runtime: `EARLY_SPLASH_DONE` at 506 ms, `SPLASH_REUSE_EARLY_FRAME`, `SPLASH_EXPOSURE_END elapsed=3200`, `SPLASH_CLEAR_DONE`, `MAIN LOOP MENU ENTER`, and `MENU_DRAW_BEGIN`; no panic/backtrace observed.
- `BEGIN_TFT_EXIT` no longer produces an intermediate full-screen clear while the early splash is active.
- Runtime log: `logs/20261009-033000-single-splash/runtime.log`; flash retry log: `logs/20261009-033000-single-splash/flash-retry.log`.
