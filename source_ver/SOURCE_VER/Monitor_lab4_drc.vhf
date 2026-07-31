--------------------------------------------------------------------------------
-- Copyright (c) 1995-2013 Xilinx, Inc.  All rights reserved.
--------------------------------------------------------------------------------
--   ____  ____ 
--  /   /\/   / 
-- /___/  \  /    Vendor: Xilinx 
-- \   \   \/     Version : 14.7
--  \   \         Application : sch2hdl
--  /   /         Filename : Monitor_lab4_drc.vhf
-- /___/   /\     Timestamp : 07/27/2026 11:28:29
-- \   \  /  \ 
--  \___\/\___\ 
--
--Command: C:\Xilinx\14.7\ISE_DS\ISE\bin\nt64\unwrapped\sch2hdl.exe -intstyle ise -family spartan6 -flat -suppress -vhdl Monitor_lab4_drc.vhf -w E:/adlx/C1/try2/SOURCE_VER/Monitor_lab4.sch
--Design Name: Monitor_lab4
--Device: spartan6
--Purpose:
--    This vhdl netlist is translated from an ECS schematic. It can be 
--    synthesized and simulated, but it should not be modified. 
--
----- CELL FD8RE_HXILINX_Monitor_lab4 -----


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity FD8RE_HXILINX_Monitor_lab4 is
port (
    Q   : out STD_LOGIC_VECTOR(7 downto 0) := (others => '0');

    C   : in STD_LOGIC;
    CE  : in STD_LOGIC;
    D   : in STD_LOGIC_VECTOR(7 downto 0);
    R   : in STD_LOGIC
    );
end FD8RE_HXILINX_Monitor_lab4;

architecture Behavioral of FD8RE_HXILINX_Monitor_lab4 is

begin

