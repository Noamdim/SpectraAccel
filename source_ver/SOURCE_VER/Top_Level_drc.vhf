--------------------------------------------------------------------------------
-- Copyright (c) 1995-2013 Xilinx, Inc.  All rights reserved.
--------------------------------------------------------------------------------
--   ____  ____ 
--  /   /\/   / 
-- /___/  \  /    Vendor: Xilinx 
-- \   \   \/     Version : 14.7
--  \   \         Application : sch2hdl
--  /   /         Filename : Top_Level_drc.vhf
-- /___/   /\     Timestamp : 07/27/2026 13:17:35
-- \   \  /  \ 
--  \___\/\___\ 
--
--Command: C:\Xilinx\14.7\ISE_DS\ISE\bin\nt64\unwrapped\sch2hdl.exe -intstyle ise -family spartan6 -flat -suppress -vhdl Top_Level_drc.vhf -w E:/adlx/C1/try2/SOURCE_VER/Top_Level.sch
--Design Name: Top_Level
--Device: spartan6
--Purpose:
--    This vhdl netlist is translated from an ECS schematic. It can be 
--    synthesized and simulated, but it should not be modified. 
--
----- CELL FD8RE_HXILINX_Top_Level -----


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity FD8RE_HXILINX_Top_Level is
port (
    Q   : out STD_LOGIC_VECTOR(7 downto 0) := (others => '0');

    C   : in STD_LOGIC;
    CE  : in STD_LOGIC;
    D   : in STD_LOGIC_VECTOR(7 downto 0);
    R   : in STD_LOGIC
    );
end FD8RE_HXILINX_Top_Level;

architecture Behavioral of FD8RE_HXILINX_Top_Level is

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

entity Logic_Analyzer_MUSER_Top_Level is
   port ( AI         : in    std_logic_vector (4 downto 0); 
          CLK        : in    std_logic; 
          IN_INIT    : in    std_logic; 
          LA_Data_in : in    std_logic_vector (31 downto 0); 
          STEP_EN    : in    std_logic; 
          STOP_N     : in    std_logic; 
          D_out      : out   std_logic_vector (31 downto 0); 
          STATUS     : out   std_logic_vector (7 downto 0));
end Logic_Analyzer_MUSER_Top_Level;

architecture BEHAVIORAL of Logic_Analyzer_MUSER_Top_Level is
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
   
   component FD8RE_HXILINX_Top_Level
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
   
   XLXI_4 : FD8RE_HXILINX_Top_Level
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

entity Monitor_lab4_MUSER_Top_Level is
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
end Monitor_lab4_MUSER_Top_Level;

architecture BEHAVIORAL of Monitor_lab4_MUSER_Top_Level is
   signal D_out       : std_logic_vector (31 downto 0);
   signal ID_NAME     : std_logic_vector (7 downto 0);
   signal STATUS      : std_logic_vector (7 downto 0);
   signal Status_id   : std_logic_vector (31 downto 0);
   component Logic_Analyzer_MUSER_Top_Level
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
   XLXI_1 : Logic_Analyzer_MUSER_Top_Level
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



library ieee;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.ALL;
library UNISIM;
use UNISIM.Vcomponents.ALL;

entity Top_Level is
   port ( fpgaClk_i : in    std_logic; 
          sdClkFb_i : in    std_logic; 
          sdAddr_o  : out   std_logic_vector (12 downto 0); 
          sdBs_o    : out   std_logic_vector (1 downto 0); 
          sdCas_bo  : out   std_logic; 
          sdCe_bo   : out   std_logic; 
          sdCke_o   : out   std_logic; 
          sdClk_o   : out   std_logic; 
          sdDqmh_o  : out   std_logic; 
          sdDqml_o  : out   std_logic; 
          sdRas_bo  : out   std_logic; 
          sdWe_bo   : out   std_logic; 
          sdData_io : inout std_logic_vector (15 downto 0));
end Top_Level;

