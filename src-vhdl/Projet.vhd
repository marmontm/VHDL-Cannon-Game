LIBRARY ieee ;
USE ieee.std_logic_1164.all ;

Entity Projet is
	---------------------------------------------------
	--il est interdit de modifier l'entité de Projet---
	---------------------------------------------------
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
end Projet;

use work.Projet_pack.all;
Architecture Projet_arch of Projet is
	--signaux _int
	signal stEnVGA_int		: std_logic;
	signal stPause_int		: std_logic;
	
	signal stFinLigne_int	: std_logic;	
	signal stFinImage_int	: std_logic;
	signal stInitS_int 		: std_logic;
	signal stFeu_int		: std_logic;
	
	signal stPlus_int		: std_logic;
	signal iAngle_int		: integer range 1 to 13;
	
	signal iX_int			: integer range 0 to iXABCD;
	signal iY_int			: integer range 0 to iYABCD;
	
	signal iXobus_int		: integer range 0 to iXABCD;
	signal iYobus_int		: integer range 0 to iYABCD;

--	signal iXcanon_int		: integer range 0 to iXABCD;
--	signal iYcanon_int		: integer range 0 to iYABCD;
	
	signal iXcible_int		: integer range 0 to iXABCD;
	signal iYcible_int		: integer range 0 to iYABCD;
begin
	--	écrivez ici les intanciations des parties de votre projet.
	stInitS_int <= stv10SW(1);
	stEnVGA_int <= not stv10SW(3);
	stPause_int <= stv10SW(2);
	stFeu_int 	<= stv10SW(0);
	stPlus_int	<= stv3KEY(2);
	stv8LEDG(4) <= stEnVGA_int;
	stv8LEDG(3)	<= (not stInitS_int) and (not stPause_int);
	
	
	CompteurX_Ex1 : CompteurX
		port map
		(	stClk			=>	stHorloge50MHz,
			iX				=>	iX_int,
			stEnVGA			=>	stEnVGA_int,
			stSynchroLigne 	=> 	stVGA_SynchroLigne,
			stFinLigne		=>	stFinLigne_int
		);
	
	CompteurY_Ex1 : CompteurY
		port map
		(	stClk			=>	stHorloge50MHz,
			stEnC			=>	stFinLigne_int,
			iY				=>	iY_int,
			stSynchroTrame 	=> 	stVGA_SynchroTrame,
			stFinImage	 	=> 	stFinImage_int			
		);
		
	GeneRGB_Ex1 : GeneRGB 	
		port map
		(	iX			=>	iX_int,
			iY			=>	iY_int,
			iXobus		=>	iXobus_int,
			iYobus		=>	iYobus_int,
--			iXcanon		=>	iXcanon_int,
--			iYcanon		=>	iYcanon_int,
			iXcible		=>	iXcible_int,
			iYcible		=>	iYcible_cte,
			iAngle		=>	iAngle_int,
			stFeu		=>	stFeu_int,
			stR			=>	stR,
			stG			=>	stG,
			stB			=>	stB
		);

	CalcPosObus_Ex1 : CalcPosObus 
		port map
		(	stClk		=>	stHorloge50MHz,
			stInitS		=>	stInitS_int,
			stFinImage 	=>	stFinImage_int,
			stPause		=>	stPause_int,
			stFeu		=>	stFeu_int,
			iAngle		=>	iAngle_int,
			iXobus		=>	iXobus_int,
			iYobus		=>	iYobus_int
		);
		
	CalcPosCible_Ex1 : CalcPosCible
		port map
		(	stClk		=>	stHorloge50MHz,
			stAleat		=>	stInitS_int,
			iXcible		=>	iXcible_int
		);
		
	CalcAngle_Ex1 : CalcAngle
		port map
		(	
			stPlus		=>	stPlus_int,
			iAngle		=>	iAngle_int
		);

	--	Affectations des sorties qui ne sont pas utilisées
	-- 	mettez ces afectations en commentaire si vous utilisez ces sorties
	HEX : for i in 0 to 6 generate
		stv7HEX0(i) <= stInSertARien;
		stv7HEX1(i) <= stInSertARien;
		stv7HEX2(i) <= stInSertARien;
		stv7HEX3(i) <= stInSertARien;
	end generate HEX ;

--	LEDG : for i in 0 to 7 generate
--		stv8LEDG(i) <= not stInSertARien;
--	end generate LEDG;		
	
end Projet_arch;





