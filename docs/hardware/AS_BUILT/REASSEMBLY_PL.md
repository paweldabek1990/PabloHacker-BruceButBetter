# Ponowny montaż — wersja robocza

Ta instrukcja nie zastępuje brakującej mapy otworów. Obecne zdjęcia nie pozwalają jeszcze odtworzyć każdego przewodu bez ryzyka pomyłki.

1. Odłącz oba przewody USB i odczekaj, aż wszystkie diody zgasną.
2. Ułóż trzy płytki w orientacji ze zdjęcia 5: ESP32 na osobnej płytce, TFT na płytce przy górze, płytka pośrednia pomiędzy nimi.
3. Najpierw połącz wspólną masę i 3V3, ale dopiero po sprawdzeniu miernikiem ciągłości i braku zwarcia między 3V3 i GND.
4. Odtwórz wspólny SPI: SCK 12, MOSI 11, MISO 13; następnie osobno CS TFT 15, DC 17, RST 16 i CS dotyku 10.
5. Nie zgaduj kolorów ani otworów. Każdy przewód oznacz etykietą po obu stronach.
6. Sprawdź wszystkie połączenia omomierzem przy odłączonym USB.
7. Podłącz USB dopiero po kontroli zasilania i sprawdź najpierw ekran testowy, potem dotyk.
