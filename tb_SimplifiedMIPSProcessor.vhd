library IEEE;
use IEEE.std_logic_1164.all;

--Usually name your testbench similar to below for clarify tb_<name>
entity tb_SimplifiedMIPSProcessor is
--Generic for half of the clock cycle period
  generic(gCLK_HPER   : time := 50 ns);  
end tb_SimplifiedMIPSProcessor;

architecture mixed of tb_SimplifiedMIPSProcessor is

--Define the total clock period time
constant cCLK_PER  : time := gCLK_HPER * 2;

--We will be making an instance of the file that we are testing
component SimplifiedMIPSProcessor is
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
end component;

-- Create signals for all of the inputs and outputs of the file that you are testing
-- := '0' or := (others => '0') just make all the signals start at an initial value of zero
signal CLK, reset, reg_we, reg_dest, sel_imm, mem_we : std_logic := '0';
signal rs_sel, rt_sel, w_addr, shamt : std_logic_vector(4 downto 0) := (others => '0');
signal ALU_OP : std_logic_vector(3 downto 0) := (others => '0');
signal immediate : std_logic_vector(15 downto 0) := (others => '0');
signal rs_data, rt_data, ALU_out, dmem_out : std_logic_vector(31 downto 0) := (others => '0');

begin

--Make an instance of the component to test and wire all signals to the corresponding
--input or output.

  MySimplifiedMIPSProcess: SimplifiedMIPSProcessor
  port map(CLK       => CLK,
           reset     => reset,
           rs_sel    => rs_sel,
           rt_sel    => rt_sel,
           reg_we    => reg_we,
           w_addr    => w_addr,
           reg_dest  => reg_dest,
           immediate => immediate,
           sel_imm   => sel_imm,
           ALU_OP    => ALU_OP,
           shamt     => shamt,
           mem_we    => mem_we,
           rs_data   => rs_data,
           rt_data   => rt_data,
           ALU_out   => ALU_out,
           dmem_out  => dmem_out);
--You can also do the above port map in one line using the below format: http://www.ics.uci.edu/~jmoorkan/vhdlref/compinst.html
--port map(CLK, reset, rs_sel, rt_sel, reg_we, w_addr, reg_dest, immediate, sel_imm, ALU_OP, shamt, mem_we, rs_data, rt_data, ALU_out, dmem_out);
  
--This first process is to automate the clock for the test bench
  P_CLK: process
  begin
    CLK <= '1';
    wait for gCLK_HPER;
    CLK <= '0';
    wait for gCLK_HPER;
  end process;

--In this process is where you set all other signals and wait for a clock cycle to allow for 
--the simulation to occur.
  P_TB : process
  begin
    --USUALLY IT IS A GOOD IDEA TO START WITH A RESET 
    reset <= '1';
    wait for cCLK_PER;
 -----------------------------------------------------------------------------------------------------------------------------------
 --Addition Test
 -----------------------------------------------------------------------------------------------------------------------------------
    --Remember only change the values on signals that are inputs to the component,
    --not to output
	--CASE 1: ADD & ADDI
    --TODO: load registers r2 and r3 with values using the immediate
	reset <= '0';
	--Load 2 with 5
	w_addr <="00010";
	immediate <= x"0005";
	sel_imm <= '1';
	ALU_OP <= "0000";
    shamt <= "00000";
	reg_we<= '1';
	reg_dest <= '1';
	wait for cCLK_PER;
	reg_we <='0';
	
	--Load 3 with 6
	w_addr <="00011";
	immediate <= x"0006";
	sel_imm <= '1';
	ALU_OP <= "0000";
    shamt <= "00000";
	reg_we<= '1';
	reg_dest <= '1';
	wait for cCLK_PER;
	reg_we <='0';
	
	
    --ADD Test: add $r1, $r2, $r3     r1 = r2+r3
    
    rs_sel <= "00010";
    rt_sel <= "00011";
    reg_we <= '1';
    w_addr <= "00001";
    reg_dest <= '1'; 
    --Note immediate in this example is 16 bits.
    --Can use other formats than binary, see below for a hex example.
    immediate <= x"0000"; 
    sel_imm <= '0';
    ALU_OP <= "0000";
    shamt <= "00000";
    mem_we <= '1';    
    wait for cCLK_PER;
	
	
	--Show t1 in sim
	rs_sel <= "00001"; --rsdata
	wait for cCLK_PER;
