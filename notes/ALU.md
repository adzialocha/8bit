# ALU

* X: Variable (8bit)
* Y: Variable (8bit)
* Z: Ergebnis (8bit)
* C/I: Carry Flag (1bit)
* C/O: Carry Out / Übertrag Flag (1bit)
* OP: Operation (4bit)

## Opcodes

`0000` Z = X + Y
`0001` Z = X - Y
`0010` Z = X AND Y
`0011` Z = X OR Y
`0100` Z = X XOR Y
`0101` Z = X logically shifted left
`0110` Z = X logically shifted right
`0111` Z = X arithmetically shifted left
`1000` Z = X rotated left
`1001` Z = X rotated right
