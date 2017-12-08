; Beispielprogramm für fiktive 8bit CPU

; Initialisierung

lda #$00
sta $00           ; Spieler Position

; Haupt-Routine

main:
  jsr draw        ; Zeichne aktuelle Spieler Position
  jmp check_input ; Überprüfe Tastatur-Eingaben
jmp main

; Routine: Spieler zeichnen

draw:
  ldb $00         ; Lade Spieler-Position in BX
  lda #$01        ; Lade Farbe Weiß in AX
  sta $fe,b       ; Zeiche Spieler mit Farbe aus AX an Position BX
rts

; Routine: Spieler löschen

clear:
  ldb $00         ; Lade Spieler-Position in BX
  lda #$00        ; Lade Farbe Schwarz in AX
  sta $fe,b       ; Schreibe schwarz (leer) an Stelle des Spielers
rts

; Routine: Überprüfe Tastatur-Eingabe

check_input:
  lda $ff         ; Tastaturbuffer abfragen
  cmp #$04        ; "<"?
  beq left
  cmp #$02        ; ">"?
  beq right
  jmp main        ; .. zurück zum Hauptprogramm wenn nichts passiert ist

clear_input:
  lda #0          ; Tastaturbuffer ..
  sta $ff         ; .. löschen
rts

left:
  jsr clear_input
  jsr clear       ; Lösche letzte Position auf Bildschirm
  lda $00         ; Lade aktuelle Position in A
  dec             ; .. um Zahl um 1 zu verringern
  cmp #$df        ; Haben wir den linken Rand erreicht?
  beq left_border
  sta $00         ; Speichere neue Position
  jmp main
left_border:
  lda #$0         ; Setze Position auf maximalen linken Rand
  sta $00
  jmp main

right:
  jsr clear_input
  jsr clear       ; Lösche letzte Position auf Bildschirm
  lda $00         ; Lade aktuelle Position in A
  inc             ; .. um Zahl um 1 zu erhöhen
  cmp #$f0        ; haben wir den rechten Rand erreicht?
  beq right_border
  sta $00         ; Speichere neue Position
  jmp main
right_border:
  lda #$ef        ; Setze Position auf maximalen rechten Rand
  sta $00
  jmp main
