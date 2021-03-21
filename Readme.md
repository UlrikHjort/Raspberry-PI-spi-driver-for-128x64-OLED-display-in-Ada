# Raspberry Pi spi driver for 128x64 OLED display in Ada using spi 0.

Write only spi interface. Not optimized for speed.

Package works with Ada2012 and above.

## Wiring of display to Raspberry Pi 3 Model B v. 1.2:

Display reset  <- GPIO 27
Data/Command <- GPIO 17
Chip select  <- GPIO 8 (spi0 CS)
Clk  <- GPIO 11 (spi0 CLK)
Data <- GPIO 10 (spi0 MOSI)