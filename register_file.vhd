library IEEE;
use IEEE.std_logic_1164.all;

entity register_file is
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
       
 end register_file;
 
 architecture structure of register_file is
   
  component register_Nbit is
  port(i_CLK        : in std_logic;     -- Clock input
       i_RST        : in std_logic;     -- Reset input
       i_WE         : in std_logic;     -- Write enable input
       i_D          : in std_logic_vector(N-1 downto 0);     -- Data value input
       o_Q          : out std_logic_vector(N-1 downto 0));   -- Data value output
 end component;
 
 component decoder5to32 is
  port(i_sel        : in std_logic_vector(4 downto 0);  
       o_F          : out std_logic_vector(31 downto 0));   
 end component;
 
 component mux32to1 is
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
 end component;
 
 signal decoder_out : std_logic_vector(31 downto 0);
 signal i_A, i_B, i_C, i_D, i_E, i_F, i_G, i_H, i_I, i_J, i_K, i_L, i_M, i_N, i_O, i_P, i_Q, i_R, i_S, i_T, i_U, i_V, i_W, i_X, i_Y, i_Z, i_AA, i_AB, i_AC, i_AD, i_AE, i_AF  : std_logic_vector(31 downto 0); 
 signal a_out : std_logic_vector(31 downto 0);
 begin
     mux_rs : mux32to1
     port map(
       i_sel  => rs_sel,  
       i_A    => i_A,
       i_B    => i_B,
       i_C    => i_C,
       i_D    => i_D,
       i_E    => i_E,
       i_F    => i_F,
       i_G    => i_G,
       i_H    => i_H,
       i_I    => i_I,
       i_J    => i_J,
       i_K    => i_K,
       i_L    => i_L,
       i_M    => i_M,
       i_N    => i_N, 
       i_O    => i_O,
       i_P    => i_P,
       i_Q    => i_Q,
       i_R    => i_R,
       i_S    => i_S,
       i_T    => i_T,
       i_U    => i_U,
       i_V    => i_V,
       i_W    => i_W,
       i_X    => i_X,
       i_Y    => i_Y,
       i_Z    => i_Z,
       i_AA   => i_AA,
       i_AB   => i_AB,
       i_AC   => i_AC,
       i_AD   => i_AD,
       i_AE   => i_AE,
       i_AF   => i_AF,
       o_F    => rs_data);
       
    mux_rt : mux32to1
    port map(
       i_sel  => rt_sel,  
       i_A    => i_A,
       i_B    => i_B,
       i_C    => i_C,
       i_D    => i_D,
       i_E    => i_E,
       i_F    => i_F,
       i_G    => i_G,
       i_H    => i_H,
       i_I    => i_I,
       i_J    => i_J,
       i_K    => i_K,
       i_L    => i_L,
       i_M    => i_M,
       i_N    => i_N, 
       i_O    => i_O,
       i_P    => i_P,
       i_Q    => i_Q,
       i_R    => i_R,
       i_S    => i_S,
       i_T    => i_T,
       i_U    => i_U,
       i_V    => i_V,
       i_W    => i_W,
       i_X    => i_X,
       i_Y    => i_Y,
       i_Z    => i_Z,
       i_AA   => i_AA,
       i_AB   => i_AB,
       i_AC   => i_AC,
       i_AD   => i_AD,
       i_AE   => i_AE,
       i_AF   => i_AF,
       o_F    => rt_data);
       
   w_decode : decoder5to32
   port map(i_sel => w_sel,
            o_F => decoder_out);
   
   G1 : for i in 0 to 31 generate
      a_out(i) <= decoder_out(i) and w_en;
   end generate;
       
   r0: register_Nbit 
   port map(i_CLK => CLK, 
            i_RST => '1',
            i_WE  => a_out(0),
            i_D   => (others => '0'),
            o_Q   => i_A); 
            
   r1: register_Nbit
   port map(i_CLK => CLK, 
            i_RST => reset,
            i_WE  => a_out(1),
            i_D   => w_data,
            o_Q   => i_B);   
  
   r2: register_Nbit
   port map(i_CLK => CLK, 
            i_RST => reset,
            i_WE  => a_out(2),
            i_D   => w_data,
            o_Q   => i_C); 
            
   r3: register_Nbit
   port map(i_CLK => CLK, 
            i_RST => reset,
            i_WE  => a_out(3),
            i_D   => w_data,
            o_Q   => i_D);   
    
   r4: register_Nbit
   port map(i_CLK => CLK, 
            i_RST => reset,
            i_WE  => a_out(4),
            i_D   => w_data,
            o_Q   => i_E); 
            
   r5: register_Nbit
   port map(i_CLK => CLK, 
            i_RST => reset,
            i_WE  => a_out(5),
            i_D   => w_data,
            o_Q   => i_F);   
  
   r6: register_Nbit
   port map(i_CLK => CLK, 
            i_RST => reset,
            i_WE  => a_out(6),
            i_D   => w_data,
            o_Q   => i_G); 
            
   r7: register_Nbit
   port map(i_CLK => CLK, 
            i_RST => reset,
            i_WE  => a_out(7),
            i_D   => w_data,
            o_Q   => i_H);    
   
   r8: register_Nbit
   port map(i_CLK => CLK, 
            i_RST => reset,
            i_WE  => a_out(8),
            i_D   => w_data,
            o_Q   => i_I); 
            
   r9: register_Nbit
   port map(i_CLK => CLK, 
            i_RST => reset,
            i_WE  => a_out(9),
            i_D   => w_data,
            o_Q   => i_J);   
  
   r10: register_Nbit
   port map(i_CLK => CLK, 
            i_RST => reset,
            i_WE  => a_out(10),
            i_D   => w_data,
            o_Q   => i_K); 
            
   r11: register_Nbit
   port map(i_CLK => CLK, 
            i_RST => reset,
            i_WE  => a_out(11),
            i_D   => w_data,
            o_Q   => i_L);   
    
   r12: register_Nbit
   port map(i_CLK => CLK, 
            i_RST => reset,
            i_WE  => a_out(12),
            i_D   => w_data,
            o_Q   => i_M); 
            
   r13: register_Nbit
   port map(i_CLK => CLK, 
            i_RST => reset,
            i_WE  => a_out(13),
            i_D   => w_data,
            o_Q   => i_N);   
  
   r14: register_Nbit
   port map(i_CLK => CLK, 
            i_RST => reset,
            i_WE  => a_out(14),
            i_D   => w_data,
            o_Q   => i_O); 
            
   r15: register_Nbit
   port map(i_CLK => CLK, 
            i_RST => reset,
            i_WE  => a_out(15),
            i_D   => w_data,
            o_Q   => i_P);    
   
   r16: register_Nbit
   port map(i_CLK => CLK, 
            i_RST => reset,
            i_WE  => a_out(16),
            i_D   => w_data,
            o_Q   => i_Q); 
            
   r17: register_Nbit
   port map(i_CLK => CLK, 
            i_RST => reset,
            i_WE  => a_out(17),
            i_D   => w_data,
            o_Q   => i_R);   
  
   r18: register_Nbit
   port map(i_CLK => CLK, 
            i_RST => reset,
            i_WE  => a_out(18),
            i_D   => w_data,
            o_Q   => i_S); 
            
   r19: register_Nbit
   port map(i_CLK => CLK, 
            i_RST => reset,
            i_WE  => a_out(19),
            i_D   => w_data,
            o_Q   => i_T);   
    
   r20: register_Nbit
   port map(i_CLK => CLK, 
            i_RST => reset,
            i_WE  => a_out(20),
            i_D   => w_data,
            o_Q   => i_U); 
            
   r21: register_Nbit
   port map(i_CLK => CLK, 
            i_RST => reset,
            i_WE  => a_out(21),
            i_D   => w_data,
            o_Q   => i_V);   
  
   r22: register_Nbit
   port map(i_CLK => CLK, 
            i_RST => reset,
            i_WE  => a_out(22),
            i_D   => w_data,
            o_Q   => i_W); 
            
   r23: register_Nbit
   port map(i_CLK => CLK, 
            i_RST => reset,
            i_WE  => a_out(23),
            i_D   => w_data,
            o_Q   => i_X);    
   
   r24: register_Nbit
   port map(i_CLK => CLK, 
            i_RST => reset,
            i_WE  => a_out(24),
            i_D   => w_data,
            o_Q   => i_Y); 
            
   r25: register_Nbit
   port map(i_CLK => CLK, 
            i_RST => reset,
            i_WE  => a_out(25),
            i_D   => w_data,
            o_Q   => i_Z);   
  
   r26: register_Nbit
   port map(i_CLK => CLK, 
            i_RST => reset,
            i_WE  => a_out(26),
            i_D   => w_data,
            o_Q   => i_AA); 
            
   r27: register_Nbit
   port map(i_CLK => CLK, 
            i_RST => reset,
            i_WE  => a_out(27),
            i_D   => w_data,
            o_Q   => i_AB);   
    
   r28: register_Nbit
   port map(i_CLK => CLK, 
            i_RST => reset,
            i_WE  => a_out(28),
            i_D   => w_data,
            o_Q   => i_AC); 
            
   r29: register_Nbit
   port map(i_CLK => CLK, 
            i_RST => reset,
            i_WE  => a_out(29),
            i_D   => w_data,
            o_Q   => i_AD);   
  
   r30: register_Nbit
   port map(i_CLK => CLK, 
            i_RST => reset,
            i_WE  => a_out(30),
            i_D   => w_data,
            o_Q   => i_AE); 
            
   r31: register_Nbit
   port map(i_CLK => CLK, 
            i_RST => reset,
            i_WE  => a_out(31),
            i_D   => w_data,
            o_Q   => i_AF);  
       
       
end structure;