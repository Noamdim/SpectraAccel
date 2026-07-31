<?xml version="1.0" encoding="UTF-8"?>
<drawing version="7">
    <attr value="spartan6" name="DeviceFamilyName">
        <trait delete="all:0" />
        <trait editname="all:0" />
        <trait edittrait="all:0" />
    </attr>
    <netlist>
        <signal name="counter_addr(4:0)" />
        <signal name="LA_Addr(4:0)" />
        <signal name="counter_addr(7:0)" />
        <signal name="XLXN_12" />
        <signal name="D_out(31:0)" />
        <signal name="STATUS(7:0)" />
        <signal name="LA_RUN" />
        <signal name="STS_CE" />
        <signal name="CLK" />
        <signal name="LA_Data_in(31:0)" />
        <signal name="AI(4:0)" />
        <signal name="STOP_N" />
        <signal name="LA_WE" />
        <signal name="STEP_EN" />
        <signal name="IN_INIT" />
        <signal name="XLXN_19" />
        <signal name="XLXN_20" />
        <signal name="XLXN_21" />
        <signal name="IN_INIT_PULSE" />
        <signal name="XLXN_30" />
        <signal name="counter_addr(5)" />
        <signal name="counter_addr(6)" />
        <signal name="counter_addr(7)" />
        <port polarity="Output" name="D_out(31:0)" />
        <port polarity="Output" name="STATUS(7:0)" />
        <port polarity="Input" name="CLK" />
        <port polarity="Input" name="LA_Data_in(31:0)" />
        <port polarity="Input" name="AI(4:0)" />
        <port polarity="Input" name="STOP_N" />
        <port polarity="Input" name="STEP_EN" />
        <port polarity="Input" name="IN_INIT" />
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
        <blockdef name="CNT5">
            <timestamp>2024-4-13T15:49:0</timestamp>
            <rect width="256" x="64" y="-192" height="192" />
            <line x2="0" y1="-160" y2="-160" x1="64" />
            <line x2="0" y1="-96" y2="-96" x1="64" />
            <line x2="0" y1="-32" y2="-32" x1="64" />
            <rect width="64" x="320" y="-172" height="24" />
            <line x2="384" y1="-160" y2="-160" x1="320" />
        </blockdef>
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
        <blockdef name="fd8re">
            <timestamp>2000-1-1T10:10:10</timestamp>
            <line x2="64" y1="-128" y2="-128" x1="0" />
            <line x2="64" y1="-192" y2="-192" x1="0" />
            <line x2="64" y1="-256" y2="-256" x1="0" />
            <line x2="320" y1="-256" y2="-256" x1="384" />
            <line x2="64" y1="-32" y2="-32" x1="0" />
            <rect width="64" x="0" y="-268" height="24" />
            <rect width="64" x="320" y="-268" height="24" />
            <line x2="64" y1="-128" y2="-144" x1="80" />
            <line x2="80" y1="-112" y2="-128" x1="64" />
            <line x2="64" y1="-32" y2="-32" x1="192" />
            <line x2="192" y1="-64" y2="-32" x1="192" />
            <rect width="256" x="64" y="-320" height="256" />
        </blockdef>
        <blockdef name="fd">
            <timestamp>2000-1-1T10:10:10</timestamp>
            <rect width="256" x="64" y="-320" height="256" />
            <line x2="64" y1="-128" y2="-128" x1="0" />
            <line x2="64" y1="-256" y2="-256" x1="0" />
            <line x2="320" y1="-256" y2="-256" x1="384" />
            <line x2="64" y1="-128" y2="-144" x1="80" />
            <line x2="80" y1="-112" y2="-128" x1="64" />
        </blockdef>
        <blockdef name="or2">
            <timestamp>2000-1-1T10:10:10</timestamp>
            <line x2="64" y1="-64" y2="-64" x1="0" />
            <line x2="64" y1="-128" y2="-128" x1="0" />
            <line x2="192" y1="-96" y2="-96" x1="256" />
            <arc ex="192" ey="-96" sx="112" sy="-48" r="88" cx="116" cy="-136" />
            <arc ex="48" ey="-144" sx="48" sy="-48" r="56" cx="16" cy="-96" />
            <line x2="48" y1="-144" y2="-144" x1="112" />
            <arc ex="112" ey="-144" sx="192" sy="-96" r="88" cx="116" cy="-56" />
            <line x2="48" y1="-48" y2="-48" x1="112" />
        </blockdef>
        <blockdef name="inv">
            <timestamp>2000-1-1T10:10:10</timestamp>
            <line x2="64" y1="-32" y2="-32" x1="0" />
            <line x2="160" y1="-32" y2="-32" x1="224" />
            <line x2="128" y1="-64" y2="-32" x1="64" />
            <line x2="64" y1="-32" y2="0" x1="128" />
            <line x2="64" y1="0" y2="-64" x1="64" />
            <circle r="16" cx="144" cy="-32" />
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
        <blockdef name="gnd">
            <timestamp>2000-1-1T10:10:10</timestamp>
            <line x2="64" y1="-64" y2="-96" x1="64" />
            <line x2="52" y1="-48" y2="-48" x1="76" />
            <line x2="60" y1="-32" y2="-32" x1="68" />
            <line x2="40" y1="-64" y2="-64" x1="88" />
            <line x2="64" y1="-64" y2="-80" x1="64" />
            <line x2="64" y1="-128" y2="-96" x1="64" />
        </blockdef>
        <block symbolname="MUX5bit" name="XLXI_1">
            <blockpin signalname="LA_RUN" name="sel" />
            <blockpin signalname="AI(4:0)" name="A(4:0)" />
            <blockpin signalname="counter_addr(4:0)" name="B(4:0)" />
            <blockpin signalname="LA_Addr(4:0)" name="O(4:0)" />
        </block>
        <block symbolname="CNT5" name="XLXI_2">
            <blockpin signalname="CLK" name="CLK" />
            <blockpin signalname="STS_CE" name="RST" />
            <blockpin signalname="LA_WE" name="CE" />
            <blockpin signalname="counter_addr(4:0)" name="CNT(4:0)" />
        </block>
        <block symbolname="RAM32x32" name="XLXI_3">
            <blockpin signalname="CLK" name="CLK" />
            <blockpin signalname="LA_WE" name="WE" />
            <blockpin signalname="LA_Addr(4:0)" name="ADDR(4:0)" />
            <blockpin signalname="LA_Data_in(31:0)" name="DI(31:0)" />
            <blockpin signalname="D_out(31:0)" name="DO(31:0)" />
        </block>
        <block symbolname="fd8re" name="XLXI_4">
            <blockpin signalname="CLK" name="C" />
            <blockpin signalname="STS_CE" name="CE" />
            <blockpin signalname="counter_addr(7:0)" name="D(7:0)" />
            <blockpin signalname="XLXN_12" name="R" />
            <blockpin signalname="STATUS(7:0)" name="Q(7:0)" />
        </block>
        <block symbolname="gnd" name="XLXI_13">
            <blockpin signalname="XLXN_12" name="G" />
        </block>
        <block symbolname="fd" name="XLXI_5">
            <blockpin signalname="CLK" name="C" />
            <blockpin signalname="IN_INIT" name="D" />
            <blockpin signalname="XLXN_21" name="Q" />
        </block>
        <block symbolname="fd" name="XLXI_6">
            <blockpin signalname="CLK" name="C" />
            <blockpin signalname="IN_INIT_PULSE" name="D" />
            <blockpin signalname="STS_CE" name="Q" />
        </block>
        <block symbolname="or2" name="XLXI_7">
            <blockpin signalname="STEP_EN" name="I0" />
            <blockpin signalname="XLXN_19" name="I1" />
            <blockpin signalname="XLXN_20" name="O" />
        </block>
        <block symbolname="or2" name="XLXI_8">
            <blockpin signalname="IN_INIT_PULSE" name="I0" />
            <blockpin signalname="XLXN_20" name="I1" />
            <blockpin signalname="LA_RUN" name="O" />
        </block>
        <block symbolname="inv" name="XLXI_9">
            <blockpin signalname="IN_INIT" name="I" />
            <blockpin signalname="XLXN_19" name="O" />
        </block>
        <block symbolname="inv" name="XLXI_10">
            <blockpin signalname="XLXN_21" name="I" />
            <blockpin signalname="XLXN_30" name="O" />
        </block>
        <block symbolname="and2" name="XLXI_11">
            <blockpin signalname="STOP_N" name="I0" />
            <blockpin signalname="LA_RUN" name="I1" />
            <blockpin signalname="LA_WE" name="O" />
        </block>
        <block symbolname="and2" name="XLXI_12">
            <blockpin signalname="IN_INIT" name="I0" />
            <blockpin signalname="XLXN_30" name="I1" />
            <blockpin signalname="IN_INIT_PULSE" name="O" />
        </block>
        <block symbolname="gnd" name="XLXI_14">
            <blockpin signalname="counter_addr(7)" name="G" />
        </block>
        <block symbolname="gnd" name="XLXI_29">
            <blockpin signalname="counter_addr(6)" name="G" />
        </block>
        <block symbolname="gnd" name="XLXI_30">
            <blockpin signalname="counter_addr(5)" name="G" />
        </block>
    </netlist>
    <sheet sheetnum="1" width="3520" height="2720">
        <instance x="976" y="448" name="XLXI_1" orien="R0">
        </instance>
        <instance x="960" y="784" name="XLXI_2" orien="R0">
        </instance>
        <instance x="2096" y="480" name="XLXI_3" orien="R0">
        </instance>
        <instance x="2080" y="912" name="XLXI_4" orien="R0" />
        <branch name="LA_RUN">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="928" y="288" type="branch" />
            <wire x2="976" y1="288" y2="288" x1="928" />
        </branch>
        <branch name="AI(4:0)">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="928" y="352" type="branch" />
            <wire x2="976" y1="352" y2="352" x1="928" />
        </branch>
        <branch name="counter_addr(4:0)">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="928" y="416" type="branch" />
            <wire x2="976" y1="416" y2="416" x1="928" />
        </branch>
        <branch name="CLK">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="928" y="624" type="branch" />
            <wire x2="960" y1="624" y2="624" x1="928" />
        </branch>
        <branch name="STS_CE">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="928" y="688" type="branch" />
            <wire x2="960" y1="688" y2="688" x1="928" />
        </branch>
        <branch name="LA_WE">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="928" y="752" type="branch" />
            <wire x2="960" y1="752" y2="752" x1="928" />
        </branch>
        <branch name="counter_addr(4:0)">
            <attrtext style="alignment:SOFT-LEFT;fontsize:28;fontname:Arial" attrname="Name" x="1392" y="624" type="branch" />
            <wire x2="1392" y1="624" y2="624" x1="1344" />
        </branch>
        <branch name="LA_Addr(4:0)">
            <attrtext style="alignment:SOFT-LEFT;fontsize:28;fontname:Arial" attrname="Name" x="1408" y="288" type="branch" />
            <wire x2="1408" y1="288" y2="288" x1="1360" />
        </branch>
        <branch name="counter_addr(7:0)">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="2032" y="656" type="branch" />
            <wire x2="2080" y1="656" y2="656" x1="2032" />
        </branch>
        <branch name="STS_CE">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="2016" y="720" type="branch" />
            <wire x2="2080" y1="720" y2="720" x1="2016" />
        </branch>
        <branch name="CLK">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="2032" y="784" type="branch" />
            <wire x2="2080" y1="784" y2="784" x1="2032" />
        </branch>
        <branch name="XLXN_12">
            <wire x2="2080" y1="880" y2="880" x1="2016" />
        </branch>
        <branch name="LA_Data_in(31:0)">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="2064" y="448" type="branch" />
            <wire x2="2096" y1="448" y2="448" x1="2064" />
        </branch>
        <branch name="LA_Addr(4:0)">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="2064" y="384" type="branch" />
            <wire x2="2096" y1="384" y2="384" x1="2064" />
        </branch>
        <branch name="LA_WE">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="2048" y="320" type="branch" />
            <wire x2="2096" y1="320" y2="320" x1="2048" />
        </branch>
        <branch name="CLK">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="2048" y="256" type="branch" />
            <wire x2="2096" y1="256" y2="256" x1="2048" />
        </branch>
        <branch name="D_out(31:0)">
            <wire x2="2496" y1="256" y2="256" x1="2480" />
            <wire x2="2512" y1="256" y2="256" x1="2496" />
        </branch>
        <branch name="STATUS(7:0)">
            <wire x2="2496" y1="656" y2="656" x1="2464" />
        </branch>
        <branch name="CLK">
            <attrtext style="alignment:SOFT-LEFT;fontsize:28;fontname:Arial" attrname="Name" x="448" y="208" type="branch" />
            <wire x2="448" y1="208" y2="208" x1="352" />
        </branch>
        <branch name="LA_Data_in(31:0)">
            <attrtext style="alignment:SOFT-LEFT;fontsize:28;fontname:Arial" attrname="Name" x="448" y="288" type="branch" />
            <wire x2="448" y1="288" y2="288" x1="336" />
        </branch>
        <iomarker fontsize="28" x="352" y="208" name="CLK" orien="R180" />
        <iomarker fontsize="28" x="336" y="288" name="LA_Data_in(31:0)" orien="R180" />
        <branch name="AI(4:0)">
            <attrtext style="alignment:SOFT-LEFT;fontsize:28;fontname:Arial" attrname="Name" x="448" y="368" type="branch" />
            <wire x2="448" y1="368" y2="368" x1="320" />
        </branch>
        <iomarker fontsize="28" x="320" y="368" name="AI(4:0)" orien="R180" />
        <branch name="STOP_N">
            <attrtext style="alignment:SOFT-LEFT;fontsize:28;fontname:Arial" attrname="Name" x="448" y="432" type="branch" />
            <wire x2="448" y1="432" y2="432" x1="336" />
        </branch>
        <iomarker fontsize="28" x="336" y="432" name="STOP_N" orien="R180" />
        <branch name="STEP_EN">
            <attrtext style="alignment:SOFT-LEFT;fontsize:28;fontname:Arial" attrname="Name" x="432" y="496" type="branch" />
            <wire x2="432" y1="496" y2="496" x1="320" />
        </branch>
        <iomarker fontsize="28" x="320" y="496" name="STEP_EN" orien="R180" />
        <branch name="IN_INIT">
            <attrtext style="alignment:SOFT-LEFT;fontsize:28;fontname:Arial" attrname="Name" x="432" y="576" type="branch" />
            <wire x2="432" y1="576" y2="576" x1="336" />
        </branch>
        <iomarker fontsize="28" x="336" y="576" name="IN_INIT" orien="R180" />
        <instance x="1952" y="1008" name="XLXI_13" orien="R0" />
        <iomarker fontsize="28" x="2496" y="656" name="STATUS(7:0)" orien="R0" />
        <iomarker fontsize="28" x="2512" y="256" name="D_out(31:0)" orien="R0" />
        <instance x="496" y="1856" name="XLXI_5" orien="R0" />
        <instance x="1888" y="2016" name="XLXI_6" orien="R0" />
        <instance x="704" y="1312" name="XLXI_7" orien="R0" />
        <instance x="1392" y="1360" name="XLXI_8" orien="R0" />
        <instance x="384" y="1216" name="XLXI_9" orien="R0" />
        <instance x="1008" y="1632" name="XLXI_10" orien="R0" />
        <branch name="XLXN_19">
            <wire x2="704" y1="1184" y2="1184" x1="608" />
        </branch>
        <branch name="XLXN_20">
            <wire x2="1168" y1="1216" y2="1216" x1="960" />
            <wire x2="1168" y1="1216" y2="1232" x1="1168" />
            <wire x2="1392" y1="1232" y2="1232" x1="1168" />
        </branch>
        <branch name="XLXN_21">
            <wire x2="1008" y1="1600" y2="1600" x1="880" />
        </branch>
        <branch name="IN_INIT">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="448" y="1600" type="branch" />
            <wire x2="496" y1="1600" y2="1600" x1="448" />
        </branch>
        <branch name="CLK">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="448" y="1728" type="branch" />
            <wire x2="496" y1="1728" y2="1728" x1="448" />
        </branch>
        <branch name="IN_INIT">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="336" y="1184" type="branch" />
            <wire x2="384" y1="1184" y2="1184" x1="336" />
        </branch>
        <branch name="STEP_EN">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="640" y="1248" type="branch" />
            <wire x2="704" y1="1248" y2="1248" x1="640" />
        </branch>
        <branch name="IN_INIT_PULSE">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="1344" y="1296" type="branch" />
            <wire x2="1392" y1="1296" y2="1296" x1="1344" />
        </branch>
        <branch name="LA_RUN">
            <attrtext style="alignment:SOFT-LEFT;fontsize:28;fontname:Arial" attrname="Name" x="1696" y="1264" type="branch" />
            <wire x2="1696" y1="1264" y2="1264" x1="1648" />
        </branch>
        <branch name="IN_INIT_PULSE">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="1840" y="1760" type="branch" />
            <wire x2="1888" y1="1760" y2="1760" x1="1840" />
        </branch>
        <branch name="CLK">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="1824" y="1888" type="branch" />
            <wire x2="1888" y1="1888" y2="1888" x1="1824" />
        </branch>
        <branch name="XLXN_30">
            <wire x2="1248" y1="1600" y2="1600" x1="1232" />
        </branch>
        <branch name="STS_CE">
            <attrtext style="alignment:SOFT-LEFT;fontsize:28;fontname:Arial" attrname="Name" x="2320" y="1760" type="branch" />
            <wire x2="2320" y1="1760" y2="1760" x1="2272" />
        </branch>
        <instance x="2256" y="1360" name="XLXI_11" orien="R0" />
        <branch name="LA_RUN">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="2224" y="1232" type="branch" />
            <wire x2="2256" y1="1232" y2="1232" x1="2224" />
        </branch>
        <branch name="STOP_N">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="2224" y="1296" type="branch" />
            <wire x2="2256" y1="1296" y2="1296" x1="2224" />
        </branch>
        <branch name="LA_WE">
            <attrtext style="alignment:SOFT-LEFT;fontsize:28;fontname:Arial" attrname="Name" x="2544" y="1264" type="branch" />
            <wire x2="2544" y1="1264" y2="1264" x1="2512" />
        </branch>
        <instance x="1248" y="1728" name="XLXI_12" orien="R0" />
        <branch name="IN_INIT">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="1216" y="1664" type="branch" />
            <wire x2="1248" y1="1664" y2="1664" x1="1216" />
        </branch>
        <branch name="IN_INIT_PULSE">
            <attrtext style="alignment:SOFT-LEFT;fontsize:28;fontname:Arial" attrname="Name" x="1520" y="1632" type="branch" />
            <wire x2="1520" y1="1632" y2="1632" x1="1504" />
        </branch>
        <instance x="2816" y="1168" name="XLXI_14" orien="R0" />
        <instance x="2816" y="944" name="XLXI_29" orien="R0" />
        <instance x="2816" y="784" name="XLXI_30" orien="R0" />
        <branch name="counter_addr(5)">
            <attrtext style="alignment:SOFT-LEFT;fontsize:28;fontname:Arial" attrname="Name" x="2944" y="640" type="branch" />
            <wire x2="2880" y1="640" y2="656" x1="2880" />
            <wire x2="2944" y1="640" y2="640" x1="2880" />
        </branch>
        <branch name="counter_addr(6)">
            <attrtext style="alignment:SOFT-LEFT;fontsize:28;fontname:Arial" attrname="Name" x="2976" y="768" type="branch" />
            <wire x2="2880" y1="768" y2="816" x1="2880" />
            <wire x2="2976" y1="768" y2="768" x1="2880" />
        </branch>
        <branch name="counter_addr(7)">
            <attrtext style="alignment:SOFT-LEFT;fontsize:28;fontname:Arial" attrname="Name" x="2992" y="1024" type="branch" />
            <wire x2="2880" y1="1024" y2="1040" x1="2880" />
            <wire x2="2960" y1="1024" y2="1024" x1="2880" />
            <wire x2="2992" y1="1024" y2="1024" x1="2960" />
        </branch>
    </sheet>
</drawing>