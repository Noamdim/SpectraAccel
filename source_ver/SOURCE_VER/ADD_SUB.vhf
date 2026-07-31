--------------------------------------------------------------------------------
-- Copyright (c) 1995-2013 Xilinx, Inc.  All rights reserved.
--------------------------------------------------------------------------------
--   ____  ____ 
--  /   /\/   / 
-- /___/  \  /    Vendor: Xilinx 
-- \   \   \/     Version : 14.7
--  \   \         Application : sch2hdl
--  /   /         Filename : ADD_SUB.vhf
-- /___/   /\     Timestamp : 07/27/2026 13:17:53
-- \   \  /  \ 
--  \___\/\___\ 
--
--Command: sch2hdl -intstyle ise -family spartan6 -flat -suppress -vhdl E:/adlx/C1/try2/SOURCE_VER/ADD_SUB.vhf -w E:/adlx/C1/try2/SOURCE_VER/ADD_SUB.sch
--Design Name: ADD_SUB
--Device: spartan6
--Purpose:
--    This vhdl netlist is translated from an ECS schematic. It can be 
--    synthesized and simulated, but it should not be modified. 
--
----- CELL M2_1_HXILINX_ADD_SUB -----
  
library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity M2_1_HXILINX_ADD_SUB is
  
port(
    O   : out std_logic;

    D0  : in std_logic;
    D1  : in std_logic;
    S0  : in std_logic
  );
end M2_1_HXILINX_ADD_SUB;

architecture M2_1_HXILINX_ADD_SUB_V of M2_1_HXILINX_ADD_SUB is
begin
  process (D0, D1, S0)
  begin
    case S0 is
    when '0' => O <= D0;
    when '1' => O <= D1;
    when others => NULL;
    end case;
    end process; 
end M2_1_HXILINX_ADD_SUB_V;
----- CELL ADSU16_HXILINX_ADD_SUB -----
  
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity ADSU16_HXILINX_ADD_SUB is
port(
    CO   : out std_logic;
    OFL  : out std_logic;
    S    : out std_logic_vector(15 downto 0);

    A    : in std_logic_vector(15 downto 0);
    ADD  : in std_logic;
    B    : in std_logic_vector(15 downto 0);
    CI   : in std_logic
  );
end ADSU16_HXILINX_ADD_SUB;

architecture ADSU16_HXILINX_ADD_SUB_V of ADSU16_HXILINX_ADD_SUB is

begin
  adsu_p : process (A, ADD, B, CI)
    variable adsu_tmp : std_logic_vector(16 downto 0);
  begin
    if(ADD = '1') then
     adsu_tmp := conv_std_logic_vector((conv_integer(A) + conv_integer(B) + conv_integer(CI)),17);
    else
     adsu_tmp := conv_std_logic_vector((conv_integer(A) - conv_integer(not CI) - conv_integer(B)),17);
  end if;
      
  S   <= adsu_tmp(15 downto 0);
   
  if (ADD='1') then
    CO <= adsu_tmp(16);
    OFL <=  ( A(15) and B(15) and (not adsu_tmp(15)) ) or ( (not A(15)) and (not B(15)) and adsu_tmp(15) );  
  else
    CO <= not adsu_tmp(16);
    OFL <=  ( A(15) and (not B(15)) and (not adsu_tmp(15)) ) or ( (not A(15)) and B(15) and adsu_tmp(15) );  
  end if;
 
  end process;
  
end ADSU16_HXILINX_ADD_SUB_V;

library ieee;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.ALL;
library UNISIM;
use UNISIM.Vcomponents.ALL;

entity ADD_SUB is
   port ( A      : in    std_logic_vector (31 downto 0); 
          B      : in    std_logic_vector (31 downto 0); 
          sub    : in    std_logic; 
          neg    : out   std_logic; 
          ovf    : out   std_logic; 
          result : out   std_logic_vector (31 downto 0));
end ADD_SUB;

