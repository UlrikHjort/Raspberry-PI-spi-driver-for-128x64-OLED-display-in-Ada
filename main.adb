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
with SSD1306;

procedure Main is
   
begin      
   SSD1306.Init;
   SSD1306.Update;
   
   for P in 0 .. 63 loop
      SSD1306.Put_Pixel(Byte(P*2),Byte(P));
   end loop;
      
   SSD1306.Update;   
end Main;