process(C)
begin
  if (C'event and C = '1') then
    if (R='1') then
      Q <= (others => '0');
    elsif (CE='1') then 
      Q <= D;
    end if;
  end if;
end process;


end Behavioral;


library ieee;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.ALL;
library UNISIM;
use UNISIM.Vcomponents.ALL;

entity Logic_Analyzer_MUSER_Monitor_lab4 is
   port ( AI         : in    std_logic_vector (4 downto 0); 
          CLK        : in    std_logic; 
          IN_INIT    : in    std_logic; 
          LA_Data_in : in    std_logic_vector (31 downto 0); 
          STEP_EN    : in    std_logic; 
          STOP_N     : in    std_logic; 
          D_out      : out   std_logic_vector (31 downto 0); 
          STATUS     : out   std_logic_vector (7 downto 0));
end Logic_Analyzer_MUSER_Monitor_lab4;

architecture BEHAVIORAL of Logic_Analyzer_MUSER_Monitor_lab4 is
   attribute HU_SET     : string ;
   attribute BOX_TYPE   : string ;
   signal counter_addr  : std_logic_vector (7 downto 0);
   signal IN_INIT_PULSE : std_logic;
   signal LA_Addr       : std_logic_vector (4 downto 0);
   signal LA_RUN        : std_logic;
   signal LA_WE         : std_logic;
   signal STS_CE        : std_logic;
   signal XLXN_12       : std_logic;
   signal XLXN_19       : std_logic;
   signal XLXN_20       : std_logic;
   signal XLXN_21       : std_logic;
   signal XLXN_30       : std_logic;
   component MUX5bit
      port ( sel : in    std_logic; 
             A   : in    std_logic_vector (4 downto 0); 
             B   : in    std_logic_vector (4 downto 0); 
             O   : out   std_logic_vector (4 downto 0));
   end component;
   
   component CNT5
      port ( CLK : in    std_logic; 
             RST : in    std_logic; 
             CE  : in    std_logic; 
             CNT : out   std_logic_vector (4 downto 0));
   end component;
   
   component RAM32x32
      port ( CLK  : in    std_logic; 
             WE   : in    std_logic; 
             ADDR : in    std_logic_vector (4 downto 0); 
             DI   : in    std_logic_vector (31 downto 0); 
             DO   : out   std_logic_vector (31 downto 0));
   end component;
   
   component FD8RE_HXILINX_Monitor_lab4
      port ( C  : in    std_logic; 
             CE : in    std_logic; 
             D  : in    std_logic_vector (7 downto 0); 
             R  : in    std_logic; 
             Q  : out   std_logic_vector (7 downto 0));
   end component;
   
   component FD
      generic( INIT : bit :=  '0');
      port ( C : in    std_logic; 
             D : in    std_logic; 
             Q : out   std_logic);
   end component;
   attribute BOX_TYPE of FD : component is "BLACK_BOX";
   
   component OR2
      port ( I0 : in    std_logic; 
             I1 : in    std_logic; 
             O  : out   std_logic);
   end component;
   attribute BOX_TYPE of OR2 : component is "BLACK_BOX";
   
   component INV
      port ( I : in    std_logic; 
             O : out   std_logic);
   end component;
   attribute BOX_TYPE of INV : component is "BLACK_BOX";
   
   component AND2
      port ( I0 : in    std_logic; 
             I1 : in    std_logic; 
             O  : out   std_logic);
   end component;
   attribute BOX_TYPE of AND2 : component is "BLACK_BOX";
   
   component GND
      port ( G : out   std_logic);
   end component;
   attribute BOX_TYPE of GND : component is "BLACK_BOX";
   
   attribute HU_SET of XLXI_4 : label is "XLXI_4_0";
begin
   XLXI_1 : MUX5bit
      port map (A(4 downto 0)=>AI(4 downto 0),
                B(4 downto 0)=>counter_addr(4 downto 0),
                sel=>LA_RUN,
                O(4 downto 0)=>LA_Addr(4 downto 0));
   
   XLXI_2 : CNT5
      port map (CE=>LA_WE,
                CLK=>CLK,
                RST=>STS_CE,
                CNT(4 downto 0)=>counter_addr(4 downto 0));
   
   XLXI_3 : RAM32x32
      port map (ADDR(4 downto 0)=>LA_Addr(4 downto 0),
                CLK=>CLK,
                DI(31 downto 0)=>LA_Data_in(31 downto 0),
                WE=>LA_WE,
                DO(31 downto 0)=>D_out(31 downto 0));
   
   XLXI_4 : FD8RE_HXILINX_Monitor_lab4
      port map (C=>CLK,
                CE=>STS_CE,
                D(7 downto 0)=>counter_addr(7 downto 0),
                R=>XLXN_12,
                Q(7 downto 0)=>STATUS(7 downto 0));
   
   XLXI_5 : FD
      port map (C=>CLK,
                D=>IN_INIT,
                Q=>XLXN_21);
   
   XLXI_6 : FD
      port map (C=>CLK,
                D=>IN_INIT_PULSE,
                Q=>STS_CE);
   
   XLXI_7 : OR2
      port map (I0=>STEP_EN,
                I1=>XLXN_19,
                O=>XLXN_20);
   
   XLXI_8 : OR2
      port map (I0=>IN_INIT_PULSE,
                I1=>XLXN_20,
                O=>LA_RUN);
   
   XLXI_9 : INV
      port map (I=>IN_INIT,
                O=>XLXN_19);
   
   XLXI_10 : INV
      port map (I=>XLXN_21,
                O=>XLXN_30);
   
   XLXI_11 : AND2
      port map (I0=>STOP_N,
                I1=>LA_RUN,
                O=>LA_WE);
   
   XLXI_12 : AND2
      port map (I0=>IN_INIT,
                I1=>XLXN_30,
                O=>IN_INIT_PULSE);
   
   XLXI_13 : GND
      port map (G=>XLXN_12);
   
   XLXI_14 : GND
      port map (G=>counter_addr(7));
   
   XLXI_29 : GND
      port map (G=>counter_addr(6));
   
   XLXI_30 : GND
      port map (G=>counter_addr(5));
   
end BEHAVIORAL;



library ieee;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.ALL;
library UNISIM;
use UNISIM.Vcomponents.ALL;

entity Monitor_lab4 is
   port ( AI          : in    std_logic_vector (9 downto 0); 
          B           : in    std_logic_vector (31 downto 0); 
          C           : in    std_logic_vector (31 downto 0); 
          CARD_SEL    : in    std_logic; 
          CLK         : in    std_logic; 
          IN_INIT     : in    std_logic; 
          LA_Data_in  : in    std_logic_vector (31 downto 0); 
          RESET       : in    std_logic; 
          STEP_EN     : in    std_logic; 
          STOP_N      : in    std_logic; 
          WR_IN_N     : in    std_logic; 
          reg_address : out   std_logic_vector (4 downto 0); 
          SACK_N      : out   std_logic; 
          SDO         : out   std_logic_vector (31 downto 0));
end Monitor_lab4;

architecture BEHAVIORAL of Monitor_lab4 is
   signal D_out       : std_logic_vector (31 downto 0);
   signal ID_NAME     : std_logic_vector (7 downto 0);
   signal STATUS      : std_logic_vector (7 downto 0);
   signal Status_id   : std_logic_vector (31 downto 0);
   component Logic_Analyzer_MUSER_Monitor_lab4
      port ( CLK        : in    std_logic; 
             LA_Data_in : in    std_logic_vector (31 downto 0); 
             AI         : in    std_logic_vector (4 downto 0); 
             STOP_N     : in    std_logic; 
             STEP_EN    : in    std_logic; 
             IN_INIT    : in    std_logic; 
             D_out      : out   std_logic_vector (31 downto 0); 
             STATUS     : out   std_logic_vector (7 downto 0));
   end component;
   
   component slave_mux
      port ( WR_IN_N     : in    std_logic; 
             CARD_SEL    : in    std_logic; 
             clk         : in    std_logic; 
             reset       : in    std_logic; 
             AI          : in    std_logic_vector (9 downto 0); 
             a           : in    std_logic_vector (31 downto 0); 
             b           : in    std_logic_vector (31 downto 0); 
             c           : in    std_logic_vector (31 downto 0); 
             d           : in    std_logic_vector (31 downto 0); 
             SACK_N      : out   std_logic; 
             SDO         : out   std_logic_vector (31 downto 0); 
             reg_address : out   std_logic_vector (4 downto 0));
   end component;
   
   component ID_name_1
      port ( ID_name_1 : out   std_logic_vector (7 downto 0));
   end component;
   
   component concat_8_bit
      port ( in_1        : in    std_logic_vector (7 downto 0); 
             in_2        : in    std_logic_vector (7 downto 0); 
             concat_out1 : out   std_logic_vector (31 downto 0));
   end component;
   
begin
   XLXI_1 : Logic_Analyzer_MUSER_Monitor_lab4
      port map (AI(4 downto 0)=>AI(4 downto 0),
                CLK=>CLK,
                IN_INIT=>IN_INIT,
                LA_Data_in(31 downto 0)=>LA_Data_in(31 downto 0),
                STEP_EN=>STEP_EN,
                STOP_N=>STOP_N,
                D_out(31 downto 0)=>D_out(31 downto 0),
                STATUS(7 downto 0)=>STATUS(7 downto 0));
   
   XLXI_3 : slave_mux
      port map (a(31 downto 0)=>D_out(31 downto 0),
                AI(9 downto 0)=>AI(9 downto 0),
                b(31 downto 0)=>B(31 downto 0),
                c(31 downto 0)=>C(31 downto 0),
                CARD_SEL=>CARD_SEL,
                clk=>CLK,
                d(31 downto 0)=>Status_id(31 downto 0),
                reset=>RESET,
                WR_IN_N=>WR_IN_N,
                reg_address(4 downto 0)=>reg_address(4 downto 0),
                SACK_N=>SACK_N,
                SDO(31 downto 0)=>SDO(31 downto 0));
   
   XLXI_4 : ID_name_1
      port map (ID_name_1(7 downto 0)=>ID_NAME(7 downto 0));
   
   XLXI_10 : concat_8_bit
      port map (in_1(7 downto 0)=>STATUS(7 downto 0),
                in_2(7 downto 0)=>ID_NAME(7 downto 0),
                concat_out1(31 downto 0)=>Status_id(31 downto 0));
   
end BEHAVIORAL;


