# CCR

* **OP**: Operation (3bit)
* **BM**: Branch Mode Flag (1bit)
* **SEC**: Set Carry Flag (8bit)
* **CLR**: Clear Carry Flag (1bit)
* **I**: ALU Result (from Z) (8bit)
* **CLK**: Clock (1bit)
* **RST**: Reset (1bit)
* **BI**: Branch Instruction Flag (1bit)
* **C**: Carry Flag (1bit)
* **Z**: Zero Flag (1bit)
* **N**: Negative Flag (1bit)

## Operations

* `000` BPL Branch on plus (N)
* `001` BMI Branch on minus (N)
* `010` BCC Branch on carry clear (C)
* `011` BCS Branch on carry set (C)
* `100` BNE Branch on not equal (Z)
* `101` BEQ Branch on equal (Z)
* `110` SEC Set carry flag
* `111` CLC Clear carry flag
