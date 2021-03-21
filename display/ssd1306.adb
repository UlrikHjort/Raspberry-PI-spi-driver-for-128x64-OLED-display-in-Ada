---------------------------------------------------------------------------
--                Raspberry Pi SSD1306 interface
-- 
--           Copyright (C) 2020 By Ulrik Hørlyk Hjort
--
--  This Program is Free Software; You Can Redistribute It and/or
--  Modify It Under The Terms of The GNU General Public License
--  As Published By The Free Software Foundation; Either Version 2
--  of The License, or (at Your Option) Any Later Version.
--
--  This Program is Distributed in The Hope That It Will Be Useful,
--  But WITHOUT ANY WARRANTY; Without Even The Implied Warranty of
--  MERCHANTABILITY or FITNESS for A PARTICULAR PURPOSE.  See The
--  GNU General Public License for More Details.
--
-- You Should Have Received A Copy of The GNU General Public License
-- Along with This Program; if not, See <Http://Www.Gnu.Org/Licenses/>.
---------------------------------------------------------------------------
with Interfaces;
with Interfaces.C;
with Gpio_RaspberryPi;
with Spi;

--------------------------------------------------------------------
--
--
--
--------------------------------------------------------------------    
package body SSD1306 is
   
   package Gpio renames Gpio_RaspberryPi;    
   
   PIN_DC : constant Integer := 17;
   PIN_RST : constant Integer := 27;   
   
   use Interfaces.C; -- For operator for type Interfaces.C.int   
   Framebuffer : Byte_Buffer(0..(128*64/8));
   
    SSD1306_Init : constant Byte_Buffer(0 .. 25) := (
    16#AE#, -- Set display OFF
    16#D5#, -- Set Display Clock Divide Ratio / OSC Frequency
    16#80#, -- Display Clock Divide Ratio / OSC Frequency
    16#A8#, -- Set Multiplex Ratio
    16#3F#, -- Multiplex Ratio for 128x64 (64-1)
    16#D3#, -- Set Display Offset
    16#00#, -- Display Offset
    16#40#, -- Set Display Start Line
    16#8D#, -- Set Charge Pump
    16#14#, -- Charge Pump (16#10 External, 16#14 Internal DC/DC)
    16#20#, -- Set memory addressing mode
    16#02#, -- Horizontal addressing mode
    16#A1#, -- Set segment re-map, column address 127 is mapped to SEG0
    16#C8#, -- Set Com Output Scan Direction
    16#DA#, -- Set COM Hardware Configuration
    16#12#, -- COM Hardware Configuration
    16#81#, -- Set Contrast
    16#CF#, -- Contrast
    16#D9#, -- Set Pre-Charge Period
    16#F1#, -- Set Pre-Charge Period (16#22 External, 16#F1 Internal)
    16#DB#, -- Set VCOMH Deselect Level
    16#40#, -- VCOMH Deselect Level
    16#A4#, -- Set all pixels OFF
    16#A6#, -- Set display not inverted
    16#AF#, -- Set display On
    16#FF#  -- End of buffer mark
   );
    
    Spi_Handle : C.Int := 0;
    --------------------------------------------------------------------
    --
    -- Init
    --
    --------------------------------------------------------------------    
    procedure Init is
       I : C.Int := 0;
       
    begin            
       Gpio.Export(PIN_DC);
       Gpio.Set_Pin_Mode(PIN_DC,Gpio.Mode_Out);    
   
      Gpio.Export(PIN_RST);
      Gpio.Set_Pin_Mode(PIN_RST,Gpio.Mode_Out);    
      
      Reset;
      
      Spi_Handle := Spi.Open(0,C.Int(Spi.SPI_MODE_0), 10000000, 8);
      loop
	 exit when  SSD1306_Init(I) = 16#FF#;
 	 Write_Cmd(SSD1306_Init(I));
	 I := I + 1;
      end loop;
      
      Clear;      
    end Init;
    
    
    --------------------------------------------------------------------
    --
    -- Clear
    --
    --------------------------------------------------------------------       
    procedure Clear is       
       
    begin
      for I in 0 .. (128*64/8) loop
	 Framebuffer(C.Int(I)) := 0; 
      end loop;
    end Clear;
    
    
    --------------------------------------------------------------------
    --
    -- Reset
    --
    --------------------------------------------------------------------       
    procedure Reset is       
       
    begin
      Gpio.Digital_Write(PIN_RST,Gpio.Low);
      delay 0.1;
      Gpio.Digital_Write(PIN_RST,Gpio.High);          
    end Reset;
    
    
    --------------------------------------------------------------------
    --
    -- Update
    --
    --------------------------------------------------------------------       
    procedure Update is
       
    begin
       Write_Cmd(16#20#); -- Set memory addressing mode
       Write_Cmd(16#02#); -- Horizontal addressing mode
       Write_Cmd(16#40#); -- Set Display Start Line     
       Write_Cmd(16#D3#); -- Set Display Offset     
       Write_Cmd(16#00#);
       
       for Px in 0 .. 7 loop
	  Write_Cmd(16#B0# + Byte(Px));	 
	  Write_Cmd(16#00#); -- Lo Col
	  Write_Cmd(16#10#); -- Hi Col
	  for Bx in 0 .. 127 loop
	     Write_Data(Framebuffer(C.Int(Bx+(128*Px)))); 
	  end loop;	 
       end loop;	
    end Update;   
    
    
    --------------------------------------------------------------------
    --
    -- Put Pixel
    --
    --------------------------------------------------------------------        
    procedure Put_Pixel(X : Byte; Y : Byte)  is 

       Bitmask : constant Byte := Byte(Interfaces.Shift_Left(Interfaces.Unsigned_8(1),(7 - (Natural(Y) mod 8))));
       Pageno : constant C.Int := C.Int((63-Y)/8);
       Col : constant C.Int := C.Int(X mod 128);
       
    begin
       Framebuffer(Pageno*128+Col) := Framebuffer(Pageno*128+Col) xor Bitmask;
    end Put_Pixel;
    
      
    --------------------------------------------------------------------
    --
    -- Write Cmd
    --
    --------------------------------------------------------------------        
    procedure Write_Cmd(Cmd : Byte)  is
       
       Buffer : Byte_Buffer(0 .. 1);
       R : Integer := 0;
      
    begin
       Gpio.Digital_Write(PIN_DC,Gpio.Low);      
       Buffer(0) := Cmd;
       R := Spi.Write(Spi_Handle, Buffer,1,1); 
    end Write_Cmd;
    
    
    --------------------------------------------------------------------
    --
    -- Write Data
    --
    --------------------------------------------------------------------       
    procedure Write_Data(Data : Byte)  is
       Buffer : Byte_Buffer(0 .. 1);
       R : Integer := 0;
      
    begin
       Gpio.Digital_Write(PIN_DC,Gpio.High);      
       Buffer(0) := Data;
       R := Spi.Write(Spi_Handle, Buffer,1,1); 
    end Write_Data;   
      
end SSD1306;
