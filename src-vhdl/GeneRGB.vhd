library IEEE;
use IEEE.std_logic_1164.all;
use work.Projet_pack.all;

entity GeneRGB is 
	port 
	(	signal iX		: in integer range 0 to iXABCD;
  		signal iY		: in integer range 0 to iYABCD;
  		
		signal iXobus	: in integer range 0 to iXABCD;
		signal iYobus	: in integer range 0 to iYABCD;
		
--		signal iXcanon	: in integer range 0 to iXABCD;
--		signal iYcanon	: in integer range 0 to iYABCD;

		signal iXcible	: in integer range 0 to iXABCD;
		signal iYcible	: in integer range 0 to iYABCD;

		signal iAngle	: in integer range 1 to 13;
		signal stFeu	: in std_logic;

        signal stR		: out std_logic;
        signal stG		: out std_logic;
        signal stB		: out std_logic
	);
end GeneRGB;

architecture GeneRGB_arch of GeneRGB is																																																								--Marmont
	------Marmont M. - Gerardi M.------
	signal stAffichable	: std_logic;
	signal stObus_int	: std_logic;
--	signal stCanon_int	: std_logic;
--	signal stCible_int	: std_logic;
	signal stRegle_int	: std_logic;
	signal stCurseur_int : std_logic;
	signal stCible1_int	: std_logic;
	signal stCible2_int	: std_logic;
	signal stCible3_int	: std_logic;
	signal stContact_int : std_logic;
	
