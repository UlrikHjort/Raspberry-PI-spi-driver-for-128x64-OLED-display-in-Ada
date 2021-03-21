---------------------------------------------------------------------------
--                      Raspberry Pi misc types
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

with Interfaces.C;

package CTypes is
   package C renames Interfaces.C;
   
   type Byte is mod 256; pragma Convention (C, Byte);
   type Byte_Buffer is array (Interfaces.C.Int range <>) of Byte;  pragma Convention (C, Byte_Buffer);   
end CTypes;
