//Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2018.2 (win64) Build 2258646 Thu Jun 14 20:03:12 MDT 2018
//Date        : Mon Oct 22 13:09:48 2018
//Host        : WK142 running 64-bit major release  (build 9200)
//Command     : generate_target design_1_wrapper.bd
//Design      : design_1_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module design_1_wrapper
   (DDR_addr,
    DDR_ba,
    DDR_cas_n,
    DDR_ck_n,
    DDR_ck_p,
    DDR_cke,
    DDR_cs_n,
    DDR_dm,
    DDR_dq,
    DDR_dqs_n,
    DDR_dqs_p,
    DDR_odt,
    DDR_ras_n,
    DDR_reset_n,
    DDR_we_n,
    FIXED_IO_ddr_vrn,
    FIXED_IO_ddr_vrp,
    FIXED_IO_mio,
    FIXED_IO_ps_clk,
    FIXED_IO_ps_porb,
    FIXED_IO_ps_srstb,
    Vaux0_0_v_n,
    Vaux0_0_v_p,
    Vaux12_0_v_n,
    Vaux12_0_v_p,
    Vaux13_0_v_n,
    Vaux13_0_v_p,
    Vaux15_0_v_n,
    Vaux15_0_v_p,
    Vaux1_0_v_n,
    Vaux1_0_v_p,
    Vaux5_0_v_n,
    Vaux5_0_v_p,
    Vaux6_0_v_n,
    Vaux6_0_v_p,
    Vaux8_0_v_n,
    Vaux8_0_v_p,
    Vaux9_0_v_n,
    Vaux9_0_v_p,
    Vp_Vn_0_v_n,
    Vp_Vn_0_v_p,
    btns_2bits_tri_i,
    pwm_0);
  inout [14:0]DDR_addr;
  inout [2:0]DDR_ba;
  inout DDR_cas_n;
  inout DDR_ck_n;
  inout DDR_ck_p;
  inout DDR_cke;
  inout DDR_cs_n;
  inout [3:0]DDR_dm;
  inout [31:0]DDR_dq;
  inout [3:0]DDR_dqs_n;
  inout [3:0]DDR_dqs_p;
  inout DDR_odt;
  inout DDR_ras_n;
  inout DDR_reset_n;
  inout DDR_we_n;
  inout FIXED_IO_ddr_vrn;
  inout FIXED_IO_ddr_vrp;
  inout [53:0]FIXED_IO_mio;
  inout FIXED_IO_ps_clk;
  inout FIXED_IO_ps_porb;
  inout FIXED_IO_ps_srstb;
  input Vaux0_0_v_n;
  input Vaux0_0_v_p;
  input Vaux12_0_v_n;
  input Vaux12_0_v_p;
  input Vaux13_0_v_n;
  input Vaux13_0_v_p;
  input Vaux15_0_v_n;
  input Vaux15_0_v_p;
  input Vaux1_0_v_n;
  input Vaux1_0_v_p;
  input Vaux5_0_v_n;
  input Vaux5_0_v_p;
  input Vaux6_0_v_n;
  input Vaux6_0_v_p;
  input Vaux8_0_v_n;
  input Vaux8_0_v_p;
  input Vaux9_0_v_n;
  input Vaux9_0_v_p;
  input Vp_Vn_0_v_n;
  input Vp_Vn_0_v_p;
  input [1:0]btns_2bits_tri_i;
  output [2:0]pwm_0;

  wire [14:0]DDR_addr;
  wire [2:0]DDR_ba;
  wire DDR_cas_n;
  wire DDR_ck_n;
  wire DDR_ck_p;
  wire DDR_cke;
  wire DDR_cs_n;
  wire [3:0]DDR_dm;
  wire [31:0]DDR_dq;
  wire [3:0]DDR_dqs_n;
  wire [3:0]DDR_dqs_p;
  wire DDR_odt;
  wire DDR_ras_n;
  wire DDR_reset_n;
  wire DDR_we_n;
  wire FIXED_IO_ddr_vrn;
  wire FIXED_IO_ddr_vrp;
  wire [53:0]FIXED_IO_mio;
  wire FIXED_IO_ps_clk;
  wire FIXED_IO_ps_porb;
  wire FIXED_IO_ps_srstb;
  wire Vaux0_0_v_n;
  wire Vaux0_0_v_p;
  wire Vaux12_0_v_n;
  wire Vaux12_0_v_p;
  wire Vaux13_0_v_n;
  wire Vaux13_0_v_p;
  wire Vaux15_0_v_n;
  wire Vaux15_0_v_p;
  wire Vaux1_0_v_n;
  wire Vaux1_0_v_p;
  wire Vaux5_0_v_n;
  wire Vaux5_0_v_p;
  wire Vaux6_0_v_n;
  wire Vaux6_0_v_p;
  wire Vaux8_0_v_n;
  wire Vaux8_0_v_p;
  wire Vaux9_0_v_n;
  wire Vaux9_0_v_p;
  wire Vp_Vn_0_v_n;
  wire Vp_Vn_0_v_p;
  wire [1:0]btns_2bits_tri_i;
  wire [2:0]pwm_0;

  design_1 design_1_i
       (.DDR_addr(DDR_addr),
        .DDR_ba(DDR_ba),
        .DDR_cas_n(DDR_cas_n),
        .DDR_ck_n(DDR_ck_n),
        .DDR_ck_p(DDR_ck_p),
        .DDR_cke(DDR_cke),
        .DDR_cs_n(DDR_cs_n),
        .DDR_dm(DDR_dm),
        .DDR_dq(DDR_dq),
        .DDR_dqs_n(DDR_dqs_n),
        .DDR_dqs_p(DDR_dqs_p),
        .DDR_odt(DDR_odt),
        .DDR_ras_n(DDR_ras_n),
        .DDR_reset_n(DDR_reset_n),
        .DDR_we_n(DDR_we_n),
        .FIXED_IO_ddr_vrn(FIXED_IO_ddr_vrn),
        .FIXED_IO_ddr_vrp(FIXED_IO_ddr_vrp),
        .FIXED_IO_mio(FIXED_IO_mio),
        .FIXED_IO_ps_clk(FIXED_IO_ps_clk),
        .FIXED_IO_ps_porb(FIXED_IO_ps_porb),
        .FIXED_IO_ps_srstb(FIXED_IO_ps_srstb),
        .Vaux0_0_v_n(Vaux0_0_v_n),
        .Vaux0_0_v_p(Vaux0_0_v_p),
        .Vaux12_0_v_n(Vaux12_0_v_n),
        .Vaux12_0_v_p(Vaux12_0_v_p),
        .Vaux13_0_v_n(Vaux13_0_v_n),
        .Vaux13_0_v_p(Vaux13_0_v_p),
        .Vaux15_0_v_n(Vaux15_0_v_n),
        .Vaux15_0_v_p(Vaux15_0_v_p),
        .Vaux1_0_v_n(Vaux1_0_v_n),
        .Vaux1_0_v_p(Vaux1_0_v_p),
        .Vaux5_0_v_n(Vaux5_0_v_n),
        .Vaux5_0_v_p(Vaux5_0_v_p),
        .Vaux6_0_v_n(Vaux6_0_v_n),
        .Vaux6_0_v_p(Vaux6_0_v_p),
        .Vaux8_0_v_n(Vaux8_0_v_n),
        .Vaux8_0_v_p(Vaux8_0_v_p),
        .Vaux9_0_v_n(Vaux9_0_v_n),
        .Vaux9_0_v_p(Vaux9_0_v_p),
        .Vp_Vn_0_v_n(Vp_Vn_0_v_n),
        .Vp_Vn_0_v_p(Vp_Vn_0_v_p),
        .btns_2bits_tri_i(btns_2bits_tri_i),
        .pwm_0(pwm_0));
endmodule
