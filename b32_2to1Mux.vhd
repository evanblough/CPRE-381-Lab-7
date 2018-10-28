library IEEE;
use IEEE.std_logic_1164.all;

entity b32_2to1Mux is
	port(	selct 		:in std_logic;
			iA 			:in std_logic_vector(31 downto 0);
			iB 			:in std_logic_vector(31 downto 0);
			o_F			:out std_logic_vector(31 downto 0));
			
			
end b32_2to1Mux;

architecture dataflow of b32_2to1Mux is
begin 

o_F <= 	iA when selct = '0' else
		iB when selct = '1';





end dataflow;