begin
	--securite affichage pixel en zone affichee seulement
	stAffichable <=	'1' when (iX >= iXAB) and (iX < iXABC) and (iY >= iYAB) and (iY < iYABC)
			else	'0';
	
	
	stObus_int	<=	'1' when ( (iX > iXobus-iLobus/2) and (iX < iXobus+iLobus/2) and (iY > iYobus-iHobus/2) and (iY < iYobus+iHobus/2) )
			else	'0';
			
	stRegle_int	<=	'1' when (
					   ((iX > iXAB) and (iX <= (iXAB + 8)) and ((iY > 070) and (iY <= 075)))
					or ((iX > iXAB) and (iX <= (iXAB + 8)) and ((iY > 080) and (iY <= 085)))
					or ((iX > iXAB) and (iX <= (iXAB + 8)) and ((iY > 090) and (iY <= 095)))
					or ((iX > iXAB) and (iX <= (iXAB + 8)) and ((iY > 100) and (iY <= 105)))
					or ((iX > iXAB) and (iX <= (iXAB + 8)) and ((iY > 110) and (iY <= 115)))
					or ((iX > iXAB) and (iX <= (iXAB + 8)) and ((iY > 120) and (iY <= 125)))
					or ((iX > iXAB) and (iX <= (iXAB + 8)) and ((iY > 130) and (iY <= 135)))
					or ((iX > iXAB) and (iX <= (iXAB + 8)) and ((iY > 140) and (iY <= 145)))
					or ((iX > iXAB) and (iX <= (iXAB + 8)) and ((iY > 150) and (iY <= 155)))
					or ((iX > iXAB) and (iX <= (iXAB + 8)) and ((iY > 160) and (iY <= 165)))
					or ((iX > iXAB) and (iX <= (iXAB + 8)) and ((iY > 170) and (iY <= 175)))
					or ((iX > iXAB) and (iX <= (iXAB + 8)) and ((iY > 180) and (iY <= 185)))
					or ((iX > iXAB) and (iX <= (iXAB + 8)) and ((iY > 190) and (iY <= 195)))
					)
			else	'0';
			
	stCurseur_int	<=	'1' when (
					   ((iX > (iXAB + 0)) and (iX <= (iXAB + 16)) and ((iY > 070) and (iY <= 075)) and iAngle = 13)
					or ((iX > (iXAB + 0)) and (iX <= (iXAB + 16)) and ((iY > 080) and (iY <= 085)) and iAngle = 12)
					or ((iX > (iXAB + 0)) and (iX <= (iXAB + 16)) and ((iY > 090) and (iY <= 095)) and iAngle = 11)
					or ((iX > (iXAB + 0)) and (iX <= (iXAB + 16)) and ((iY > 100) and (iY <= 105)) and iAngle = 10)
					or ((iX > (iXAB + 0)) and (iX <= (iXAB + 16)) and ((iY > 110) and (iY <= 115)) and iAngle = 09)
					or ((iX > (iXAB + 0)) and (iX <= (iXAB + 16)) and ((iY > 120) and (iY <= 125)) and iAngle = 08)
					or ((iX > (iXAB + 0)) and (iX <= (iXAB + 16)) and ((iY > 130) and (iY <= 135)) and iAngle = 07)
					or ((iX > (iXAB + 0)) and (iX <= (iXAB + 16)) and ((iY > 140) and (iY <= 145)) and iAngle = 06)
					or ((iX > (iXAB + 0)) and (iX <= (iXAB + 16)) and ((iY > 150) and (iY <= 155)) and iAngle = 05)
					or ((iX > (iXAB + 0)) and (iX <= (iXAB + 16)) and ((iY > 160) and (iY <= 165)) and iAngle = 04)
					or ((iX > (iXAB + 0)) and (iX <= (iXAB + 16)) and ((iY > 170) and (iY <= 175)) and iAngle = 03)
					or ((iX > (iXAB + 0)) and (iX <= (iXAB + 16)) and ((iY > 180) and (iY <= 185)) and iAngle = 02)
					or ((iX > (iXAB + 0)) and (iX <= (iXAB + 16)) and ((iY > 190) and (iY <= 195)) and iAngle = 01)
					)
			else	'0';
			
	-----CIBLE-----
	stCible1_int	<=	'1' when (
				(((iX - iXcible) * (iX - iXcible)) + ((iY - iYcible) * (iY - iYcible))) <= 500
				)
				else	'0';
	
	stCible2_int	<=	'1' when (
				(((iX - iXcible) * (iX - iXcible)) + ((iY - iYcible) * (iY - iYcible))) <= 2000
				)
				else	'0';
			
	stCible3_int	<=	'1' when (
				(((iX - iXcible) * (iX - iXcible)) + ((iY - iYcible) * (iY - iYcible))) <= 4000		
					)
				else	'0';			
	-----FIN CIBLE-----
	
	stContact_int	<=	'1' when (stObus_int='1' and (stCible3_int='1' or stCible2_int='1' or stCible1_int='1'))
				else	'0';

	
	----RGB----
	stR	<=		'0' when (stAffichable = '0')
		else	'1' when (stCurseur_int='1' and stFeu='1')
		else	'0' when (stCurseur_int='1' and stFeu='0')
		else	'0' when (stRegle_int='1')
		else 	'0' when (stObus_int='1')
		else	'1'	when (stContact_int='1')
		else	'1' when (stCible1_int='1')
		else	'0' when (stCible2_int='1')
		else	'1' when (stCible3_int='1')
		else	'1';

	stG <=		'0' when (stAffichable = '0')
		else	'0' when (stCurseur_int='1' and stFeu='1')
		else	'0' when (stCurseur_int='1' and stFeu='0')
		else	'0' when (stRegle_int='1')
		else 	'0' when (stObus_int='1')
		else	'1'	when (stContact_int='1')
		else	'1' when (stCible1_int='1')
		else	'0' when (stCible2_int='1')
		else	'0' when (stCible3_int='1')
		else	'1';
		
	stB	<=		'0' when (stAffichable = '0')
		else	'0' when (stCurseur_int='1' and stFeu='1')
		else	'1' when (stCurseur_int='1' and stFeu='0')
		else	'1' when (stRegle_int='1')
		else 	'1' when (stObus_int='1')
		else	'0'	when (stContact_int='1')
		else	'1' when (stCible1_int='1')
		else	'1' when (stCible2_int='1')
		else	'0' when (stCible3_int='1')
		else	'1';

end GeneRGB_arch;