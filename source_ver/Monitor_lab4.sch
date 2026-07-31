<?xml version="1.0" encoding="UTF-8"?>
<drawing version="7">
    <attr value="spartan6" name="DeviceFamilyName">
        <trait delete="all:0" />
        <trait editname="all:0" />
        <trait edittrait="all:0" />
    </attr>
    <netlist>
        <signal name="IN_INIT" />
        <signal name="ID_NAME(7:0)" />
        <signal name="Status_id(31:0)" />
        <signal name="SACK_N" />
        <signal name="SDO(31:0)" />
        <signal name="reg_address(4:0)" />
        <signal name="B(31:0)" />
        <signal name="C(31:0)" />
        <signal name="CLK" />
        <signal name="RESET" />
        <signal name="AI(9:0)" />
        <signal name="LA_Data_in(31:0)" />
        <signal name="STOP_N" />
        <signal name="STEP_EN" />
        <signal name="WR_IN_N" />
        <signal name="CARD_SEL" />
        <signal name="STATUS(7:0)" />
        <signal name="AI(4:0)" />
        <signal name="D_out(31:0)" />
        <port polarity="Input" name="IN_INIT" />
        <port polarity="Output" name="SACK_N" />
        <port polarity="Output" name="SDO(31:0)" />
        <port polarity="Output" name="reg_address(4:0)" />
        <port polarity="Input" name="B(31:0)" />
        <port polarity="Input" name="C(31:0)" />
        <port polarity="Input" name="CLK" />
        <port polarity="Input" name="RESET" />
        <port polarity="Input" name="AI(9:0)" />
        <port polarity="Input" name="LA_Data_in(31:0)" />
        <port polarity="Input" name="STOP_N" />
        <port polarity="Input" name="STEP_EN" />
        <port polarity="Input" name="WR_IN_N" />
        <port polarity="Input" name="CARD_SEL" />
        <blockdef name="Logic_Analyzer">
            <timestamp>2026-5-19T7:28:30</timestamp>
            <rect width="336" x="64" y="-384" height="384" />
            <line x2="0" y1="-352" y2="-352" x1="64" />
            <rect width="64" x="0" y="-300" height="24" />
            <line x2="0" y1="-288" y2="-288" x1="64" />
            <rect width="64" x="0" y="-236" height="24" />
            <line x2="0" y1="-224" y2="-224" x1="64" />
            <line x2="0" y1="-160" y2="-160" x1="64" />
            <line x2="0" y1="-96" y2="-96" x1="64" />
            <line x2="0" y1="-32" y2="-32" x1="64" />
            <rect width="64" x="400" y="-364" height="24" />
            <line x2="464" y1="-352" y2="-352" x1="400" />
            <rect width="64" x="400" y="-44" height="24" />
            <line x2="464" y1="-32" y2="-32" x1="400" />
        </blockdef>
        <blockdef name="slave_mux">
            <timestamp>2026-5-12T7:21:28</timestamp>
            <rect width="320" x="64" y="-576" height="576" />
            <line x2="0" y1="-544" y2="-544" x1="64" />
            <line x2="0" y1="-480" y2="-480" x1="64" />
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
            <line x2="448" y1="-544" y2="-544" x1="384" />
            <rect width="64" x="384" y="-300" height="24" />
            <line x2="448" y1="-288" y2="-288" x1="384" />
            <rect width="64" x="384" y="-44" height="24" />
            <line x2="448" y1="-32" y2="-32" x1="384" />
        </blockdef>
        <blockdef name="ID_name_1">
            <timestamp>2026-5-12T8:39:27</timestamp>
            <rect width="256" x="64" y="-64" height="64" />
            <rect width="64" x="320" y="-44" height="24" />
            <line x2="384" y1="-32" y2="-32" x1="320" />
        </blockdef>
        <blockdef name="concat_8_bit">
            <timestamp>2026-5-19T9:8:57</timestamp>
            <rect width="64" x="320" y="84" height="24" />
            <line x2="384" y1="96" y2="96" x1="320" />
            <rect width="64" x="0" y="-108" height="24" />
            <line x2="0" y1="-96" y2="-96" x1="64" />
            <rect width="64" x="0" y="-44" height="24" />
            <line x2="0" y1="-32" y2="-32" x1="64" />
            <rect width="256" x="64" y="-128" height="256" />
        </blockdef>
        <block symbolname="slave_mux" name="XLXI_3">
            <blockpin signalname="WR_IN_N" name="WR_IN_N" />
            <blockpin signalname="CARD_SEL" name="CARD_SEL" />
            <blockpin signalname="CLK" name="clk" />
            <blockpin signalname="RESET" name="reset" />
            <blockpin signalname="AI(9:0)" name="AI(9:0)" />
            <blockpin signalname="D_out(31:0)" name="a(31:0)" />
            <blockpin signalname="B(31:0)" name="b(31:0)" />
            <blockpin signalname="C(31:0)" name="c(31:0)" />
            <blockpin signalname="Status_id(31:0)" name="d(31:0)" />
            <blockpin signalname="SACK_N" name="SACK_N" />
            <blockpin signalname="SDO(31:0)" name="SDO(31:0)" />
            <blockpin signalname="reg_address(4:0)" name="reg_address(4:0)" />
        </block>
        <block symbolname="ID_name_1" name="XLXI_4">
            <blockpin signalname="ID_NAME(7:0)" name="ID_name_1(7:0)" />
        </block>
        <block symbolname="Logic_Analyzer" name="XLXI_1">
            <blockpin signalname="CLK" name="CLK" />
            <blockpin signalname="LA_Data_in(31:0)" name="LA_Data_in(31:0)" />
            <blockpin signalname="AI(4:0)" name="AI(4:0)" />
            <blockpin signalname="STOP_N" name="STOP_N" />
            <blockpin signalname="STEP_EN" name="STEP_EN" />
            <blockpin signalname="IN_INIT" name="IN_INIT" />
            <blockpin signalname="D_out(31:0)" name="D_out(31:0)" />
            <blockpin signalname="STATUS(7:0)" name="STATUS(7:0)" />
        </block>
        <block symbolname="concat_8_bit" name="XLXI_10">
            <blockpin signalname="STATUS(7:0)" name="in_1(7:0)" />
            <blockpin signalname="ID_NAME(7:0)" name="in_2(7:0)" />
            <blockpin signalname="Status_id(31:0)" name="concat_out1(31:0)" />
        </block>
    </netlist>
    <sheet sheetnum="1" width="3520" height="2720">
        <instance x="2240" y="1136" name="XLXI_3" orien="R0">
        </instance>
        <instance x="928" y="1440" name="XLXI_4" orien="R0">
        </instance>
        <branch name="ID_NAME(7:0)">
            <attrtext style="alignment:SOFT-LEFT;fontsize:28;fontname:Arial" attrname="Name" x="1424" y="1408" type="branch" />
            <wire x2="1424" y1="1408" y2="1408" x1="1312" />
        </branch>
        <branch name="STATUS(7:0)">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="1376" y="1568" type="branch" />
            <wire x2="1488" y1="1568" y2="1568" x1="1376" />
        </branch>
        <branch name="ID_NAME(7:0)">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="1376" y="1632" type="branch" />
            <wire x2="1488" y1="1632" y2="1632" x1="1376" />
        </branch>
        <branch name="SACK_N">
            <wire x2="2768" y1="592" y2="592" x1="2688" />
        </branch>
        <branch name="SDO(31:0)">
            <wire x2="2816" y1="848" y2="848" x1="2688" />
        </branch>
        <branch name="reg_address(4:0)">
            <wire x2="2816" y1="1104" y2="1104" x1="2688" />
        </branch>
        <branch name="WR_IN_N">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="2160" y="592" type="branch" />
            <wire x2="2240" y1="592" y2="592" x1="2160" />
        </branch>
        <branch name="CARD_SEL">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="2128" y="656" type="branch" />
            <wire x2="2240" y1="656" y2="656" x1="2128" />
        </branch>
        <branch name="CLK">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="2144" y="720" type="branch" />
            <wire x2="2240" y1="720" y2="720" x1="2144" />
        </branch>
        <branch name="RESET">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="2128" y="784" type="branch" />
            <wire x2="2240" y1="784" y2="784" x1="2128" />
        </branch>
        <branch name="AI(9:0)">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="2128" y="848" type="branch" />
            <wire x2="2240" y1="848" y2="848" x1="2128" />
        </branch>
        <branch name="B(31:0)">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="2144" y="976" type="branch" />
            <wire x2="2240" y1="976" y2="976" x1="2144" />
        </branch>
        <branch name="C(31:0)">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="2128" y="1040" type="branch" />
            <wire x2="2240" y1="1040" y2="1040" x1="2128" />
        </branch>
        <branch name="CLK">
            <attrtext style="alignment:SOFT-LEFT;fontsize:28;fontname:Arial" attrname="Name" x="416" y="160" type="branch" />
            <wire x2="416" y1="160" y2="160" x1="320" />
        </branch>
        <branch name="RESET">
            <attrtext style="alignment:SOFT-LEFT;fontsize:28;fontname:Arial" attrname="Name" x="432" y="240" type="branch" />
            <wire x2="432" y1="240" y2="240" x1="320" />
        </branch>
        <branch name="LA_Data_in(31:0)">
            <attrtext style="alignment:SOFT-LEFT;fontsize:28;fontname:Arial" attrname="Name" x="416" y="384" type="branch" />
            <wire x2="416" y1="384" y2="384" x1="320" />
        </branch>
        <branch name="STOP_N">
            <attrtext style="alignment:SOFT-LEFT;fontsize:28;fontname:Arial" attrname="Name" x="416" y="464" type="branch" />
            <wire x2="416" y1="464" y2="464" x1="320" />
        </branch>
        <iomarker fontsize="28" x="320" y="160" name="CLK" orien="R180" />
        <iomarker fontsize="28" x="320" y="240" name="RESET" orien="R180" />
        <branch name="STEP_EN">
            <attrtext style="alignment:SOFT-LEFT;fontsize:28;fontname:Arial" attrname="Name" x="416" y="544" type="branch" />
            <wire x2="416" y1="544" y2="544" x1="320" />
        </branch>
        <branch name="IN_INIT">
            <attrtext style="alignment:SOFT-LEFT;fontsize:28;fontname:Arial" attrname="Name" x="416" y="640" type="branch" />
            <wire x2="416" y1="640" y2="640" x1="320" />
        </branch>
        <branch name="WR_IN_N">
            <attrtext style="alignment:SOFT-LEFT;fontsize:28;fontname:Arial" attrname="Name" x="416" y="720" type="branch" />
            <wire x2="416" y1="720" y2="720" x1="320" />
        </branch>
        <branch name="CARD_SEL">
            <attrtext style="alignment:SOFT-LEFT;fontsize:28;fontname:Arial" attrname="Name" x="416" y="800" type="branch" />
            <wire x2="416" y1="800" y2="800" x1="320" />
        </branch>
        <branch name="AI(9:0)">
            <attrtext style="alignment:SOFT-LEFT;fontsize:28;fontname:Arial" attrname="Name" x="416" y="320" type="branch" />
            <wire x2="416" y1="320" y2="320" x1="304" />
        </branch>
        <iomarker fontsize="28" x="304" y="320" name="AI(9:0)" orien="R180" />
        <iomarker fontsize="28" x="320" y="384" name="LA_Data_in(31:0)" orien="R180" />
        <iomarker fontsize="28" x="320" y="464" name="STOP_N" orien="R180" />
        <instance x="976" y="1040" name="XLXI_1" orien="R0">
        </instance>
        <branch name="STATUS(7:0)">
            <attrtext style="alignment:SOFT-LEFT;fontsize:28;fontname:Arial" attrname="Name" x="1552" y="1008" type="branch" />
            <wire x2="1552" y1="1008" y2="1008" x1="1440" />
        </branch>
        <branch name="CLK">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="880" y="688" type="branch" />
            <wire x2="976" y1="688" y2="688" x1="880" />
        </branch>
        <branch name="LA_Data_in(31:0)">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="896" y="752" type="branch" />
            <wire x2="976" y1="752" y2="752" x1="896" />
        </branch>
        <branch name="AI(4:0)">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="880" y="816" type="branch" />
            <wire x2="976" y1="816" y2="816" x1="880" />
        </branch>
        <branch name="STOP_N">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="880" y="880" type="branch" />
            <wire x2="976" y1="880" y2="880" x1="880" />
        </branch>
        <branch name="STEP_EN">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="880" y="944" type="branch" />
            <wire x2="976" y1="944" y2="944" x1="880" />
        </branch>
        <branch name="IN_INIT">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="880" y="1008" type="branch" />
            <wire x2="976" y1="1008" y2="1008" x1="880" />
        </branch>
        <iomarker fontsize="28" x="320" y="544" name="STEP_EN" orien="R180" />
        <iomarker fontsize="28" x="320" y="640" name="IN_INIT" orien="R180" />
        <iomarker fontsize="28" x="320" y="720" name="WR_IN_N" orien="R180" />
        <iomarker fontsize="28" x="320" y="800" name="CARD_SEL" orien="R180" />
        <branch name="B(31:0)">
            <attrtext style="alignment:SOFT-LEFT;fontsize:28;fontname:Arial" attrname="Name" x="416" y="880" type="branch" />
            <wire x2="416" y1="880" y2="880" x1="320" />
        </branch>
        <branch name="C(31:0)">
            <attrtext style="alignment:SOFT-LEFT;fontsize:28;fontname:Arial" attrname="Name" x="416" y="960" type="branch" />
            <wire x2="416" y1="960" y2="960" x1="320" />
        </branch>
        <iomarker fontsize="28" x="320" y="880" name="B(31:0)" orien="R180" />
        <iomarker fontsize="28" x="320" y="960" name="C(31:0)" orien="R180" />
        <iomarker fontsize="28" x="2768" y="592" name="SACK_N" orien="R0" />
        <iomarker fontsize="28" x="2816" y="848" name="SDO(31:0)" orien="R0" />
        <iomarker fontsize="28" x="2816" y="1104" name="reg_address(4:0)" orien="R0" />
        <branch name="Status_id(31:0)">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="2160" y="1104" type="branch" />
            <wire x2="2240" y1="1104" y2="1104" x1="2160" />
        </branch>
        <branch name="D_out(31:0)">
            <attrtext style="alignment:SOFT-LEFT;fontsize:28;fontname:Arial" attrname="Name" x="1552" y="688" type="branch" />
            <wire x2="1552" y1="688" y2="688" x1="1440" />
        </branch>
        <branch name="D_out(31:0)">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="2128" y="912" type="branch" />
            <wire x2="2240" y1="912" y2="912" x1="2128" />
        </branch>
        <instance x="1488" y="1664" name="XLXI_10" orien="R0">
        </instance>
        <branch name="Status_id(31:0)">
            <attrtext style="alignment:SOFT-LEFT;fontsize:28;fontname:Arial" attrname="Name" x="2000" y="1760" type="branch" />
            <wire x2="2000" y1="1760" y2="1760" x1="1872" />
        </branch>
    </sheet>
</drawing>