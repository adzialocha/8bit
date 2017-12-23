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
; as addresses pointing at the screen positions.

lda #$eb              ; position
sta $d0               ; ... of snake head

lda #$ec              ; first segment
sta $d1               ; ... of snake body

lda #$ed              ; second segment
sta $d2               ; ... of snake body

; additionally we keep the ...

lda #$02              ; length
sta $de               ; ... of snake body

; we store the current direction of the snake
; with the following constants:
;
; $01 = moving up
; $02 = moving left
; $03 = moving down
; $04 = moving right

lda #$04              ; current direction
sta $df               ; ... of snake

; main loop routine

main:
  jsr update
  jsr move
  jsr collision
  jsr draw_snake
  jsr wait
  jmp main

; routine: pass over body segments to next position ahead

update:
  lda $de             ; get snake length
  dec
update_loop:
  ldb $d0,a           ; get body segment
  stb $d1,a           ; ... store it one address after
  dec
  bpl update_loop
rts

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
  lda $df             ; get snake direction

  cmp #$03            ; check if we are going down
  beq move_illegal    ; ... which would be an illegal move

  lda #$01            ; take up
  sta $df             ; ... as the next direction

  lda $d0             ; load snake head position
  sbc #$05            ; ... substract a whole screen line
  sta $d0             ; ... store it again
rts

move_left:
  lda $df             ; get snake direction

  cmp #$04            ; check if we are going right
  beq move_illegal    ; ... which would be an illegal move

  lda #$02            ; take left
  sta $df             ; ... as the next direction

  lda $d0             ; load snake head position
  dec                 ; ... decrement it by one
  sta $d0             ; ... store it again
rts

move_down:
  lda $df             ; get snake direction

  cmp #$01            ; check if we are going up
  beq move_illegal    ; ... which would be an illegal move

  lda #$03            ; take down
  sta $df             ; ... as the next direction

  lda $d0             ; load snake head position
  adc #$05            ; ... add a whole screen line
  sta $d0             ; ... store it again
rts

move_right:
  lda $df             ; get snake direction

  cmp #$02            ; check if we are going left
  beq move_illegal    ; ... which would be an illegal move

  lda #$04            ; take right
  sta $df             ; ... as the next direction

  lda $d0             ; load snake head position
  inc                 ; ... increment it by one
  sta $d0             ; ... store it again
rts

move_illegal:
rts

; routine: check if snake collided with apple or wall or itself

collision:
rts

; routine: draw snake on screen

draw_snake:
  lda $de             ; get snake length
  ldb #$00            ; prepare clear pixel
  stb ($d0,a)

  ldb #$ff            ; prepare set pixel for display
  stb ($d0)           ; draw head at screen position
rts

; routine: wait loop

wait:
  lda #$10            ; count down from 10 to 0
wait_loop:
  dec
  bne wait_loop
rts
