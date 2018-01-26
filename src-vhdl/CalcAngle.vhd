library IEEE;
use IEEE.std_logic_1164.all;
use work.Projet_pack.all;

entity CalcAngle is
	port
	(	signal stPlus	: in	std_logic;
		signal iAngle	: out	integer range 1 to 13
	);
end CalcAngle;

architecture CalcAngle_arch of CalcAngle is
	signal stCpt_int	: integer range 1 to 13;

begin
	process(stPlus)
	begin
		if(stPlus'event and stPlus='1') then
			if(stCpt_int > 13) then
				stCpt_int <= 1;
			else
				stCpt_int <= stCpt_int + 1;
			end if;
		end if;
	end process;
	
	iAngle <= stCpt_int;

end CalcAngle_arch;
