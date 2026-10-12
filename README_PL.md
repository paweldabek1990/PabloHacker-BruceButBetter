<p align="center"><img src="docs/showcase/pablo-hacker-reference.png" width="100%" alt="BruceButBetter — Dolphin One"></p>

> **Branding transition / Zmiana nazwy:** Dolphin One (D1) is the new project name. The historical artwork above still contains the old logo and will be replaced, not falsely presented as the new brand.
<p align="center"><a href="README_PL.md">🇵🇱 Polski</a> · <a href="README.md">🇬🇧 English</a></p>

# BruceButBetter / Dolphin One

**Cyber Dashboard V2** · ESP32-S3-WROOM-1 N16R8 · ILI9341 240×320 · XPT2046

![Status](https://img.shields.io/badge/status-aktywny_rozwój-00bfa8?style=for-the-badge) ![ESP32-S3](https://img.shields.io/badge/MCU-ESP32--S3-00a5cb?style=for-the-badge) ![ILI9341](https://img.shields.io/badge/wyświetlacz-ILI9341_240%C3%97320-10ae97?style=for-the-badge) ![PlatformIO](https://img.shields.io/badge/build-PlatformIO-f58220?style=for-the-badge)

> Rzeczywisty zapis rozwoju sprzętu i interfejsu — od małego eksperymentu z OLED-em SH1106 do kierunku Dolphin One. Grafika pozostaje grafiką; nie przedstawiamy jej jako dowodu gotowej obudowy ani ukończonego urządzenia.

## Nasza droga rozwoju

Poniższe pięć etapów opisuje progres bez tworzenia fikcyjnych fotografii historycznych. Jako eksporty projektu pokazujemy tylko pliki o znanym pochodzeniu.

| 1 · OLED SH1106 | 2 · Pierwszy ILI9341 | 3 · Surowe menu | 4 · Ulepszone kafelki | 5 · Cyber Dashboard V2 |
|---|---|---|---|---|
| Pierwszy prototyp, mały ekran, artefakty i ograniczenia. | Okablowanie i sterowniki pierwszego TFT 240×320. | Działające podstawy, ucięte elementy i błędy nawigacji. | Rozwój układu i ilustracji pod czytelne kafelki dotykowe. | Zatwierdzony kierunek wizualny; integracja i testy trwają. |

<p align="center"><img src="docs/showcase/screens/overview.png" width="100%" alt="Eksport widoku Cyber Dashboard V2"></p>

## Aktualny interfejs · autentyczne eksporty 240×320

<table>
<tr><td align="center"><strong>Main Menu</strong><br><img src="docs/showcase/screens/overview.png" width="240" alt="Main Menu"></td><td align="center"><strong>Bluetooth</strong><br><img src="docs/showcase/screens/bluetooth-final-preview.png" width="240" alt="Ekran Bluetooth"></td><td align="center"><strong>BLE Scanner</strong><br><img src="docs/showcase/screens/scanner-final-preview.png" width="240" alt="Skaner BLE"></td></tr>
<tr><td align="center"><strong>Scan Results</strong><br><img src="docs/showcase/screens/results-final-preview.png" width="240" alt="Wyniki skanowania"></td><td align="center"><strong>Settings</strong><br><img src="docs/showcase/screens/settings-final-preview.png" width="240" alt="Ustawienia"></td><td align="center"><strong>Karty BLE / iBeacon</strong><br><img src="docs/showcase/screens/ble-scan-card.png" width="240" alt="Karta skanowania BLE"><br><img src="docs/showcase/screens/ibeacon-card.png" width="240" alt="Karta iBeacon"></td></tr>
</table>

## Sprzęt i dokumentacja

| Podzespół | Aktualna definicja projektu |
|---|---|
| Kontroler | ESP32-S3-WROOM-1 N16R8 · 16 MB Flash · 8 MB PSRAM |
| Wyświetlacz | ILI9341 240×320 |
| Dotyk | Rezystancyjny kontroler XPT2046 |
| Build | PlatformIO, środowisko `esp32-s3-n16r8-ili9341-touch` |
| Połączenia | [Schemat GPIO i okablowanie](HARDWARE_WIRING.md) |

**Potwierdzony stan projektu:** udokumentowano uruchomienie wyświetlacza, ścieżkę dotyku na testowanych ekranach oraz proces budowania i flashowania firmware. Pełna nawigacja, powrót BLE, podmenu, spójność wizualna i końcowe testy fizyczne pozostają w toku. Nie deklarujemy gotowej obudowy 3D ani fikcyjnych wyników testów.

## Dalsze kroki

- dokończyć i zweryfikować ścieżki menu oraz nawigacji;
- kontynuować integrację sprzętową i testy fizyczne;
- synchronizować eksporty 240×320 i informacje o pochodzeniu grafik;
- zapisywać zmiany w [historii zmian](CHANGELOG.md).

## Dokumentacja

[Build Guide](docs/software/build.md) · [Diagnostyka](DIAGNOSTYKA.md) · [Znane problemy](KNOWN_ISSUES.md) · [Historia zmian](CHANGELOG.md) · [Wykaz grafik](docs/showcase/ASSET_MANIFEST.md)

<sub>Nieoficjalny wariant <a href="https://github.com/Yoursel71/BruceButBetter">BruceButBetter</a>. Zachowano autorstwo, atrybucję i <a href="LICENSE">licencję</a>. Funkcje bezpieczeństwa wyłącznie do autoryzowanych testów i nauki.</sub>
