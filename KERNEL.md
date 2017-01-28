# KERNEL

$1C00 - $1FFF (7168 - 8191) Kernel (1024 Byte)

PC starts at address $1C00.

## Program

```
($0000) $1C00		1d0800		JMP #$0800		# set PC to #$0800 where our program lies
($03FC) $1FFF		1d1ffc		JMP #$1FFC		# endless loop
```