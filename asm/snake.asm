; snake clone for my 8bit cpu

;    ▄▄▄▄▄    ▄   ██   █  █▀ ▄███▄
;   █     ▀▄   █  █ █  █▄█   █▀   ▀
; ▄  ▀▀▀▀▄ ██   █ █▄▄█ █▀▄   ██▄▄
;  ▀▄▄▄▄▀  █ █  █ █  █ █  █  █▄   ▄▀
;          █  █ █    █   █   ▀███▀
;          █   ██   █   ▀
;                  ▀

; variables

; the following variables hold the snakes
; position on our 5x5 pixel screen
;
; the screen is organized as follows:
;
; e5 e6 e7 e8 e9
; ea eb ec ed ee
; ef f0 f1 f2 f3
; f4 f5 f6 f7 f8
; f9 fa fb fc fd

; the segment positions of the body we organize
; starting from memory address $d0 (as an array).
; on top we keep the ...

lda #$00              ; position
sta $dd               ; ... of snake head

lda #$02              ; length
sta $de               ; ... of snake body

; we store the current direction of the snake
; with the following constants:
;
; 01 = moving up
; 02 = moving left
; 03 = moving down
; 04 = moving right

lda #$04              ; current direction
sta $df               ; ... of snake

; main loop routine

main:
  jsr move
  jsr draw_snake
  jsr wait
  jmp main

; routine: check pressed keys & check if the move is maybe illegal

move:
  lda $fe             ; get currently pressed key

  cmp #$01            ; [up] pressed?
  beq move_up
  cmp #$02            ; [left] pressed?
  beq move_left
  cmp #$03            ; [down] pressed?
  beq move_down
  cmp #$04            ; [right] pressed?
  beq move_right
rts

move_up:
  lda $da             ; get snake direction

  cmp #$03            ; check if we are going down
  beq move_illegal    ; ... which would be an illegal move

  lda #$01            ; take up
  sta $da             ; ... as the next direction

  lda $dd
  sbc #$05
  sta $dd
rts

move_left:
  lda $da             ; get snake direction

  cmp #$04            ; check if we are going right
  beq move_illegal    ; ... which would be an illegal move

  lda #$02            ; take left
  sta $da             ; ... as the next direction

  lda $dd             ; load snake head position
  dec                 ; ... decrement it by one
  sta $dd             ; ... store it again
rts

move_down:
  lda $da             ; get snake direction

  cmp #$01            ; check if we are going up
  beq move_illegal    ; ... which would be an illegal move

  lda #$03            ; take down
  sta $da             ; ... as the next direction

  lda $dd
  adc #$05
  sta $dd
rts

move_right:
  lda $da             ; get snake direction

  cmp #$02            ; check if we are going left
  beq move_illegal    ; ... which would be an illegal move

  lda #$04            ; take right
  sta $da             ; ... as the next direction

  lda $dd             ; load snake head position
  inc                 ; ... increment it by one
  sta $dd             ; ... store it again
rts

move_illegal:
  rts

; routine: draw snake on screen

draw_snake:
  lda $dd             ; get snake head
  ldb #$ff            ; prepare set pixel for display
  stb $e5,a           ; draw head at screen position
rts

; routine: wait loop

wait:
  lda #$10
wait_loop:
  dec
  bne wait_loop
rts
