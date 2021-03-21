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

package body spi is
   
   --------------------------------------------------------------------
   --
   --
   --
   --------------------------------------------------------------------       
   function Init return Integer is
	
   begin            
      return 0;
   end Init;
   
   --------------------------------------------------------------------
   --
   --
   --
   --------------------------------------------------------------------          
   function Open(Device : C.Int; Mode : C.Int; Speed : C.Int; Bits_Pr_Word : C.Int) return C.Int is 
      
      function COpen(Device : C.Int; Mode : C.Int; Speed : C.Int; Bits_Pr_Word : C.Int)  return C.Int 
	with
	Import        => True,
	Convention    => C,
        External_Name => "spi_open";
      
   begin
      return COpen(Device, Mode, Speed, Bits_Pr_Word);
   end Open;
   

   --------------------------------------------------------------------
   --
   --
   --
   --------------------------------------------------------------------          
   function Write(Handle : C.Int; Buffer : Byte_Buffer; Length : C.Int; KeepCsLow : C.Int) return Integer is
      
      function CWrite(Handle : C.Int; TxBuffer : Byte_Buffer; Length : C.Int; KeepCsLow : C.Int) return C.Int	
	with
	Import        => True,
	Convention    => C,
        External_Name => "spi_write";  
      
   begin
      return Integer(CWrite(Handle, Buffer, Length , KeepCsLow));

   end Write;
   
   --------------------------------------------------------------------
   --
   --
   --
   --------------------------------------------------------------------          
   function Close(handle : C.Int) return Integer is
      
      function CClose(Handle : C.Int) return C.Int	
	with
	Import        => True,
	Convention    => C,
        External_Name => "spi_close";  
      
   begin
      return Integer(CClose(Handle));
   end Close;
end spi;
