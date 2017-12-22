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

lda #$eb              ; position
sta $dd               ; ... of snake head

lda #$02              ; length
sta $de               ; ... of snake body

; we store the current direction of the snake
; with the following constants:
;
; 00 = moving up
; 01 = moving right
; 02 = moving down
; 03 = moving left

lda #$01              ; current direction
sta $df               ; ... of snake

; main loop routine

main:
  jsr move
  jsr draw_snake
  jmp main

; routine: move snake to next position

move:
  lda $da             ; get snake direction

  cmp #$00            ; jump to subroutine
  beq move_up         ; ... for according
  cmp #$01            ; direction
  beq move_right
  cmp #$02
  beq move_down
  cmp #$03
  beq move_left
rts

move_up:

rts

move_right:

rts

move_down:

rts

move_left:

rts

draw_snake:

rts
