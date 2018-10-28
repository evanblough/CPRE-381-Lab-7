library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity ALU is
  port(ALU_OP        : in  std_logic_vector(3 downto 0);
       shamt         : in  std_logic_vector(4 downto 0);
       i_A           : in  std_logic_vector(31 downto 0);
       i_B           : in  std_logic_vector(31 downto 0);
       zero          : out std_logic;
       ALU_out       : out std_logic_vector(31 downto 0));
end ALU;

Architecture mixed of ALU is 

signal s_temp : std_logic_vector(63 downto 0);

begin

  process(ALU_OP, i_A, i_B, shamt)
  
  variable int_shamt : integer;
  variable temp : std_logic_vector(63 downto 0);
  begin
    int_shamt := to_integer(unsigned(shamt));
 
    if ALU_OP = "0000" then -- addition
		temp(31 downto 0) := std_logic_vector(signed(i_A) + signed(i_B));
    end if;
    if ALU_OP = "0001" then -- subtraction
		temp(31 downto 0) := std_logic_vector(signed(i_A) - signed(i_B));
    end if;
    if ALU_OP = "0010" then -- XOR
		temp(31 downto 0) := i_A xor i_B;
    end if;
    if ALU_OP = "0011" then -- NOR
		temp(31 downto 0) := i_A nor i_B;
    end if;
    if ALU_OP = "0100" then -- NAND
		temp(31 downto 0) := i_A nand i_B;
    end if;
    if ALU_OP = "0101" then -- AND
		temp(31 downto 0) := i_A and i_B;
    end if;
    if ALU_OP = "0110" then -- OR
		temp(31 downto 0) := i_A or i_B;
    end if;
    if ALU_OP = "0111" then -- set less than (A < B)
      if (signed(i_A) < signed(i_B)) then 
        temp(0) := '1';
        temp(31 downto 1) := (others => '0');
      else 
        temp(31 downto 0) := (others => '0');
      end if;
    end if;
    if ALU_OP = "1000" then -- multiply (32-bit result only)
		temp := std_logic_vector(signed(i_A) * signed(i_B));
    end if;
    if ALU_OP = "1001" then -- shift right arithmetic
		temp(31 downto 0) := to_stdlogicvector(to_bitvector(i_A) sra int_shamt);
    end if;
    if ALU_OP = "1010" then -- shift right logical
		temp(31 downto 0) := to_stdlogicvector(to_bitvector(i_A) srl int_shamt);
    end if;  
    if ALU_OP = "1011" then -- shift left logical
        temp(31 downto 0) := to_stdlogicvector(to_bitvector(i_A) sll int_shamt);
    end if;  
	
	s_temp <= temp;
	
    if (temp(31 downto 0) = x"00000000") then -- zero flag
      zero <= '1';
    else 
      zero <= '0';
    end if;

  end process;
  
  ALU_out <= s_temp(31 downto 0);

end mixed;