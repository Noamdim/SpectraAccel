--------------------------------------------------------------------------------
-- Copyright (c) 1995-2013 Xilinx, Inc.  All rights reserved.
--------------------------------------------------------------------------------
--   ____  ____ 
--  /   /\/   / 
-- /___/  \  /    Vendor: Xilinx 
-- \   \   \/     Version : 14.7
--  \   \         Application : sch2hdl
--  /   /         Filename : DATAPATH.vhf
-- /___/   /\     Timestamp : 07/27/2026 13:17:56
-- \   \  /  \ 
--  \___\/\___\ 
--
--Command: sch2hdl -intstyle ise -family spartan6 -flat -suppress -vhdl E:/adlx/C1/try2/SOURCE_VER/DATAPATH.vhf -w E:/adlx/C1/try2/SOURCE_VER/DATAPATH.sch
--Design Name: DATAPATH
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

entity GPR_env_sch_MUSER_DATAPATH is
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
end GPR_env_sch_MUSER_DATAPATH;

architecture BEHAVIORAL of GPR_env_sch_MUSER_DATAPATH is
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



library ieee;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.ALL;
library UNISIM;
use UNISIM.Vcomponents.ALL;

entity DATAPATH is
   port ( Ace        : in    std_logic; 
          add        : in    std_logic; 
          Asel       : in    std_logic; 
          Bce        : in    std_logic; 
          Cce        : in    std_logic; 
          CLK        : in    std_logic; 
          DI         : in    std_logic_vector (31 downto 0); 
          DINTsel    : in    std_logic; 
          D_addr     : in    std_logic_vector (4 downto 0); 
          GPR_WE     : in    std_logic; 
          IRce       : in    std_logic; 
          Itype      : in    std_logic; 
          Jlink      : in    std_logic; 
          MARce      : in    std_logic; 
          MDRce      : in    std_logic; 
          MDRsel     : in    std_logic; 
          PCce       : in    std_logic; 
          RESET      : in    std_logic; 
          SHIFTce    : in    std_logic; 
          SHIFTright : in    std_logic; 
          S1sel      : in    std_logic_vector (1 downto 0); 
          S2sel      : in    std_logic_vector (1 downto 0); 
          Test       : in    std_logic; 
          AEQZ       : out   std_logic; 
          ALUF       : out   std_logic_vector (2 downto 0); 
          DO         : out   std_logic_vector (31 downto 0); 
          D_MONITOR  : out   std_logic_vector (31 downto 0); 
          IR         : out   std_logic_vector (31 downto 0); 
          MAO        : out   std_logic_vector (31 downto 0); 
          opcode     : out   std_logic_vector (5 downto 0));
end DATAPATH;

