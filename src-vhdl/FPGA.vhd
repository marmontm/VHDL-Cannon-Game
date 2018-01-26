-----------------------------------------------------
-----------------------------------------------------
-----il est interdit de modifier ce fichier ---------
-----------------------------------------------------
-----------------------------------------------------

LIBRARY ieee ;
USE ieee.std_logic_1164.all ;

Entity FPGA is
	port
	(	--entrées utiles pour les projets(	
		stInSertARien			:in std_logic;
		stHorloge50MHz			:in std_logic;
		stv3KEY					:in std_logic_vector(2 downto 0);
		stv10SW					:in std_logic_vector(9 downto 0);		
		
		--sorties utiles pour les projets
		stv7HEX0				:out std_logic_vector(6 downto 0);
		stv7HEX1				:out std_logic_vector(6 downto 0);
		stv7HEX2				:out std_logic_vector(6 downto 0);
		stv7HEX3				:out std_logic_vector(6 downto 0);
		stHEX0_DP				:out std_logic;
		stHEX1_DP				:out std_logic;
		stHEX2_DP				:out std_logic;
		stHEX3_DP				:out std_logic;
		stv10LEDG				:out std_logic_vector(9 downto 0);
		stv4VGA_R				:out std_logic_vector(3 downto 0);
		stv4VGA_G				:out std_logic_vector(3 downto 0);
		stv4VGA_B				:out std_logic_vector(3 downto 0);
		stVGA_SynchroLigne		:out std_logic;
		stVGA_SynchroTrame		:out std_logic;
		
		--signaux inutiles pour les projets
		DRAM_ADDR				:in std_logic_vector(12 downto 0);--OK
		DRAM_BA_0				:in std_logic;	--OK
		DRAM_BA_1				:in std_logic;	--OK
		DRAM_CAS_N				:in std_logic;	--OK
		DRAM_CKE				:in std_logic;	--OK
		DRAM_CLK				:in std_logic;	--OK
		DRAM_CS_N				:in std_logic;	--OK
		DRAM_DQ					:in std_logic_vector(15 downto 0);--OK
		DRAM_LDQM				:in std_logic;	--OK
		DRAM_UDQM				:in std_logic;	--OK
		DRAM_RAS_N				:in std_logic;	--OK
		DRAM_WE_N				:in std_logic;	--OK
		
		FL_ADDR					:in std_logic_vector(21 downto 0);	--OK
		FL_CE_N					:in std_logic;	--OK
		FL_OE_N					:in std_logic;	--OK
		FL_DQ					:in std_logic_vector(14 downto 0);	--OK
		FL_RST_N				:in std_logic;	--OK
		FL_WE_N					:in std_logic;	--OK
		FL_DQ15_AM1				:in std_logic;	--OK
		FL_WP_N					:in std_logic;	--OK
		FL_BYTE_N				:in std_logic;	--OK
		FL_RY					:in std_logic;	--OK
		
		CLOCK_50_2				:in std_logic;
		
		PS2_KBCLK				:in std_logic;	--OK
		PS2_KBDAT				:in std_logic;	--OK
		PS2_MSCLK				:in std_logic;	--OK
		PS2_MSDAT				:in std_logic;	--OK
		
		UART_RXD				:in std_logic;	--OK
		UART_TXD				:in std_logic;	--OK
		UART_RTS				:in std_logic;	--OK
		UART_CTS				:in std_logic;	--OK
		
		LCD_RW					:in std_logic;	--OK
		LCD_EN					:in std_logic;	--OK
		LCD_RS					:in std_logic;	--OK
		LCD_DATA				:in std_logic_vector(7 downto 0);	--OK
		LCD_BLON				:in std_logic;	--OK
		
		SD_DAT0					:in std_logic;
		SD_DAT3					:in std_logic;
		SD_CMD					:in std_logic;
		SD_CLK					:in std_logic;
		SD_WP_N					:in std_logic;
		
		GPIO0_CLKIN				:in std_logic_vector(1 downto 0);
		GPIO0_CLKOUT			:in std_logic_vector(1 downto 0);
		GPIO0_D					:in std_logic_vector(31 downto 0);
		GPIO1_CLKIN				:in std_logic_vector(1 downto 0);
		GPIO1_CLKOUT			:in std_logic_vector(1 downto 0);
		GPIO1_D					:in std_logic_vector(31 downto 0);

		stSortie				:out std_logic
	);
end FPGA;

-----------------------------------------------------
-----------------------------------------------------
-----il est interdit de modifier ce fichier ---------
-----------------------------------------------------
-----------------------------------------------------

use work.Projet_pack.all;

Architecture FPGA_arch of FPGA is
	signal stR		: std_logic;
	signal stG		: std_logic;
	signal stB		: std_logic;
	constant iNbInutiles : integer := 196;
	signal 	Interne	: std_logic_vector(iNbInutiles downto 0);
	signal 	SdeEt2	: std_logic_vector(iNbInutiles downto 0);
begin
	--instanciation du projet des étudiants
	Proj : Projet
		port map
		(	stInSertARien			=>	stInSertARien,
			stHorloge50MHz			=>	stHorloge50MHz,
			stv3KEY					=>	stv3KEY,
			stv10SW					=>	stv10SW,	
			stv7HEX0				=>	stv7HEX0,
			stv7HEX1				=>	stv7HEX1,
			stv7HEX2				=>	stv7HEX2,
			stv7HEX3				=>	stv7HEX3,
			stv8LEDG				=>	stv10LEDG(7 downto 0),
			stR						=>	stR,
			stG						=>	stG,
			stB						=>	stB,
			stVGA_SynchroLigne		=>	stVGA_SynchroLigne,
			stVGA_SynchroTrame		=>	stVGA_SynchroTrame
		);
		
	-- duplication de stR à tous les bits de stv4VGA_R, idem pour G et B
	RGB : for i in 0 to 3 generate
		stv4VGA_R(i) <= stR;
		stv4VGA_G(i) <= stG;
		stv4VGA_B(i) <= stB;
	end generate RGB;

	
	--utilisation de tous les signaux INUTILES pour le projet
	--ceci permet d'empécher le fitter de mettre des signaux du projet 
	--sur les pattes aux quelles sont reliés les circuits périphériques 
	--comme la RAM, le port Ethernet etc	
	Interne(12 downto 0) 	<= DRAM_ADDR(12 downto 0);
	Interne(72)				<= DRAM_BA_0;
	Interne(13)				<= DRAM_BA_1;
	Interne(14)				<= DRAM_CAS_N;
	Interne(15)				<= DRAM_CKE;
	Interne(16)				<= DRAM_CLK;
	Interne(17)				<= DRAM_CS_N;
	Interne(33 downto 18)	<= DRAM_DQ(15 downto 0);
	Interne(34)				<= DRAM_LDQM;
	Interne(35)				<= DRAM_UDQM;
	Interne(36)				<= DRAM_RAS_N;
	Interne(37)				<= DRAM_WE_N;
	
	Interne(59 downto 38)	<= FL_ADDR(21 downto 0);
	Interne(60)				<= FL_CE_N;
	Interne(61)				<= FL_OE_N;
	Interne(69 downto 62)	<= FL_DQ(7 downto 0);
	Interne(96 downto 90)	<= FL_DQ(14 downto 8);
	Interne(70)				<= FL_RST_N;
	Interne(71)				<= FL_WE_N;
	Interne(192)			<= FL_DQ15_AM1;
	Interne(193)			<= FL_WP_N;
	Interne(194)			<= FL_BYTE_N;
	Interne(195)			<= FL_RY;

	Interne(73)				<= PS2_KBCLK;
	Interne(74)				<= PS2_KBDAT;
	Interne(97)				<= PS2_MSCLK;
	Interne(98)				<= PS2_MSDAT;
	
	Interne(75)				<= UART_RXD;
	Interne(76)				<= UART_TXD;
	Interne(88)				<= UART_RTS;
	Interne(99)				<= UART_CTS;
		
	Interne(77)				<= LCD_RW;
	Interne(78)				<= LCD_EN;
	Interne(79)				<= LCD_RS;
	Interne(87 downto 80)	<= LCD_DATA(7 downto 0);
	Interne(89)				<= LCD_BLON;
	
--99	
	Interne(100)			<= SD_DAT0;
	Interne(101)			<= SD_DAT3;
	Interne(102)			<= SD_CMD;
	Interne(103)			<= SD_CLK;
	Interne(196)			<= SD_WP_N;

	Interne(104)			<= GPIO0_CLKIN(0);
	Interne(105)			<= GPIO0_CLKIN(1);
	Interne(106)			<= GPIO0_CLKOUT(0);
	Interne(107)			<= GPIO0_CLKOUT(1);
	Interne(139 downto 108)	<= GPIO0_D(31 downto 0);
	
	Interne(140)			<= GPIO1_CLKIN(0);
	Interne(141)			<= GPIO1_CLKIN(1);
	Interne(142)			<= GPIO1_CLKOUT(0);
	Interne(143)			<= GPIO1_CLKOUT(1);	
	Interne(175 downto 144)	<= GPIO1_D(31 downto 0);

	--utilisation des entrées utiles aussi, 
	--ainsi si elles ne sont pas utilisées dans projet, ça ne génère pas de Warning 
	--car elles sont utilisées ici
	Interne(176)			<= CLOCK_50_2;
	Interne(177)			<= stHorloge50MHz;
	Interne(180 downto 178)	<= stv3KEY;
	Interne(190 downto 181)	<= stv10SW;	
	Interne(191)			<= stInSertARien;	
	
	SdeEt2(0)	<= Interne(0);
	RepetEt2 : for i in 0 to (iNbInutiles-1) generate
		SdeEt2(i+1) <= SdeEt2(i) and Interne(i+1);
	end generate RepetEt2 ;
	
	--affectation de ssorties inutilisées
	stSortie	<= not SdeEt2(iNbInutiles);
	stv10LEDG(9)<= SdeEt2(iNbInutiles);
	stv10LEDG(8)<= SdeEt2(iNbInutiles);
	stHEX0_DP	<= not SdeEt2(iNbInutiles);
	stHEX1_DP	<= not SdeEt2(iNbInutiles);
	stHEX2_DP	<= not SdeEt2(iNbInutiles);
	stHEX3_DP	<= not SdeEt2(iNbInutiles);
	
end FPGA_arch;





