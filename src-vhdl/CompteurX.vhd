library IEEE;
use IEEE.std_logic_1164.all;
use work.Projet_pack.all;

entity CompteurX is 
	port 
	(	signal stClk			: in 	STD_LOGIC;
		signal iX				: out integer range 0 to iXABCD;
		signal stEnVGA			: in	STD_LOGIC;
		signal stSynchroLigne	: out std_logic;
		signal stFinLigne		: out std_logic
	);
end CompteurX;

architecture CompteurX_arch of CompteurX is
	signal iCtX	:integer range 0 to iXABCD;
begin
	process (stClk)
	begin
		if (stClk'event and stClk = '1') then
				if(iCtX >= iXABCD-1)then
					iCtX<=0;
				else
					iCtX <= iCtX + 1;
				end if;
		end if;
	end process;
	
	iX <= iCtX;
	
	stFinLigne	<= 	'1' when(iCtX=iXABCD-1 )
			else	'0';
		
	stSynchroLigne	<=	'0' when(iCtX < iXA)
				else	'0' when(stEnVGA='0')
				else	'1';
	
end CompteurX_arch;
