# Microcode

## Adress-Bus

* 23 OP/I  (CU)
* 22 PC/I  (PC)
* 21 PC/O  (PC)
* 20 +1    (PC)
* 19 AR/I  (RAM)
* 18 R     (RAM)
* 17 W     (RAM)
* 16 DR/I  (RAM)

* 15 DR/O  (RAM)
* 14 %     ()
* 13 %     ()
* 12 %     ()
* 11 %     ()
* 10 %     ()
* 09 %     ()
* 08 %     ()

* 07 AX/I  (AX)
* 06 AX/O  (AX)
* 05 BX/I  (BX)
* 04 BX/O  (BX)
* 03 SP/I  (SP)
* 02 SP/O  (SP)
* 01 %     ()
* 00 %     ()

## Hauptroutine

```
$00 $280000 001010000000000000000000 AR := PC                 ; fetch
$01 $050000 000001010000000000000000 DR := {AR}
$02 $908000 100100001000000000000000 OP := DR & PC := PC+1
$03 $280000 001010000000000000000000 AR := PC                 ; fetch operands
$04 $150000 000101010000000000000000 DR := {AR} & PC := PC+1
$05 $ffffff 111111111111111111111111                          ; decode
```

## lda #$nn (imm)

```
$06 $008080 000000001000000010000000 AX := DR
$07 $000000 000000000000000000000000 OP := $00                ; execute
```

## LDA $nn (abs)

```
ARL := DR
ARH := $00
DR := {ARL}
AX := DR
OP := $00        ; execute
```

## STA $nn (abs)

```
ARL := DR
DR := AX
{ARL} := DR
OP := $00        ; execute
```

---

```
; STA $nnnn

ARL := SP        ; push operand to stack
{ARL} := DR
PC := PC + 1 *   ; fetch next operand
ARL := PCL
ARH := PCH
DR := {AR}
ARH := DR        ; use 2. operand for high
ARL := SP        ; pop 1. operand from stack for low
SP := SP - 1
DR := {ARL}
ARL := DR
DR := AX         ; store AX
{AR} := DR
OP := $00        ; execute
```
