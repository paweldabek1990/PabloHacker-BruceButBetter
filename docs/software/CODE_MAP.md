# Mapa kodu i funkcjonalności
Zakres: publiczna baza firmware 2c05bb4. Obecność kodu nie dowodzi działania modułu na urządzeniu.

| Plik / katalog | Odpowiedzialność |
|---|---|
| src/main.cpp | Uruchomienie aplikacji i główna pętla |
| src/core/main_menu.cpp | Rejestr kategorii; warunkowe dodawanie modułów; ukrywanie menu |
| src/core/menu_items/ | Obsługa poszczególnych kategorii |
| src/core/display.cpp | Warstwa rysowania i interfejs wyświetlacza |
| src/core/config.cpp, src/core/configPins.cpp | Ustawienia aplikacji i pinów |
| src/core/settings.cpp, src/core/theme.cpp | Ustawienia i motywy |
| src/core/sd_functions.cpp | Obsługa pamięci i plików |
| src/core/serialcmds.cpp, src/core/serial_commands/ | Polecenia przez port szeregowy |
| src/modules/wifi/, src/core/wifi/ | Funkcje Wi-Fi i połączeń |
| src/modules/ble/, src/modules/ble_api/ | Bluetooth LE i usługi BLE |
| src/modules/badusb_ble/, src/modules/others/ | Narzędzia HID i pozostałe aplikacje |
| src/modules/rf/ | Funkcje radiowe Sub-GHz |
| src/modules/NRF24/ | Moduły NRF24 |
| src/modules/rfid/ | RFID/NFC; zgodność zależy od czytnika i jego interfejsu |
| src/modules/ir/ | Podczerwień |
| src/modules/bjs_interpreter/ | Interpreter skryptów |
| boards/esp32-s3-n16r8-ili9341-touch/ | Konfiguracja konkretnej płytki i wejścia |
| platformio.ini | Wspólne biblioteki, platforma i skrypty budowania |
| lib/ | Biblioteki lokalne i sterowniki |
| sd_files/ | Przykładowa zawartość karty; nie dowodzi sprawności SD |

## Co konfiguracja rzeczywiście włącza
Źródło: boards/esp32-s3-n16r8-ili9341-touch/esp32-s3-n16r8-ili9341-touch.ini.

- TFT ILI9341, dotyk TFT_eSPI/XPT2046, natywne USB CDC i USB_as_HID.
- Definicje CC1101, NRF24 i drugiego NRF24; nie oznaczają zamontowanych modułów.
- SD CS 14; IR TX 2 / RX 1; CC1101 CS 3 / GDO0 9; NRF24 CE 4 / CS 5, drugi CE 6 / CS 7. To wartości konfiguracji, nie potwierdzenie okablowania.
- DISABLE_LORA, DISABLE_GPS, DISABLE_ETHERNET i DISABLE_FM wyłączają te kategorie dla tego celu.
- Menu Wi-Fi, BLE, RF, RFID, IR, Others, NRF24, pliki, skrypty, self-test, zegar i konfiguracja są rejestrowane w kodzie. Widoczność może dodatkowo zmienić zapisane disabledMenus.

## Granice
Nie przypisujemy posiadanemu czytnikowi NFC modelu PN532 bez sprawdzenia. Nie deklarujemy działania każdej funkcji odziedziczonej z Bruce. Stan testów i rozbieżności między repozytorium a lokalnym D1 opisano w PROJECT_STATE.md.
