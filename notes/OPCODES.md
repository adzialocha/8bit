# Opcodes

## Layout

16bit (instruction [+ operand])

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
* `inc` AX = AX + 1
* `dec` AX = AX - 1

### Bitwise

* `and #$nn` AX = AX AND $nn
* `and $nn` AX = AX AND {$nn}
* `ora #$nn` AX = AX OR $nn
* `ora $nn` AX = AX OR {$nn}
* `eor #$nn` AX = AX XOR $nn
* `eor $nn` AX = AX XOR {$nn}

* `lsl` AX logical shift left
* `lsr` AX logical shift right
* `asl` AX arithmetic shift left
* `rol` AX rotate left one bit
* `ror` AX rotate right one bit

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
