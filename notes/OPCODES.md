# OPCODES

## Layout

16bit

```
| --------- | --------- |
| 0000 0000 | Adresse   |
| 0000 0000 | Operand   |
| --------- | --------- |
```

## Addressing methods

```
* Absolute  (abs) $nn
* Immediate (imm) #$nn
```

## Opcodes

### Storage

* `LDA #$nn`
* `LDA $nn`
* `LDB #$nn`
* `LDB $nn`

* `STA $nn`
* `STB $nn`
* `STB $nn,B`

* `TAB` transfer from AX to BX
* `TBA` transfer from BX to AX

### Math

- `ADD` add (with carry)
- `SUB` substract (with borrow)
- `INC` increment AX
- `DEC` decrement AX

### Bitwise

- `AND` logical AND
- `EOR` exclusive OR
- `ORA` inclusive OR with AX
- `LSL` logical shift left
- `LSR` logical shift right
- `ASL` arithmetic shift left
- `ROL` rotate left one bit
- `ROR` rotate right one bit

### Branch

- `BEQ $nn` branch on zero flag

### Registers

- `CMP $nn` compare M to AX
- `CMP #$nn` compare M to AX

### Stack

- `PHA` push AX on stack
- `PLA` pull AX from stack

### Jump

- `JMP $nn` jump to location
- `JSR $nn` jump to location and save return address
- `RTS` return from subroutine