architecture BEHAVIORAL of ADD_SUB is
   attribute HU_SET     : string ;
   attribute BOX_TYPE   : string ;
   signal ADD                : std_logic;
   signal carry_out          : std_logic;
   signal carry_out_cin_high : std_logic;
   signal carry_out_cin_low  : std_logic;
   signal carry_out_real     : std_logic;
   signal XLXN_34            : std_logic;
   signal XLXN_35            : std_logic;
   signal XLXN_36            : std_logic_vector (15 downto 0);
   signal XLXN_37            : std_logic_vector (15 downto 0);
   signal XLXN_51            : std_logic;
   component ADSU16_HXILINX_ADD_SUB
      port ( A   : in    std_logic_vector (15 downto 0); 
             ADD : in    std_logic; 
             B   : in    std_logic_vector (15 downto 0); 
             CI  : in    std_logic; 
             CO  : out   std_logic; 
             OFL : out   std_logic; 
             S   : out   std_logic_vector (15 downto 0));
   end component;
   
   component INV
      port ( I : in    std_logic; 
             O : out   std_logic);
   end component;
   attribute BOX_TYPE of INV : component is "BLACK_BOX";
   
   component VCC
      port ( P : out   std_logic);
   end component;
   attribute BOX_TYPE of VCC : component is "BLACK_BOX";
   
   component GND
      port ( G : out   std_logic);
   end component;
   attribute BOX_TYPE of GND : component is "BLACK_BOX";
   
   component MUX16bit
      port ( sel : in    std_logic; 
             A   : in    std_logic_vector (15 downto 0); 
             B   : in    std_logic_vector (15 downto 0); 
             O   : out   std_logic_vector (15 downto 0));
   end component;
   
   component BUF
      port ( I : in    std_logic; 
             O : out   std_logic);
   end component;
   attribute BOX_TYPE of BUF : component is "BLACK_BOX";
   
   component M2_1_HXILINX_ADD_SUB
      port ( D0 : in    std_logic; 
             D1 : in    std_logic; 
             S0 : in    std_logic; 
             O  : out   std_logic);
   end component;
   
   component XOR4
      port ( I0 : in    std_logic; 
             I1 : in    std_logic; 
             I2 : in    std_logic; 
             I3 : in    std_logic; 
             O  : out   std_logic);
   end component;
   attribute BOX_TYPE of XOR4 : component is "BLACK_BOX";
   
   attribute HU_SET of XLXI_1 : label is "XLXI_1_1";
   attribute HU_SET of XLXI_2 : label is "XLXI_2_2";
   attribute HU_SET of XLXI_3 : label is "XLXI_3_3";
   attribute HU_SET of XLXI_17 : label is "XLXI_17_4";
begin
   XLXI_1 : ADSU16_HXILINX_ADD_SUB
      port map (A(15 downto 0)=>A(15 downto 0),
                ADD=>ADD,
                B(15 downto 0)=>B(15 downto 0),
                CI=>sub,
                CO=>carry_out,
                OFL=>open,
                S(15 downto 0)=>result(15 downto 0));
   
   XLXI_2 : ADSU16_HXILINX_ADD_SUB
      port map (A(15 downto 0)=>A(31 downto 16),
                ADD=>ADD,
                B(15 downto 0)=>B(31 downto 16),
                CI=>XLXN_35,
                CO=>carry_out_cin_low,
                OFL=>open,
                S(15 downto 0)=>XLXN_36(15 downto 0));
   
   XLXI_3 : ADSU16_HXILINX_ADD_SUB
      port map (A(15 downto 0)=>A(31 downto 16),
                ADD=>ADD,
                B(15 downto 0)=>B(31 downto 16),
                CI=>XLXN_34,
                CO=>carry_out_cin_high,
                OFL=>open,
                S(15 downto 0)=>XLXN_37(15 downto 0));
   
   XLXI_4 : INV
      port map (I=>sub,
                O=>ADD);
   
   XLXI_9 : VCC
      port map (P=>XLXN_34);
   
   XLXI_10 : GND
      port map (G=>XLXN_35);
   
   XLXI_11 : MUX16bit
      port map (A(15 downto 0)=>XLXN_36(15 downto 0),
                B(15 downto 0)=>XLXN_37(15 downto 0),
                sel=>carry_out,
                O(15 downto 0)=>result(31 downto 16));
   
   XLXI_12 : BUF
      port map (I=>XLXN_51,
                O=>neg);
   
   XLXI_17 : M2_1_HXILINX_ADD_SUB
      port map (D0=>carry_out_cin_low,
                D1=>carry_out_cin_high,
                S0=>carry_out,
                O=>carry_out_real);
   
   XLXI_18 : XOR4
      port map (I0=>sub,
                I1=>carry_out_real,
                I2=>B(31),
                I3=>A(31),
                O=>XLXN_51);
   
end BEHAVIORAL;


