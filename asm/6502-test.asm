; Beispielprogramm in 6502 Assembler

; Initialisierung

LDA #$00
STA $01           ; Spieler Position

; Haupt-Routine

main:
  JSR draw        ; Zeichne aktuelle Spieler Position
  JMP check_input ; Überprüfe Tastatur-Eingaben
JMP main

; Routine: Spieler zeichnen

draw:
  LDX $01         ; Lade Spieler-Position in X
  LDA #$01        ; Lade Farbe Weiß in A
  STA $0200,X     ; Zeiche Spieler mit Farbe aus A an Position X
RTS

; Routine: Spieler löschen

clear:
  LDX $01         ; Lade Spieler-Position in X
  LDA #$00        ; Lade Farbe Schwarz in A
  STA $0200,X     ; Schreibe schwarz (leer) an Stelle des Spielers
RTS

; Routine: Überprüfe Tastatur-Eingabe

check_input:
  LDA $FF         ; Tastaturbuffer abfragen
  CMP #$61        ; "A"?
  BEQ left
  CMP #$64        ; "D"?
  BEQ right
  JMP main        ; .. zurück zum Hauptprogramm wenn nichts passiert ist

; Routine: Tastaturbuffer löschen

clear_input:
  LDA #0          ; Tastaturbuffer ..
  STA $ff         ; .. löschen
RTS

; Routine: Spieler nach links bewegen

left:
  JSR clear_input
  JSR clear       ; Lösche letzte Position auf Bildschirm
  LDA $01         ; Lade aktuelle Position in A und
  TAX             ; .. kopiere nach X
  DEX             ; .. um Zahl um 1 zu verringern
  CPX #$ff        ; Haben wir den linken Rand erreicht?
  BEQ left_border
  STX $01         ; Speichere neue Position
  JMP main
left_border:
  LDA #$0         ; Setze Position auf maximalen linken Rand
  STA $01
  JMP main

; Routine: Spieler nach rechts bewegen

right:
  JSR clear_input
  JSR clear       ; Lösche letzte Position auf Bildschirm
  LDA $01         ; Lade aktuelle Position in A und
  TAX             ; .. kopiere nach X
  INX             ; .. um Zahl um 1 zu erhöhen
  CPX #$0f        ; haben wir den rechten Rand erreicht?
  BEQ right_border
  STX $01         ; Speichere neue Position
  JMP main
right_border:
  LDA #$0e        ; Setze Position auf maximalen rechten Rand
  STA $01
  JMP main
