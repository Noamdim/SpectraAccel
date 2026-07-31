--------------------------------------------------------------------------------
-- Copyright (c) 1995-2013 Xilinx, Inc.  All rights reserved.
--------------------------------------------------------------------------------
--   ____  ____ 
--  /   /\/   / 
-- /___/  \  /    Vendor: Xilinx 
-- \   \   \/     Version : 14.7
--  \   \         Application : sch2hdl
--  /   /         Filename : GPR_env_sch.vhf
-- /___/   /\     Timestamp : 07/27/2026 13:17:54
-- \   \  /  \ 
--  \___\/\___\ 
--
--Command: sch2hdl -intstyle ise -family spartan6 -flat -suppress -vhdl E:/adlx/C1/try2/SOURCE_VER/GPR_env_sch.vhf -w E:/adlx/C1/try2/SOURCE_VER/GPR_env_sch.sch
--Design Name: GPR_env_sch
--Device: spartan6
--Purpose:
--    This vhdl netlist is translated from an ECS schematic. It can be 
--    synthesized and simulated, but it should not be modified. 
--

library ieee;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.ALL;
library UNISIM;
use UNISIM.Vcomponents.ALL;

entity GPR_env_sch is
   port ( A_adr  : in    std_logic_vector (4 downto 0); 
          B_adr  : in    std_logic_vector (4 downto 0); 
          C      : in    std_logic_vector (31 downto 0); 
          CLK    : in    std_logic; 
          C_adr  : in    std_logic_vector (4 downto 0); 
          D_adr  : in    std_logic_vector (4 downto 0); 
          GPR_we : in    std_logic; 
          A      : out   std_logic_vector (31 downto 0); 
          AEQZ_O : out   std_logic; 
          B      : out   std_logic_vector (31 downto 0); 
          D      : out   std_logic_vector (31 downto 0));
end GPR_env_sch;

architecture BEHAVIORAL of GPR_env_sch is
   attribute BOX_TYPE   : string ;
   signal GPR_WE_RAM : std_logic;
   signal MUX_A_C    : std_logic_vector (4 downto 0);
   signal MUX_B_C    : std_logic_vector (4 downto 0);
   signal MUX_D_C    : std_logic_vector (4 downto 0);
   signal XLXN_47    : std_logic;
   signal XLXN_48    : std_logic;
   signal A_DUMMY    : std_logic_vector (31 downto 0);
   component RAM32x32
      port ( CLK  : in    std_logic; 
             WE   : in    std_logic; 
             ADDR : in    std_logic_vector (4 downto 0); 
             DI   : in    std_logic_vector (31 downto 0); 
             DO   : out   std_logic_vector (31 downto 0));
   end component;
   
   component MUX5bit
      port ( sel : in    std_logic; 
             A   : in    std_logic_vector (4 downto 0); 
             B   : in    std_logic_vector (4 downto 0); 
             O   : out   std_logic_vector (4 downto 0));
   end component;
   
   component AEQZ
      port ( DI    : in    std_logic_vector (31 downto 0); 
             A_eqz : out   std_logic);
   end component;
   
   component OR3
      port ( I0 : in    std_logic; 
             I1 : in    std_logic; 
             I2 : in    std_logic; 
             O  : out   std_logic);
   end component;
   attribute BOX_TYPE of OR3 : component is "BLACK_BOX";
   
   component AND2
      port ( I0 : in    std_logic; 
             I1 : in    std_logic; 
             O  : out   std_logic);
   end component;
   attribute BOX_TYPE of AND2 : component is "BLACK_BOX";
   
begin
   A(31 downto 0) <= A_DUMMY(31 downto 0);
   XLXI_1 : RAM32x32
      port map (ADDR(4 downto 0)=>MUX_A_C(4 downto 0),
                CLK=>CLK,
                DI(31 downto 0)=>C(31 downto 0),
                WE=>GPR_WE_RAM,
                DO(31 downto 0)=>A_DUMMY(31 downto 0));
   
   XLXI_2 : RAM32x32
      port map (ADDR(4 downto 0)=>MUX_B_C(4 downto 0),
                CLK=>CLK,
                DI(31 downto 0)=>C(31 downto 0),
                WE=>GPR_WE_RAM,
                DO(31 downto 0)=>B(31 downto 0));
   
   XLXI_3 : RAM32x32
      port map (ADDR(4 downto 0)=>MUX_D_C(4 downto 0),
                CLK=>CLK,
                DI(31 downto 0)=>C(31 downto 0),
                WE=>GPR_WE_RAM,
                DO(31 downto 0)=>D(31 downto 0));
   
   XLXI_4 : MUX5bit
      port map (A(4 downto 0)=>A_adr(4 downto 0),
                B(4 downto 0)=>C_adr(4 downto 0),
                sel=>GPR_we,
                O(4 downto 0)=>MUX_A_C(4 downto 0));
   
   XLXI_5 : MUX5bit
      port map (A(4 downto 0)=>B_adr(4 downto 0),
                B(4 downto 0)=>C_adr(4 downto 0),
                sel=>GPR_we,
                O(4 downto 0)=>MUX_B_C(4 downto 0));
   
   XLXI_6 : MUX5bit
      port map (A(4 downto 0)=>D_adr(4 downto 0),
                B(4 downto 0)=>C_adr(4 downto 0),
                sel=>GPR_we,
                O(4 downto 0)=>MUX_D_C(4 downto 0));
   
   XLXI_7 : AEQZ
      port map (DI(31 downto 0)=>A_DUMMY(31 downto 0),
                A_eqz=>AEQZ_O);
   
   XLXI_8 : OR3
      port map (I0=>C_adr(0),
                I1=>C_adr(1),
                I2=>C_adr(2),
                O=>XLXN_47);
   
   XLXI_9 : OR3
      port map (I0=>XLXN_47,
                I1=>C_adr(3),
                I2=>C_adr(4),
                O=>XLXN_48);
   
   XLXI_10 : AND2
      port map (I0=>XLXN_48,
                I1=>GPR_we,
                O=>GPR_WE_RAM);
   
end BEHAVIORAL;