architecture BEHAVIORAL of DATAPATH is
   signal A          : std_logic_vector (31 downto 0);
   signal A_OUT      : std_logic_vector (31 downto 0);
   signal B          : std_logic_vector (31 downto 0);
   signal B_OUT      : std_logic_vector (31 downto 0);
   signal DINT       : std_logic_vector (31 downto 0);
   signal imm        : std_logic_vector (31 downto 0);
   signal MAR        : std_logic_vector (31 downto 0);
   signal PC         : std_logic_vector (31 downto 0);
   signal RD         : std_logic_vector (4 downto 0);
   signal RS1        : std_logic_vector (4 downto 0);
   signal RS2        : std_logic_vector (4 downto 0);
   signal S1         : std_logic_vector (31 downto 0);
   signal S2         : std_logic_vector (31 downto 0);
   signal XLXN_34    : std_logic_vector (31 downto 0);
   signal XLXN_38    : std_logic_vector (31 downto 0);
   signal XLXN_39    : std_logic_vector (31 downto 0);
   signal XLXN_40    : std_logic_vector (31 downto 0);
   signal XLXN_58    : std_logic_vector (31 downto 0);
   signal XLXN_60    : std_logic_vector (31 downto 0);
   signal XLXN_71    : std_logic_vector (31 downto 0);
   signal DO_DUMMY   : std_logic_vector (31 downto 0);
   signal ALUF_DUMMY : std_logic_vector (2 downto 0);
   component IR_ENV_DLX
      port ( CLK    : in    std_logic; 
             IRce   : in    std_logic; 
             Itype  : in    std_logic; 
             Jlink  : in    std_logic; 
             Din    : in    std_logic_vector (31 downto 0); 
             opcode : out   std_logic_vector (5 downto 0); 
             rs1    : out   std_logic_vector (4 downto 0); 
             rs2    : out   std_logic_vector (4 downto 0); 
             rd     : out   std_logic_vector (4 downto 0); 
             imm    : out   std_logic_vector (31 downto 0); 
             aluf   : out   std_logic_vector (2 downto 0); 
             ir     : out   std_logic_vector (31 downto 0));
   end component;
   
   component ALU_env
      port ( add     : in    std_logic; 
             test    : in    std_logic; 
             ALUf    : in    std_logic_vector (2 downto 0); 
             A       : in    std_logic_vector (31 downto 0); 
             B       : in    std_logic_vector (31 downto 0); 
             ALU_OUT : out   std_logic_vector (31 downto 0));
   end component;
   
   component shift_env
      port ( SHIFTce    : in    std_logic; 
             SHIFTright : in    std_logic; 
             SHIFT_OUT  : out   std_logic_vector (31 downto 0); 
             S1         : in    std_logic_vector (31 downto 0));
   end component;
   
   component GPR_env_sch_MUSER_DATAPATH
      port ( CLK    : in    std_logic; 
             GPR_we : in    std_logic; 
             A_adr  : in    std_logic_vector (4 downto 0); 
             B_adr  : in    std_logic_vector (4 downto 0); 
             C_adr  : in    std_logic_vector (4 downto 0); 
             D_adr  : in    std_logic_vector (4 downto 0); 
             C      : in    std_logic_vector (31 downto 0); 
             A      : out   std_logic_vector (31 downto 0); 
             B      : out   std_logic_vector (31 downto 0); 
             D      : out   std_logic_vector (31 downto 0); 
             AEQZ_O : out   std_logic);
   end component;
   
   component MUX32bit
      port ( sel : in    std_logic; 
             A   : in    std_logic_vector (31 downto 0); 
             B   : in    std_logic_vector (31 downto 0); 
             O   : out   std_logic_vector (31 downto 0));
   end component;
   
   component MMU
      port ( Din  : in    std_logic_vector (31 downto 0); 
             Dout : out   std_logic_vector (31 downto 0));
   end component;
   
   component MUX4_32bit
      port ( A   : in    std_logic_vector (31 downto 0); 
             B   : in    std_logic_vector (31 downto 0); 
             C   : in    std_logic_vector (31 downto 0); 
             D   : in    std_logic_vector (31 downto 0); 
             sel : in    std_logic_vector (1 downto 0); 
             O   : out   std_logic_vector (31 downto 0));
   end component;
   
   component REG32CE
      port ( CLK : in    std_logic; 
             CE  : in    std_logic; 
             DI  : in    std_logic_vector (31 downto 0); 
             DO  : out   std_logic_vector (31 downto 0));
   end component;
   
   component REG32RST
      port ( CLK : in    std_logic; 
             CE  : in    std_logic; 
             RST : in    std_logic; 
             DI  : in    std_logic_vector (31 downto 0); 
             DO  : out   std_logic_vector (31 downto 0));
   end component;
   
