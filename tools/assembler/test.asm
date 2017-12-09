; Beispielprogramm für fiktive 8bit CPU

; Initialisierung

lda #$00
sta $c0           ; Spieler Position

; Haupt-Routine

main:
  jsr draw        ; Zeichne aktuelle Spieler Position
  jmp check_input ; Überprüfe Tastatur-Eingaben
jmp main

; Routine: Spieler zeichnen

draw:
  lda $c0         ; Lade Spieler-Position in AX
  ldb #$ff        ; Lade Farbe Weiß in BX
  stb $e0,a       ; Zeiche Spieler mit Farbe aus BX an Position AX
rts

; Routine: Spieler löschen

clear:
  lda $c0         ; Lade Spieler-Position in AX
  ldb #$00        ; Lade Farbe Schwarz in BX
  stb $e0,a       ; Schreibe schwarz (leer) an Stelle des Spielers
rts

; Routine: Überprüfe Tastatur-Eingabe

check_input:
  lda $fe         ; Tastaturbuffer abfragen
  cmp #$01        ; "<"?
  beq left
  cmp #$03        ; ">"?
  beq right
  jmp main        ; .. zurück zum Hauptprogramm wenn nichts passiert ist

left:
  cib             ; Clear input buffer
  jsr clear       ; Lösche letzte Position auf Bildschirm
  lda $c0         ; Lade aktuelle Position in A
  dec             ; .. um Zahl um 1 zu verringern
  cmp #$df        ; Haben wir den linken Rand erreicht?
  beq left_border
  sta $c0         ; Speichere neue Position
  jmp main
left_border:
  lda #$0         ; Setze Position auf maximalen linken Rand
  sta $e0
  jmp main

right:
  cib             ; Clear input buffer
  jsr clear       ; Lösche letzte Position auf Bildschirm
  lda $c0         ; Lade aktuelle Position in A
  inc             ; .. um Zahl um 1 zu erhöhen
  cmp #$f8        ; haben wir den rechten Rand erreicht?
  beq right_border
  sta $c0         ; Speichere neue Position
  jmp main
right_border:
  lda #$f7        ; Setze Position auf maximalen rechten Rand
  sta $c0
  jmp main
