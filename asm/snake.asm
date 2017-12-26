; snake clone for my 8bit cpu

;    ▄▄▄▄▄    ▄   ██   █  █▀ ▄███▄
;   █     ▀▄   █  █ █  █▄█   █▀   ▀
; ▄  ▀▀▀▀▄ ██   █ █▄▄█ █▀▄   ██▄▄
;  ▀▄▄▄▄▀  █ █  █ █  █ █  █  █▄   ▄▀
;          █  █ █    █   █   ▀███▀
;          █   ██   █   ▀
;                  ▀

; variables

; the following variables describe the
; snakes position on our 5x5 pixel screen
;
; note: the screen is organized as follows:
;
; e5 e6 e7 e8 e9
; ea eb ec ed ee
; ef f0 f1 f2 f3
; f4 f5 f6 f7 f8
; f9 fa fb fc fd
;
; the segment positions of the snake are
; pointers to the screen positions.
;
; prepare the following variables:

    lda #$eb            ; position
    sta $d0             ; ... of snake head

    lda #$ec            ; first segment
    sta $d1             ; ... of snake body

    lda #$ed            ; second segment
    sta $d2             ; ... of snake body

    lda #$02            ; length
    sta $de             ; ... of snake body

; note: the machine only gives 224 byte of free
; memory. We need 2 bytes for variables ($de, $df)
; plus a maximum of 14 bytes for the snake head
; & body ($d0-$dd) which restricts the whole
; program size to 208 bytes ($00-$cf)!

; initial routines

    jsr apple           ; generate a random apple position
    jsr draw_apple      ; ... & draw the apple

; main loop routine

; note: the program jumps directly to game
; over after executing the main routine for
; the second time, if there is no moving-
; direction defined. To avoid this we do not
; start the game when the user didn't press
; any arrow keys yet.

main:
    lda $fe             ; check the pressed key
    cmp #$00            ; ... when nothing was pressed yet
    beq main            ; ... then do nothing!

    jsr move
    jsr collision
    jsr update
    jsr draw_snake
    jsr draw_apple

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

; note: we do not check for wall collisions
; to let the snake run infinitely. Also when leaving
; right or left the snake appears on a different
; line on the other side than before. Both decisions
; are mainly design restrictions due to the
; small memory size.

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
    lda $d0             ; load snake head position
    sbc #$05            ; ... substract a whole screen line
    sta $d0             ; ... store it again

    cmp #$e5            ; did we reach the top?
    bcc move_up_end     ; ... then ...
rts

move_up_end:
    adc #$19            ; ... come up from the bottom again
    sta $d0
rts

move_left:
    lda $d0             ; load snake head position
    dec                 ; ... decrement it by one
    sta $d0             ; ... store it again

    cmp #$e4            ; did we reach the up left border?
    beq move_left_end   ; ... then
rts

move_left_end:
    lda #$e9            ; ... come out on the right corner
    sta $d0
rts

move_down:
    lda $d0             ; load snake head position
    adc #$05            ; ... add a whole screen line
    sta $d0             ; ... store it again

    cmp #$fe            ; did we reach the border?
    bcs move_down_endh

    cmp #$04            ; we also have to check for this since
    bcc move_down_endl  ; the screen memory is (weirdly) organized
rts

move_down_endh:
    sbc #$19            ; come up from the top again
    sta $d0
rts

move_down_endl:
    adc #$e7            ; ... same here
    sta $d0
rts

move_right:
    lda $d0             ; load snake head position
    inc                 ; ... increment it by one
    sta $d0             ; ... store it again

    cmp #$fe            ; did we reach the bottom right?
    beq move_right_end  ; ... then
rts

move_right_end:
    lda #$f9            ; ... come out on the left corner
    sta $d0
rts

; routine: check if snake collided with apple or itself

; note: we check first if the snake's head sits
; on the same address as the apple. if not
; then any set pixel must be a part of the snake.

collision:
    lda $df             ; load apple position
    cmp $d0             ; ... check if its the heads position
    bne collision_snake

    lda $de             ; increase snake length
    inc                 ; ... by one
    sta $de             ; ... & store it again

    jsr apple           ; find new apple position
rts

collision_snake:
    lda ($d0)           ; load pixel at snake head
    cmp #$ff            ; check if its set
    beq game_over
rts

; routine: place an apple randomly on the screen

apple:
    lda $ff             ; load a random number into AX
    and #$18            ; limit range to 0-24
    adc #$e5            ; add start screen address
    sta $df             ; ... & store it as the new apple position
rts

; routine: draw snake on screen

draw_snake:
    lda $de             ; get snake length
    ldb #$00            ; prepare clear pixel
    stb ($d0,a)

    ldb #$ff            ; prepare set pixel for display
    stb ($d0)           ; draw head at screen position
rts

draw_apple:
    ldb #$ff            ; pixel to set
    stb ($df)           ; ... & store at screen location
rts

; routine: game over

game_over:
    jmp game_over       ; ... is an endless loop
