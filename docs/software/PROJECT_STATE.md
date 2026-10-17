# Stan projektu i audyt publikacji
Data: 2026-10-17.

## Sprawdzone bezpośrednio na GitHubie
- Publiczne repozytorium: paweldabek1990/PabloHacker-BruceButBetter, main przed aktualizacją dokumentacji: 2c05bb4dd41363df6349e5dd8b6226ede33460c4 (2026-10-09).
- Gałąź docs/dolphin-one-branding: 688936f6c851f28fb5dd5fa5ceab0ff3748781d5. Zawierała nowszą nazwę i grafikę, lecz nie nowsze źródła firmware. PR #2 był szkicem.
- Osobne repozytorium BruceButBetter-Cyber: domyślna gałąź cyber-dashboard-v2, f46d0df69a4a8f152140f3d32e65f7fb8c378031; istnieje też local-ui-finalization, 7e84cd9155cdcdf93719b3351b31bffdbfc3009a.
- Na odczytanych listach gałęzi nie ma d1-v8-recovery-20261013.
- Konfigurację funkcji sprawdzono w pliku środowiska płytki, a rejestr menu w src/core/main_menu.cpp.

## Późniejszy stan zgłoszony w historii rozmów
Poniższe informacje odzyskano z historii projektu. W tej sesji nie odczytano odpowiadających im plików z MSI, nie przeliczono SHA i nie powtórzono testów.

- Nazwa zatwierdzona przez użytkownika: Dolphin One, skrót D1; zastąpiła Pablo Hacker.
- 2026-10-12: zgłoszono wdrożenie Graphics Root Fix z C:\Bruce\firmware-rebrand, 4 061 232 bajty, SHA-256 2B5F359DB9D4D69BC0BB26890C710A5DD5D8B4420B8AC7D6DBA7276343C107B0. Zgłoszono BACKUP/FLASH/VERIFY/BOOT PASS na COM18. Nie jest to dowód pełnej poprawności UI.
- Zgłoszone logi: backups/graphics-root-fix-deploy-20261012-continued/ i diagnostics/autonomous/D1_GRAPHICS_DEPLOY.md w tym lokalnym projekcie.
- 2026-10-13: zgłoszony checkpoint 47bb3b1, gałąź d1-v8-recovery-20261013 oraz D1_RICH_ASSET_LOCK_V8.zip, D1_CODEX_READY_V8_HANDOFF.zip i neon_dolphin_one_d1_dashboard.png. Kierunek: osiem ilustrowanych kafelków i PREV/OPEN/BACK.
- Lokalizacje zgłoszone dla referencji: diagnostics/incoming-v8/ oraz diagnostics/d1-ui-integration/references-v8/.
- Zgłaszano pozostałości ramek i podświetlenia kafelków. Nie oznaczamy całości jako ukończonej.

## Co zmienia aktualizacja
README PL/EN, grafika referencyjna istniejąca już na gałęzi dokumentacyjnej, mapa kodu, macierz funkcji, status weryfikacji i instrukcja budowania. Bez podmiany firmware, pinów i konfiguracji kompilacji.

## Co jest zablokowane
Import najnowszego firmware, zasobów V8 i raportów MSI. Dostępne ACC DEV udostępnia wyłącznie projekt ai-command-center. Próba listy projektów starego ACC zakończyła się błędem MCP 429. Nie uzyskano dostępu do katalogów Bruce z tej sesji.

## Warunki wydania potwierdzonej wersji
1. Odczytać lokalne repozytoria C:\Bruce\firmware-rebrand i C:\BruceTouch, ich remote, branch, HEAD oraz niezacommitowane zmiany.
2. Odczytać raport wdrożenia i logi; powiązać binarkę, pełny SHA-256, źródła i konfigurację.
3. Zachować backup i historię; przed publikacją sprawdzić prywatne dane i sekrety.
4. Zbudować właściwe środowisko i uruchomić dostępne testy. Oddzielić wyniki historyczne od nowych.
5. Zaimportować autentyczne V8 i zdjęcia sprzętu z opisanym pochodzeniem; wykonać testy fizyczne brakujących ścieżek.
6. Dopiero wtedy oznaczyć konkretny commit/tag jako odtwarzalną wersję urządzenia.
