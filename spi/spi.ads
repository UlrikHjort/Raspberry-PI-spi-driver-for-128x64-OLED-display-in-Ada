---------------------------------------------------------------------------
--                Raspberry Pi Spi interface
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
with CTypes; use CTypes; 

--------------------------------------------------------------------
--
--
--
--------------------------------------------------------------------       
package spi is

      SPI_CPHA : constant Byte :=  16#01#; -- Clock phase
      SPI_CPOL : constant Byte :=  16#02#; -- Clock polarity
      
      -- SPI_MODE_0 CPOL = 0, CPHA = 0, Clock idle low, data is clocked in on rising edge, output data on falling edge
      -- SPI_MODE_1 CPOL = 0, CPHA = 1, Clock idle low, data is clocked in on falling edge, output data on rising edge
      -- SPI_MODE_2 CPOL = 1, CPHA = 0, Clock idle high, data is clocked in on falling edge, output data on rising edge
      -- SPI_MODE_3 CPOL = 1, CPHA = 1, Clock idle high, data is clocked in on rising, edge output data  on falling edge
      
      SPI_MODE_0 : constant Byte := 0;
      SPI_MODE_1 : constant Byte := SPI_CPHA;      
      SPI_MODE_2 : constant Byte := SPI_CPOL;
      SPI_MODE_3 : constant Byte := (SPI_CPOL or SPI_CPHA);
       
   --------------------------------------------------------------------
   --
   --
   --
   --------------------------------------------------------------------       
   function Init return Integer;
   
   --------------------------------------------------------------------
   --
   --
   --
   --------------------------------------------------------------------          
   function Open(Device : C.Int; Mode : C.Int; Speed : C.Int; Bits_Pr_Word : C.Int) return C.Int;   
   
   --------------------------------------------------------------------
   --
   --
   --
   --------------------------------------------------------------------          
   function Write(handle : C.Int; Buffer : Byte_Buffer; Length : C.Int; KeepCsLow : C.Int) return Integer;
   
   --------------------------------------------------------------------
   --
   --
   --
   --------------------------------------------------------------------          
   function Close(handle : C.Int) return Integer;   
   
   
end spi;
