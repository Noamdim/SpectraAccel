<?xml version="1.0" encoding="UTF-8"?>
<drawing version="7">
    <attr value="spartan6" name="DeviceFamilyName">
        <trait delete="all:0" />
        <trait editname="all:0" />
        <trait edittrait="all:0" />
    </attr>
    <netlist>
        <signal name="CLK" />
        <signal name="GPR_we" />
        <signal name="A_adr(4:0)" />
        <signal name="B_adr(4:0)" />
        <signal name="A(31:0)" />
        <signal name="B(31:0)" />
        <signal name="D(31:0)" />
        <signal name="AEQZ_O" />
        <signal name="C_adr(4:0)" />
        <signal name="D_adr(4:0)" />
        <signal name="C(31:0)" />
        <signal name="MUX_A_C(4:0)" />
        <signal name="MUX_B_C(4:0)" />
        <signal name="XLXN_47" />
        <signal name="XLXN_48" />
        <signal name="GPR_WE_RAM" />
        <signal name="C_adr(0)" />
        <signal name="C_adr(1)" />
        <signal name="C_adr(2)" />
        <signal name="C_adr(4)" />
        <signal name="C_adr(3)" />
        <signal name="MUX_D_C(4:0)" />
        <port polarity="Input" name="CLK" />
        <port polarity="Input" name="GPR_we" />
        <port polarity="Input" name="A_adr(4:0)" />
        <port polarity="Input" name="B_adr(4:0)" />
        <port polarity="Output" name="A(31:0)" />
        <port polarity="Output" name="B(31:0)" />
        <port polarity="Output" name="D(31:0)" />
        <port polarity="Output" name="AEQZ_O" />
        <port polarity="Input" name="C_adr(4:0)" />
        <port polarity="Input" name="D_adr(4:0)" />
        <port polarity="Input" name="C(31:0)" />
        <blockdef name="RAM32x32">
            <timestamp>2024-4-10T5:17:8</timestamp>
            <rect width="256" x="64" y="-256" height="256" />
            <line x2="0" y1="-224" y2="-224" x1="64" />
            <line x2="0" y1="-160" y2="-160" x1="64" />
            <rect width="64" x="0" y="-108" height="24" />
            <line x2="0" y1="-96" y2="-96" x1="64" />
            <rect width="64" x="0" y="-44" height="24" />
            <line x2="0" y1="-32" y2="-32" x1="64" />
            <rect width="64" x="320" y="-236" height="24" />
            <line x2="384" y1="-224" y2="-224" x1="320" />
        </blockdef>
        <blockdef name="MUX5bit">
            <timestamp>2024-4-10T7:9:50</timestamp>
            <rect width="256" x="64" y="-192" height="192" />
            <line x2="0" y1="-160" y2="-160" x1="64" />
            <rect width="64" x="0" y="-108" height="24" />
            <line x2="0" y1="-96" y2="-96" x1="64" />
            <rect width="64" x="0" y="-44" height="24" />
            <line x2="0" y1="-32" y2="-32" x1="64" />
            <rect width="64" x="320" y="-172" height="24" />
            <line x2="384" y1="-160" y2="-160" x1="320" />
        </blockdef>
        <blockdef name="AEQZ">
            <timestamp>2024-4-10T5:15:16</timestamp>
            <rect width="256" x="64" y="-64" height="64" />
            <rect width="64" x="0" y="-44" height="24" />
            <line x2="0" y1="-32" y2="-32" x1="64" />
            <line x2="384" y1="-32" y2="-32" x1="320" />
        </blockdef>
        <blockdef name="or3">
            <timestamp>2000-1-1T10:10:10</timestamp>
            <line x2="48" y1="-64" y2="-64" x1="0" />
            <line x2="72" y1="-128" y2="-128" x1="0" />
            <line x2="48" y1="-192" y2="-192" x1="0" />
            <line x2="192" y1="-128" y2="-128" x1="256" />
            <arc ex="192" ey="-128" sx="112" sy="-80" r="88" cx="116" cy="-168" />
            <arc ex="48" ey="-176" sx="48" sy="-80" r="56" cx="16" cy="-128" />
            <line x2="48" y1="-64" y2="-80" x1="48" />
            <line x2="48" y1="-192" y2="-176" x1="48" />
            <line x2="48" y1="-80" y2="-80" x1="112" />
            <arc ex="112" ey="-176" sx="192" sy="-128" r="88" cx="116" cy="-88" />
            <line x2="48" y1="-176" y2="-176" x1="112" />
        </blockdef>
        <blockdef name="and2">
            <timestamp>2000-1-1T10:10:10</timestamp>
            <line x2="64" y1="-64" y2="-64" x1="0" />
            <line x2="64" y1="-128" y2="-128" x1="0" />
            <line x2="192" y1="-96" y2="-96" x1="256" />
            <arc ex="144" ey="-144" sx="144" sy="-48" r="48" cx="144" cy="-96" />
            <line x2="64" y1="-48" y2="-48" x1="144" />
            <line x2="144" y1="-144" y2="-144" x1="64" />
            <line x2="64" y1="-48" y2="-144" x1="64" />
        </blockdef>
        <block symbolname="RAM32x32" name="XLXI_1">
            <blockpin signalname="CLK" name="CLK" />
            <blockpin signalname="GPR_WE_RAM" name="WE" />
            <blockpin signalname="MUX_A_C(4:0)" name="ADDR(4:0)" />
            <blockpin signalname="C(31:0)" name="DI(31:0)" />
            <blockpin signalname="A(31:0)" name="DO(31:0)" />
        </block>
        <block symbolname="RAM32x32" name="XLXI_2">
            <blockpin signalname="CLK" name="CLK" />
            <blockpin signalname="GPR_WE_RAM" name="WE" />
            <blockpin signalname="MUX_B_C(4:0)" name="ADDR(4:0)" />
            <blockpin signalname="C(31:0)" name="DI(31:0)" />
            <blockpin signalname="B(31:0)" name="DO(31:0)" />
        </block>
        <block symbolname="RAM32x32" name="XLXI_3">
            <blockpin signalname="CLK" name="CLK" />
            <blockpin signalname="GPR_WE_RAM" name="WE" />
            <blockpin signalname="MUX_D_C(4:0)" name="ADDR(4:0)" />
            <blockpin signalname="C(31:0)" name="DI(31:0)" />
            <blockpin signalname="D(31:0)" name="DO(31:0)" />
        </block>
        <block symbolname="MUX5bit" name="XLXI_4">
            <blockpin signalname="GPR_we" name="sel" />
            <blockpin signalname="A_adr(4:0)" name="A(4:0)" />
            <blockpin signalname="C_adr(4:0)" name="B(4:0)" />
            <blockpin signalname="MUX_A_C(4:0)" name="O(4:0)" />
        </block>
        <block symbolname="MUX5bit" name="XLXI_5">
            <blockpin signalname="GPR_we" name="sel" />
            <blockpin signalname="B_adr(4:0)" name="A(4:0)" />
            <blockpin signalname="C_adr(4:0)" name="B(4:0)" />
            <blockpin signalname="MUX_B_C(4:0)" name="O(4:0)" />
        </block>
        <block symbolname="MUX5bit" name="XLXI_6">
            <blockpin signalname="GPR_we" name="sel" />
            <blockpin signalname="D_adr(4:0)" name="A(4:0)" />
            <blockpin signalname="C_adr(4:0)" name="B(4:0)" />
            <blockpin signalname="MUX_D_C(4:0)" name="O(4:0)" />
        </block>
        <block symbolname="AEQZ" name="XLXI_7">
            <blockpin signalname="A(31:0)" name="DI(31:0)" />
            <blockpin signalname="AEQZ_O" name="A_eqz" />
        </block>
        <block symbolname="or3" name="XLXI_8">
            <blockpin signalname="C_adr(0)" name="I0" />
            <blockpin signalname="C_adr(1)" name="I1" />
            <blockpin signalname="C_adr(2)" name="I2" />
            <blockpin signalname="XLXN_47" name="O" />
        </block>
        <block symbolname="or3" name="XLXI_9">
            <blockpin signalname="XLXN_47" name="I0" />
            <blockpin signalname="C_adr(3)" name="I1" />
            <blockpin signalname="C_adr(4)" name="I2" />
            <blockpin signalname="XLXN_48" name="O" />
        </block>
        <block symbolname="and2" name="XLXI_10">
            <blockpin signalname="XLXN_48" name="I0" />
            <blockpin signalname="GPR_we" name="I1" />
            <blockpin signalname="GPR_WE_RAM" name="O" />
        </block>
    </netlist>
    <sheet sheetnum="1" width="3520" height="2720">
        <branch name="CLK">
            <attrtext style="alignment:SOFT-LEFT;fontsize:28;fontname:Arial" attrname="Name" x="544" y="224" type="branch" />
            <wire x2="544" y1="224" y2="224" x1="384" />
        </branch>
        <branch name="GPR_we">
            <attrtext style="alignment:SOFT-LEFT;fontsize:28;fontname:Arial" attrname="Name" x="544" y="304" type="branch" />
            <wire x2="544" y1="304" y2="304" x1="384" />
        </branch>
        <branch name="A_adr(4:0)">
            <attrtext style="alignment:SOFT-LEFT;fontsize:28;fontname:Arial" attrname="Name" x="544" y="384" type="branch" />
            <wire x2="544" y1="384" y2="384" x1="384" />
        </branch>
        <branch name="B_adr(4:0)">
            <attrtext style="alignment:SOFT-LEFT;fontsize:28;fontname:Arial" attrname="Name" x="544" y="464" type="branch" />
            <wire x2="544" y1="464" y2="464" x1="384" />
        </branch>
        <branch name="A(31:0)">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="2976" y="192" type="branch" />
            <wire x2="3136" y1="192" y2="192" x1="2976" />
        </branch>
        <branch name="B(31:0)">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="2976" y="272" type="branch" />
            <wire x2="3136" y1="272" y2="272" x1="2976" />
        </branch>
        <branch name="D(31:0)">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="2976" y="352" type="branch" />
            <wire x2="3136" y1="352" y2="352" x1="2976" />
        </branch>
        <branch name="AEQZ_O">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="2976" y="432" type="branch" />
            <wire x2="3136" y1="432" y2="432" x1="2976" />
        </branch>
        <branch name="C_adr(4:0)">
            <attrtext style="alignment:SOFT-LEFT;fontsize:28;fontname:Arial" attrname="Name" x="544" y="560" type="branch" />
            <wire x2="544" y1="560" y2="560" x1="384" />
        </branch>
        <branch name="D_adr(4:0)">
            <attrtext style="alignment:SOFT-LEFT;fontsize:28;fontname:Arial" attrname="Name" x="544" y="640" type="branch" />
            <wire x2="544" y1="640" y2="640" x1="384" />
        </branch>
        <branch name="C(31:0)">
            <attrtext style="alignment:SOFT-LEFT;fontsize:28;fontname:Arial" attrname="Name" x="544" y="720" type="branch" />
            <wire x2="544" y1="720" y2="720" x1="384" />
        </branch>
        <instance x="560" y="1392" name="XLXI_1" orien="R0">
        </instance>
        <branch name="A(31:0)">
            <attrtext style="alignment:SOFT-LEFT;fontsize:28;fontname:Arial" attrname="Name" x="1040" y="1168" type="branch" />
            <wire x2="1040" y1="1168" y2="1168" x1="944" />
        </branch>
        <branch name="CLK">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="512" y="1168" type="branch" />
            <wire x2="560" y1="1168" y2="1168" x1="512" />
        </branch>
        <branch name="GPR_WE_RAM">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="512" y="1232" type="branch" />
            <wire x2="560" y1="1232" y2="1232" x1="512" />
        </branch>
        <branch name="MUX_A_C(4:0)">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="512" y="1296" type="branch" />
            <wire x2="560" y1="1296" y2="1296" x1="512" />
        </branch>
        <branch name="C(31:0)">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="512" y="1360" type="branch" />
            <wire x2="560" y1="1360" y2="1360" x1="512" />
        </branch>
        <instance x="1440" y="1392" name="XLXI_2" orien="R0">
        </instance>
        <branch name="B(31:0)">
            <attrtext style="alignment:SOFT-LEFT;fontsize:28;fontname:Arial" attrname="Name" x="1920" y="1168" type="branch" />
            <wire x2="1920" y1="1168" y2="1168" x1="1824" />
        </branch>
        <branch name="CLK">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="1392" y="1168" type="branch" />
            <wire x2="1440" y1="1168" y2="1168" x1="1392" />
        </branch>
        <branch name="GPR_WE_RAM">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="1392" y="1232" type="branch" />
            <wire x2="1440" y1="1232" y2="1232" x1="1392" />
        </branch>
        <branch name="MUX_B_C(4:0)">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="1392" y="1296" type="branch" />
            <wire x2="1440" y1="1296" y2="1296" x1="1392" />
        </branch>
        <branch name="C(31:0)">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="1392" y="1360" type="branch" />
            <wire x2="1440" y1="1360" y2="1360" x1="1392" />
        </branch>
        <instance x="2352" y="1392" name="XLXI_3" orien="R0">
        </instance>
        <branch name="D(31:0)">
            <attrtext style="alignment:SOFT-LEFT;fontsize:28;fontname:Arial" attrname="Name" x="2832" y="1168" type="branch" />
            <wire x2="2832" y1="1168" y2="1168" x1="2736" />
        </branch>
        <branch name="CLK">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="2304" y="1168" type="branch" />
            <wire x2="2352" y1="1168" y2="1168" x1="2304" />
        </branch>
        <branch name="GPR_WE_RAM">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="2304" y="1232" type="branch" />
            <wire x2="2352" y1="1232" y2="1232" x1="2304" />
        </branch>
        <branch name="MUX_D_C(4:0)">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="2304" y="1296" type="branch" />
            <wire x2="2352" y1="1296" y2="1296" x1="2304" />
        </branch>
        <branch name="C(31:0)">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="2304" y="1360" type="branch" />
            <wire x2="2352" y1="1360" y2="1360" x1="2304" />
        </branch>
        <instance x="560" y="1696" name="XLXI_4" orien="R0">
        </instance>
        <branch name="GPR_we">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="528" y="1536" type="branch" />
            <wire x2="560" y1="1536" y2="1536" x1="528" />
        </branch>
        <branch name="A_adr(4:0)">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="528" y="1600" type="branch" />
            <wire x2="560" y1="1600" y2="1600" x1="528" />
        </branch>
        <branch name="C_adr(4:0)">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="528" y="1664" type="branch" />
            <wire x2="560" y1="1664" y2="1664" x1="528" />
        </branch>
        <branch name="MUX_A_C(4:0)">
            <attrtext style="alignment:SOFT-LEFT;fontsize:28;fontname:Arial" attrname="Name" x="1008" y="1536" type="branch" />
            <wire x2="1008" y1="1536" y2="1536" x1="944" />
        </branch>
        <branch name="GPR_we">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="1408" y="1536" type="branch" />
            <wire x2="1440" y1="1536" y2="1536" x1="1408" />
        </branch>
        <branch name="B_adr(4:0)">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="1408" y="1600" type="branch" />
            <wire x2="1440" y1="1600" y2="1600" x1="1408" />
        </branch>
        <branch name="C_adr(4:0)">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="1408" y="1664" type="branch" />
            <wire x2="1440" y1="1664" y2="1664" x1="1408" />
        </branch>
        <branch name="MUX_B_C(4:0)">
            <attrtext style="alignment:SOFT-LEFT;fontsize:28;fontname:Arial" attrname="Name" x="1888" y="1536" type="branch" />
            <wire x2="1888" y1="1536" y2="1536" x1="1824" />
        </branch>
        <instance x="1440" y="1696" name="XLXI_5" orien="R0">
        </instance>
        <branch name="GPR_we">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="2320" y="1520" type="branch" />
            <wire x2="2352" y1="1520" y2="1520" x1="2320" />
        </branch>
        <branch name="D_adr(4:0)">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="2320" y="1584" type="branch" />
            <wire x2="2352" y1="1584" y2="1584" x1="2320" />
        </branch>
        <branch name="C_adr(4:0)">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="2320" y="1648" type="branch" />
            <wire x2="2352" y1="1648" y2="1648" x1="2320" />
        </branch>
        <branch name="MUX_D_C(4:0)">
            <attrtext style="alignment:SOFT-LEFT;fontsize:28;fontname:Arial" attrname="Name" x="2800" y="1520" type="branch" />
            <wire x2="2800" y1="1520" y2="1520" x1="2736" />
        </branch>
        <instance x="2352" y="1680" name="XLXI_6" orien="R0">
        </instance>
        <instance x="2368" y="752" name="XLXI_7" orien="R0">
        </instance>
        <branch name="A(31:0)">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="2320" y="720" type="branch" />
            <wire x2="2368" y1="720" y2="720" x1="2320" />
        </branch>
        <branch name="AEQZ_O">
            <attrtext style="alignment:SOFT-LEFT;fontsize:28;fontname:Arial" attrname="Name" x="2816" y="720" type="branch" />
            <wire x2="2816" y1="720" y2="720" x1="2752" />
        </branch>
        <instance x="800" y="2304" name="XLXI_8" orien="R0" />
        <instance x="1168" y="2240" name="XLXI_9" orien="R0" />
        <instance x="1552" y="2176" name="XLXI_10" orien="R0" />
        <branch name="XLXN_47">
            <wire x2="1168" y1="2176" y2="2176" x1="1056" />
        </branch>
        <branch name="XLXN_48">
            <wire x2="1552" y1="2112" y2="2112" x1="1424" />
        </branch>
        <branch name="GPR_we">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="1504" y="2048" type="branch" />
            <wire x2="1552" y1="2048" y2="2048" x1="1504" />
        </branch>
        <branch name="GPR_WE_RAM">
            <attrtext style="alignment:SOFT-LEFT;fontsize:28;fontname:Arial" attrname="Name" x="1888" y="2080" type="branch" />
            <wire x2="1888" y1="2080" y2="2080" x1="1808" />
        </branch>
        <iomarker fontsize="28" x="384" y="224" name="CLK" orien="R180" />
        <iomarker fontsize="28" x="384" y="304" name="GPR_we" orien="R180" />
        <iomarker fontsize="28" x="384" y="384" name="A_adr(4:0)" orien="R180" />
        <iomarker fontsize="28" x="384" y="464" name="B_adr(4:0)" orien="R180" />
        <iomarker fontsize="28" x="384" y="560" name="C_adr(4:0)" orien="R180" />
        <iomarker fontsize="28" x="384" y="640" name="D_adr(4:0)" orien="R180" />
        <iomarker fontsize="28" x="384" y="720" name="C(31:0)" orien="R180" />
        <iomarker fontsize="28" x="3136" y="192" name="A(31:0)" orien="R0" />
        <iomarker fontsize="28" x="3136" y="272" name="B(31:0)" orien="R0" />
        <iomarker fontsize="28" x="3136" y="352" name="D(31:0)" orien="R0" />
        <iomarker fontsize="28" x="3136" y="432" name="AEQZ_O" orien="R0" />
        <branch name="C_adr(0)">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="752" y="2240" type="branch" />
            <wire x2="800" y1="2240" y2="2240" x1="752" />
        </branch>
        <branch name="C_adr(1)">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="736" y="2176" type="branch" />
            <wire x2="800" y1="2176" y2="2176" x1="736" />
        </branch>
        <branch name="C_adr(2)">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="768" y="2112" type="branch" />
            <wire x2="800" y1="2112" y2="2112" x1="768" />
        </branch>
        <branch name="C_adr(4)">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="1120" y="2048" type="branch" />
            <wire x2="1168" y1="2048" y2="2048" x1="1120" />
        </branch>
        <branch name="C_adr(3)">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="1104" y="2112" type="branch" />
            <wire x2="1168" y1="2112" y2="2112" x1="1104" />
        </branch>
    </sheet>
</drawing>