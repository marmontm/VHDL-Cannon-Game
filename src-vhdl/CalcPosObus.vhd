library IEEE;
use IEEE.std_logic_1164.all;
use work.Projet_pack.all;

entity CalcPosObus is 
	port 
	(	signal stClk		: in std_logic;
		signal stInitS		: in std_logic;
		signal stFinImage 	: in std_logic;
		signal stPause		: in std_logic;
		signal stFeu		: in std_logic;
		signal iAngle		: in integer range 1 to 13;
		signal iXobus		: out integer range 0 to iXABCD;
		signal iYobus		: out integer range 0 to iYABCD
	);
end CalcPosObus;


architecture CalcPosObus_arch of CalcPosObus is
	type T_etat is ( INIT, MONTE, DESCEND, FIN	);
	signal Etat			: T_etat;
	signal iCtXobus		: integer range 0 to iXABCD;
	signal iCtYobus		: integer range 0 to iYABCD;
	signal iDepX		: integer range 0 to iXABCD;
	signal iDepY		: integer range 0 to iYABCD;
	signal iCtImage		: integer range 0 to 9;

begin	
	process (stClk)
	begin
		if (stClk'event and stClk = '1') then
			if (stInitS='1') then
					Etat	<= INIT;
					iCtXobus	<= iXAB-1+(iLobus/2);
					iCtYobus	<= iYABC-(iHobus/2);
			elsif (stFinImage='1' and stPause='0') then	
				case Etat is
					when INIT =>
						iCtImage	<= 0;
						iCtXobus	<= iXAB-1+(iLobus/2);
						iCtYobus	<= iYABC-(iHobus/2);
						iDepX		<= iTab10DepX(iAngle)/10;
						iDepY		<= iTab10DepY(iAngle)/10;
						if (stFeu='1') then
							Etat	<= MONTE;
						end if;
					when MONTE =>
						if (iCtImage >=  9) then
							iCtImage	<= 0;
							iDepY		<= iDepY - 1;
						else
							iCtImage	<= iCtImage + 1;
						end if;
						iCtXobus	<= iCtXobus + iDepX;
						iCtYobus	<= iCtYobus - iDepY;
						if (	(iDepY <= 0) or ((iCtYobus-iHobus/2) <= iYAB) or ((iCtXobus+iLobus/2) >= iXABC)	) then
							Etat <= DESCEND;
						end if;
						
					when DESCEND =>
						if (iCtImage >=  9) then
							iCtImage	<= 0;
							iDepY		<= iDepY + 1;
						else
							iCtImage	<= iCtImage + 1;
						end if;
						if ( ((iCtXobus+iLobus/2) >= iXABC) or ((iCtYobus+iHobus/2) >= iYABC)	) then
							Etat <= FIN;
						else
							iCtXobus	<= iCtXobus + iDepX;
							iCtYobus	<= iCtYobus + iDepY;
						end if;
							
					when FIN =>
						iCtXobus	<= iCtXobus;
						iCtYobus	<= iCtYobus;
						
				end case;
			end if;
		end if;
	end process;
	
	iXobus	<= iCtXobus;
	iYobus	<= iCtYobus;
	
end CalcPosObus_arch;