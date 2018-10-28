library IEEE;
use IEEE.std_logic_1164.all;


entity SimplifiedMIPSProcessor is
  port(CLK       : in  std_logic;
       reset     : in  std_logic;
       rs_sel    : in  std_logic_vector(4 downto 0);
       rt_sel    : in  std_logic_vector(4 downto 0);
       reg_we    : in  std_logic;
       w_addr    : in  std_logic_vector(4 downto 0);
       reg_dest  : in  std_logic;
       immediate : in  std_logic_vector(15 downto 0);
       sel_imm   : in  std_logic;
       ALU_OP    : in  std_logic_vector(3 downto 0);
       shamt     : in  std_logic_vector(4 downto 0);
       mem_we    : in  std_logic;
       -- I added extra outputs to make testing and debuging easier.
       rs_data   : out std_logic_vector(31 downto 0);
       rt_data   : out std_logic_vector(31 downto 0);
       ALU_out   : out std_logic_vector(31 downto 0);
       dmem_out  : out std_logic_vector(31 downto 0));
end SimplifiedMIPSProcessor;



architecture dataflow of SimplifiedMIPSProcessor is

component register_file is

 generic (N : integer := 32);
  port(CLK            : in  std_logic;
       rs_sel         : in  std_logic_vector(4 downto 0); -- first read address    
       rt_sel         : in  std_logic_vector(4 downto 0); -- second read address
       w_data         : in  std_logic_vector(31 downto 0); -- write data
       w_sel          : in  std_logic_vector(4 downto 0); -- write address
       w_en           : in  std_logic; -- write enable
       reset          : in  std_logic; -- resets all registers to 0
       rs_data        : out std_logic_vector(31 downto 0); -- first read data
       rt_data        : out std_logic_vector(31 downto 0)); -- second read data


end component;

component ALU is
	port(ALU_OP        : in  std_logic_vector(3 downto 0);
		shamt         : in  std_logic_vector(4 downto 0);
		i_A           : in  std_logic_vector(31 downto 0);
		i_B           : in  std_logic_vector(31 downto 0);
		zero          : out std_logic;
		ALU_out       : out std_logic_vector(31 downto 0));

end component;

component mem is
	generic(depth_exp_of_2 	: integer := 10;
			mif_filename 	: string := "dmem.mif");
	port   (address			: IN STD_LOGIC_VECTOR (depth_exp_of_2-1 DOWNTO 0) := (OTHERS => '0');
			byteena			: IN STD_LOGIC_VECTOR (3 DOWNTO 0) := (OTHERS => '1');
			clock			: IN STD_LOGIC := '1';
			data			: IN STD_LOGIC_VECTOR (31 DOWNTO 0) := (OTHERS => '0');
			wren			: IN STD_LOGIC := '0';
			q				: OUT STD_LOGIC_VECTOR (31 DOWNTO 0));
end component;

component b32_2to1Mux is
	port(	selct 		:in std_logic;
			iA 			:in std_logic_vector(31 downto 0);
			iB 			:in std_logic_vector(31 downto 0);
			o_F			:out std_logic_vector(31 downto 0));




end component;

signal MuxtoFile : std_logic_vector(31 downto 0);
signal MuxtoAlu : std_logic_vector(31 downto 0);
signal FiletoMux : std_logic_vector(31 downto 0);
signal FiletoALU : std_logic_vector(31 downto 0);
signal AlutoMem : std_logic_vector(31 downto 0);
signal MemtoMux : std_logic_vector(31 downto 0);
constant zero : std_logic_vector(3 downto 0) := "0000"; 



begin

reg_file : register_file 
generic map (N => 32)
port map (
			CLK => CLK,          
			rs_sel => rs_sel,            
			rt_sel => rt_sel,       
			w_data => MuxtoFile,       
			w_sel => w_addr,       
			w_en => reg_we,          
			reset => reset,			
			rs_data => FiletoALU,    
			rt_data  => FiletoMux);

ALU1 : ALU 
port map(
		ALU_OP => ALU_OP,       
		shamt => shamt,       
		i_A => FiletoALU,          
		i_B => MuxtoAlu,         
		zero => open,         
		ALU_out  => AlutoMem);			

Mem1 : mem
generic map ( depth_exp_of_2  => 10,   mif_filename => "dmem.mif")
port map ( 		
				address	=> AlutoMem(9 downto 0), 	
				byteena	=> zero,	
				clock	=> CLK,		
				data	=> FiletoMux,		
				wren	=> mem_we,		
				q		=> MemtoMux);

Mux1 : b32_2to1Mux
port map( 	selct 	=> 	reg_dest,
			iA 	=> MemtoMux,		
			iB 	=> AlutoMem,		
			o_F	=> MuxtoFile);

Mux2 : b32_2to1Mux
port map (	selct 	=> 	sel_imm,
			iA 	=> FiletoMux,		
			iB(15 downto 0)	=> immediate(15 downto 0),
			iB(31 downto 16) => x"0000",
			o_F	=> MuxtoAlu);		
			
	rs_data <= 	FiletoALU;
	rt_data <= 	FiletoMux;
	ALU_out <= 	AlutoMem;
	dmem_out <= MemtoMux;
			
			
end dataflow;


