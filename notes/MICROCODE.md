# MICROCODE

```
; Hauptroutine
; Fetch Address

AR := PC
DR := {AR}
OP := DR

; Fetch Operand

PC := PC + 1 *
AR := PC
DR := {AR}

; Decode
```

```
; LDA #$nn

AX := DR
OP := $00        ; execute
```

```
; LDA $nn

ARL := DR
ARH := $00
DR := {ARL}
AX := DR
OP := $00        ; execute
```

```
; LDA $nnnn

AX := DR
PC := PC + 1 *
ARL := PCL
ARH := PCH
DR := {AR}
ARL := AX
ARH := DR
DR := {AR}
AX := DR
OP := $00        ; execute
```

```
; STA $nn

ARL := DR
DR := AX
{ARL} := DR
OP := $00        ; execute
```

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
