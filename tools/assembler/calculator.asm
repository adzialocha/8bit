; A small calculator

lda #$05    ; Store first variable
sta $40

lda #$10    ; Store second variable

adc $40     ; Summarize variables
