library IEEE;
use IEEE.std_logic_1164.all;

entity mux32to1 is
  port(i_sel        : in  std_logic_vector(4 downto 0);  
       i_A          : in  std_logic_vector(31 downto 0);
       i_B          : in  std_logic_vector(31 downto 0);
       i_C          : in  std_logic_vector(31 downto 0);
       i_D          : in  std_logic_vector(31 downto 0);
       i_E          : in  std_logic_vector(31 downto 0);
       i_F          : in  std_logic_vector(31 downto 0);
       i_G          : in  std_logic_vector(31 downto 0); 
       i_H          : in  std_logic_vector(31 downto 0);
       i_I          : in  std_logic_vector(31 downto 0);
       i_J          : in  std_logic_vector(31 downto 0);
       i_K          : in  std_logic_vector(31 downto 0);
       i_L          : in  std_logic_vector(31 downto 0);
       i_M          : in  std_logic_vector(31 downto 0);
       i_N          : in  std_logic_vector(31 downto 0); 
       i_O          : in  std_logic_vector(31 downto 0);
       i_P          : in  std_logic_vector(31 downto 0);
       i_Q          : in  std_logic_vector(31 downto 0);
       i_R          : in  std_logic_vector(31 downto 0);
       i_S          : in  std_logic_vector(31 downto 0);
       i_T          : in  std_logic_vector(31 downto 0);
       i_U          : in  std_logic_vector(31 downto 0); 
       i_V          : in  std_logic_vector(31 downto 0);
       i_W          : in  std_logic_vector(31 downto 0);
       i_X          : in  std_logic_vector(31 downto 0);
       i_Y          : in  std_logic_vector(31 downto 0);
       i_Z          : in  std_logic_vector(31 downto 0);
       i_AA         : in  std_logic_vector(31 downto 0);
       i_AB         : in  std_logic_vector(31 downto 0); 
       i_AC         : in  std_logic_vector(31 downto 0);
       i_AD         : in  std_logic_vector(31 downto 0); 
       i_AE         : in  std_logic_vector(31 downto 0);
       i_AF         : in  std_logic_vector(31 downto 0); 
       o_F          : out std_logic_vector(31 downto 0));   
 end mux32to1;

architecture dataflow of mux32to1 is
  
begin
  
  with i_sel select o_F <=
        i_A when "00000",
        i_B when "00001",
        i_C when "00010",
        i_D when "00011",
        i_E when "00100",
        i_F when "00101",
        i_G when "00110",
        i_H when "00111", 
        i_I when "01000",
        i_J when "01001",
        i_K when "01010",
        i_L when "01011",
        i_M when "01100",
        i_N when "01101",
        i_O when "01110",
        i_P when "01111", 
        i_Q when "10000",
        i_R when "10001",
        i_S when "10010",
        i_T when "10011",
        i_U when "10100",
        i_V when "10101",
        i_W when "10110",
        i_X when "10111", 
        i_Y when "11000",
        i_Z when "11001",
        i_AA when "11010",
        i_AB when "11011",
        i_AC when "11100",
        i_AD when "11101",
        i_AE when "11110",
        i_AF when "11111",
        x"00000000" when others;
  
end dataflow;



