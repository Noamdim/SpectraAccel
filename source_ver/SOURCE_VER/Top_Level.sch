<?xml version="1.0" encoding="UTF-8"?>
<drawing version="7">
    <attr value="spartan6" name="DeviceFamilyName">
        <trait delete="all:0" />
        <trait editname="all:0" />
        <trait edittrait="all:0" />
    </attr>
    <netlist>
        <signal name="Card_Sel" />
        <signal name="Rsel" />
        <signal name="AI(9:0)" />
        <signal name="DO(31:0)" />
        <signal name="WR_IN_N" />
        <signal name="RACK_N" />
        <signal name="MAO(31:0)" />
        <signal name="MDO(31:0)" />
        <signal name="SACK_N" />
        <signal name="IN_INIT" />
        <signal name="CLK" />
        <signal name="STEP_EN" />
        <signal name="AS_N" />
        <signal name="WR_OUT_N" />
        <signal name="RESET" />
        <signal name="R_DO(31:0)" />
        <signal name="sdClk_o" />
        <signal name="sdBs_o(1:0)" />
        <signal name="sdDqml_o" />
        <signal name="sdDqmh_o" />
        <signal name="sdWe_bo" />
        <signal name="sdCas_bo" />
        <signal name="sdRas_bo" />
        <signal name="sdCe_bo" />
        <signal name="sdCke_o" />
        <signal name="fpgaClk_i" />
        <signal name="sdClkFb_i" />
        <signal name="sdData_io(15:0)" />
        <signal name="sdAddr_o(12:0)" />
        <signal name="SDO(31:0)" />
        <signal name="ACK_N" />
        <signal name="D_GPR(31:0)" />
        <signal name="LA_DATA_IN(31:0)" />
        <signal name="STOP_N" />
        <signal name="REG_ADDR(4:0)" />
        <signal name="SACK_N_MON" />
        <signal name="sc_WR_OUT_N" />
        <signal name="classify_pulse" />
        <signal name="dlx_ACK_N" />
        <signal name="sc_ACK_N" />
        <signal name="accel_active" />
        <signal name="dlx_AS_N" />
        <signal name="dlx_WR_OUT_N" />
        <signal name="sc_AS_N" />
        <signal name="dlx_MAO(31:0)" />
        <signal name="dlx_MDO(31:0)" />
        <signal name="sc_MAO(31:0)" />
        <signal name="sc_MDO(31:0)" />
        <signal name="SACK_N_ACCEL" />
        <signal name="SDO_MON(31:0)" />
        <signal name="SDO_ACCEL(31:0)" />
        <signal name="wf_count(4:0)" />
        <signal name="XLXN_41(1:0)" />
        <signal name="XLXN_42(4:0)" />
        <signal name="debug_accel(3:0)" />
        <port polarity="Output" name="sdClk_o" />
        <port polarity="Output" name="sdBs_o(1:0)" />
        <port polarity="Output" name="sdDqml_o" />
        <port polarity="Output" name="sdDqmh_o" />
        <port polarity="Output" name="sdWe_bo" />
        <port polarity="Output" name="sdCas_bo" />
        <port polarity="Output" name="sdRas_bo" />
        <port polarity="Output" name="sdCe_bo" />
        <port polarity="Output" name="sdCke_o" />
        <port polarity="Input" name="fpgaClk_i" />
        <port polarity="Input" name="sdClkFb_i" />
        <port polarity="BiDirectional" name="sdData_io(15:0)" />
        <port polarity="Output" name="sdAddr_o(12:0)" />
        <blockdef name="IO_LOGIC_U">
            <timestamp>2015-7-8T11:14:45</timestamp>
            <rect width="304" x="64" y="-1280" height="1280" />
            <line x2="0" y1="-1248" y2="-1248" x1="64" />
            <line x2="0" y1="-1136" y2="-1136" x1="64" />
            <line x2="0" y1="-1024" y2="-1024" x1="64" />
            <line x2="0" y1="-912" y2="-912" x1="64" />
            <line x2="0" y1="-800" y2="-800" x1="64" />
            <line x2="0" y1="-688" y2="-688" x1="64" />
            <line x2="0" y1="-576" y2="-576" x1="64" />
            <rect width="64" x="0" y="-476" height="24" />
            <line x2="0" y1="-464" y2="-464" x1="64" />
            <rect width="64" x="0" y="-364" height="24" />
            <line x2="0" y1="-352" y2="-352" x1="64" />
            <rect width="64" x="0" y="-252" height="24" />
            <line x2="0" y1="-240" y2="-240" x1="64" />
            <rect width="64" x="0" y="-140" height="24" />
            <line x2="0" y1="-128" y2="-128" x1="64" />
            <line x2="432" y1="-1248" y2="-1248" x1="368" />
            <line x2="432" y1="-1184" y2="-1184" x1="368" />
            <line x2="432" y1="-1120" y2="-1120" x1="368" />
            <line x2="432" y1="-1056" y2="-1056" x1="368" />
            <line x2="432" y1="-992" y2="-992" x1="368" />
            <line x2="432" y1="-928" y2="-928" x1="368" />
            <line x2="432" y1="-864" y2="-864" x1="368" />
            <line x2="432" y1="-800" y2="-800" x1="368" />
            <line x2="432" y1="-736" y2="-736" x1="368" />
            <line x2="432" y1="-672" y2="-672" x1="368" />
            <line x2="432" y1="-608" y2="-608" x1="368" />
            <line x2="432" y1="-544" y2="-544" x1="368" />
            <line x2="432" y1="-480" y2="-480" x1="368" />
            <line x2="432" y1="-416" y2="-416" x1="368" />
            <line x2="432" y1="-352" y2="-352" x1="368" />
            <rect width="64" x="368" y="-300" height="24" />
            <line x2="432" y1="-288" y2="-288" x1="368" />
            <rect width="64" x="368" y="-236" height="24" />
            <line x2="432" y1="-224" y2="-224" x1="368" />
            <rect width="64" x="368" y="-172" height="24" />
            <line x2="432" y1="-160" y2="-160" x1="368" />
            <rect width="64" x="368" y="-108" height="24" />
            <line x2="432" y1="-96" y2="-96" x1="368" />
            <rect width="64" x="368" y="-44" height="24" />
            <line x2="432" y1="-32" y2="-32" x1="368" />
        </blockdef>
        <blockdef name="DLX_Wrapper">
            <timestamp>2026-7-28T11:11:49</timestamp>
            <rect width="64" x="0" y="84" height="24" />
            <line x2="0" y1="96" y2="96" x1="64" />
            <rect width="64" x="0" y="20" height="24" />
            <line x2="0" y1="32" y2="32" x1="64" />
            <line x2="0" y1="-672" y2="-672" x1="64" />
            <line x2="0" y1="-544" y2="-544" x1="64" />
            <line x2="0" y1="-416" y2="-416" x1="64" />
            <line x2="0" y1="-288" y2="-288" x1="64" />
            <rect width="64" x="0" y="-172" height="24" />
            <line x2="0" y1="-160" y2="-160" x1="64" />
            <rect width="64" x="0" y="-44" height="24" />
            <line x2="0" y1="-32" y2="-32" x1="64" />
            <line x2="464" y1="-672" y2="-672" x1="400" />
            <line x2="464" y1="-608" y2="-608" x1="400" />
            <line x2="464" y1="-544" y2="-544" x1="400" />
            <line x2="464" y1="-480" y2="-480" x1="400" />
            <line x2="464" y1="-416" y2="-416" x1="400" />
            <rect width="64" x="400" y="-364" height="24" />
            <line x2="464" y1="-352" y2="-352" x1="400" />
            <rect width="64" x="400" y="-300" height="24" />
            <line x2="464" y1="-288" y2="-288" x1="400" />
            <rect width="64" x="400" y="-236" height="24" />
            <line x2="464" y1="-224" y2="-224" x1="400" />
            <rect width="64" x="400" y="-172" height="24" />
            <line x2="464" y1="-160" y2="-160" x1="400" />
            <rect width="64" x="400" y="-108" height="24" />
            <line x2="464" y1="-96" y2="-96" x1="400" />
            <rect width="64" x="400" y="-44" height="24" />
            <line x2="464" y1="-32" y2="-32" x1="400" />
            <rect width="336" x="64" y="-704" height="832" />
        </blockdef>
        <blockdef name="Accelerator_Subsystem">
            <timestamp>2026-7-27T17:17:57</timestamp>
            <rect width="64" x="464" y="84" height="24" />
            <line x2="528" y1="96" y2="96" x1="464" />
            <rect width="64" x="464" y="20" height="24" />
            <line x2="528" y1="32" y2="32" x1="464" />
            <line x2="0" y1="-672" y2="-672" x1="64" />
            <line x2="0" y1="-608" y2="-608" x1="64" />
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
            <line x2="528" y1="-672" y2="-672" x1="464" />
            <line x2="528" y1="-576" y2="-576" x1="464" />
            <line x2="528" y1="-480" y2="-480" x1="464" />
            <line x2="528" y1="-384" y2="-384" x1="464" />
            <rect width="64" x="464" y="-300" height="24" />
            <line x2="528" y1="-288" y2="-288" x1="464" />
            <rect width="64" x="464" y="-204" height="24" />
            <line x2="528" y1="-192" y2="-192" x1="464" />
            <rect width="64" x="464" y="-108" height="24" />
            <line x2="528" y1="-96" y2="-96" x1="464" />
            <rect width="400" x="64" y="-704" height="832" />
        </blockdef>
        <blockdef name="Monitor_lab4">
            <timestamp>2026-7-27T8:29:4</timestamp>
            <rect width="368" x="64" y="-704" height="704" />
            <line x2="0" y1="-672" y2="-672" x1="64" />
            <rect width="64" x="0" y="-620" height="24" />
            <line x2="0" y1="-608" y2="-608" x1="64" />
            <rect width="64" x="0" y="-556" height="24" />
            <line x2="0" y1="-544" y2="-544" x1="64" />
            <line x2="0" y1="-480" y2="-480" x1="64" />
            <line x2="0" y1="-416" y2="-416" x1="64" />
            <rect width="64" x="0" y="-364" height="24" />
            <line x2="0" y1="-352" y2="-352" x1="64" />
            <rect width="64" x="0" y="-300" height="24" />
            <line x2="0" y1="-288" y2="-288" x1="64" />
            <line x2="0" y1="-224" y2="-224" x1="64" />
            <line x2="0" y1="-160" y2="-160" x1="64" />
            <line x2="0" y1="-96" y2="-96" x1="64" />
            <line x2="0" y1="-32" y2="-32" x1="64" />
            <line x2="496" y1="-672" y2="-672" x1="432" />
            <rect width="64" x="432" y="-364" height="24" />
            <line x2="496" y1="-352" y2="-352" x1="432" />
            <rect width="64" x="432" y="-44" height="24" />
            <line x2="496" y1="-32" y2="-32" x1="432" />
        </blockdef>
        <blockdef name="bus_master_mux">
            <timestamp>2026-7-27T9:9:50</timestamp>
            <rect width="64" x="0" y="20" height="24" />
            <line x2="0" y1="32" y2="32" x1="64" />
            <rect width="64" x="0" y="84" height="24" />
            <line x2="0" y1="96" y2="96" x1="64" />
            <rect width="64" x="0" y="148" height="24" />
            <line x2="0" y1="160" y2="160" x1="64" />
            <rect width="64" x="448" y="20" height="24" />
            <line x2="512" y1="32" y2="32" x1="448" />
            <line x2="0" y1="-608" y2="-608" x1="64" />
            <line x2="0" y1="-544" y2="-544" x1="64" />
            <line x2="0" y1="-480" y2="-480" x1="64" />
            <line x2="0" y1="-416" y2="-416" x1="64" />
            <line x2="0" y1="-352" y2="-352" x1="64" />
            <line x2="0" y1="-288" y2="-288" x1="64" />
            <rect width="64" x="0" y="-236" height="24" />
            <line x2="0" y1="-224" y2="-224" x1="64" />
            <rect width="64" x="0" y="-172" height="24" />
            <line x2="0" y1="-160" y2="-160" x1="64" />
            <rect width="64" x="0" y="-108" height="24" />
            <line x2="0" y1="-96" y2="-96" x1="64" />
            <rect width="64" x="0" y="-44" height="24" />
            <line x2="0" y1="-32" y2="-32" x1="64" />
            <line x2="512" y1="-608" y2="-608" x1="448" />
            <line x2="512" y1="-496" y2="-496" x1="448" />
            <line x2="512" y1="-384" y2="-384" x1="448" />
            <line x2="512" y1="-272" y2="-272" x1="448" />
            <rect width="64" x="448" y="-172" height="24" />
            <line x2="512" y1="-160" y2="-160" x1="448" />
            <rect width="64" x="448" y="-60" height="24" />
            <line x2="512" y1="-48" y2="-48" x1="448" />
            <rect width="384" x="64" y="-640" height="832" />
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
        <block symbolname="IO_LOGIC_U" name="XLXI_23">
            <blockpin signalname="AS_N" name="AS_N_i" />
            <blockpin signalname="fpgaClk_i" name="fpgaClk_i" />
            <blockpin signalname="IN_INIT" name="in_init_i" />
            <blockpin signalname="RACK_N" name="RACK_N_i" />
            <blockpin signalname="SACK_N" name="SACK_N_i" />
            <blockpin signalname="sdClkFb_i" name="sdClkFb_i" />
            <blockpin signalname="WR_OUT_N" name="WR_N_i" />
            <blockpin signalname="MAO(31:0)" name="MA_i(31:0)" />
            <blockpin signalname="MDO(31:0)" name="MD_i(31:0)" />
            <blockpin signalname="R_DO(31:0)" name="RD_i(31:0)" />
            <blockpin signalname="SDO(31:0)" name="SD_i(31:0)" />
            <blockpin signalname="CLK" name="CLK" />
            <blockpin signalname="ACK_N" name="MACK_N_o" />
            <blockpin signalname="RESET" name="RESET" />
            <blockpin signalname="Rsel" name="Rsel_o" />
            <blockpin signalname="sdCas_bo" name="sdCas_bo" />
            <blockpin signalname="sdCe_bo" name="sdCe_bo" />
            <blockpin signalname="sdCke_o" name="sdCke_o" />
            <blockpin signalname="sdClk_o" name="sdClk_o" />
            <blockpin signalname="sdDqmh_o" name="sdDqmh_o" />
            <blockpin signalname="sdDqml_o" name="sdDqml_o" />
            <blockpin signalname="sdRas_bo" name="sdRas_bo" />
            <blockpin signalname="sdWe_bo" name="sdWe_bo" />
            <blockpin signalname="Card_Sel" name="Ssel_o" />
            <blockpin signalname="STEP_EN" name="step_en_o" />
            <blockpin signalname="WR_IN_N" name="WR_N_o" />
            <blockpin signalname="AI(9:0)" name="A_o(9:0)" />
            <blockpin signalname="DO(31:0)" name="DO(31:0)" />
            <blockpin signalname="sdAddr_o(12:0)" name="sdAddr_o(12:0)" />
            <blockpin signalname="sdBs_o(1:0)" name="sdBs_o(1:0)" />
            <blockpin signalname="sdData_io(15:0)" name="sdData_io(15:0)" />
        </block>
        <block symbolname="Accelerator_Subsystem" name="XLXI_33">
            <blockpin signalname="CLK" name="CLK" />
            <blockpin signalname="RESET" name="RESET" />
            <blockpin signalname="Card_Sel" name="Card_Sel" />
            <blockpin signalname="WR_IN_N" name="WR_IN_N" />
            <blockpin signalname="sc_ACK_N" name="sc_ack_n" />
            <blockpin signalname="classify_pulse" name="classify_pulse" />
            <blockpin signalname="AI(9:0)" name="AI(9:0)" />
            <blockpin signalname="MDO(31:0)" name="MDO_muxed(31:0)" />
            <blockpin signalname="DO(31:0)" name="DO(31:0)" />
            <blockpin signalname="MDO(31:0)" name="MDO(31:0)" />
            <blockpin signalname="MAO(31:0)" name="MAO(31:0)" />
            <blockpin signalname="SACK_N_ACCEL" name="SACK_N_ACCEL" />
            <blockpin signalname="sc_AS_N" name="sc_AS_N" />
            <blockpin signalname="sc_WR_OUT_N" name="sc_WR_OUT_N" />
            <blockpin signalname="accel_active" name="accel_active" />
            <blockpin signalname="SDO_ACCEL(31:0)" name="SDO_ACCEL(31:0)" />
            <blockpin signalname="sc_MAO(31:0)" name="sc_MAO(31:0)" />
            <blockpin signalname="sc_MDO(31:0)" name="sc_MDO(31:0)" />
            <blockpin signalname="wf_count(4:0)" name="wf_count(4:0)" />
            <blockpin signalname="debug_accel(3:0)" name="debug_accel(3:0)" />
        </block>
        <block symbolname="bus_master_mux" name="XLXI_35">
            <blockpin signalname="accel_active" name="accel_active" />
            <blockpin signalname="dlx_AS_N" name="dlx_AS_N" />
            <blockpin signalname="dlx_WR_OUT_N" name="dlx_WR_OUT_N" />
            <blockpin signalname="sc_AS_N" name="sc_AS_N" />
            <blockpin signalname="sc_WR_OUT_N" name="sc_WR_OUT_N" />
            <blockpin signalname="ACK_N" name="ACK_N_raw" />
            <blockpin signalname="dlx_MAO(31:0)" name="dlx_MAO(31:0)" />
            <blockpin signalname="dlx_MDO(31:0)" name="dlx_MDO(31:0)" />
            <blockpin signalname="sc_MAO(31:0)" name="sc_MAO(31:0)" />
            <blockpin signalname="sc_MDO(31:0)" name="sc_MDO(31:0)" />
            <blockpin signalname="dlx_ACK_N" name="dlx_ACK_N" />
            <blockpin signalname="sc_ACK_N" name="sc_ack_n" />
            <blockpin signalname="AS_N" name="AS_N_muxed" />
            <blockpin signalname="WR_OUT_N" name="WR_OUT_N_muxed" />
            <blockpin signalname="MAO(31:0)" name="MAO_muxed(31:0)" />
            <blockpin signalname="MDO(31:0)" name="MDO_muxed(31:0)" />
            <blockpin signalname="AI(9:0)" name="AI(9:0)" />
            <blockpin signalname="SDO_MON(31:0)" name="SDO_MON(31:0)" />
            <blockpin signalname="SDO_ACCEL(31:0)" name="SDO_ACCEL(31:0)" />
            <blockpin signalname="SDO(31:0)" name="SDO_final(31:0)" />
        </block>
        <block symbolname="and2" name="XLXI_37">
            <blockpin signalname="SACK_N_MON" name="I0" />
            <blockpin signalname="SACK_N_ACCEL" name="I1" />
            <blockpin signalname="SACK_N" name="O" />
        </block>
        <block symbolname="Monitor_lab4" name="XLXI_34">
            <blockpin signalname="IN_INIT" name="IN_INIT" />
            <blockpin signalname="dlx_MAO(31:0)" name="B(31:0)" />
            <blockpin signalname="D_GPR(31:0)" name="C(31:0)" />
            <blockpin signalname="CLK" name="CLK" />
            <blockpin signalname="RESET" name="RESET" />
            <blockpin signalname="AI(9:0)" name="AI(9:0)" />
            <blockpin signalname="LA_DATA_IN(31:0)" name="LA_Data_in(31:0)" />
            <blockpin signalname="STOP_N" name="STOP_N" />
            <blockpin signalname="STEP_EN" name="STEP_EN" />
            <blockpin signalname="WR_IN_N" name="WR_IN_N" />
            <blockpin signalname="Card_Sel" name="CARD_SEL" />
            <blockpin signalname="SACK_N_MON" name="SACK_N" />
            <blockpin signalname="SDO_MON(31:0)" name="SDO(31:0)" />
            <blockpin signalname="REG_ADDR(4:0)" name="reg_address(4:0)" />
        </block>
        <block symbolname="DLX_Wrapper" name="XLXI_39">
            <blockpin signalname="CLK" name="CLK" />
            <blockpin signalname="RESET" name="RESET" />
            <blockpin signalname="dlx_ACK_N" name="ACK_N" />
            <blockpin signalname="STEP_EN" name="STEP_EN" />
            <blockpin signalname="DO(31:0)" name="DI(31:0)" />
            <blockpin signalname="REG_ADDR(4:0)" name="D_addr(4:0)" />
            <blockpin signalname="wf_count(4:0)" name="wf_count(4:0)" />
            <blockpin signalname="debug_accel(3:0)" name="debug_accel(3:0)" />
            <blockpin signalname="dlx_AS_N" name="AS_N" />
            <blockpin signalname="dlx_WR_OUT_N" name="WR_OUT_N" />
            <blockpin signalname="classify_pulse" name="classify_pulse" />
            <blockpin signalname="STOP_N" name="STOP_N" />
            <blockpin signalname="IN_INIT" name="IN_INIT" />
            <blockpin signalname="dlx_MAO(31:0)" name="MAO(31:0)" />
            <blockpin signalname="dlx_MDO(31:0)" name="DO(31:0)" />
            <blockpin signalname="XLXN_42(4:0)" name="ctrl_dlx_state(4:0)" />
            <blockpin signalname="XLXN_41(1:0)" name="MAC_STATE(1:0)" />
            <blockpin signalname="D_GPR(31:0)" name="D_MONITOR(31:0)" />
            <blockpin signalname="LA_DATA_IN(31:0)" name="LA_DATA_IN(31:0)" />
        </block>
    </netlist>
    <sheet sheetnum="1" width="3520" height="2720">
        <branch name="AS_N">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="240" y="208" type="branch" />
            <wire x2="432" y1="208" y2="208" x1="240" />
        </branch>
        <branch name="WR_OUT_N">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="240" y="256" type="branch" />
            <wire x2="432" y1="256" y2="256" x1="240" />
        </branch>
        <branch name="MAO(31:0)">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="240" y="304" type="branch" />
            <wire x2="432" y1="304" y2="304" x1="240" />
        </branch>
        <branch name="MDO(31:0)">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="240" y="352" type="branch" />
            <wire x2="432" y1="352" y2="352" x1="240" />
        </branch>
        <branch name="ACK_N">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="240" y="400" type="branch" />
            <wire x2="432" y1="400" y2="400" x1="240" />
        </branch>
        <branch name="Card_Sel">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="240" y="2080" type="branch" />
            <wire x2="448" y1="2080" y2="2080" x1="240" />
        </branch>
        <branch name="AI(9:0)">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="240" y="2032" type="branch" />
            <wire x2="448" y1="2032" y2="2032" x1="240" />
        </branch>
        <branch name="WR_IN_N">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="240" y="1984" type="branch" />
            <wire x2="448" y1="1984" y2="1984" x1="240" />
        </branch>
        <branch name="SDO(31:0)">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="240" y="1936" type="branch" />
            <wire x2="448" y1="1936" y2="1936" x1="240" />
        </branch>
        <branch name="SACK_N">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="240" y="1888" type="branch" />
            <wire x2="448" y1="1888" y2="1888" x1="240" />
        </branch>
        <branch name="DO(31:0)">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="240" y="1632" type="branch" />
            <wire x2="448" y1="1632" y2="1632" x1="240" />
        </branch>
        <branch name="IN_INIT">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="256" y="1024" type="branch" />
            <wire x2="448" y1="1024" y2="1024" x1="256" />
        </branch>
        <branch name="RESET">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="256" y="1072" type="branch" />
            <wire x2="448" y1="1072" y2="1072" x1="256" />
        </branch>
        <branch name="STEP_EN">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="256" y="1120" type="branch" />
            <wire x2="448" y1="1120" y2="1120" x1="256" />
        </branch>
        <branch name="CLK">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="256" y="1168" type="branch" />
            <wire x2="448" y1="1168" y2="1168" x1="256" />
        </branch>
        <text style="fontsize:32;fontname:Arial" x="268" y="488">Master I/O</text>
        <text style="fontsize:32;fontname:Arial" x="284" y="1232">Control I/O</text>
        <text style="fontsize:32;fontname:Arial" x="256" y="1692">Bus data O</text>
        <text style="fontsize:32;fontname:Arial" x="280" y="2140">Slave I/O</text>
        <instance x="2144" y="1712" name="XLXI_33" orien="R0">
        </instance>
        <instance x="1088" y="1664" name="XLXI_35" orien="R0">
        </instance>
        <branch name="CLK">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="2080" y="1040" type="branch" />
            <wire x2="2144" y1="1040" y2="1040" x1="2080" />
        </branch>
        <branch name="RESET">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="2096" y="1104" type="branch" />
            <wire x2="2144" y1="1104" y2="1104" x1="2096" />
        </branch>
        <branch name="Card_Sel">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="2096" y="1168" type="branch" />
            <wire x2="2144" y1="1168" y2="1168" x1="2096" />
        </branch>
        <branch name="WR_IN_N">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="2096" y="1232" type="branch" />
            <wire x2="2144" y1="1232" y2="1232" x1="2096" />
        </branch>
        <branch name="sc_ACK_N">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="2096" y="1296" type="branch" />
            <wire x2="2144" y1="1296" y2="1296" x1="2096" />
        </branch>
        <branch name="classify_pulse">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="2096" y="1360" type="branch" />
            <wire x2="2144" y1="1360" y2="1360" x1="2096" />
        </branch>
        <branch name="AI(9:0)">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="2096" y="1424" type="branch" />
            <wire x2="2144" y1="1424" y2="1424" x1="2096" />
        </branch>
        <branch name="MDO(31:0)">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="2096" y="1488" type="branch" />
            <wire x2="2144" y1="1488" y2="1488" x1="2096" />
        </branch>
        <branch name="DO(31:0)">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="2096" y="1552" type="branch" />
            <wire x2="2144" y1="1552" y2="1552" x1="2096" />
        </branch>
        <branch name="MDO(31:0)">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="2096" y="1616" type="branch" />
            <wire x2="2144" y1="1616" y2="1616" x1="2096" />
        </branch>
        <branch name="MAO(31:0)">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="2096" y="1680" type="branch" />
            <wire x2="2144" y1="1680" y2="1680" x1="2096" />
        </branch>
        <branch name="sc_MDO(31:0)">
            <attrtext style="alignment:SOFT-LEFT;fontsize:28;fontname:Arial" attrname="Name" x="2720" y="1616" type="branch" />
            <wire x2="2720" y1="1616" y2="1616" x1="2672" />
        </branch>
        <branch name="sc_MAO(31:0)">
            <attrtext style="alignment:SOFT-LEFT;fontsize:28;fontname:Arial" attrname="Name" x="2720" y="1520" type="branch" />
            <wire x2="2720" y1="1520" y2="1520" x1="2672" />
        </branch>
        <branch name="SDO_ACCEL(31:0)">
            <attrtext style="alignment:SOFT-LEFT;fontsize:28;fontname:Arial" attrname="Name" x="2720" y="1424" type="branch" />
            <wire x2="2720" y1="1424" y2="1424" x1="2672" />
        </branch>
        <branch name="accel_active">
            <attrtext style="alignment:SOFT-LEFT;fontsize:28;fontname:Arial" attrname="Name" x="2720" y="1328" type="branch" />
            <wire x2="2720" y1="1328" y2="1328" x1="2672" />
        </branch>
        <branch name="sc_WR_OUT_N">
            <attrtext style="alignment:SOFT-LEFT;fontsize:28;fontname:Arial" attrname="Name" x="2720" y="1232" type="branch" />
            <wire x2="2720" y1="1232" y2="1232" x1="2672" />
        </branch>
        <branch name="sc_AS_N">
            <attrtext style="alignment:SOFT-LEFT;fontsize:28;fontname:Arial" attrname="Name" x="2720" y="1136" type="branch" />
            <wire x2="2720" y1="1136" y2="1136" x1="2672" />
        </branch>
        <branch name="SACK_N_ACCEL">
            <attrtext style="alignment:SOFT-LEFT;fontsize:28;fontname:Arial" attrname="Name" x="2720" y="1040" type="branch" />
            <wire x2="2720" y1="1040" y2="1040" x1="2672" />
        </branch>
        <branch name="dlx_ACK_N">
            <attrtext style="alignment:SOFT-LEFT;fontsize:28;fontname:Arial" attrname="Name" x="1648" y="1056" type="branch" />
            <wire x2="1648" y1="1056" y2="1056" x1="1600" />
        </branch>
        <branch name="sc_ACK_N">
            <attrtext style="alignment:SOFT-LEFT;fontsize:28;fontname:Arial" attrname="Name" x="1648" y="1168" type="branch" />
            <wire x2="1648" y1="1168" y2="1168" x1="1600" />
        </branch>
        <branch name="AS_N">
            <attrtext style="alignment:SOFT-LEFT;fontsize:28;fontname:Arial" attrname="Name" x="1648" y="1280" type="branch" />
            <wire x2="1648" y1="1280" y2="1280" x1="1600" />
        </branch>
        <branch name="WR_OUT_N">
            <attrtext style="alignment:SOFT-LEFT;fontsize:28;fontname:Arial" attrname="Name" x="1648" y="1392" type="branch" />
            <wire x2="1648" y1="1392" y2="1392" x1="1600" />
        </branch>
        <branch name="MAO(31:0)">
            <attrtext style="alignment:SOFT-LEFT;fontsize:28;fontname:Arial" attrname="Name" x="1632" y="1504" type="branch" />
            <wire x2="1632" y1="1504" y2="1504" x1="1600" />
        </branch>
        <branch name="MDO(31:0)">
            <attrtext style="alignment:SOFT-LEFT;fontsize:28;fontname:Arial" attrname="Name" x="1664" y="1616" type="branch" />
            <wire x2="1664" y1="1616" y2="1616" x1="1600" />
        </branch>
        <branch name="accel_active">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="1056" y="1056" type="branch" />
            <wire x2="1088" y1="1056" y2="1056" x1="1056" />
        </branch>
        <branch name="dlx_AS_N">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="1040" y="1120" type="branch" />
            <wire x2="1088" y1="1120" y2="1120" x1="1040" />
        </branch>
        <branch name="dlx_WR_OUT_N">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="1040" y="1184" type="branch" />
            <wire x2="1088" y1="1184" y2="1184" x1="1040" />
        </branch>
        <branch name="sc_AS_N">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="1056" y="1248" type="branch" />
            <wire x2="1088" y1="1248" y2="1248" x1="1056" />
        </branch>
        <branch name="sc_WR_OUT_N">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="1056" y="1312" type="branch" />
            <wire x2="1088" y1="1312" y2="1312" x1="1056" />
        </branch>
        <branch name="ACK_N">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="1040" y="1376" type="branch" />
            <wire x2="1088" y1="1376" y2="1376" x1="1040" />
        </branch>
        <branch name="dlx_MAO(31:0)">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="1040" y="1440" type="branch" />
            <wire x2="1088" y1="1440" y2="1440" x1="1040" />
        </branch>
        <branch name="dlx_MDO(31:0)">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="1056" y="1504" type="branch" />
            <wire x2="1088" y1="1504" y2="1504" x1="1056" />
        </branch>
        <branch name="sc_MAO(31:0)">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="1040" y="1568" type="branch" />
            <wire x2="1088" y1="1568" y2="1568" x1="1040" />
        </branch>
        <branch name="sc_MDO(31:0)">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="1040" y="1632" type="branch" />
            <wire x2="1088" y1="1632" y2="1632" x1="1040" />
        </branch>
        <instance x="960" y="2256" name="XLXI_37" orien="R0" />
        <branch name="SACK_N">
            <attrtext style="alignment:SOFT-LEFT;fontsize:28;fontname:Arial" attrname="Name" x="1248" y="2160" type="branch" />
            <wire x2="1248" y1="2160" y2="2160" x1="1216" />
        </branch>
        <branch name="SACK_N_ACCEL">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="928" y="2128" type="branch" />
            <wire x2="960" y1="2128" y2="2128" x1="928" />
        </branch>
        <branch name="SACK_N_MON">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="928" y="2192" type="branch" />
            <wire x2="960" y1="2192" y2="2192" x1="928" />
        </branch>
        <branch name="AI(9:0)">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="1040" y="1696" type="branch" />
            <wire x2="1088" y1="1696" y2="1696" x1="1040" />
        </branch>
        <branch name="SDO_MON(31:0)">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="1040" y="1760" type="branch" />
            <wire x2="1088" y1="1760" y2="1760" x1="1040" />
        </branch>
        <branch name="SDO_ACCEL(31:0)">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="1040" y="1824" type="branch" />
            <wire x2="1088" y1="1824" y2="1824" x1="1040" />
        </branch>
        <branch name="SDO(31:0)">
            <attrtext style="alignment:SOFT-LEFT;fontsize:28;fontname:Arial" attrname="Name" x="1664" y="1696" type="branch" />
            <wire x2="1664" y1="1696" y2="1696" x1="1600" />
        </branch>
        <branch name="wf_count(4:0)">
            <attrtext style="alignment:SOFT-LEFT;fontsize:28;fontname:Arial" attrname="Name" x="2720" y="1744" type="branch" />
            <wire x2="2720" y1="1744" y2="1744" x1="2672" />
        </branch>
        <branch name="IN_INIT">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="2128" y="2000" type="branch" />
            <wire x2="2176" y1="2000" y2="2000" x1="2128" />
        </branch>
        <branch name="dlx_MAO(31:0)">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="2128" y="2064" type="branch" />
            <wire x2="2176" y1="2064" y2="2064" x1="2128" />
        </branch>
        <branch name="D_GPR(31:0)">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="2128" y="2128" type="branch" />
            <wire x2="2176" y1="2128" y2="2128" x1="2128" />
        </branch>
        <branch name="CLK">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="2128" y="2192" type="branch" />
            <wire x2="2176" y1="2192" y2="2192" x1="2128" />
        </branch>
        <branch name="RESET">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="2128" y="2256" type="branch" />
            <wire x2="2176" y1="2256" y2="2256" x1="2128" />
        </branch>
        <branch name="AI(9:0)">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="2128" y="2320" type="branch" />
            <wire x2="2176" y1="2320" y2="2320" x1="2128" />
        </branch>
        <branch name="LA_DATA_IN(31:0)">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="2128" y="2384" type="branch" />
            <wire x2="2176" y1="2384" y2="2384" x1="2128" />
        </branch>
        <branch name="STOP_N">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="2112" y="2448" type="branch" />
            <wire x2="2176" y1="2448" y2="2448" x1="2112" />
        </branch>
        <branch name="STEP_EN">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="2144" y="2512" type="branch" />
            <wire x2="2176" y1="2512" y2="2512" x1="2144" />
        </branch>
        <branch name="WR_IN_N">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="2128" y="2576" type="branch" />
            <wire x2="2176" y1="2576" y2="2576" x1="2128" />
        </branch>
        <branch name="Card_Sel">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="2128" y="2640" type="branch" />
            <wire x2="2176" y1="2640" y2="2640" x1="2128" />
        </branch>
        <branch name="REG_ADDR(4:0)">
            <attrtext style="alignment:SOFT-LEFT;fontsize:28;fontname:Arial" attrname="Name" x="2704" y="2640" type="branch" />
            <wire x2="2704" y1="2640" y2="2640" x1="2672" />
        </branch>
        <branch name="SDO_MON(31:0)">
            <attrtext style="alignment:SOFT-LEFT;fontsize:28;fontname:Arial" attrname="Name" x="2704" y="2320" type="branch" />
            <wire x2="2704" y1="2320" y2="2320" x1="2672" />
        </branch>
        <branch name="SACK_N_MON">
            <attrtext style="alignment:SOFT-LEFT;fontsize:28;fontname:Arial" attrname="Name" x="2704" y="2000" type="branch" />
            <wire x2="2704" y1="2000" y2="2000" x1="2672" />
        </branch>
        <instance x="2176" y="2672" name="XLXI_34" orien="R0">
        </instance>
        <branch name="CLK">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="2160" y="96" type="branch" />
            <wire x2="2224" y1="96" y2="96" x1="2160" />
        </branch>
        <branch name="RESET">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="2176" y="224" type="branch" />
            <wire x2="2224" y1="224" y2="224" x1="2176" />
        </branch>
        <branch name="dlx_ACK_N">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="2176" y="352" type="branch" />
            <wire x2="2224" y1="352" y2="352" x1="2176" />
        </branch>
        <branch name="STEP_EN">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="2176" y="480" type="branch" />
            <wire x2="2224" y1="480" y2="480" x1="2176" />
        </branch>
        <branch name="DO(31:0)">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="2176" y="608" type="branch" />
            <wire x2="2224" y1="608" y2="608" x1="2176" />
        </branch>
        <branch name="REG_ADDR(4:0)">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="2176" y="736" type="branch" />
            <wire x2="2224" y1="736" y2="736" x1="2176" />
        </branch>
        <branch name="LA_DATA_IN(31:0)">
            <attrtext style="alignment:SOFT-LEFT;fontsize:28;fontname:Arial" attrname="Name" x="2768" y="736" type="branch" />
            <wire x2="2768" y1="736" y2="736" x1="2688" />
        </branch>
        <branch name="D_GPR(31:0)">
            <attrtext style="alignment:SOFT-LEFT;fontsize:28;fontname:Arial" attrname="Name" x="2768" y="672" type="branch" />
            <wire x2="2768" y1="672" y2="672" x1="2688" />
        </branch>
        <branch name="XLXN_41(1:0)">
            <wire x2="2768" y1="608" y2="608" x1="2688" />
        </branch>
        <branch name="XLXN_42(4:0)">
            <wire x2="2768" y1="544" y2="544" x1="2688" />
        </branch>
        <branch name="dlx_MDO(31:0)">
            <attrtext style="alignment:SOFT-LEFT;fontsize:28;fontname:Arial" attrname="Name" x="2768" y="480" type="branch" />
            <wire x2="2768" y1="480" y2="480" x1="2688" />
        </branch>
        <branch name="dlx_MAO(31:0)">
            <attrtext style="alignment:SOFT-LEFT;fontsize:28;fontname:Arial" attrname="Name" x="2768" y="416" type="branch" />
            <wire x2="2768" y1="416" y2="416" x1="2688" />
        </branch>
        <branch name="IN_INIT">
            <attrtext style="alignment:SOFT-LEFT;fontsize:28;fontname:Arial" attrname="Name" x="2768" y="352" type="branch" />
            <wire x2="2768" y1="352" y2="352" x1="2688" />
        </branch>
        <branch name="STOP_N">
            <attrtext style="alignment:SOFT-LEFT;fontsize:28;fontname:Arial" attrname="Name" x="2768" y="288" type="branch" />
            <wire x2="2768" y1="288" y2="288" x1="2688" />
        </branch>
        <branch name="classify_pulse">
            <attrtext style="alignment:SOFT-LEFT;fontsize:28;fontname:Arial" attrname="Name" x="2768" y="224" type="branch" />
            <wire x2="2768" y1="224" y2="224" x1="2688" />
        </branch>
        <branch name="dlx_WR_OUT_N">
            <attrtext style="alignment:SOFT-LEFT;fontsize:28;fontname:Arial" attrname="Name" x="2768" y="160" type="branch" />
            <wire x2="2768" y1="160" y2="160" x1="2688" />
        </branch>
        <branch name="dlx_AS_N">
            <attrtext style="alignment:SOFT-LEFT;fontsize:28;fontname:Arial" attrname="Name" x="2768" y="96" type="branch" />
            <wire x2="2768" y1="96" y2="96" x1="2688" />
        </branch>
        <branch name="wf_count(4:0)">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="2176" y="800" type="branch" />
            <wire x2="2224" y1="800" y2="800" x1="2176" />
        </branch>
        <instance x="2224" y="768" name="XLXI_39" orien="R0">
        </instance>
        <branch name="debug_accel(3:0)">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="2176" y="864" type="branch" />
            <wire x2="2224" y1="864" y2="864" x1="2176" />
        </branch>
        <branch name="debug_accel(3:0)">
            <attrtext style="alignment:SOFT-LEFT;fontsize:28;fontname:Arial" attrname="Name" x="2720" y="1808" type="branch" />
            <wire x2="2720" y1="1808" y2="1808" x1="2672" />
        </branch>
    </sheet>
    <sheet sheetnum="2" width="3520" height="2720">
        <branch name="DO(31:0)">
            <attrtext style="alignment:SOFT-LEFT;fontsize:28;fontname:Arial" attrname="Name" x="2240" y="1632" type="branch" />
            <wire x2="2240" y1="1632" y2="1632" x1="1840" />
        </branch>
        <branch name="AI(9:0)">
            <attrtext style="alignment:SOFT-LEFT;fontsize:28;fontname:Arial" attrname="Name" x="2240" y="1568" type="branch" />
            <wire x2="2240" y1="1568" y2="1568" x1="1840" />
        </branch>
        <branch name="sdClk_o">
            <wire x2="1856" y1="1056" y2="1056" x1="1840" />
            <wire x2="1904" y1="1056" y2="1056" x1="1856" />
        </branch>
        <branch name="sdBs_o(1:0)">
            <wire x2="1856" y1="1760" y2="1760" x1="1840" />
            <wire x2="1904" y1="1760" y2="1760" x1="1856" />
        </branch>
        <branch name="sdDqml_o">
            <wire x2="1856" y1="1184" y2="1184" x1="1840" />
            <wire x2="1904" y1="1184" y2="1184" x1="1856" />
        </branch>
        <branch name="sdDqmh_o">
            <wire x2="1856" y1="1120" y2="1120" x1="1840" />
            <wire x2="1904" y1="1120" y2="1120" x1="1856" />
        </branch>
        <branch name="sdWe_bo">
            <wire x2="1856" y1="1312" y2="1312" x1="1840" />
            <wire x2="1904" y1="1312" y2="1312" x1="1856" />
        </branch>
        <branch name="sdCas_bo">
            <wire x2="1856" y1="864" y2="864" x1="1840" />
            <wire x2="1888" y1="864" y2="864" x1="1856" />
        </branch>
        <branch name="sdRas_bo">
            <wire x2="1856" y1="1248" y2="1248" x1="1840" />
            <wire x2="1904" y1="1248" y2="1248" x1="1856" />
        </branch>
        <branch name="sdCe_bo">
            <wire x2="1856" y1="928" y2="928" x1="1840" />
            <wire x2="1888" y1="928" y2="928" x1="1856" />
        </branch>
        <branch name="sdCke_o">
            <wire x2="1856" y1="992" y2="992" x1="1840" />
            <wire x2="1888" y1="992" y2="992" x1="1856" />
        </branch>
        <branch name="IN_INIT">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="1360" y="832" type="branch" />
            <wire x2="1408" y1="832" y2="832" x1="1360" />
        </branch>
        <branch name="fpgaClk_i">
            <wire x2="1408" y1="720" y2="720" x1="1376" />
        </branch>
        <branch name="MAO(31:0)">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="1344" y="1392" type="branch" />
            <wire x2="1408" y1="1392" y2="1392" x1="1344" />
        </branch>
        <branch name="R_DO(31:0)">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="1328" y="1616" type="branch" />
            <wire x2="1408" y1="1616" y2="1616" x1="1328" />
        </branch>
        <instance x="1408" y="1856" name="XLXI_23" orien="R0">
        </instance>
        <branch name="AS_N">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="1360" y="608" type="branch" />
            <wire x2="1408" y1="608" y2="608" x1="1360" />
        </branch>
        <branch name="WR_OUT_N">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="1344" y="1280" type="branch" />
            <wire x2="1408" y1="1280" y2="1280" x1="1344" />
        </branch>
        <branch name="RACK_N">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="1360" y="944" type="branch" />
            <wire x2="1408" y1="944" y2="944" x1="1360" />
        </branch>
        <branch name="SACK_N">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="1344" y="1056" type="branch" />
            <wire x2="1408" y1="1056" y2="1056" x1="1344" />
        </branch>
        <branch name="MDO(31:0)">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="1344" y="1504" type="branch" />
            <wire x2="1408" y1="1504" y2="1504" x1="1344" />
        </branch>
        <branch name="SDO(31:0)">
            <attrtext style="alignment:SOFT-RIGHT;fontsize:28;fontname:Arial" attrname="Name" x="1344" y="1728" type="branch" />
            <wire x2="1408" y1="1728" y2="1728" x1="1344" />
        </branch>
        <branch name="sdClkFb_i">
            <wire x2="1408" y1="1168" y2="1168" x1="1360" />
        </branch>
        <iomarker fontsize="28" x="1360" y="1168" name="sdClkFb_i" orien="R180" />
        <iomarker fontsize="28" x="1376" y="720" name="fpgaClk_i" orien="R180" />
        <branch name="RESET">
            <attrtext style="alignment:SOFT-LEFT;fontsize:28;fontname:Arial" attrname="Name" x="1904" y="736" type="branch" />
            <wire x2="1904" y1="736" y2="736" x1="1840" />
        </branch>
        <branch name="CLK">
            <attrtext style="alignment:SOFT-LEFT;fontsize:28;fontname:Arial" attrname="Name" x="1904" y="608" type="branch" />
            <wire x2="1904" y1="608" y2="608" x1="1840" />
        </branch>
        <branch name="STEP_EN">
            <attrtext style="alignment:SOFT-LEFT;fontsize:28;fontname:Arial" attrname="Name" x="1920" y="1440" type="branch" />
            <wire x2="1920" y1="1440" y2="1440" x1="1840" />
        </branch>
        <branch name="WR_IN_N">
            <attrtext style="alignment:SOFT-LEFT;fontsize:28;fontname:Arial" attrname="Name" x="1936" y="1504" type="branch" />
            <wire x2="1936" y1="1504" y2="1504" x1="1840" />
        </branch>
        <branch name="ACK_N">
            <attrtext style="alignment:SOFT-LEFT;fontsize:28;fontname:Arial" attrname="Name" x="1936" y="672" type="branch" />
            <wire x2="1936" y1="672" y2="672" x1="1840" />
        </branch>
        <branch name="Rsel">
            <attrtext style="alignment:SOFT-LEFT;fontsize:28;fontname:Arial" attrname="Name" x="1936" y="800" type="branch" />
            <wire x2="1936" y1="800" y2="800" x1="1840" />
        </branch>
        <branch name="Card_Sel">
            <attrtext style="alignment:SOFT-LEFT;fontsize:28;fontname:Arial" attrname="Name" x="1936" y="1376" type="branch" />
            <wire x2="1936" y1="1376" y2="1376" x1="1840" />
        </branch>
        <branch name="sdData_io(15:0)">
            <wire x2="1856" y1="1824" y2="1824" x1="1840" />
            <wire x2="1904" y1="1824" y2="1824" x1="1856" />
        </branch>
        <branch name="sdAddr_o(12:0)">
            <wire x2="1904" y1="1696" y2="1696" x1="1840" />
        </branch>
        <iomarker fontsize="28" x="1904" y="1696" name="sdAddr_o(12:0)" orien="R0" />
        <iomarker fontsize="28" x="1904" y="1824" name="sdData_io(15:0)" orien="R0" />
        <iomarker fontsize="28" x="1904" y="1056" name="sdClk_o" orien="R0" />
        <iomarker fontsize="28" x="1888" y="864" name="sdCas_bo" orien="R0" />
        <iomarker fontsize="28" x="1888" y="928" name="sdCe_bo" orien="R0" />
        <iomarker fontsize="28" x="1888" y="992" name="sdCke_o" orien="R0" />
        <iomarker fontsize="28" x="1904" y="1184" name="sdDqml_o" orien="R0" />
        <iomarker fontsize="28" x="1904" y="1120" name="sdDqmh_o" orien="R0" />
        <iomarker fontsize="28" x="1904" y="1312" name="sdWe_bo" orien="R0" />
        <iomarker fontsize="28" x="1904" y="1248" name="sdRas_bo" orien="R0" />
        <iomarker fontsize="28" x="1904" y="1760" name="sdBs_o(1:0)" orien="R0" />
    </sheet>
</drawing>