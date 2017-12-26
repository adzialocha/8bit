# ALU

* **X**: Variable X (8bit)
* **Y**: Variable Y (AX) (8bit)
* **Z**: Result Z (8bit)
* **1**: Constant 1 on X Flag (1bit)
* **C/I**: Carry Flag (1bit)
* **C/O**: Carry Out Flag (1bit)
* **OP**: Operation (4bit)

## Operations

* `0001` Z = X + Y
* `0010` Z = X - Y
* `0011` Z = X AND Y
* `0100` Z = X OR Y
* `0101` Z = X XOR Y
* `0110` Z = Y logically shifted left
* `0111` Z = Y logically shifted right
* `1000` Z = Y arithmetically shifted left
* `1001` Z = Y rotated left
* `1010` Z = Y rotated right