architecture BEHAVIORAL of Top_Level is
   attribute BOX_TYPE   : string ;
   signal accel_active   : std_logic;
   signal ACK_N          : std_logic;
   signal AI             : std_logic_vector (9 downto 0);
   signal AS_N           : std_logic;
   signal Card_Sel       : std_logic;
   signal classify_pulse : std_logic;
   signal CLK            : std_logic;
   signal dlx_ACK_N      : std_logic;
   signal dlx_AS_N       : std_logic;
   signal dlx_MAO        : std_logic_vector (31 downto 0);
   signal dlx_MDO        : std_logic_vector (31 downto 0);
   signal dlx_WR_OUT_N   : std_logic;
   signal DO             : std_logic_vector (31 downto 0);
   signal D_GPR          : std_logic_vector (31 downto 0);
   signal IN_INIT        : std_logic;
   signal LA_DATA_IN     : std_logic_vector (31 downto 0);
   signal MAO            : std_logic_vector (31 downto 0);
   signal MDO            : std_logic_vector (31 downto 0);
   signal RACK_N         : std_logic;
   signal REG_ADDR       : std_logic_vector (4 downto 0);
   signal RESET          : std_logic;
   signal Rsel           : std_logic;
   signal R_DO           : std_logic_vector (31 downto 0);
   signal SACK_N         : std_logic;
   signal SACK_N_ACCEL   : std_logic;
   signal SACK_N_MON     : std_logic;
   signal sc_ACK_N       : std_logic;
   signal sc_AS_N        : std_logic;
   signal sc_MAO         : std_logic_vector (31 downto 0);
   signal sc_MDO         : std_logic_vector (31 downto 0);
   signal sc_WR_OUT_N    : std_logic;
   signal SDO            : std_logic_vector (31 downto 0);
   signal SDO_ACCEL      : std_logic_vector (31 downto 0);
   signal SDO_MON        : std_logic_vector (31 downto 0);
   signal STEP_EN        : std_logic;
   signal STOP_N         : std_logic;
   signal WR_IN_N        : std_logic;
   signal WR_OUT_N       : std_logic;
   signal XLXN_41        : std_logic_vector (1 downto 0);
   signal XLXN_42        : std_logic_vector (4 downto 0);
   component IO_LOGIC_U
      port ( AS_N_i    : in    std_logic; 
             fpgaClk_i : in    std_logic; 
             in_init_i : in    std_logic; 
             RACK_N_i  : in    std_logic; 
             SACK_N_i  : in    std_logic; 
             sdClkFb_i : in    std_logic; 
             WR_N_i    : in    std_logic; 
             MA_i      : in    std_logic_vector (31 downto 0); 
             MD_i      : in    std_logic_vector (31 downto 0); 
             RD_i      : in    std_logic_vector (31 downto 0); 
             SD_i      : in    std_logic_vector (31 downto 0); 
             CLK       : out   std_logic; 
             MACK_N_o  : out   std_logic; 
             RESET     : out   std_logic; 
             Rsel_o    : out   std_logic; 
             sdCas_bo  : out   std_logic; 
             sdCe_bo   : out   std_logic; 
             sdCke_o   : out   std_logic; 
             sdClk_o   : out   std_logic; 
             sdDqmh_o  : out   std_logic; 
             sdDqml_o  : out   std_logic; 
             sdRas_bo  : out   std_logic; 
             sdWe_bo   : out   std_logic; 
             Ssel_o    : out   std_logic; 
             step_en_o : out   std_logic; 
             WR_N_o    : out   std_logic; 
             A_o       : out   std_logic_vector (9 downto 0); 
             DO        : out   std_logic_vector (31 downto 0); 
             sdAddr_o  : out   std_logic_vector (12 downto 0); 
             sdBs_o    : out   std_logic_vector (1 downto 0); 
             sdData_io : inout std_logic_vector (15 downto 0));
   end component;
   
   component DLX_Wrapper
      port ( CLK            : in    std_logic; 
             RESET          : in    std_logic; 
             ACK_N          : in    std_logic; 
             STEP_EN        : in    std_logic; 
             DI             : in    std_logic_vector (31 downto 0); 
             D_addr         : in    std_logic_vector (4 downto 0); 
             AS_N           : out   std_logic; 
             WR_OUT_N       : out   std_logic; 
             classify_pulse : out   std_logic; 
             STOP_N         : out   std_logic; 
             IN_INIT        : out   std_logic; 
             MAO            : out   std_logic_vector (31 downto 0); 
             DO             : out   std_logic_vector (31 downto 0); 
             ctrl_dlx_state : out   std_logic_vector (4 downto 0); 
             MAC_STATE      : out   std_logic_vector (1 downto 0); 
             D_MONITOR      : out   std_logic_vector (31 downto 0); 
             LA_DATA_IN     : out   std_logic_vector (31 downto 0));
   end component;
   
   component Accelerator_Subsystem
      port ( CLK            : in    std_logic; 
             RESET          : in    std_logic; 
             Card_Sel       : in    std_logic; 
             WR_IN_N        : in    std_logic; 
             sc_ack_n       : in    std_logic; 
             classify_pulse : in    std_logic; 
             AI             : in    std_logic_vector (9 downto 0); 
             MDO_muxed      : in    std_logic_vector (31 downto 0); 
             DO             : in    std_logic_vector (31 downto 0); 
             MDO            : in    std_logic_vector (31 downto 0); 
             MAO            : in    std_logic_vector (31 downto 0); 
             SACK_N_ACCEL   : out   std_logic; 
             sc_AS_N        : out   std_logic; 
             sc_WR_OUT_N    : out   std_logic; 
             accel_active   : out   std_logic; 
             SDO_ACCEL      : out   std_logic_vector (31 downto 0); 
             sc_MAO         : out   std_logic_vector (31 downto 0); 
             sc_MDO         : out   std_logic_vector (31 downto 0));
   end component;
   
   component Monitor_lab4_MUSER_Top_Level
      port ( IN_INIT     : in    std_logic; 
             B           : in    std_logic_vector (31 downto 0); 
             C           : in    std_logic_vector (31 downto 0); 
             CLK         : in    std_logic; 
             RESET       : in    std_logic; 
             AI          : in    std_logic_vector (9 downto 0); 
             LA_Data_in  : in    std_logic_vector (31 downto 0); 
             STOP_N      : in    std_logic; 
             STEP_EN     : in    std_logic; 
             WR_IN_N     : in    std_logic; 
             CARD_SEL    : in    std_logic; 
             SACK_N      : out   std_logic; 
             SDO         : out   std_logic_vector (31 downto 0); 
             reg_address : out   std_logic_vector (4 downto 0));
   end component;
   
   component bus_master_mux
      port ( accel_active   : in    std_logic; 
             dlx_AS_N       : in    std_logic; 
             dlx_WR_OUT_N   : in    std_logic; 
             sc_AS_N        : in    std_logic; 
             sc_WR_OUT_N    : in    std_logic; 
             ACK_N_raw      : in    std_logic; 
             dlx_MAO        : in    std_logic_vector (31 downto 0); 
             dlx_MDO        : in    std_logic_vector (31 downto 0); 
             sc_MAO         : in    std_logic_vector (31 downto 0); 
             sc_MDO         : in    std_logic_vector (31 downto 0); 
             dlx_ACK_N      : out   std_logic; 
             sc_ack_n       : out   std_logic; 
             AS_N_muxed     : out   std_logic; 
             WR_OUT_N_muxed : out   std_logic; 
             MAO_muxed      : out   std_logic_vector (31 downto 0); 
             MDO_muxed      : out   std_logic_vector (31 downto 0); 
             AI             : in    std_logic_vector (9 downto 0); 
             SDO_MON        : in    std_logic_vector (31 downto 0); 
             SDO_ACCEL      : in    std_logic_vector (31 downto 0); 
             SDO_final      : out   std_logic_vector (31 downto 0));
   end component;
   
   component AND2
      port ( I0 : in    std_logic; 
             I1 : in    std_logic; 
             O  : out   std_logic);
   end component;
   attribute BOX_TYPE of AND2 : component is "BLACK_BOX";
   
