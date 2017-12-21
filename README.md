# 8bit

These are my notes on building a 8bit computer. The circuit is simulated with the great [Logisim](http://www.cburch.com/logisim/de/), I've also written a converter for my [assembly language](https://github.com/adzialocha/8bit/blob/master/tools/assembler/assembler.c) and a helper to write [micro instructions](https://github.com/adzialocha/8bit/blob/master/tools/microcode-editor/microcode-editor.html).

### Folder structure

* `asm` contains sketches and final programs written in 6502 or my own assembler.
* `circuit` holds all Logisim projects, `v3` is the latest.
* `docs` my [writings](https://andreasdzialocha.com/8bit/) (mainly in german, someday in english) documenting the process.
* `microcode` the microcode program for the circuits control unit (can be read, edited and saved by the microcode editor tool).
* `notes` different notes on the architecture, memory organisation, opcodes etc.
* `tools` small software projects to help me designing the computer.
