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
with CTypes; use CTypes; 

--------------------------------------------------------------------
--
--
--
--------------------------------------------------------------------       
package SSD1306 is
   
   --------------------------------------------------------------------
   --
   -- Init the display
   --
   --------------------------------------------------------------------       
   procedure Init;   
   
   --------------------------------------------------------------------
   --
   -- Update display from framebuffer
   --
   --------------------------------------------------------------------          
   procedure Update;
   
   --------------------------------------------------------------------
   --
   -- Reset display
   --
   --------------------------------------------------------------------          
   procedure Reset;   
   
    --------------------------------------------------------------------
    --
    -- Clear display 
    --
    --------------------------------------------------------------------       
    procedure Clear;         
   
   --------------------------------------------------------------------
   --
   -- Write command via SPI
   --
   --------------------------------------------------------------------          
   procedure Write_Cmd(Cmd : Byte); 
   
   --------------------------------------------------------------------
   --
   -- Write data via SPI
   --
   --------------------------------------------------------------------          
   procedure Write_Data(Data : Byte);           
   
   --------------------------------------------------------------------
   --
   -- Put pixel at positon (X,Y) 
   -- Swap pixel state on current position e.g set to white if black 
   -- and vice versa
   --
   --------------------------------------------------------------------        
   procedure Put_Pixel(X : Byte; Y : Byte);
   
end SSD1306;
  
