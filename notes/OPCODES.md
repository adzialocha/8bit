# Opcodes

## Layout

8bit (instruction)

```
| --------- | --------- |
| 0000 0000 | Adresse   |
| --------- | --------- |
```

16bit (instruction + operand)

```
| --------- | --------- |
| 0000 0000 | Adresse   |
| 0000 0000 | Operand   |
| --------- | --------- |
```

## Addressing modes

* Absolute (abs) `$nn`
* Immediate (imm) `#$nn`
* Indexed (idx) `$nn,b`
* Indirect (ind) `($nn)`

## Opcodes

### Storage

* `lda #$nn`
* `lda $nn`
* `ldb #$nn`
* `ldb $nn`

* `sta $nn`
* `stb $nn,a`
* `stb $nn`

* `tab` transfer from AX to BX
* `tba` transfer from BX to AX

### Math

* `adc #$nn` AX = AX + $nn
* `adc $nn` AX = AX + {$nn}
* `sbc #$nn` AX = AX - $nn
* `sbc $nn` AX = AX - {$nn}
* `inc` increment AX
* `dec` decrement AX

### Bitwise

* `and` logical AND
* `eor` exclusive OR
* `ora` inclusive OR with AX
* `lsl` logical shift left
* `lsr` logical shift right
* `asl` arithmetic shift left
* `rol` rotate left one bit
* `ror` rotate right one bit

### Branch

* `beq $nn` branch on zero flag

### Registers

* `cmp $nn` compare M to AX
* `cmp #$nn` compare M to AX

### Stack

* `pha` push AX on stack
* `pla` pull AX from stack

### Jump

* `jmp $nn` jump to location
* `jsr $nn` jump to location and save return address
* `rts` return from subroutine
