<?xml version="1.0" encoding="UTF-8"?>
<drawing version="7">
    <attr value="spartan6" name="DeviceFamilyName">
        <trait delete="all:0" />
        <trait editname="all:0" />
        <trait edittrait="all:0" />
    </attr>
    <netlist>
        <signal name="A(31:0)" />
        <signal name="B(31:0)" />
        <signal name="sub" />
        <signal name="ovf" />
        <signal name="result(31:0)" />
        <signal name="ADD" />
        <signal name="carry_out" />
        <signal name="result(15:0)" />
        <signal name="B(15:0)" />
        <signal name="A(15:0)" />
        <signal name="B(31:16)" />
        <signal name="A(31:16)" />
        <signal name="result(31:16)" />
        <signal name="XLXN_34" />
        <signal name="XLXN_35" />
        <signal name="carry_out_cin_high" />
        <signal name="carry_out_cin_low" />
        <signal name="XLXN_36(15:0)" />
        <signal name="XLXN_37(15:0)" />
        <signal name="XLXN_38(15:0)" />
        <signal name="neg" />
        <signal name="A(31)" />
        <signal name="B(31)" />
        <signal name="carry_out_real" />
        <signal name="XLXN_45" />
        <signal name="XLXN_51" />
        <port polarity="Input" name="A(31:0)" />
        <port polarity="Input" name="B(31:0)" />
        <port polarity="Input" name="sub" />
        <port polarity="Output" name="ovf" />
        <port polarity="Output" name="result(31:0)" />
        <port polarity="Output" name="neg" />
        <blockdef name="adsu16">
            <timestamp>2000-1-1T10:10:10</timestamp>
            <line x2="384" y1="-64" y2="-64" x1="240" />
            <line x2="240" y1="-124" y2="-64" x1="240" />
            <rect width="64" x="0" y="-204" height="24" />
            <rect width="64" x="0" y="-332" height="24" />
            <rect width="64" x="384" y="-268" height="24" />
            <line x2="64" y1="-448" y2="-448" x1="128" />
            <line x2="128" y1="-416" y2="-448" x1="128" />
            <line x2="48" y1="-64" y2="-64" x1="128" />
            <line x2="128" y1="-96" y2="-64" x1="128" />
            <line x2="64" y1="-288" y2="-432" x1="64" />
            <line x2="64" y1="-256" y2="-288" x1="128" />
            <line x2="128" y1="-224" y2="-256" x1="64" />
            <line x2="64" y1="-80" y2="-224" x1="64" />
            <line x2="64" y1="-160" y2="-80" x1="384" />
            <line x2="384" y1="-336" y2="-160" x1="384" />
            <line x2="384" y1="-352" y2="-336" x1="384" />
            <line x2="384" y1="-432" y2="-352" x1="64" />
            <line x2="336" y1="-128" y2="-148" x1="336" />
            <line x2="336" y1="-128" y2="-128" x1="384" />
            <line x2="384" y1="-256" y2="-256" x1="448" />
            <line x2="384" y1="-128" y2="-128" x1="448" />
            <line x2="384" y1="-64" y2="-64" x1="448" />
            <line x2="64" y1="-448" y2="-448" x1="0" />
            <line x2="64" y1="-192" y2="-192" x1="0" />
            <line x2="64" y1="-320" y2="-320" x1="0" />
            <line x2="64" y1="-64" y2="-64" x1="0" />
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
        <blockdef name="vcc">
            <timestamp>2000-1-1T10:10:10</timestamp>
            <line x2="64" y1="-32" y2="-64" x1="64" />
            <line x2="64" y1="0" y2="-32" x1="64" />
            <line x2="32" y1="-64" y2="-64" x1="96" />
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
        <blockdef name="MUX16bit">
            <timestamp>2024-4-10T7:9:32</timestamp>
            <rect width="256" x="64" y="-192" height="192" />
            <line x2="0" y1="-160" y2="-160" x1="64" />
            <rect width="64" x="0" y="-108" height="24" />
            <line x2="0" y1="-96" y2="-96" x1="64" />
            <rect width="64" x="0" y="-44" height="24" />
            <line x2="0" y1="-32" y2="-32" x1="64" />
            <rect width="64" x="320" y="-172" height="24" />
            <line x2="384" y1="-160" y2="-160" x1="320" />
        </blockdef>
        <blockdef name="buf">
            <timestamp>2000-1-1T10:10:10</timestamp>
            <line x2="64" y1="-32" y2="-32" x1="0" />
            <line x2="128" y1="-32" y2="-32" x1="224" />
            <line x2="128" y1="0" y2="-32" x1="64" />
            <line x2="64" y1="-32" y2="-64" x1="128" />
            <line x2="64" y1="-64" y2="0" x1="64" />
        </blockdef>
        <blockdef name="m2_1">
            <timestamp>2000-1-1T10:10:10</timestamp>
            <line x2="96" y1="-64" y2="-192" x1="96" />
            <line x2="96" y1="-96" y2="-64" x1="256" />
            <line x2="256" y1="-160" y2="-96" x1="256" />
            <line x2="256" y1="-192" y2="-160" x1="96" />
            <line x2="96" y1="-32" y2="-32" x1="176" />
            <line x2="176" y1="-80" y2="-32" x1="176" />
            <line x2="96" y1="-32" y2="-32" x1="0" />
            <line x2="256" y1="-128" y2="-128" x1="320" />
            <line x2="96" y1="-96" y2="-96" x1="0" />
            <line x2="96" y1="-160" y2="-160" x1="0" />
        </blockdef>
        <blockdef name="xor4">
            <timestamp>2000-1-1T10:10:10</timestamp>
            <line x2="48" y1="-64" y2="-64" x1="0" />
            <line x2="64" y1="-128" y2="-128" x1="0" />
            <line x2="60" y1="-192" y2="-192" x1="0" />
            <line x2="48" y1="-256" y2="-256" x1="0" />
            <line x2="208" y1="-160" y2="-160" x1="256" />
            <arc ex="64" ey="-208" sx="64" sy="-112" r="56" cx="32" cy="-160" />
            <line x2="64" y1="-208" y2="-208" x1="128" />
            <line x2="64" y1="-112" y2="-112" x1="128" />
            <line x2="48" y1="-64" y2="-112" x1="48" />
            <line x2="48" y1="-256" y2="-208" x1="48" />
            <arc ex="128" ey="-208" sx="208" sy="-160" r="88" cx="132" cy="-120" />
            <arc ex="48" ey="-208" sx="48" sy="-112" r="56" cx="16" cy="-160" />
            <arc ex="208" ey="-160" sx="128" sy="-112" r="88" cx="132" cy="-200" />
        </blockdef>
        <block symbolname="inv" name="XLXI_4">
            <blockpin signalname="sub" name="I" />
            <blockpin signalname="ADD" name="O" />
        </block>
        <block symbolname="adsu16" name="XLXI_1">
            <blockpin signalname="A(15:0)" name="A(15:0)" />
            <blockpin signalname="ADD" name="ADD" />
            <blockpin signalname="B(15:0)" name="B(15:0)" />
            <blockpin signalname="sub" name="CI" />
            <blockpin signalname="carry_out" name="CO" />
            <blockpin name="OFL" />
            <blockpin signalname="result(15:0)" name="S(15:0)" />
        </block>
        <block symbolname="adsu16" name="XLXI_2">
            <blockpin signalname="A(31:16)" name="A(15:0)" />
            <blockpin signalname="ADD" name="ADD" />
            <blockpin signalname="B(31:16)" name="B(15:0)" />
            <blockpin signalname="XLXN_35" name="CI" />
            <blockpin signalname="carry_out_cin_low" name="CO" />
            <blockpin name="OFL" />
            <blockpin signalname="XLXN_36(15:0)" name="S(15:0)" />
        </block>
        <block symbolname="adsu16" name="XLXI_3">
            <blockpin signalname="A(31:16)" name="A(15:0)" />
            <blockpin signalname="ADD" name="ADD" />
            <blockpin signalname="B(31:16)" name="B(15:0)" />
            <blockpin signalname="XLXN_34" name="CI" />
            <blockpin signalname="carry_out_cin_high" name="CO" />
            <blockpin name="OFL" />
            <blockpin signalname="XLXN_37(15:0)" name="S(15:0)" />
        </block>
        <block symbolname="vcc" name="XLXI_9">
            <blockpin signalname="XLXN_34" name="P" />
        </block>
        <block symbolname="gnd" name="XLXI_10">
            <blockpin signalname="XLXN_35" name="G" />
        </block>
        <block symbolname="MUX16bit" name="XLXI_11">
            <blockpin signalname="carry_out" name="sel" />
            <blockpin signalname="XLXN_36(15:0)" name="A(15:0)" />
            <blockpin signalname="XLXN_37(15:0)" name="B(15:0)" />
            <blockpin signalname="result(31:16)" name="O(15:0)" />
        </block>
        <block symbolname="buf" name="XLXI_12">
            <blockpin signalname="XLXN_51" name="I" />
            <blockpin signalname="neg" name="O" />
        </block>
        <block symbolname="m2_1" name="XLXI_17">
            <blockpin signalname="carry_out_cin_low" name="D0" />
            <blockpin signalname="carry_out_cin_high" name="D1" />
            <blockpin signalname="carry_out" name="S0" />
            <blockpin signalname="carry_out_real" name="O" />
        </block>
        <block symbolname="xor4" name="XLXI_18">
            <blockpin signalname="sub" name="I0" />
            <blockpin signalname="carry_out_real" name="I1" />
            <blockpin signalname="B(31)" name="I2" />
            <blockpin signalname="A(31)" name="I3" />
            <blockpin signalname="XLXN_51" name="O" />
        </block>
    </netlist>
    <sheet sheetnum="1" width="3520" height="2720">
        <branch name="A(31:0)">
            <wire x2="336" y1="368" y2="368" x1="144" />
        </branch>
        <iomarker fontsize="28" x="144" y="368" name="A(31:0)" orien="R180" />
        <branch name="B(31:0)">
            <wire x2="368" y1="448" y2="448" x1="160" />
        </branch>
        <branch name="sub">
            <wire x2="400" y1="512" y2="512" x1="160" />
        </branch>
        <branch name="ovf">
            <wire x2="2160" y1="480" y2="480" x1="1888" />
        </branch>
        <branch name="result(31:0)">
            <wire x2="2176" y1="576" y2="576" x1="1888" />
        </branch>
        <iomarker fontsize="28" x="160" y="448" name="B(31:0)" orien="R180" />
        <iomarker fontsize="28" x="160" y="512" name="sub" orien="R180" />
        <iomarker fontsize="28" x="2160" y="480" name="ovf" orien="R0" />
        <iomarker fontsize="28" x="2176" y="576" name="result(31:0)" orien="R0" />
        <instance x="304" y="192" name="XLXI_4" orien="R0" />
        <branch name="sub">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="208" y="160" type="branch" />
            <wire x2="304" y1="160" y2="160" x1="208" />
        </branch>
        <branch name="ADD">
            <attrtext style="alignment:SOFT-LEFT;fontsize:28;fontname:Arial" attrname="Name" x="912" y="160" type="branch" />
            <wire x2="528" y1="160" y2="160" x1="512" />
            <wire x2="912" y1="160" y2="160" x1="528" />
        </branch>
        <branch name="carry_out">
            <attrtext style="alignment:SOFT-LEFT;fontsize:28;fontname:Arial" attrname="Name" x="1056" y="1024" type="branch" />
            <wire x2="1040" y1="1024" y2="1024" x1="880" />
            <wire x2="1056" y1="1024" y2="1024" x1="1040" />
        </branch>
        <branch name="result(15:0)">
            <attrtext style="alignment:SOFT-LEFT;fontsize:28;fontname:Arial" attrname="Name" x="1024" y="832" type="branch" />
            <wire x2="1008" y1="832" y2="832" x1="880" />
            <wire x2="1024" y1="832" y2="832" x1="1008" />
        </branch>
        <branch name="ADD">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="272" y="1024" type="branch" />
            <wire x2="288" y1="1024" y2="1024" x1="272" />
            <wire x2="432" y1="1024" y2="1024" x1="288" />
        </branch>
        <branch name="B(15:0)">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="240" y="896" type="branch" />
            <wire x2="256" y1="896" y2="896" x1="240" />
            <wire x2="432" y1="896" y2="896" x1="256" />
        </branch>
        <branch name="A(15:0)">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="240" y="768" type="branch" />
            <wire x2="256" y1="768" y2="768" x1="240" />
            <wire x2="272" y1="768" y2="768" x1="256" />
            <wire x2="432" y1="768" y2="768" x1="272" />
        </branch>
        <branch name="sub">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="320" y="640" type="branch" />
            <wire x2="336" y1="640" y2="640" x1="320" />
            <wire x2="432" y1="640" y2="640" x1="336" />
        </branch>
        <instance x="432" y="1088" name="XLXI_1" orien="R0" />
        <instance x="512" y="1696" name="XLXI_2" orien="R0" />
        <instance x="528" y="2240" name="XLXI_3" orien="R0" />
        <branch name="A(31:16)">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="304" y="1376" type="branch" />
            <wire x2="448" y1="1376" y2="1376" x1="304" />
            <wire x2="512" y1="1376" y2="1376" x1="448" />
        </branch>
        <branch name="B(31:16)">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="320" y="1504" type="branch" />
            <wire x2="512" y1="1504" y2="1504" x1="320" />
        </branch>
        <branch name="A(31:16)">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="336" y="1920" type="branch" />
            <wire x2="528" y1="1920" y2="1920" x1="336" />
        </branch>
        <branch name="B(31:16)">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="336" y="2048" type="branch" />
            <wire x2="528" y1="2048" y2="2048" x1="336" />
        </branch>
        <instance x="336" y="1184" name="XLXI_10" orien="R90" />
        <branch name="XLXN_35">
            <wire x2="512" y1="1248" y2="1248" x1="464" />
        </branch>
        <instance x="416" y="1856" name="XLXI_9" orien="R270" />
        <branch name="XLXN_34">
            <wire x2="464" y1="1792" y2="1792" x1="416" />
            <wire x2="464" y1="1776" y2="1792" x1="464" />
            <wire x2="528" y1="1776" y2="1776" x1="464" />
            <wire x2="528" y1="1776" y2="1792" x1="528" />
        </branch>
        <branch name="ADD">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="368" y="1632" type="branch" />
            <wire x2="512" y1="1632" y2="1632" x1="368" />
        </branch>
        <branch name="ADD">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="384" y="2176" type="branch" />
            <wire x2="528" y1="2176" y2="2176" x1="384" />
        </branch>
        <branch name="carry_out_cin_high">
            <attrtext style="alignment:SOFT-LEFT;fontsize:28;fontname:Arial" attrname="Name" x="1040" y="2176" type="branch" />
            <wire x2="1040" y1="2176" y2="2176" x1="976" />
        </branch>
        <branch name="carry_out_cin_low">
            <attrtext style="alignment:SOFT-LEFT;fontsize:28;fontname:Arial" attrname="Name" x="1040" y="1632" type="branch" />
            <wire x2="1040" y1="1632" y2="1632" x1="960" />
        </branch>
        <instance x="1616" y="1696" name="XLXI_11" orien="R0">
        </instance>
        <branch name="carry_out">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="1520" y="1536" type="branch" />
            <wire x2="1616" y1="1536" y2="1536" x1="1520" />
        </branch>
        <branch name="result(31:16)">
            <attrtext style="alignment:SOFT-LEFT;fontsize:28;fontname:Arial" attrname="Name" x="2144" y="1536" type="branch" />
            <wire x2="2144" y1="1536" y2="1536" x1="2000" />
        </branch>
        <branch name="XLXN_36(15:0)">
            <wire x2="1280" y1="1440" y2="1440" x1="960" />
            <wire x2="1280" y1="1440" y2="1600" x1="1280" />
            <wire x2="1616" y1="1600" y2="1600" x1="1280" />
        </branch>
        <branch name="XLXN_37(15:0)">
            <wire x2="992" y1="1984" y2="1984" x1="976" />
            <wire x2="1616" y1="1664" y2="1664" x1="992" />
            <wire x2="992" y1="1664" y2="1984" x1="992" />
        </branch>
        <branch name="neg">
            <wire x2="2448" y1="320" y2="320" x1="2336" />
            <wire x2="2720" y1="320" y2="320" x1="2448" />
        </branch>
        <instance x="2112" y="352" name="XLXI_12" orien="R0" />
        <iomarker fontsize="28" x="2720" y="320" name="neg" orien="R0" />
        <branch name="A(31)">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="1152" y="304" type="branch" />
            <wire x2="1344" y1="304" y2="304" x1="1152" />
        </branch>
        <branch name="B(31)">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="1152" y="368" type="branch" />
            <wire x2="1344" y1="368" y2="368" x1="1152" />
        </branch>
        <branch name="carry_out_real">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="1168" y="432" type="branch" />
            <wire x2="1344" y1="432" y2="432" x1="1168" />
        </branch>
        <instance x="1856" y="2096" name="XLXI_17" orien="R0" />
        <branch name="carry_out_cin_low">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="1712" y="1936" type="branch" />
            <wire x2="1856" y1="1936" y2="1936" x1="1712" />
        </branch>
        <branch name="carry_out_cin_high">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="1696" y="2000" type="branch" />
            <wire x2="1856" y1="2000" y2="2000" x1="1696" />
        </branch>
        <branch name="carry_out">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="1696" y="2064" type="branch" />
            <wire x2="1856" y1="2064" y2="2064" x1="1696" />
        </branch>
        <branch name="carry_out_real">
            <attrtext style="alignment:SOFT-LEFT;fontsize:28;fontname:Arial" attrname="Name" x="2304" y="1968" type="branch" />
            <wire x2="2304" y1="1968" y2="1968" x1="2176" />
        </branch>
        <instance x="1344" y="560" name="XLXI_18" orien="R0" />
        <branch name="XLXN_51">
            <wire x2="1856" y1="400" y2="400" x1="1600" />
            <wire x2="1856" y1="320" y2="400" x1="1856" />
            <wire x2="2112" y1="320" y2="320" x1="1856" />
        </branch>
        <branch name="sub">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="1216" y="496" type="branch" />
            <wire x2="1344" y1="496" y2="496" x1="1216" />
        </branch>
    </sheet>
</drawing>