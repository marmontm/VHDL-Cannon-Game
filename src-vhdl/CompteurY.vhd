library IEEE;
use IEEE.std_logic_1164.all;
use work.Projet_pack.all;

entity CompteurY is 
	port 
	(	signal stClk			: in 	STD_LOGIC;
  		signal stEnC			: in 	STD_LOGIC;
		signal iY				: out integer range 0 to iYABCD;
		signal stSynchroTrame	: out std_logic;
		signal stFinImage		: out std_logic
	);
end CompteurY;

architecture CompteurY_arch of CompteurY is
	signal iCtY	: integer range 0 to iYABCD;
begin
	process (stClk)
	begin
		if (stClk'event and stClk = '1') then
			if(stEnC='1') then
				if(iCtY >= iYABCD-1)then
					iCtY <= 0;
				else
					iCtY <= iCtY + 1;
				end if;
			end if;
		end if;
	end process;
	
	iY <= iCtY;
		
	stSynchroTrame <=	'0' when(iCtY < iYA)
		else			'1';

	stFinImage 		<=	'1' when( (stEnC='1')and(iCtY=iYABCD-1) )
		else			'0';		
end CompteurY_arch;