begin
   XLXN_58(31 downto 0) <= x"00000000";
   XLXN_60(31 downto 0) <= x"00000001";
   ALUF(2 downto 0) <= ALUF_DUMMY(2 downto 0);
   DO(31 downto 0) <= DO_DUMMY(31 downto 0);
   XLXI_1 : IR_ENV_DLX
      port map (CLK=>CLK,
                Din(31 downto 0)=>DI(31 downto 0),
                IRce=>IRce,
                Itype=>Itype,
                Jlink=>Jlink,
                aluf(2 downto 0)=>ALUF_DUMMY(2 downto 0),
                imm(31 downto 0)=>imm(31 downto 0),
                ir(31 downto 0)=>IR(31 downto 0),
                opcode(5 downto 0)=>opcode(5 downto 0),
                rd(4 downto 0)=>RD(4 downto 0),
                rs1(4 downto 0)=>RS1(4 downto 0),
                rs2(4 downto 0)=>RS2(4 downto 0));
   
   XLXI_2 : ALU_env
      port map (A(31 downto 0)=>S1(31 downto 0),
                add=>add,
                ALUf(2 downto 0)=>ALUF_DUMMY(2 downto 0),
                B(31 downto 0)=>S2(31 downto 0),
                test=>Test,
                ALU_OUT(31 downto 0)=>XLXN_38(31 downto 0));
   
   XLXI_3 : shift_env
      port map (SHIFTce=>SHIFTce,
                SHIFTright=>SHIFTright,
                S1(31 downto 0)=>S1(31 downto 0),
                SHIFT_OUT(31 downto 0)=>XLXN_39(31 downto 0));
   
   XLXI_4 : GPR_env_sch_MUSER_DATAPATH
      port map (A_adr(4 downto 0)=>RS1(4 downto 0),
                B_adr(4 downto 0)=>RS2(4 downto 0),
                C(31 downto 0)=>XLXN_34(31 downto 0),
                CLK=>CLK,
                C_adr(4 downto 0)=>RD(4 downto 0),
                D_adr(4 downto 0)=>D_addr(4 downto 0),
                GPR_we=>GPR_WE,
                A(31 downto 0)=>A(31 downto 0),
                AEQZ_O=>AEQZ,
                B(31 downto 0)=>B(31 downto 0),
                D(31 downto 0)=>D_MONITOR(31 downto 0));
   
   XLXI_5 : MUX32bit
      port map (A(31 downto 0)=>PC(31 downto 0),
                B(31 downto 0)=>MAR(31 downto 0),
                sel=>Asel,
                O(31 downto 0)=>XLXN_40(31 downto 0));
   
   XLXI_6 : MUX32bit
      port map (A(31 downto 0)=>XLXN_38(31 downto 0),
                B(31 downto 0)=>XLXN_39(31 downto 0),
                sel=>DINTsel,
                O(31 downto 0)=>DINT(31 downto 0));
   
   XLXI_7 : MUX32bit
      port map (A(31 downto 0)=>DINT(31 downto 0),
                B(31 downto 0)=>DI(31 downto 0),
                sel=>MDRsel,
                O(31 downto 0)=>XLXN_71(31 downto 0));
   
   XLXI_8 : MMU
      port map (Din(31 downto 0)=>XLXN_40(31 downto 0),
                Dout(31 downto 0)=>MAO(31 downto 0));
   
   XLXI_9 : MUX4_32bit
      port map (A(31 downto 0)=>B_OUT(31 downto 0),
                B(31 downto 0)=>imm(31 downto 0),
                C(31 downto 0)=>XLXN_58(31 downto 0),
                D(31 downto 0)=>XLXN_60(31 downto 0),
                sel(1 downto 0)=>S2sel(1 downto 0),
                O(31 downto 0)=>S2(31 downto 0));
   
   XLXI_10 : MUX4_32bit
      port map (A(31 downto 0)=>PC(31 downto 0),
                B(31 downto 0)=>A_OUT(31 downto 0),
                C(31 downto 0)=>B_OUT(31 downto 0),
                D(31 downto 0)=>DO_DUMMY(31 downto 0),
                sel(1 downto 0)=>S1sel(1 downto 0),
                O(31 downto 0)=>S1(31 downto 0));
   
   XLXI_11 : REG32CE
      port map (CE=>Cce,
                CLK=>CLK,
                DI(31 downto 0)=>DINT(31 downto 0),
                DO(31 downto 0)=>XLXN_34(31 downto 0));
   
   XLXI_12 : REG32CE
      port map (CE=>MDRce,
                CLK=>CLK,
                DI(31 downto 0)=>XLXN_71(31 downto 0),
                DO(31 downto 0)=>DO_DUMMY(31 downto 0));
   
   XLXI_13 : REG32CE
      port map (CE=>Bce,
                CLK=>CLK,
                DI(31 downto 0)=>B(31 downto 0),
                DO(31 downto 0)=>B_OUT(31 downto 0));
   
   XLXI_14 : REG32CE
      port map (CE=>Ace,
                CLK=>CLK,
                DI(31 downto 0)=>A(31 downto 0),
                DO(31 downto 0)=>A_OUT(31 downto 0));
   
   XLXI_16 : REG32CE
      port map (CE=>MARce,
                CLK=>CLK,
                DI(31 downto 0)=>DINT(31 downto 0),
                DO(31 downto 0)=>MAR(31 downto 0));
   
   XLXI_17 : REG32RST
      port map (CE=>PCce,
                CLK=>CLK,
                DI(31 downto 0)=>DINT(31 downto 0),
                RST=>RESET,
                DO(31 downto 0)=>PC(31 downto 0));
   
end BEHAVIORAL;


