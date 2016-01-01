module rf_1wr_1rd_always_1_guarded_0_bool_2e(input clk, input reset,
    input  io_glock,
    input  io_r1load,
    input  io_r1opcode,
    input  io_t1data,
    input  io_t1load,
    input  io_t1opcode,
    output io_r1data,
    output[1:0] io_guard
);

  wire[1:0] T0;
  wire[1:0] T1;
  wire guard_0;
  wire T2;
  reg  rf_0;
  wire T20;
  wire T3;
  wire T4;
  wire T5;
  wire[1:0] T6;
  wire T7;
  wire T8;
  wire T9;
  wire T10;
  wire T11;
  wire guard_1;
  wire T12;
  reg  rf_1;
  wire T21;
  wire T13;
  wire T14;
  wire T15;
  wire T16;
  wire T17;
  wire T18;
  wire T19;

`ifndef SYNTHESIS
// synthesis translate_off
  integer initvar;
  initial begin
    #0.002;
    rf_0 = {1{$random}};
    rf_1 = {1{$random}};
  end
// synthesis translate_on
`endif

  assign io_guard = T0;
  assign T0 = T1;
  assign T1 = {guard_1, guard_0};
  assign guard_0 = T2 != 1'h0;
  assign T2 = T10 ? io_t1data : rf_0;
  assign T20 = reset ? 1'h0 : T3;
  assign T3 = T4 ? io_t1data : rf_0;
  assign T4 = T8 & T5;
  assign T5 = T6[1'h0:1'h0];
  assign T6 = 1'h1 << T7;
  assign T7 = io_t1opcode;
  assign T8 = T9 & io_t1load;
  assign T9 = io_glock ^ 1'h1;
  assign T10 = io_t1load & T11;
  assign T11 = io_t1opcode == 1'h0;
  assign guard_1 = T12 != 1'h0;
  assign T12 = T16 ? io_t1data : rf_1;
  assign T21 = reset ? 1'h0 : T13;
  assign T13 = T14 ? io_t1data : rf_1;
  assign T14 = T8 & T15;
  assign T15 = T6[1'h1:1'h1];
  assign T16 = io_t1load & T17;
  assign T17 = io_t1opcode == 1'h1;
  assign io_r1data = T18;
  assign T18 = T19 ? rf_1 : rf_0;
  assign T19 = io_r1opcode;
  always @(posedge clk or negedge reset) begin
    if(!reset) begin
      rf_0 <= 1'h0;
    end else if(T4) begin
      rf_0 <= io_t1data;
    end
  end
  always @(posedge clk or negedge reset) begin
    if(!reset) begin
      rf_1 <= 1'h0;
    end else if(T14) begin
      rf_1 <= io_t1data;
    end
  end
endmodule

