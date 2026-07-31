<?xml version="1.0" encoding="UTF-8"?>
<drawing version="7">
    <attr value="spartan6" name="DeviceFamilyName">
        <trait delete="all:0" />
        <trait editname="all:0" />
        <trait edittrait="all:0" />
    </attr>
    <netlist>
        <signal name="RESET" />
        <signal name="CLK" />
        <signal name="IRce" />
        <signal name="Bce" />
        <signal name="Ace" />
        <signal name="Cce" />
        <signal name="MARce" />
        <signal name="PCce" />
        <signal name="MDRce" />
        <signal name="Itype" />
        <signal name="Jlink" />
        <signal name="D_addr(4:0)" />
        <signal name="S2sel(1:0)" />
        <signal name="GPR_WE" />
        <signal name="add" />
        <signal name="Test" />
        <signal name="SHIFTce" />
        <signal name="DINTsel" />
        <signal name="Asel" />
        <signal name="ALUF(2:0)" />
        <signal name="DO(31:0)" />
        <signal name="opcode(5:0)" />
        <signal name="MAO(31:0)" />
        <signal name="IR(31:0)" />
        <signal name="AEQZ" />
        <signal name="D_MONITOR(31:0)" />
        <signal name="XLXN_34(31:0)" />
        <signal name="XLXN_40(31:0)" />
        <signal name="DI(31:0)" />
        <signal name="imm(31:0)" />
        <signal name="RD(4:0)" />
        <signal name="RS1(4:0)" />
        <signal name="XLXN_58(31:0)" />
        <signal name="XLXN_60(31:0)" />
        <signal name="A_OUT(31:0)" />
        <signal name="XLXN_38(31:0)" />
        <signal name="XLXN_39(31:0)" />
        <signal name="XLXN_71(31:0)" />
        <signal name="MAR(31:0)" />
        <signal name="S2(31:0)" />
        <signal name="B_OUT(31:0)" />
        <signal name="SHIFTright" />
        <signal name="B(31:0)" />
        <signal name="A(31:0)" />
        <signal name="S1sel(1:0)" />
        <signal name="PC(31:0)" />
        <signal name="S1(31:0)" />
        <signal name="RS2(4:0)" />
        <signal name="DINT(31:0)" />
        <signal name="MDRsel" />
        <port polarity="Input" name="RESET" />
        <port polarity="Input" name="CLK" />
        <port polarity="Input" name="IRce" />
        <port polarity="Input" name="Bce" />
        <port polarity="Input" name="Ace" />
        <port polarity="Input" name="Cce" />
        <port polarity="Input" name="MARce" />
        <port polarity="Input" name="PCce" />
        <port polarity="Input" name="MDRce" />
        <port polarity="Input" name="Itype" />
        <port polarity="Input" name="Jlink" />
        <port polarity="Input" name="D_addr(4:0)" />
        <port polarity="Input" name="S2sel(1:0)" />
        <port polarity="Input" name="GPR_WE" />
        <port polarity="Input" name="add" />
        <port polarity="Input" name="Test" />
        <port polarity="Input" name="SHIFTce" />
        <port polarity="Input" name="DINTsel" />
        <port polarity="Input" name="Asel" />
        <port polarity="Output" name="ALUF(2:0)" />
        <port polarity="Output" name="DO(31:0)" />
        <port polarity="Output" name="opcode(5:0)" />
        <port polarity="Output" name="MAO(31:0)" />
        <port polarity="Output" name="IR(31:0)" />
        <port polarity="Output" name="AEQZ" />
        <port polarity="Output" name="D_MONITOR(31:0)" />
        <port polarity="Input" name="DI(31:0)" />
        <port polarity="Input" name="SHIFTright" />
        <port polarity="Input" name="S1sel(1:0)" />
        <port polarity="Input" name="MDRsel" />
        <blockdef name="IR_ENV_DLX">
            <timestamp>2026-7-7T9:4:40</timestamp>
            <rect width="256" x="64" y="-448" height="448" />
            <line x2="0" y1="-416" y2="-416" x1="64" />
            <line x2="0" y1="-320" y2="-320" x1="64" />
            <line x2="0" y1="-224" y2="-224" x1="64" />
            <line x2="0" y1="-128" y2="-128" x1="64" />
            <rect width="64" x="0" y="-44" height="24" />
            <line x2="0" y1="-32" y2="-32" x1="64" />
            <rect width="64" x="320" y="-428" height="24" />
            <line x2="384" y1="-416" y2="-416" x1="320" />
            <rect width="64" x="320" y="-364" height="24" />
            <line x2="384" y1="-352" y2="-352" x1="320" />
            <rect width="64" x="320" y="-300" height="24" />
            <line x2="384" y1="-288" y2="-288" x1="320" />
            <rect width="64" x="320" y="-236" height="24" />
            <line x2="384" y1="-224" y2="-224" x1="320" />
            <rect width="64" x="320" y="-172" height="24" />
            <line x2="384" y1="-160" y2="-160" x1="320" />
            <rect width="64" x="320" y="-108" height="24" />
            <line x2="384" y1="-96" y2="-96" x1="320" />
            <rect width="64" x="320" y="-44" height="24" />
            <line x2="384" y1="-32" y2="-32" x1="320" />
        </blockdef>
        <blockdef name="ALU_env">
            <timestamp>2026-6-17T6:54:31</timestamp>
            <rect width="256" x="64" y="-320" height="320" />
            <line x2="0" y1="-288" y2="-288" x1="64" />
            <line x2="0" y1="-224" y2="-224" x1="64" />
            <rect width="64" x="0" y="-172" height="24" />
            <line x2="0" y1="-160" y2="-160" x1="64" />
            <rect width="64" x="0" y="-108" height="24" />
            <line x2="0" y1="-96" y2="-96" x1="64" />
            <rect width="64" x="0" y="-44" height="24" />
            <line x2="0" y1="-32" y2="-32" x1="64" />
            <rect width="64" x="320" y="-300" height="24" />
            <line x2="384" y1="-288" y2="-288" x1="320" />
        </blockdef>
        <blockdef name="shift_env">
            <timestamp>2026-6-23T10:23:25</timestamp>
            <rect width="64" x="0" y="20" height="24" />
            <line x2="0" y1="32" y2="32" x1="64" />
            <line x2="0" y1="-96" y2="-96" x1="64" />
            <line x2="0" y1="-32" y2="-32" x1="64" />
            <rect width="64" x="384" y="-172" height="24" />
            <line x2="448" y1="-160" y2="-160" x1="384" />
            <rect width="320" x="64" y="-192" height="256" />
        </blockdef>
        <blockdef name="GPR_env_sch">
            <timestamp>2026-6-9T7:54:8</timestamp>
            <rect width="256" x="64" y="-448" height="448" />
            <line x2="0" y1="-416" y2="-416" x1="64" />
            <line x2="0" y1="-352" y2="-352" x1="64" />
            <rect width="64" x="0" y="-300" height="24" />
            <line x2="0" y1="-288" y2="-288" x1="64" />
            <rect width="64" x="0" y="-236" height="24" />
            <line x2="0" y1="-224" y2="-224" x1="64" />
            <rect width="64" x="0" y="-172" height="24" />
            <line x2="0" y1="-160" y2="-160" x1="64" />
            <rect width="64" x="0" y="-108" height="24" />
            <line x2="0" y1="-96" y2="-96" x1="64" />
            <rect width="64" x="0" y="-44" height="24" />
            <line x2="0" y1="-32" y2="-32" x1="64" />
            <rect width="64" x="320" y="-428" height="24" />
            <line x2="384" y1="-416" y2="-416" x1="320" />
            <rect width="64" x="320" y="-300" height="24" />
            <line x2="384" y1="-288" y2="-288" x1="320" />
            <rect width="64" x="320" y="-172" height="24" />
            <line x2="384" y1="-160" y2="-160" x1="320" />
            <line x2="384" y1="-32" y2="-32" x1="320" />
        </blockdef>
        <blockdef name="MUX32bit">
            <timestamp>2024-4-10T7:9:40</timestamp>
            <rect width="256" x="64" y="-192" height="192" />
            <line x2="0" y1="-160" y2="-160" x1="64" />
            <rect width="64" x="0" y="-108" height="24" />
            <line x2="0" y1="-96" y2="-96" x1="64" />
            <rect width="64" x="0" y="-44" height="24" />
            <line x2="0" y1="-32" y2="-32" x1="64" />
            <rect width="64" x="320" y="-172" height="24" />
            <line x2="384" y1="-160" y2="-160" x1="320" />
        </blockdef>
        <blockdef name="MMU">
            <timestamp>2026-6-23T9:9:57</timestamp>
            <rect width="256" x="64" y="-64" height="64" />
            <rect width="64" x="0" y="-44" height="24" />
            <line x2="0" y1="-32" y2="-32" x1="64" />
            <rect width="64" x="320" y="-44" height="24" />
            <line x2="384" y1="-32" y2="-32" x1="320" />
        </blockdef>
        <blockdef name="MUX4_32bit">
            <timestamp>2024-4-10T7:9:46</timestamp>
            <rect width="256" x="64" y="-320" height="320" />
            <rect width="64" x="0" y="-300" height="24" />
            <line x2="0" y1="-288" y2="-288" x1="64" />
            <rect width="64" x="0" y="-236" height="24" />
            <line x2="0" y1="-224" y2="-224" x1="64" />
            <rect width="64" x="0" y="-172" height="24" />
            <line x2="0" y1="-160" y2="-160" x1="64" />
            <rect width="64" x="0" y="-108" height="24" />
            <line x2="0" y1="-96" y2="-96" x1="64" />
            <rect width="64" x="0" y="-44" height="24" />
            <line x2="0" y1="-32" y2="-32" x1="64" />
            <rect width="64" x="320" y="-300" height="24" />
            <line x2="384" y1="-288" y2="-288" x1="320" />
        </blockdef>
        <blockdef name="REG32CE">
            <timestamp>2024-4-10T5:17:14</timestamp>
            <rect width="256" x="64" y="-192" height="192" />
            <line x2="0" y1="-160" y2="-160" x1="64" />
            <line x2="0" y1="-96" y2="-96" x1="64" />
            <rect width="64" x="0" y="-44" height="24" />
            <line x2="0" y1="-32" y2="-32" x1="64" />
            <rect width="64" x="320" y="-172" height="24" />
            <line x2="384" y1="-160" y2="-160" x1="320" />
        </blockdef>
        <blockdef name="REG32RST">
            <timestamp>2024-4-10T5:17:18</timestamp>
            <rect width="256" x="64" y="-256" height="256" />
            <line x2="0" y1="-224" y2="-224" x1="64" />
            <line x2="0" y1="-160" y2="-160" x1="64" />
            <line x2="0" y1="-96" y2="-96" x1="64" />
            <rect width="64" x="0" y="-44" height="24" />
            <line x2="0" y1="-32" y2="-32" x1="64" />
            <rect width="64" x="320" y="-236" height="24" />
            <line x2="384" y1="-224" y2="-224" x1="320" />
        </blockdef>
        <blockdef name="constant">
            <timestamp>2006-1-1T10:10:10</timestamp>
            <rect width="112" x="0" y="0" height="64" />
            <line x2="112" y1="32" y2="32" x1="144" />
        </blockdef>
        <block symbolname="IR_ENV_DLX" name="XLXI_1">
            <blockpin signalname="CLK" name="CLK" />
            <blockpin signalname="IRce" name="IRce" />
            <blockpin signalname="Itype" name="Itype" />
            <blockpin signalname="Jlink" name="Jlink" />
            <blockpin signalname="DI(31:0)" name="Din(31:0)" />
            <blockpin signalname="opcode(5:0)" name="opcode(5:0)" />
            <blockpin signalname="RS1(4:0)" name="rs1(4:0)" />
            <blockpin signalname="RS2(4:0)" name="rs2(4:0)" />
            <blockpin signalname="RD(4:0)" name="rd(4:0)" />
            <blockpin signalname="imm(31:0)" name="imm(31:0)" />
            <blockpin signalname="ALUF(2:0)" name="aluf(2:0)" />
            <blockpin signalname="IR(31:0)" name="ir(31:0)" />
        </block>
        <block symbolname="MUX32bit" name="XLXI_5">
            <blockpin signalname="Asel" name="sel" />
            <blockpin signalname="PC(31:0)" name="A(31:0)" />
            <blockpin signalname="MAR(31:0)" name="B(31:0)" />
            <blockpin signalname="XLXN_40(31:0)" name="O(31:0)" />
        </block>
        <block symbolname="MMU" name="XLXI_8">
            <blockpin signalname="XLXN_40(31:0)" name="Din(31:0)" />
            <blockpin signalname="MAO(31:0)" name="Dout(31:0)" />
        </block>
        <block symbolname="MUX4_32bit" name="XLXI_9">
            <blockpin signalname="B_OUT(31:0)" name="A(31:0)" />
            <blockpin signalname="imm(31:0)" name="B(31:0)" />
            <blockpin signalname="XLXN_58(31:0)" name="C(31:0)" />
            <blockpin signalname="XLXN_60(31:0)" name="D(31:0)" />
            <blockpin signalname="S2sel(1:0)" name="sel(1:0)" />
            <blockpin signalname="S2(31:0)" name="O(31:0)" />
        </block>
        <block symbolname="REG32RST" name="XLXI_17">
            <blockpin signalname="CLK" name="CLK" />
            <blockpin signalname="PCce" name="CE" />
            <blockpin signalname="RESET" name="RST" />
            <blockpin signalname="DINT(31:0)" name="DI(31:0)" />
            <blockpin signalname="PC(31:0)" name="DO(31:0)" />
        </block>
        <block symbolname="MUX32bit" name="XLXI_7">
            <blockpin signalname="MDRsel" name="sel" />
            <blockpin signalname="DINT(31:0)" name="A(31:0)" />
            <blockpin signalname="DI(31:0)" name="B(31:0)" />
            <blockpin signalname="XLXN_71(31:0)" name="O(31:0)" />
        </block>
        <block symbolname="GPR_env_sch" name="XLXI_4">
            <blockpin signalname="CLK" name="CLK" />
            <blockpin signalname="GPR_WE" name="GPR_we" />
            <blockpin signalname="RS1(4:0)" name="A_adr(4:0)" />
            <blockpin signalname="RS2(4:0)" name="B_adr(4:0)" />
            <blockpin signalname="RD(4:0)" name="C_adr(4:0)" />
            <blockpin signalname="D_addr(4:0)" name="D_adr(4:0)" />
            <blockpin signalname="XLXN_34(31:0)" name="C(31:0)" />
            <blockpin signalname="A(31:0)" name="A(31:0)" />
            <blockpin signalname="B(31:0)" name="B(31:0)" />
            <blockpin signalname="D_MONITOR(31:0)" name="D(31:0)" />
            <blockpin signalname="AEQZ" name="AEQZ_O" />
        </block>
        <block symbolname="REG32CE" name="XLXI_11">
            <blockpin signalname="CLK" name="CLK" />
            <blockpin signalname="Cce" name="CE" />
            <blockpin signalname="DINT(31:0)" name="DI(31:0)" />
            <blockpin signalname="XLXN_34(31:0)" name="DO(31:0)" />
        </block>
        <block symbolname="MUX4_32bit" name="XLXI_10">
            <blockpin signalname="PC(31:0)" name="A(31:0)" />
            <blockpin signalname="A_OUT(31:0)" name="B(31:0)" />
            <blockpin signalname="B_OUT(31:0)" name="C(31:0)" />
            <blockpin signalname="DO(31:0)" name="D(31:0)" />
            <blockpin signalname="S1sel(1:0)" name="sel(1:0)" />
            <blockpin signalname="S1(31:0)" name="O(31:0)" />
        </block>
        <block symbolname="ALU_env" name="XLXI_2">
            <blockpin signalname="add" name="add" />
            <blockpin signalname="Test" name="test" />
            <blockpin signalname="ALUF(2:0)" name="ALUf(2:0)" />
            <blockpin signalname="S1(31:0)" name="A(31:0)" />
            <blockpin signalname="S2(31:0)" name="B(31:0)" />
            <blockpin signalname="XLXN_38(31:0)" name="ALU_OUT(31:0)" />
        </block>
        <block symbolname="shift_env" name="XLXI_3">
            <blockpin signalname="SHIFTce" name="SHIFTce" />
            <blockpin signalname="SHIFTright" name="SHIFTright" />
            <blockpin signalname="XLXN_39(31:0)" name="SHIFT_OUT(31:0)" />
            <blockpin signalname="S1(31:0)" name="S1(31:0)" />
        </block>
        <block symbolname="MUX32bit" name="XLXI_6">
            <blockpin signalname="DINTsel" name="sel" />
            <blockpin signalname="XLXN_38(31:0)" name="A(31:0)" />
            <blockpin signalname="XLXN_39(31:0)" name="B(31:0)" />
            <blockpin signalname="DINT(31:0)" name="O(31:0)" />
        </block>
        <block symbolname="REG32CE" name="XLXI_16">
            <blockpin signalname="CLK" name="CLK" />
            <blockpin signalname="MARce" name="CE" />
            <blockpin signalname="DINT(31:0)" name="DI(31:0)" />
            <blockpin signalname="MAR(31:0)" name="DO(31:0)" />
        </block>
        <block symbolname="REG32CE" name="XLXI_13">
            <blockpin signalname="CLK" name="CLK" />
            <blockpin signalname="Bce" name="CE" />
            <blockpin signalname="B(31:0)" name="DI(31:0)" />
            <blockpin signalname="B_OUT(31:0)" name="DO(31:0)" />
        </block>
        <block symbolname="REG32CE" name="XLXI_12">
            <blockpin signalname="CLK" name="CLK" />
            <blockpin signalname="MDRce" name="CE" />
            <blockpin signalname="XLXN_71(31:0)" name="DI(31:0)" />
            <blockpin signalname="DO(31:0)" name="DO(31:0)" />
        </block>
        <block symbolname="REG32CE" name="XLXI_14">
            <blockpin signalname="CLK" name="CLK" />
            <blockpin signalname="Ace" name="CE" />
            <blockpin signalname="A(31:0)" name="DI(31:0)" />
            <blockpin signalname="A_OUT(31:0)" name="DO(31:0)" />
        </block>
        <block symbolname="constant" name="XLXI_35">
            <attr value="00000000" name="CValue">
                <trait delete="all:1 sym:0" />
                <trait editname="all:1 sch:0" />
                <trait valuetype="BitVector 32 Hexadecimal" />
            </attr>
            <blockpin signalname="XLXN_58(31:0)" name="O" />
        </block>
        <block symbolname="constant" name="XLXI_36">
            <attr value="00000001" name="CValue">
                <trait delete="all:1 sym:0" />
                <trait editname="all:1 sch:0" />
                <trait valuetype="BitVector 32 Hexadecimal" />
            </attr>
            <blockpin signalname="XLXN_60(31:0)" name="O" />
        </block>
    </netlist>
    <sheet sheetnum="1" width="3520" height="2720">
        <instance x="880" y="592" name="XLXI_1" orien="R0">
        </instance>
        <instance x="1856" y="304" name="XLXI_5" orien="R0">
        </instance>
        <instance x="2416" y="176" name="XLXI_8" orien="R0">
        </instance>
        <instance x="1840" y="720" name="XLXI_9" orien="R0">
        </instance>
        <branch name="RESET">
            <attrtext style="alignment:SOFT-LEFT;fontsize:28;fontname:Arial" attrname="Name" x="320" y="160" type="branch" />
            <wire x2="320" y1="160" y2="160" x1="240" />
        </branch>
        <branch name="CLK">
            <attrtext style="alignment:SOFT-LEFT;fontsize:28;fontname:Arial" attrname="Name" x="320" y="80" type="branch" />
            <wire x2="320" y1="80" y2="80" x1="240" />
        </branch>
        <branch name="IRce">
            <attrtext style="alignment:SOFT-LEFT;fontsize:28;fontname:Arial" attrname="Name" x="320" y="240" type="branch" />
            <wire x2="320" y1="240" y2="240" x1="240" />
        </branch>
        <branch name="Bce">
            <attrtext style="alignment:SOFT-LEFT;fontsize:28;fontname:Arial" attrname="Name" x="320" y="400" type="branch" />
            <wire x2="320" y1="400" y2="400" x1="240" />
        </branch>
        <branch name="Ace">
            <attrtext style="alignment:SOFT-LEFT;fontsize:28;fontname:Arial" attrname="Name" x="320" y="320" type="branch" />
            <wire x2="304" y1="320" y2="320" x1="240" />
            <wire x2="320" y1="320" y2="320" x1="304" />
        </branch>
        <branch name="Cce">
            <attrtext style="alignment:SOFT-LEFT;fontsize:28;fontname:Arial" attrname="Name" x="320" y="480" type="branch" />
            <wire x2="320" y1="480" y2="480" x1="240" />
        </branch>
        <branch name="MARce">
            <attrtext style="alignment:SOFT-LEFT;fontsize:28;fontname:Arial" attrname="Name" x="320" y="640" type="branch" />
            <wire x2="320" y1="640" y2="640" x1="240" />
        </branch>
        <branch name="PCce">
            <attrtext style="alignment:SOFT-LEFT;fontsize:28;fontname:Arial" attrname="Name" x="320" y="560" type="branch" />
            <wire x2="320" y1="560" y2="560" x1="240" />
        </branch>
        <branch name="MDRce">
            <attrtext style="alignment:SOFT-LEFT;fontsize:28;fontname:Arial" attrname="Name" x="320" y="720" type="branch" />
            <wire x2="320" y1="720" y2="720" x1="240" />
        </branch>
        <branch name="Itype">
            <attrtext style="alignment:SOFT-LEFT;fontsize:28;fontname:Arial" attrname="Name" x="320" y="880" type="branch" />
            <wire x2="320" y1="880" y2="880" x1="240" />
        </branch>
        <branch name="Jlink">
            <attrtext style="alignment:SOFT-LEFT;fontsize:28;fontname:Arial" attrname="Name" x="320" y="800" type="branch" />
            <wire x2="320" y1="800" y2="800" x1="240" />
        </branch>
        <branch name="D_addr(4:0)">
            <attrtext style="alignment:SOFT-LEFT;fontsize:28;fontname:Arial" attrname="Name" x="320" y="960" type="branch" />
            <wire x2="320" y1="960" y2="960" x1="240" />
        </branch>
        <instance x="992" y="2048" name="XLXI_4" orien="R0">
        </instance>
        <branch name="S2sel(1:0)">
            <attrtext style="alignment:SOFT-LEFT;fontsize:28;fontname:Arial" attrname="Name" x="320" y="1120" type="branch" />
            <wire x2="320" y1="1120" y2="1120" x1="240" />
        </branch>
        <branch name="GPR_WE">
            <attrtext style="alignment:SOFT-LEFT;fontsize:28;fontname:Arial" attrname="Name" x="320" y="1040" type="branch" />
            <wire x2="320" y1="1040" y2="1040" x1="240" />
        </branch>
        <branch name="S1sel(1:0)">
            <attrtext style="alignment:SOFT-LEFT;fontsize:28;fontname:Arial" attrname="Name" x="320" y="1200" type="branch" />
            <wire x2="320" y1="1200" y2="1200" x1="240" />
        </branch>
        <branch name="add">
            <attrtext style="alignment:SOFT-LEFT;fontsize:28;fontname:Arial" attrname="Name" x="320" y="1360" type="branch" />
            <wire x2="320" y1="1360" y2="1360" x1="240" />
        </branch>
        <branch name="Test">
            <attrtext style="alignment:SOFT-LEFT;fontsize:28;fontname:Arial" attrname="Name" x="320" y="1280" type="branch" />
            <wire x2="320" y1="1280" y2="1280" x1="240" />
        </branch>
        <branch name="SHIFTce">
            <attrtext style="alignment:SOFT-LEFT;fontsize:28;fontname:Arial" attrname="Name" x="320" y="1440" type="branch" />
            <wire x2="320" y1="1440" y2="1440" x1="240" />
        </branch>
        <branch name="DINTsel">
            <attrtext style="alignment:SOFT-LEFT;fontsize:28;fontname:Arial" attrname="Name" x="320" y="1600" type="branch" />
            <wire x2="320" y1="1600" y2="1600" x1="240" />
        </branch>
        <branch name="SHIFTright">
            <attrtext style="alignment:SOFT-LEFT;fontsize:28;fontname:Arial" attrname="Name" x="320" y="1520" type="branch" />
            <wire x2="320" y1="1520" y2="1520" x1="240" />
        </branch>
        <branch name="Asel">
            <attrtext style="alignment:SOFT-LEFT;fontsize:28;fontname:Arial" attrname="Name" x="320" y="1680" type="branch" />
            <wire x2="320" y1="1680" y2="1680" x1="240" />
        </branch>
        <branch name="MDRsel">
            <attrtext style="alignment:SOFT-LEFT;fontsize:28;fontname:Arial" attrname="Name" x="320" y="1840" type="branch" />
            <wire x2="320" y1="1840" y2="1840" x1="240" />
        </branch>
        <branch name="DI(31:0)">
            <attrtext style="alignment:SOFT-LEFT;fontsize:28;fontname:Arial" attrname="Name" x="320" y="1760" type="branch" />
            <wire x2="320" y1="1760" y2="1760" x1="240" />
        </branch>
        <branch name="ALUF(2:0)">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="3120" y="320" type="branch" />
            <wire x2="3200" y1="320" y2="320" x1="3120" />
        </branch>
        <branch name="DO(31:0)">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="3120" y="240" type="branch" />
            <wire x2="3200" y1="240" y2="240" x1="3120" />
        </branch>
        <branch name="opcode(5:0)">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="3120" y="400" type="branch" />
            <wire x2="3200" y1="400" y2="400" x1="3120" />
        </branch>
        <branch name="MAO(31:0)">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="3120" y="560" type="branch" />
            <wire x2="3200" y1="560" y2="560" x1="3120" />
        </branch>
        <branch name="IR(31:0)">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="3120" y="480" type="branch" />
            <wire x2="3200" y1="480" y2="480" x1="3120" />
        </branch>
        <branch name="AEQZ">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="3120" y="640" type="branch" />
            <wire x2="3200" y1="640" y2="640" x1="3120" />
        </branch>
        <branch name="D_MONITOR(31:0)">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="3120" y="720" type="branch" />
            <wire x2="3200" y1="720" y2="720" x1="3120" />
        </branch>
        <instance x="432" y="2176" name="XLXI_11" orien="R0">
        </instance>
        <branch name="XLXN_34(31:0)">
            <wire x2="864" y1="2016" y2="2016" x1="816" />
            <wire x2="992" y1="2016" y2="2016" x1="864" />
        </branch>
        <branch name="XLXN_40(31:0)">
            <wire x2="2416" y1="144" y2="144" x1="2240" />
        </branch>
        <branch name="CLK">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="832" y="176" type="branch" />
            <wire x2="880" y1="176" y2="176" x1="832" />
        </branch>
        <branch name="IRce">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="848" y="272" type="branch" />
            <wire x2="880" y1="272" y2="272" x1="848" />
        </branch>
        <branch name="Itype">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="832" y="368" type="branch" />
            <wire x2="880" y1="368" y2="368" x1="832" />
        </branch>
        <branch name="Jlink">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="848" y="464" type="branch" />
            <wire x2="880" y1="464" y2="464" x1="848" />
        </branch>
        <branch name="DI(31:0)">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="832" y="560" type="branch" />
            <wire x2="880" y1="560" y2="560" x1="832" />
        </branch>
        <branch name="IR(31:0)">
            <attrtext style="alignment:SOFT-LEFT;fontsize:28;fontname:Arial" attrname="Name" x="1296" y="560" type="branch" />
            <wire x2="1296" y1="560" y2="560" x1="1264" />
        </branch>
        <branch name="ALUF(2:0)">
            <attrtext style="alignment:SOFT-LEFT;fontsize:28;fontname:Arial" attrname="Name" x="1312" y="496" type="branch" />
            <wire x2="1312" y1="496" y2="496" x1="1264" />
        </branch>
        <branch name="imm(31:0)">
            <attrtext style="alignment:SOFT-LEFT;fontsize:28;fontname:Arial" attrname="Name" x="1328" y="432" type="branch" />
            <wire x2="1328" y1="432" y2="432" x1="1264" />
        </branch>
        <branch name="RD(4:0)">
            <attrtext style="alignment:SOFT-LEFT;fontsize:28;fontname:Arial" attrname="Name" x="1312" y="368" type="branch" />
            <wire x2="1312" y1="368" y2="368" x1="1264" />
        </branch>
        <branch name="RS2(4:0)">
            <attrtext style="alignment:SOFT-LEFT;fontsize:28;fontname:Arial" attrname="Name" x="1312" y="304" type="branch" />
            <wire x2="1312" y1="304" y2="304" x1="1264" />
        </branch>
        <branch name="RS1(4:0)">
            <attrtext style="alignment:SOFT-LEFT;fontsize:28;fontname:Arial" attrname="Name" x="1312" y="240" type="branch" />
            <wire x2="1312" y1="240" y2="240" x1="1264" />
        </branch>
        <branch name="opcode(5:0)">
            <attrtext style="alignment:SOFT-LEFT;fontsize:28;fontname:Arial" attrname="Name" x="1328" y="176" type="branch" />
            <wire x2="1328" y1="176" y2="176" x1="1264" />
        </branch>
        <branch name="MAO(31:0)">
            <attrtext style="alignment:SOFT-LEFT;fontsize:28;fontname:Arial" attrname="Name" x="2832" y="144" type="branch" />
            <wire x2="2832" y1="144" y2="144" x1="2800" />
        </branch>
        <branch name="S2(31:0)">
            <attrtext style="alignment:SOFT-LEFT;fontsize:28;fontname:Arial" attrname="Name" x="2272" y="432" type="branch" />
            <wire x2="2272" y1="432" y2="432" x1="2224" />
        </branch>
        <branch name="B_OUT(31:0)">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="1792" y="432" type="branch" />
            <wire x2="1840" y1="432" y2="432" x1="1792" />
        </branch>
        <branch name="imm(31:0)">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="1792" y="496" type="branch" />
            <wire x2="1840" y1="496" y2="496" x1="1792" />
        </branch>
        <branch name="XLXN_58(31:0)">
            <wire x2="1840" y1="560" y2="560" x1="1792" />
        </branch>
        <branch name="XLXN_60(31:0)">
            <wire x2="1840" y1="624" y2="624" x1="1792" />
        </branch>
        <branch name="S2sel(1:0)">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="1792" y="688" type="branch" />
            <wire x2="1840" y1="688" y2="688" x1="1792" />
        </branch>
        <branch name="A_OUT(31:0)">
            <attrtext style="alignment:SOFT-BCENTER;fontsize:28;fontname:Arial" attrname="Name" x="2336" y="1792" type="branch" />
            <wire x2="2336" y1="1792" y2="1792" x1="2288" />
            <wire x2="2464" y1="1792" y2="1792" x1="2336" />
            <wire x2="2480" y1="1792" y2="1792" x1="2464" />
        </branch>
        <instance x="2480" y="2016" name="XLXI_10" orien="R0">
        </instance>
        <instance x="2000" y="2352" name="XLXI_17" orien="R0">
        </instance>
        <instance x="1856" y="1200" name="XLXI_2" orien="R0">
        </instance>
        <instance x="1840" y="1488" name="XLXI_3" orien="R0">
        </instance>
        <branch name="XLXN_38(31:0)">
            <wire x2="2256" y1="912" y2="912" x1="2240" />
            <wire x2="2256" y1="912" y2="1248" x1="2256" />
            <wire x2="2560" y1="1248" y2="1248" x1="2256" />
        </branch>
        <branch name="XLXN_39(31:0)">
            <wire x2="2304" y1="1328" y2="1328" x1="2288" />
            <wire x2="2560" y1="1312" y2="1312" x1="2304" />
            <wire x2="2304" y1="1312" y2="1328" x1="2304" />
        </branch>
        <instance x="2560" y="1344" name="XLXI_6" orien="R0">
        </instance>
        <branch name="DINT(31:0)">
            <attrtext style="alignment:SOFT-BCENTER;fontsize:28;fontname:Arial" attrname="Name" x="2752" y="1056" type="branch" />
            <wire x2="2496" y1="992" y2="1056" x1="2496" />
            <wire x2="2752" y1="1056" y2="1056" x1="2496" />
            <wire x2="2944" y1="1056" y2="1056" x1="2752" />
            <wire x2="2960" y1="1056" y2="1056" x1="2944" />
            <wire x2="2960" y1="1056" y2="1184" x1="2960" />
            <wire x2="2560" y1="992" y2="992" x1="2496" />
            <wire x2="2960" y1="1184" y2="1184" x1="2944" />
        </branch>
        <instance x="2560" y="1024" name="XLXI_16" orien="R0">
        </instance>
        <instance x="1072" y="1312" name="XLXI_13" orien="R0">
        </instance>
        <instance x="1088" y="976" name="XLXI_12" orien="R0">
        </instance>
        <instance x="576" y="1104" name="XLXI_7" orien="R0">
        </instance>
        <branch name="XLXN_71(31:0)">
            <wire x2="1088" y1="944" y2="944" x1="960" />
        </branch>
        <branch name="Asel">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="1824" y="144" type="branch" />
            <wire x2="1856" y1="144" y2="144" x1="1824" />
        </branch>
        <branch name="PC(31:0)">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="1824" y="208" type="branch" />
            <wire x2="1856" y1="208" y2="208" x1="1824" />
        </branch>
        <branch name="MAR(31:0)">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="1824" y="272" type="branch" />
            <wire x2="1856" y1="272" y2="272" x1="1824" />
        </branch>
        <branch name="MAR(31:0)">
            <attrtext style="alignment:SOFT-LEFT;fontsize:28;fontname:Arial" attrname="Name" x="2976" y="864" type="branch" />
            <wire x2="2976" y1="864" y2="864" x1="2944" />
        </branch>
        <branch name="CLK">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="2512" y="864" type="branch" />
            <wire x2="2560" y1="864" y2="864" x1="2512" />
        </branch>
        <branch name="MARce">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="2496" y="928" type="branch" />
            <wire x2="2560" y1="928" y2="928" x1="2496" />
        </branch>
        <branch name="DINTsel">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="2496" y="1184" type="branch" />
            <wire x2="2560" y1="1184" y2="1184" x1="2496" />
        </branch>
        <branch name="add">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="1808" y="912" type="branch" />
            <wire x2="1856" y1="912" y2="912" x1="1808" />
        </branch>
        <branch name="Test">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="1824" y="976" type="branch" />
            <wire x2="1856" y1="976" y2="976" x1="1824" />
        </branch>
        <branch name="ALUF(2:0)">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="1808" y="1040" type="branch" />
            <wire x2="1856" y1="1040" y2="1040" x1="1808" />
        </branch>
        <branch name="S1(31:0)">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="1808" y="1104" type="branch" />
            <wire x2="1824" y1="1104" y2="1104" x1="1808" />
            <wire x2="1856" y1="1104" y2="1104" x1="1824" />
        </branch>
        <branch name="S2(31:0)">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="1792" y="1168" type="branch" />
            <wire x2="1856" y1="1168" y2="1168" x1="1792" />
        </branch>
        <branch name="SHIFTce">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="1776" y="1392" type="branch" />
            <wire x2="1840" y1="1392" y2="1392" x1="1776" />
        </branch>
        <branch name="B_OUT(31:0)">
            <attrtext style="alignment:SOFT-LEFT;fontsize:28;fontname:Arial" attrname="Name" x="1472" y="1152" type="branch" />
            <wire x2="1472" y1="1152" y2="1152" x1="1456" />
        </branch>
        <branch name="DO(31:0)">
            <attrtext style="alignment:SOFT-LEFT;fontsize:28;fontname:Arial" attrname="Name" x="1504" y="816" type="branch" />
            <wire x2="1504" y1="816" y2="816" x1="1472" />
        </branch>
        <branch name="CLK">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="1056" y="816" type="branch" />
            <wire x2="1088" y1="816" y2="816" x1="1056" />
        </branch>
        <branch name="MDRce">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="1056" y="880" type="branch" />
            <wire x2="1088" y1="880" y2="880" x1="1056" />
        </branch>
        <branch name="CLK">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="1024" y="1152" type="branch" />
            <wire x2="1072" y1="1152" y2="1152" x1="1024" />
        </branch>
        <branch name="Bce">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="1024" y="1216" type="branch" />
            <wire x2="1072" y1="1216" y2="1216" x1="1024" />
        </branch>
        <branch name="B(31:0)">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="1024" y="1280" type="branch" />
            <wire x2="1072" y1="1280" y2="1280" x1="1024" />
        </branch>
        <branch name="SHIFTright">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="1792" y="1456" type="branch" />
            <wire x2="1840" y1="1456" y2="1456" x1="1792" />
        </branch>
        <branch name="AEQZ">
            <attrtext style="alignment:SOFT-LEFT;fontsize:28;fontname:Arial" attrname="Name" x="1408" y="2016" type="branch" />
            <wire x2="1408" y1="2016" y2="2016" x1="1376" />
        </branch>
        <branch name="D_MONITOR(31:0)">
            <attrtext style="alignment:SOFT-LEFT;fontsize:28;fontname:Arial" attrname="Name" x="1424" y="1888" type="branch" />
            <wire x2="1424" y1="1888" y2="1888" x1="1376" />
        </branch>
        <branch name="B(31:0)">
            <attrtext style="alignment:SOFT-LEFT;fontsize:28;fontname:Arial" attrname="Name" x="1408" y="1760" type="branch" />
            <wire x2="1408" y1="1760" y2="1760" x1="1376" />
        </branch>
        <branch name="A(31:0)">
            <attrtext style="alignment:SOFT-LEFT;fontsize:28;fontname:Arial" attrname="Name" x="1424" y="1632" type="branch" />
            <wire x2="1424" y1="1632" y2="1632" x1="1376" />
        </branch>
        <branch name="CLK">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="1936" y="2128" type="branch" />
            <wire x2="2000" y1="2128" y2="2128" x1="1936" />
        </branch>
        <branch name="PCce">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="1936" y="2192" type="branch" />
            <wire x2="2000" y1="2192" y2="2192" x1="1936" />
        </branch>
        <branch name="RESET">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="1936" y="2256" type="branch" />
            <wire x2="2000" y1="2256" y2="2256" x1="1936" />
        </branch>
        <branch name="DINT(31:0)">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="1936" y="2320" type="branch" />
            <wire x2="2000" y1="2320" y2="2320" x1="1936" />
        </branch>
        <branch name="PC(31:0)">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="2448" y="1728" type="branch" />
            <wire x2="2480" y1="1728" y2="1728" x1="2448" />
        </branch>
        <branch name="B_OUT(31:0)">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="2448" y="1856" type="branch" />
            <wire x2="2480" y1="1856" y2="1856" x1="2448" />
        </branch>
        <branch name="DO(31:0)">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="2448" y="1920" type="branch" />
            <wire x2="2480" y1="1920" y2="1920" x1="2448" />
        </branch>
        <branch name="S1sel(1:0)">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="2448" y="1984" type="branch" />
            <wire x2="2480" y1="1984" y2="1984" x1="2448" />
        </branch>
        <branch name="PC(31:0)">
            <attrtext style="alignment:SOFT-LEFT;fontsize:28;fontname:Arial" attrname="Name" x="2432" y="2128" type="branch" />
            <wire x2="2432" y1="2128" y2="2128" x1="2384" />
        </branch>
        <branch name="S1(31:0)">
            <attrtext style="alignment:SOFT-LEFT;fontsize:28;fontname:Arial" attrname="Name" x="2896" y="1728" type="branch" />
            <wire x2="2896" y1="1728" y2="1728" x1="2864" />
        </branch>
        <branch name="CLK">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="944" y="1632" type="branch" />
            <wire x2="992" y1="1632" y2="1632" x1="944" />
        </branch>
        <branch name="D_addr(4:0)">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="960" y="1952" type="branch" />
            <wire x2="992" y1="1952" y2="1952" x1="960" />
        </branch>
        <branch name="RD(4:0)">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="960" y="1888" type="branch" />
            <wire x2="992" y1="1888" y2="1888" x1="960" />
        </branch>
        <branch name="RS2(4:0)">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="976" y="1824" type="branch" />
            <wire x2="992" y1="1824" y2="1824" x1="976" />
        </branch>
        <branch name="RS1(4:0)">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="960" y="1760" type="branch" />
            <wire x2="992" y1="1760" y2="1760" x1="960" />
        </branch>
        <branch name="GPR_WE">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="960" y="1696" type="branch" />
            <wire x2="992" y1="1696" y2="1696" x1="960" />
        </branch>
        <branch name="CLK">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="384" y="2016" type="branch" />
            <wire x2="432" y1="2016" y2="2016" x1="384" />
        </branch>
        <branch name="Cce">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="400" y="2080" type="branch" />
            <wire x2="416" y1="2080" y2="2080" x1="400" />
            <wire x2="432" y1="2080" y2="2080" x1="416" />
        </branch>
        <branch name="DINT(31:0)">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="400" y="2144" type="branch" />
            <wire x2="432" y1="2144" y2="2144" x1="400" />
        </branch>
        <branch name="MDRsel">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="544" y="944" type="branch" />
            <wire x2="576" y1="944" y2="944" x1="544" />
        </branch>
        <branch name="DINT(31:0)">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="544" y="1008" type="branch" />
            <wire x2="576" y1="1008" y2="1008" x1="544" />
        </branch>
        <branch name="DI(31:0)">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="528" y="1072" type="branch" />
            <wire x2="576" y1="1072" y2="1072" x1="528" />
        </branch>
        <branch name="CLK">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="1840" y="1792" type="branch" />
            <wire x2="1904" y1="1792" y2="1792" x1="1840" />
        </branch>
        <branch name="Ace">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="1840" y="1856" type="branch" />
            <wire x2="1904" y1="1856" y2="1856" x1="1840" />
        </branch>
        <branch name="A(31:0)">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="1840" y="1920" type="branch" />
            <wire x2="1904" y1="1920" y2="1920" x1="1840" />
        </branch>
        <instance x="1904" y="1952" name="XLXI_14" orien="R0">
        </instance>
        <instance x="1648" y="528" name="XLXI_35" orien="R0">
        </instance>
        <instance x="1648" y="592" name="XLXI_36" orien="R0">
        </instance>
        <iomarker fontsize="28" x="240" y="80" name="CLK" orien="R180" />
        <iomarker fontsize="28" x="240" y="160" name="RESET" orien="R180" />
        <iomarker fontsize="28" x="240" y="240" name="IRce" orien="R180" />
        <iomarker fontsize="28" x="240" y="320" name="Ace" orien="R180" />
        <iomarker fontsize="28" x="240" y="400" name="Bce" orien="R180" />
        <iomarker fontsize="28" x="240" y="480" name="Cce" orien="R180" />
        <iomarker fontsize="28" x="240" y="560" name="PCce" orien="R180" />
        <iomarker fontsize="28" x="240" y="640" name="MARce" orien="R180" />
        <iomarker fontsize="28" x="240" y="720" name="MDRce" orien="R180" />
        <iomarker fontsize="28" x="240" y="800" name="Jlink" orien="R180" />
        <iomarker fontsize="28" x="240" y="880" name="Itype" orien="R180" />
        <iomarker fontsize="28" x="240" y="960" name="D_addr(4:0)" orien="R180" />
        <iomarker fontsize="28" x="240" y="1040" name="GPR_WE" orien="R180" />
        <iomarker fontsize="28" x="240" y="1120" name="S2sel(1:0)" orien="R180" />
        <iomarker fontsize="28" x="240" y="1200" name="S1sel(1:0)" orien="R180" />
        <iomarker fontsize="28" x="240" y="1280" name="Test" orien="R180" />
        <iomarker fontsize="28" x="240" y="1360" name="add" orien="R180" />
        <iomarker fontsize="28" x="240" y="1440" name="SHIFTce" orien="R180" />
        <iomarker fontsize="28" x="240" y="1520" name="SHIFTright" orien="R180" />
        <iomarker fontsize="28" x="240" y="1600" name="DINTsel" orien="R180" />
        <iomarker fontsize="28" x="240" y="1680" name="Asel" orien="R180" />
        <iomarker fontsize="28" x="240" y="1760" name="DI(31:0)" orien="R180" />
        <iomarker fontsize="28" x="240" y="1840" name="MDRsel" orien="R180" />
        <iomarker fontsize="28" x="3200" y="240" name="DO(31:0)" orien="R0" />
        <iomarker fontsize="28" x="3200" y="320" name="ALUF(2:0)" orien="R0" />
        <iomarker fontsize="28" x="3200" y="400" name="opcode(5:0)" orien="R0" />
        <iomarker fontsize="28" x="3200" y="480" name="IR(31:0)" orien="R0" />
        <iomarker fontsize="28" x="3200" y="560" name="MAO(31:0)" orien="R0" />
        <iomarker fontsize="28" x="3200" y="640" name="AEQZ" orien="R0" />
        <iomarker fontsize="28" x="3200" y="720" name="D_MONITOR(31:0)" orien="R0" />
        <branch name="S1(31:0)">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="1776" y="1520" type="branch" />
            <wire x2="1840" y1="1520" y2="1520" x1="1776" />
        </branch>
    </sheet>
</drawing>