begin
   XLXI_23 : IO_LOGIC_U
      port map (AS_N_i=>AS_N,
                fpgaClk_i=>fpgaClk_i,
                in_init_i=>IN_INIT,
                MA_i(31 downto 0)=>MAO(31 downto 0),
                MD_i(31 downto 0)=>MDO(31 downto 0),
                RACK_N_i=>RACK_N,
                RD_i(31 downto 0)=>R_DO(31 downto 0),
                SACK_N_i=>SACK_N,
                sdClkFb_i=>sdClkFb_i,
                SD_i(31 downto 0)=>SDO(31 downto 0),
                WR_N_i=>WR_OUT_N,
                A_o(9 downto 0)=>AI(9 downto 0),
                CLK=>CLK,
                DO(31 downto 0)=>DO(31 downto 0),
                MACK_N_o=>ACK_N,
                RESET=>RESET,
                Rsel_o=>Rsel,
                sdAddr_o(12 downto 0)=>sdAddr_o(12 downto 0),
                sdBs_o(1 downto 0)=>sdBs_o(1 downto 0),
                sdCas_bo=>sdCas_bo,
                sdCe_bo=>sdCe_bo,
                sdCke_o=>sdCke_o,
                sdClk_o=>sdClk_o,
                sdDqmh_o=>sdDqmh_o,
                sdDqml_o=>sdDqml_o,
                sdRas_bo=>sdRas_bo,
                sdWe_bo=>sdWe_bo,
                Ssel_o=>Card_Sel,
                step_en_o=>STEP_EN,
                WR_N_o=>WR_IN_N,
                sdData_io(15 downto 0)=>sdData_io(15 downto 0));
   
   XLXI_32 : DLX_Wrapper
      port map (ACK_N=>dlx_ACK_N,
                CLK=>CLK,
                DI(31 downto 0)=>DO(31 downto 0),
                D_addr(4 downto 0)=>REG_ADDR(4 downto 0),
                RESET=>RESET,
                STEP_EN=>STEP_EN,
                AS_N=>dlx_AS_N,
                classify_pulse=>classify_pulse,
                ctrl_dlx_state(4 downto 0)=>XLXN_42(4 downto 0),
                DO(31 downto 0)=>dlx_MDO(31 downto 0),
                D_MONITOR(31 downto 0)=>D_GPR(31 downto 0),
                IN_INIT=>IN_INIT,
                LA_DATA_IN(31 downto 0)=>LA_DATA_IN(31 downto 0),
                MAC_STATE(1 downto 0)=>XLXN_41(1 downto 0),
                MAO(31 downto 0)=>dlx_MAO(31 downto 0),
                STOP_N=>STOP_N,
                WR_OUT_N=>dlx_WR_OUT_N);
   
   XLXI_33 : Accelerator_Subsystem
      port map (AI(9 downto 0)=>AI(9 downto 0),
                Card_Sel=>Card_Sel,
                classify_pulse=>classify_pulse,
                CLK=>CLK,
                DO(31 downto 0)=>DO(31 downto 0),
                MAO(31 downto 0)=>MAO(31 downto 0),
                MDO(31 downto 0)=>MDO(31 downto 0),
                MDO_muxed(31 downto 0)=>MDO(31 downto 0),
                RESET=>RESET,
                sc_ack_n=>sc_ACK_N,
                WR_IN_N=>WR_IN_N,
                accel_active=>accel_active,
                SACK_N_ACCEL=>SACK_N_ACCEL,
                sc_AS_N=>sc_AS_N,
                sc_MAO(31 downto 0)=>sc_MAO(31 downto 0),
                sc_MDO(31 downto 0)=>sc_MDO(31 downto 0),
                sc_WR_OUT_N=>sc_WR_OUT_N,
                SDO_ACCEL(31 downto 0)=>SDO_ACCEL(31 downto 0));
   
   XLXI_34 : Monitor_lab4_MUSER_Top_Level
      port map (AI(9 downto 0)=>AI(9 downto 0),
                B(31 downto 0)=>dlx_MAO(31 downto 0),
                C(31 downto 0)=>D_GPR(31 downto 0),
                CARD_SEL=>Card_Sel,
                CLK=>CLK,
                IN_INIT=>IN_INIT,
                LA_Data_in(31 downto 0)=>LA_DATA_IN(31 downto 0),
                RESET=>RESET,
                STEP_EN=>STEP_EN,
                STOP_N=>STOP_N,
                WR_IN_N=>WR_IN_N,
                reg_address(4 downto 0)=>REG_ADDR(4 downto 0),
                SACK_N=>SACK_N_MON,
                SDO(31 downto 0)=>SDO_MON(31 downto 0));
   
   XLXI_35 : bus_master_mux
      port map (accel_active=>accel_active,
                ACK_N_raw=>ACK_N,
                AI(9 downto 0)=>AI(9 downto 0),
                dlx_AS_N=>dlx_AS_N,
                dlx_MAO(31 downto 0)=>dlx_MAO(31 downto 0),
                dlx_MDO(31 downto 0)=>dlx_MDO(31 downto 0),
                dlx_WR_OUT_N=>dlx_WR_OUT_N,
                sc_AS_N=>sc_AS_N,
                sc_MAO(31 downto 0)=>sc_MAO(31 downto 0),
                sc_MDO(31 downto 0)=>sc_MDO(31 downto 0),
                sc_WR_OUT_N=>sc_WR_OUT_N,
                SDO_ACCEL(31 downto 0)=>SDO_ACCEL(31 downto 0),
                SDO_MON(31 downto 0)=>SDO_MON(31 downto 0),
                AS_N_muxed=>AS_N,
                dlx_ACK_N=>dlx_ACK_N,
                MAO_muxed(31 downto 0)=>MAO(31 downto 0),
                MDO_muxed(31 downto 0)=>MDO(31 downto 0),
                sc_ack_n=>sc_ACK_N,
                SDO_final(31 downto 0)=>SDO(31 downto 0),
                WR_OUT_N_muxed=>WR_OUT_N);
   
   XLXI_37 : AND2
      port map (I0=>SACK_N_MON,
                I1=>SACK_N_ACCEL,
                O=>SACK_N);
   
end BEHAVIORAL;


