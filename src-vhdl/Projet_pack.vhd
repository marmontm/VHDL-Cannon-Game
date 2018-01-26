LIBRARY ieee ;
USE ieee.std_logic_1164.all ;

Package Projet_pack is
	--déclarations des constantes utiles au projet
	constant iXA		:integer	:=160;
	constant iXAB		:integer	:=270;		--origine X
	constant iXABC		:integer	:=1270;		--max X
	constant iXABCD		:integer	:=1320;
	
	constant iYA		:integer	:=4;
	constant iYAB		:integer	:=27;		--origine Y
	constant iYABC		:integer	:=627;		--max Y
	constant iYABCD		:integer	:=628;
	
	constant iDep		:integer	:=10;
	
	constant iXMILIEU	:integer	:=(iXAB+iXABC)/2;
	constant iYMILIEU	:integer	:=(iYAB+iYABC)/2;
	
	constant iLobus		:integer	:=50;
	constant iHobus		:integer	:=40;
	
--	constant iLcanon	:integer	:=120;
--	constant iHcanon	:integer	:=120;
	
--	constant iLcible	:integer	:=120;
--	constant iHcible	:integer	:=120;
	constant iYcible_cte	:integer	:=(iYABC-(iYAB*3));

	type T_Tab13Int is Array(1 to 13) of integer;	-- Appel variable : iTab10Dep(X)
	constant iTab10DepX	: T_Tab13Int := (99, 98, 95, 91, 87, 81, 74, 67, 59, 50, 41, 31, 21);
	constant iTab10DepY	: T_Tab13Int := (10, 21, 31, 41, 50, 59, 67, 74, 81, 87, 91, 95, 98);
	
	type T_Tab7Int is Array (0 to 6) of integer ;
	constant iTabAleat : T_Tab7Int:=
	(iXMILIEU, 100, 400, 600, 300, 50, 400);
	
	--Composants du projet
	component CalcPosObus 
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
	end component;
	
	component CalcPosCible
	port
		(	signal stClk		: in std_logic;
	--		signal stInitS		: in std_logic;
			signal stAleat 		: in std_logic;
			signal iXcible 		: out integer range 0 to iXABCD
			);
	end component;	
		
	component CalcAngle
	port
		(	signal stPlus	: in	std_logic;
			signal iAngle	: out	integer range 1 to 13
		);
	end component;
	
	component GeneRGB 
		port 
		(	signal iX		: in integer range 0 to iXABCD;
			signal iY		: in integer range 0 to iYABCD;
			signal iXobus	: in integer range 0 to iXABCD;
			signal iYobus	: in integer range 0 to iYABCD;
--			signal iXcanon	: in integer range 0 to iXABCD;
--			signal iYcanon	: in integer range 0 to iYABCD;
			signal iXcible	: in integer range 0 to iXABCD;
			signal iYcible	: in integer range 0 to iYABCD;
			signal iAngle	: in integer range 1 to 13;
			signal stFeu	: in std_logic;
			signal stR		: out std_logic;
			signal stG		: out std_logic;
			signal stB		: out std_logic
		);
	end component;	
	
	component CompteurY is 
		port 
		(	signal stClk			: in 	STD_LOGIC;
			signal stEnC			: in 	STD_LOGIC;
			signal iY				: buffer integer range 0 to iYABCD;
			signal stSynchroTrame	: out std_logic;
			signal stFinImage		: out std_logic
		);
	end component;
	
	component CompteurX 
		port 
		(	signal stClk			: in 	STD_LOGIC;
			signal iX				: buffer integer range 0 to iXABCD;
			signal stEnVGA			: in	STD_LOGIC;
			signal stSynchroLigne	: out std_logic;
			signal stFinLigne		: out std_logic
		);
	end component;	
	
	----------------------------------------------------------------------------------------------
	----------------------------------------------------------------------------------------------
	--déclaration de composant de Projet
	--n'y touchez surtout pas
	----------------------------------------------------------------------------------------------
	component Projet
		port
		(	--entrées utiles pour les projets(	
			stInSertARien			:in std_logic;
			stHorloge50MHz			:in std_logic;
			stv3KEY					:in std_logic_vector(2 downto 0);	--poussoirs de la maquette
			stv10SW					:in std_logic_vector(9 downto 0);	--inters de la maquette	
			
			--sorties utiles pour les projets
			--afficheurs 7 segments de la maquette
			stv7HEX0				:out std_logic_vector(6 downto 0);
			stv7HEX1				:out std_logic_vector(6 downto 0);
			stv7HEX2				:out std_logic_vector(6 downto 0);
			stv7HEX3				:out std_logic_vector(6 downto 0);
		
			--LEDs de la maquette
			stv8LEDG				:out std_logic_vector(7 downto 0);
			
			--sorties VGA de la maquette, elles sont connectées à l'écran du PC
			stR						:out std_logic;
			stG						:out std_logic;
			stB						:out std_logic;
			stVGA_SynchroLigne		:out std_logic;
			stVGA_SynchroTrame		:out std_logic
		);
	end component;
	
end Projet_pack;

