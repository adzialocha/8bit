# Memory

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

## Organisation

- $00 - $CF (000 - 207) free usable memory (208 Byte)
- $D0 - $DF (208 - 223) stack (16 Byte)
- $E0 - $F8 (224 - 248) 5x5 Pixel Display (25 Byte)
- $F9 (249) unused (1 Byte) [read-only]
- $FA (250) unused (1 Byte) [read-only]
- $FB (251) unused (1 Byte) [read-only]
- $FC (252) unused (1 Byte) [read-only]
- $FD (253) unused (1 Byte) [read-only]
- $FE (254) currently pressed key (1 Byte) [read-only]
- $FF (255) random number (1 Byte) [read-only]

## Tasten

- $01 : Pfeil Oben
- $02 : Pfeil Rechts
- $03 : Pfeil Unten
- $04 : Pfeil Links
- $05 : Taste A
- $06 : Taste B