------------------------------------------------------------------------------------------------------------------------------
--Subtraction TEST
------------------------------------------------------------------------------------------------------------------------------	
	--Reset
	reset <= '1';
	wait for cCLK_PER;
	
	reset <= '0';
	wait for cCLK_PER;
	
	--load Immediate values
	--Load 2 with 32
	w_addr <="00010";
	immediate <= x"0020";
	sel_imm <= '1';
	ALU_OP <= "0000";
    shamt <= "00000";
	reg_we<= '1';
	reg_dest <= '1';
	wait for cCLK_PER;
	reg_we <='0';
	
	--Load 3 with 6
	w_addr <="00011";
	immediate <= x"0006";
	sel_imm <= '1';
	ALU_OP <= "0000";
    shamt <= "00000";
	reg_we<= '1';
	reg_dest <= '1';
	wait for cCLK_PER;
	reg_we <='0';
	
	--SUB test #$2-$3 =$1
	rs_sel <= "00010";
    rt_sel <= "00011";
    reg_we <= '1';
    w_addr <= "00001";
    reg_dest <= '1'; 
    --Note immediate in this example is 16 bits.
    --Can use other formats than binary, see below for a hex example.
    immediate <= x"0000"; 
    sel_imm <= '0';
    ALU_OP <= "0001";
    shamt <= "00000";
    mem_we <= '1';    
    wait for cCLK_PER;
	
	
	--Show t1 in sim
	rs_sel <= "00001"; --rsdata
	wait for cCLK_PER;
--------------------------------------------------------------------------------------------------------------------------
------Store / Load Word
--------------------------------------------------------------------------------------------------------------------------
	
	--Reset
	reset <= '1';
	wait for cCLK_PER;
	
	reset <= '0';
	wait for cCLK_PER;
	
	--
	--Store adress "6" in $r2
	--Load 2 with 32
	
	w_addr <="00010";
	immediate <= x"0006";
	sel_imm <= '1';
	ALU_OP <= "0000";
    shamt <= "00000";
	reg_we<= '1';
	reg_dest <= '1';
	wait for cCLK_PER;
	reg_we <='0';
	
	--Store data AA in r3
	w_addr <="00011";
	immediate <= x"00AA";
	sel_imm <= '1';
	ALU_OP <= "0000";
    shamt <= "00000";
	reg_we<= '1';
	reg_dest <= '1';
	wait for cCLK_PER;
	reg_we <='0';
	
	
	--SW Operation
	rs_sel <= "00010";
    rt_sel <= "00011";
    w_addr <= "00001";
    reg_dest <= '1'; 
    --Note immediate in this example is 16 bits.
    --Can use other formats than binary, see below for a hex example.
    immediate <= x"0000"; 
    sel_imm <= '1';
    ALU_OP <= "0000";
    shamt <= "00000";
    mem_we <= '1';    
    wait for cCLK_PER;
	mem_we <='0';
	
	--LW
	rs_sel <= "00010";
    rt_sel <= "00011";
    w_addr <= "00101";
    reg_dest <= '0'; 
    --Note immediate in this example is 16 bits.
    --Can use other formats than binary, see below for a hex example.
    immediate <= x"0000"; 
    sel_imm <= '1';
    ALU_OP <= "0000";
    shamt <= "00000";
	reg_we <= '1';
	wait for cCLK_PER;
	reg_we <= '0';
	
	--Display loaded value at rs data
	rs_sel <= "00101";
	wait for cCLK_PER;
	
	---------------------------------------------------------------------------------------------------------
	---SLL---------------------------------------------------------------------------------------------------
	---------------------------------------------------------------------------------------------------------
	--Reset
	reset <= '1';
	wait for cCLK_PER;
	
	reset <= '0';
	wait for cCLK_PER;
	
	----Load 2 with value 32
	w_addr <="00010";
	immediate <= x"0020";
	sel_imm <= '1';
	ALU_OP <= "0000";
    shamt <= "00000";
	reg_we<= '1';
	reg_dest <= '1';
	wait for cCLK_PER;
	reg_we <='0';
	
	--Perform shift
	rs_sel <= "00010";
    rt_sel <= "00011";
    reg_we <= '1';
    w_addr <= "00001";
    reg_dest <= '1'; 
    --Note immediate in this example is 16 bits.
    --Can use other formats than binary, see below for a hex example.
    immediate <= x"0000"; 
    sel_imm <= '1';
    ALU_OP <= "1011";
    shamt <= "00011";
    mem_we <= '1';    
    wait for cCLK_PER;
	reg_we <='0';
	
	--Display shifted value in rs data
	rs_sel <= "00001"; --rsdata
	wait for cCLK_PER;
	
	
	
	
	
	
	
	
	
	
	
    --TODO: make more tests below (hint: copy and paste and change values)

    --NOTE: There are ways to create self checking testbenches, here is a link that mentions one method:
    --      https://cseweb.ucsd.edu/classes/sp09/cse141L/Media/xapp199.pdf
    --      There may be easier methods than the one above. 
  end process;

end mixed;
