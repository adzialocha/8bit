main:
  lda $fe         ; Tastaturbuffer abfragen
  cmp #$02        ; "<"?
  beq left
  cmp #$04        ; ">"?
  beq right
  jmp main

left:
  cib
  lda $cc
  inc
  tab
  sta $cc
  jmp main

right:
  cib
  lda $cc
  dec
  tab
  sta $cc
  jmp main
