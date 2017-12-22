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

* Implicit
* Absolute `$nn`
* Immediate `#$nn`
* Indexed `$nn,a`
* Indexed indirect `($nn,a)`
* Indirect `($nn)`
* Indirect indexed `($nn),a`

## Opcodes

### Storage

* `lda #$nn`
* `lda $nn`
* `lda ($nn)`
* `ldb #$nn`
* `ldb $nn`
* `ldb ($nn)`
* `sta $nn`
* `sta ($nn)`
* `stb $nn`
* `stb $nn,a`
* `stb ($nn),a`
* `stb ($nn,a)`
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

* `bpl $nn` branch on plus (N)
* `bmi $nn` branch on minus (N)
* `bcc $nn` branch on carry clear (C)
* `bcs $nn` branch on carry set (C)
* `bne $nn` branch on not equal (Z)
* `beq $nn` branch on equal (Z)

### Flags

* `sec` set carry flag
* `clc` clear carry flag

### Registers

* `cmp #$nn` compare $nn to AX
* `cmp $nn` compare {$nn} to AX

### Stack

* `pha` push AX on stack
* `pop` pop stack top to AX

### Jump

* `jmp #$nn` jump to location $nn
* `jmp $nn` jump to location {$nn}
* `jsr $nn` jump to location $nn and save return address
* `jsr {$nn}` jump to location {$nn} and save return address
* `rts` return from subroutine

### Input

* `cib` clear input buffer

## Microcode addresses

```
adc #$nn - $57
adc $nn - $5a
and #$nn - $6d
and $nn - $70
asl - $8b
bcc - $98
bcs - $9a
beq - $9e
bmi - $96
bne - $9c
bpl - $94
cib - $d7
clc - $a2
cmp #$nn - $a4
cmp $nn - $a6
dec - $6a
eor #$nn - $7d
eor $nn - $80
inc - $67
jmp #$nn - $b8
jmp $nn - $ba
jsr #$nn - $be
jsr $nn - $c8
lda #$nn - $06
lda $nn - $08
lda ($nn) - $0c
ldb #$nn - $12
ldb $nn - $14
ldb ($nn) - $18
ldb ($nn),a - $1e
ldb ($nn,a) - $25
lsl - $85
lsr - $88
ora #$nn - $75
ora $nn - $78
pha - $aa
pop - $b2
rol - $8e
ror - $91
rts - $d1
sbc #$nn - $5f
sbc $nn - $62
sec - $a0
sta $nn - $2c
sta ($nn) - $30
stb $nn - $3b
stb $nn,a - $36
stb ($nn) - $3f
stb ($nn),a - $45
stb ($nn,a) - $4c
tab - $53
tba - $55
```
