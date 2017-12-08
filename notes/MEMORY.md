# MEMORY

## Register

Arbeitsregister um 8bit Werte kurzzeitig festzuhalten.

* I: Eingabewert welcher im Register gespeichert werden soll (8bit)
* O: Ausgabewert welcher aus Register ausgelesen wurde (8bit)
* R/I: Schreiben-Flag, um Eingabewert in Register zu speichern (1bit)
* R/O: Lesen-Flag, um aktuellen Registerwert auszugeben (1bit)
* CLK: Takt
* RST: Zurücksetzen-Flag

## RAM

8bit addressierbarer 2048bit (256x8bit) Arbeitsspeicher.

- 256 words by 8 bits (word-length)
- 2048bit total
- Adressen: $00 - $ff (000 - 255)

* AR/I: Speicher-Adresse-Schreiben Flag (1bit)
* DR/I: Datenregister-Schreiben-Flag (1bit)
* DR/O: Datenregister-Lesen-Flag (1bit)
* R: Lese bit aus Arbeitsspeicher aus gegebener Adresse (1bit)
* W: Schreibe bit an die Adresse in Arbeitsspeicher (1bit)
* D/I: Datenbus Eingang (8bit)
* D/O: Datenbus Ausgang (8bit)
* CLK: Takt
* RST: Zurücksetzen-Flag

## Speicher Organisation

- $00 - $CF (000 - 207) Freier Speicher (208 Byte)
- $D0 - $DF (208 - 223) Stack (16 Byte)
- $E0 - $EF (224 - 239) 4x4 Pixel Display (16 Byte)
- $F0 (240) % (1 Byte)
- $F1 (241) % (1 Byte)
- $F2 (242) % (1 Byte)
- $F3 (243) % (1 Byte)
- $F4 (244) % (1 Byte)
- $F5 (245) % (1 Byte)
- $F6 (246) % (1 Byte)
- $F7 (247) % (1 Byte)
- $F8 (248) % (1 Byte)
- $F9 (249) % (1 Byte)
- $FA (250) % (1 Byte)
- $FB (251) % (1 Byte)
- $FC (252) % (1 Byte)
- $FD (253) % (1 Byte)
- $FE (254) % (1 Byte)
- $FF (255) Aktuell gedrückte Taste (1 Byte)

## Tasten

- $01 : Pfeil Oben
- $02 : Pfeil Rechts
- $03 : Pfeil Unten
- $04 : Pfeil Links
- $05 : Taste A
- $06 : Taste B
