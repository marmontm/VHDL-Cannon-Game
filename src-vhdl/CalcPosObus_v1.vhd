library IEEE;
use IEEE.std_logic_1164.all;
use work.Projet_pack.all;

entity CalcPosObus is 
	port 
	(	signal stClk		: in std_logic;
		signal stInitS		: in std_logic;
		signal stFinImage 	: in std_logic;
		signal stPause		: in std_logic;
		signal iXobus		: out integer range 0 to iXABCD;
		signal iYobus		: out integer range 0 to iYABCD
	);
end CalcPosObus;


architecture CalcPosObus_arch of CalcPosObus is
	signal iCtXobus		: integer range 0 to iXABCD;
	signal iCtYobus		: integer range 0 to iYABCD;
	signal iDepX		: integer range 0 to iXABCD;
	signal iDepY		: integer range 0 to iYABCD;
	signal iCtImage		: integer range 0 to 9;
	signal stEnDep		: std_logic;

begin	
	process (stClk)
	begin
		if (stClk'event and stClk = '1') then
			if (stInitS='1') then
				iCtImage	<= 0;
				iCtXobus	<= iXAB;
				iCtYobus	<= iYABC;
				iDepX		<= 7;
				iDepY		<= 7;
				stEnDep		<= '1';
			elsif (stFinImage='1' and stPause='0') then	
				if (iCtImage >=  9) then
					iCtImage	<= 0;
					iDepY		<= iDepY - 1;
				else
					iCtImage	<= iCtImage + 1;
				end if;
				
				if (	(iCtXobus > iXABC) or (iCtYobus > iYABC)	) then
					stEnDep		<= '0';		
				elsif (	stEnDep='1' and (iDepY > 0)	) then
					iCtXobus	<= iCtXobus + iDepX;
					iCtYobus	<= iCtYobus - iDepY;
				elsif (	stEnDep='1' and (iDepY <= 0)	) then
					iCtXobus	<= iCtXobus + iDepX;
					iCtYobus	<= iCtYobus + iDepY;
				end if;				
			end if;
		end if;
	end process;
	
	iXobus	<= iCtXobus;
	iYobus	<= iCtYobus;
	
end CalcPosObus_arch;