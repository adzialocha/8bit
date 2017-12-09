; Beispielprogramm für fiktive 8bit CPU

; Initialisierung

lda #$00
sta $40           ; Spieler Position

; Haupt-Routine

main:
  jsr draw        ; Zeichne aktuelle Spieler Position
jmp main

; Routine: Spieler zeichnen

draw:
  lda $40         ; Lade Spieler-Position in AX
  ldb #$ff        ; Lade Farbe Weiß in BX
  stb $e0,a       ; Zeiche Spieler mit Farbe aus BX an Position AX
rts
