library IEEE;
use IEEE.std_logic_1164.all;
use work.Projet_pack.all;

entity CalcPosCible is 
	port 
	(	signal stClk		: in std_logic;
--		signal stInitS		: in std_logic;
		signal stAleat 		: in std_logic;
		signal iXcible 		: out integer range 0 to iXABCD
		
	);
end CalcPosCible;


architecture CalcPosCible_arch of CalcPosCible is
	signal iRien			: integer range 0 to 2312;
	signal iCtXcible		: integer range 0 to iXABC;
	signal iCtChoisir       : integer range 0 to iXABC;
begin	
	process (stClk)
	begin
		if (stClk'event and stClk = '1') then
			
--			if (stInitS = '1') then
--				iCtXcible <= iTabAleat(0);
--			end if;
			
			if (iCtChoisir >= iXABC) then --compteur pour position aleatoire
				iCtChoisir <= (iXAB+200);

			else 
				iCtChoisir <= iCtChoisir + 100;
			end if;
			
			if(stAleat = '1') then 
			
				if(iRien = 2312) then
					iRien <= 0;
				else
				iRien <= iRien + 1;
				end if;
				
			end if;
		
			
			if (stAleat = '1' and iRien >= 2312) then 
				iCtXcible <= iCtChoisir;
			end if;
			
		end if;
	end process;
	iXcible  <= iCtXcible;
end CalcPosCible_arch;