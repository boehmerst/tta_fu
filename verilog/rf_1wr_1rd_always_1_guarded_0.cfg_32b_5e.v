module rf_1wr_1rd_always_1_guarded_0_32b_5e(input clk, input reset,
    input  io_glock,
    input  io_r1load,
    input [2:0] io_r1opcode,
    input [31:0] io_t1data,
    input  io_t1load,
    input [2:0] io_t1opcode,
    output[31:0] io_r1data,
    output[4:0] io_guard
);

  wire[4:0] T0;
  wire[4:0] T1;
  wire[2:0] T2;
  wire[1:0] T3;
  wire guard_0;
  wire[31:0] T4;
  reg [31:0] rf_0;
  wire[31:0] T48;
  wire[31:0] T5;
  wire T6;
  wire T7;
  wire[7:0] T8;
  wire[2:0] T9;
  wire T10;
  wire T11;
  wire T12;
  wire T13;
  wire guard_1;
  wire[31:0] T14;
  reg [31:0] rf_1;
  wire[31:0] T49;
  wire[31:0] T15;
  wire T16;
  wire T17;
  wire T18;
  wire T19;
  wire guard_2;
  wire[31:0] T20;
  reg [31:0] rf_2;
  wire[31:0] T50;
  wire[31:0] T21;
  wire T22;
  wire T23;
  wire T24;
  wire T25;
  wire[1:0] T26;
  wire guard_3;
  wire[31:0] T27;
  reg [31:0] rf_3;
  wire[31:0] T51;
  wire[31:0] T28;
  wire T29;
  wire T30;
  wire T31;
  wire T32;
  wire guard_4;
  wire[31:0] T33;
  reg [31:0] rf_4;
  wire[31:0] T52;
  wire[31:0] T34;
  wire T35;
  wire T36;
  wire T37;
  wire T38;
  wire[31:0] T39;
  wire[31:0] T40;
  wire[31:0] T41;
  wire T42;
  wire[2:0] T43;
  wire[31:0] T44;
  wire T45;
  wire T46;
  wire T47;

`ifndef SYNTHESIS
// synthesis translate_off
  integer initvar;
  initial begin
    #0.002;
    rf_0 = {1{$random}};
    rf_1 = {1{$random}};
    rf_2 = {1{$random}};
    rf_3 = {1{$random}};
    rf_4 = {1{$random}};
  end
// synthesis translate_on
`endif

  assign io_guard = T0;
  assign T0 = T1;
  assign T1 = {T26, T2};
  assign T2 = {guard_2, T3};
  assign T3 = {guard_1, guard_0};
  assign guard_0 = T4 != 32'h0;
  assign T4 = T12 ? io_t1data : rf_0;
  assign T48 = reset ? 32'h0 : T5;
  assign T5 = T6 ? io_t1data : rf_0;
  assign T6 = T10 & T7;
  assign T7 = T8[1'h0:1'h0];
  assign T8 = 1'h1 << T9;
  assign T9 = io_t1opcode;
  assign T10 = T11 & io_t1load;
  assign T11 = io_glock ^ 1'h1;
  assign T12 = io_t1load & T13;
  assign T13 = io_t1opcode == 3'h0;
  assign guard_1 = T14 != 32'h0;
  assign T14 = T18 ? io_t1data : rf_1;
  assign T49 = reset ? 32'h0 : T15;
  assign T15 = T16 ? io_t1data : rf_1;
  assign T16 = T10 & T17;
  assign T17 = T8[1'h1:1'h1];
  assign T18 = io_t1load & T19;
  assign T19 = io_t1opcode == 3'h1;
  assign guard_2 = T20 != 32'h0;
  assign T20 = T24 ? io_t1data : rf_2;
  assign T50 = reset ? 32'h0 : T21;
  assign T21 = T22 ? io_t1data : rf_2;
  assign T22 = T10 & T23;
  assign T23 = T8[2'h2:2'h2];
  assign T24 = io_t1load & T25;
  assign T25 = io_t1opcode == 3'h2;
  assign T26 = {guard_4, guard_3};
  assign guard_3 = T27 != 32'h0;
  assign T27 = T31 ? io_t1data : rf_3;
  assign T51 = reset ? 32'h0 : T28;
  assign T28 = T29 ? io_t1data : rf_3;
  assign T29 = T10 & T30;
  assign T30 = T8[2'h3:2'h3];
  assign T31 = io_t1load & T32;
  assign T32 = io_t1opcode == 3'h3;
  assign guard_4 = T33 != 32'h0;
  assign T33 = T37 ? io_t1data : rf_4;
  assign T52 = reset ? 32'h0 : T34;
  assign T34 = T35 ? io_t1data : rf_4;
  assign T35 = T10 & T36;
  assign T36 = T8[3'h4:3'h4];
  assign T37 = io_t1load & T38;
  assign T38 = io_t1opcode == 3'h4;
  assign io_r1data = T39;
  assign T39 = T47 ? rf_4 : T40;
  assign T40 = T46 ? T44 : T41;
  assign T41 = T42 ? rf_1 : rf_0;
  assign T42 = T43[1'h0:1'h0];
  assign T43 = io_r1opcode;
  assign T44 = T45 ? rf_3 : rf_2;
  assign T45 = T43[1'h0:1'h0];
  assign T46 = T43[1'h1:1'h1];
  assign T47 = T43[2'h2:2'h2];
  always @(posedge clk or negedge reset) begin
    if(!reset) begin
      rf_0 <= 32'h0;
    end else if(T6) begin
      rf_0 <= io_t1data;
    end
  end
  always @(posedge clk or negedge reset) begin
    if(!reset) begin
      rf_1 <= 32'h0;
    end else if(T16) begin
      rf_1 <= io_t1data;
    end
  end
  always @(posedge clk or negedge reset) begin
    if(!reset) begin
      rf_2 <= 32'h0;
    end else if(T22) begin
      rf_2 <= io_t1data;
    end
  end
  always @(posedge clk or negedge reset) begin
    if(!reset) begin
      rf_3 <= 32'h0;
    end else if(T29) begin
      rf_3 <= io_t1data;
    end
  end
  always @(posedge clk or negedge reset) begin
    if(!reset) begin
      rf_4 <= 32'h0;
    end else if(T35) begin
      rf_4 <= io_t1data;
    end
  end
endmodule

