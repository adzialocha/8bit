# MEMORY

## General

- 8192 words by 8 bits (word-length)
- 65,536-bit total, ca. 64Kbit / 8KByte
- Addresses $0000 - $1FFF (0000 - 8191)

## Organization

- $0000 - $001F (0000 - 0031) Zeropage (32 Byte)
- $0020 - $003F (0032 - 0063) Stack (32 Byte)
- $0040 - $005F (0064 - 0095) LED Display (32 Byte)
- $0060 - $007F (0096 - 0127) Input (32 Byte)
- $0080 - $1BFF (0128 - 7167) RAM (7040 Byte)
- $1C00 - $1FFF (7168 - 8191) Kernel (1024 Byte)

## Zeropage $0000 - $001F

## Stack $0020 - $003F

- $0020 - $003F (0032 - 0063) Processor Stack

## LED Display $0040 - $005F

- $0040 - $0047 (0064 - 0071) Pixels for left 8x8 LED
- $0048 - $004F (0072 - 0079) Pixels for right 8x8 LED
- $0050 - $0057 (0080 - 0087) Colors for left 8x8 LED *
- $0058 - $005F (0088 - 0095) Colors for right 8x8 LED *

## Input $0060 - $007F

## RAM $0080 - $1BFF

- $0080 - $1BFF (0128 - 7167) Free usable RAM

## Kernel $1C00 - $1FFF
