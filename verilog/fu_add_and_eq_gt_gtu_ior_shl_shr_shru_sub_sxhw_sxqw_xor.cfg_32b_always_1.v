module fu_add_and_eq_gt_gtu_ior_shl_shr_shru_sub_sxhw_sxqw_xor_32b_always_1(input clk, input reset,
    input [31:0] io_t1data,
    input [3:0] io_t1opcode,
    input  io_t1load,
    input [31:0] io_o1data,
    input  io_o1load,
    output[31:0] io_r1data,
    input  io_glock
);

  wire[31:0] alu_out;
  wire[31:0] T0;
  wire[31:0] T1;
  wire[31:0] T2;
  wire[31:0] T3;
  wire[31:0] T4;
  wire[31:0] T5;
  wire[31:0] T6;
  wire[31:0] T137;
  wire cmp;
  wire T7;
  wire T8;
  wire T9;
  wire T10;
  wire[31:0] alu_a;
  reg [31:0] t1reg;
  wire[31:0] T138;
  wire[31:0] T11;
  wire t1_en;
  wire T12;
  wire T13;
  wire T14;
  wire[31:0] alu_b;
  reg [31:0] o1reg;
  wire[31:0] T139;
  wire[31:0] T15;
  wire o1_en;
  wire T16;
  wire T17;
  wire[3:0] opcode;
  reg [3:0] opc1reg;
  wire[3:0] T140;
  wire[3:0] T18;
  wire T19;
  wire T20;
  wire T21;
  wire T22;
  wire T23;
  wire T24;
  wire T25;
  wire equal;
  wire T26;
  wire[31:0] T27;
  wire[15:0] T28;
  wire[15:0] T29;
  wire[15:0] T141;
  wire T30;
  wire T31;
  wire[31:0] T32;
  wire[7:0] T33;
  wire[23:0] T34;
  wire[23:0] T142;
  wire T35;
  wire T36;
  wire[31:0] T37;
  wire T38;
  wire[31:0] T39;
  wire T40;
  wire[31:0] T41;
  wire T42;
  wire[31:0] shift_left;
  wire[31:0] T43;
  wire[31:0] T44;
  wire[30:0] T45;
  wire[31:0] T46;
  wire[31:0] T47;
  wire[31:0] T48;
  wire[29:0] T49;
  wire[31:0] T50;
  wire[31:0] T51;
  wire[31:0] T52;
  wire[27:0] T53;
  wire[31:0] T54;
  wire[31:0] T55;
  wire[31:0] T56;
  wire[23:0] T57;
  wire[31:0] T58;
  wire[31:0] T59;
  wire[31:0] T60;
  wire[15:0] T61;
  wire[31:0] T62;
  wire[31:0] T143;
  wire[15:0] T63;
  wire[31:0] T64;
  wire[31:0] T144;
  wire[23:0] T65;
  wire[31:0] T66;
  wire[31:0] T145;
  wire[27:0] T67;
  wire[31:0] T68;
  wire[31:0] T146;
  wire[29:0] T69;
  wire[31:0] T70;
  wire[31:0] T147;
  wire[30:0] T71;
  wire T72;
  wire[31:0] shift_right;
  wire[31:0] T73;
  wire[31:0] T74;
  wire[31:0] T75;
  wire[31:0] T76;
  wire[31:0] shift_in;
  wire[31:0] T77;
  wire[31:0] T78;
  wire[31:0] T79;
  wire[30:0] T80;
  wire[31:0] T81;
  wire[31:0] T82;
  wire[31:0] T83;
  wire[29:0] T84;
  wire[31:0] T85;
  wire[31:0] T86;
  wire[31:0] T87;
  wire[27:0] T88;
  wire[31:0] T89;
  wire[31:0] T90;
  wire[31:0] T91;
  wire[23:0] T92;
  wire[31:0] T93;
  wire[31:0] T94;
  wire[31:0] T95;
  wire[15:0] T96;
  wire[31:0] T97;
  wire[31:0] T148;
  wire[15:0] T98;
  wire[31:0] T99;
  wire[31:0] T149;
  wire[23:0] T100;
  wire[31:0] T101;
  wire[31:0] T150;
  wire[27:0] T102;
  wire[31:0] T103;
  wire[31:0] T151;
  wire[29:0] T104;
  wire[31:0] T105;
  wire[31:0] T152;
  wire[30:0] T106;
  wire T107;
  wire[31:0] T108;
  wire[15:0] T109;
  wire[15:0] T110;
  wire[15:0] T153;
  wire T111;
  wire T112;
  wire[31:0] T113;
  wire[23:0] T114;
  wire[7:0] T115;
  wire[7:0] T154;
  wire T116;
  wire[31:0] T117;
  wire[27:0] T118;
  wire[3:0] T119;
  wire[3:0] T155;
  wire T120;
  wire[31:0] T121;
  wire[29:0] T122;
  wire[1:0] T123;
  wire[1:0] T156;
  wire T124;
  wire[31:0] T125;
  wire[30:0] T126;
  wire T127;
  wire T128;
  wire T129;
  wire T130;
  wire[31:0] sum;
  wire[31:0] T131;
  wire[31:0] T132;
  wire T133;
  wire T134;
  wire T135;
  wire T136;

`ifndef SYNTHESIS
// synthesis translate_off
  integer initvar;
  initial begin
    #0.002;
    t1reg = {1{$random}};
    o1reg = {1{$random}};
    opc1reg = {1{$random}};
  end
// synthesis translate_on
`endif

  assign io_r1data = alu_out;
  assign alu_out = T134 ? sum : T0;
  assign T0 = T128 ? shift_right : T1;
  assign T1 = T72 ? shift_left : T2;
  assign T2 = T42 ? T41 : T3;
  assign T3 = T40 ? T39 : T4;
  assign T4 = T38 ? T37 : T5;
  assign T5 = T36 ? T32 : T6;
  assign T6 = T31 ? T27 : T137;
  assign T137 = {31'h0, cmp};
  assign cmp = T26 ? equal : T7;
  assign T7 = T23 ? T19 : T8;
  assign T8 = T17 ? T13 : T9;
  assign T9 = T10 ^ 1'h1;
  assign T10 = alu_a[5'h1f:5'h1f];
  assign alu_a = t1reg;
  assign T138 = reset ? 32'h0 : T11;
  assign T11 = t1_en ? io_t1data : t1reg;
  assign t1_en = T12 & io_t1load;
  assign T12 = io_glock ^ 1'h1;
  assign T13 = T14 ^ 1'h1;
  assign T14 = alu_b[5'h1f:5'h1f];
  assign alu_b = o1reg;
  assign T139 = reset ? 32'h0 : T15;
  assign T15 = o1_en ? io_o1data : o1reg;
  assign o1_en = T16 & io_o1load;
  assign T16 = io_glock ^ 1'h1;
  assign T17 = opcode == 4'h4;
  assign opcode = opc1reg;
  assign T140 = reset ? 4'h0 : T18;
  assign T18 = t1_en ? io_t1opcode : opc1reg;
  assign T19 = T21 & T20;
  assign T20 = equal ^ 1'h1;
  assign T21 = T22 ^ 1'h1;
  assign T22 = sum[5'h1f:5'h1f];
  assign T23 = T25 == T24;
  assign T24 = alu_b[5'h1f:5'h1f];
  assign T25 = alu_a[5'h1f:5'h1f];
  assign equal = sum == 32'h0;
  assign T26 = opcode == 4'h2;
  assign T27 = {T29, T28};
  assign T28 = alu_a[4'hf:1'h0];
  assign T29 = 16'h0 - T141;
  assign T141 = {15'h0, T30};
  assign T30 = alu_a[4'hf:4'hf];
  assign T31 = opcode == 4'ha;
  assign T32 = {T34, T33};
  assign T33 = alu_a[3'h7:1'h0];
  assign T34 = 24'h0 - T142;
  assign T142 = {23'h0, T35};
  assign T35 = alu_a[3'h7:3'h7];
  assign T36 = opcode == 4'hb;
  assign T37 = alu_a ^ alu_b;
  assign T38 = opcode == 4'hc;
  assign T39 = alu_a | alu_b;
  assign T40 = opcode == 4'h5;
  assign T41 = alu_a & alu_b;
  assign T42 = opcode == 4'h1;
  assign shift_left = T70 | T43;
  assign T43 = T44 & 32'haaaaaaaa;
  assign T44 = T45 << 1'h1;
  assign T45 = T46[5'h1e:1'h0];
  assign T46 = T68 | T47;
  assign T47 = T48 & 32'hcccccccc;
  assign T48 = T49 << 2'h2;
  assign T49 = T50[5'h1d:1'h0];
  assign T50 = T66 | T51;
  assign T51 = T52 & 32'hf0f0f0f0;
  assign T52 = T53 << 3'h4;
  assign T53 = T54[5'h1b:1'h0];
  assign T54 = T64 | T55;
  assign T55 = T56 & 32'hff00ff00;
  assign T56 = T57 << 4'h8;
  assign T57 = T58[5'h17:1'h0];
  assign T58 = T62 | T59;
  assign T59 = T60 & 32'hffff0000;
  assign T60 = T61 << 5'h10;
  assign T61 = shift_right[4'hf:1'h0];
  assign T62 = T143 & 32'hffff;
  assign T143 = {16'h0, T63};
  assign T63 = shift_right >> 5'h10;
  assign T64 = T144 & 32'hff00ff;
  assign T144 = {8'h0, T65};
  assign T65 = T58 >> 4'h8;
  assign T66 = T145 & 32'hf0f0f0f;
  assign T145 = {4'h0, T67};
  assign T67 = T54 >> 3'h4;
  assign T68 = T146 & 32'h33333333;
  assign T146 = {2'h0, T69};
  assign T69 = T50 >> 2'h2;
  assign T70 = T147 & 32'h55555555;
  assign T147 = {1'h0, T71};
  assign T71 = T46 >> 1'h1;
  assign T72 = opcode == 4'h6;
  assign shift_right = T127 ? T125 : T73;
  assign T73 = T124 ? T121 : T74;
  assign T74 = T120 ? T117 : T75;
  assign T75 = T116 ? T113 : T76;
  assign T76 = T112 ? T108 : shift_in;
  assign shift_in = T107 ? T77 : alu_a;
  assign T77 = T105 | T78;
  assign T78 = T79 & 32'haaaaaaaa;
  assign T79 = T80 << 1'h1;
  assign T80 = T81[5'h1e:1'h0];
  assign T81 = T103 | T82;
  assign T82 = T83 & 32'hcccccccc;
  assign T83 = T84 << 2'h2;
  assign T84 = T85[5'h1d:1'h0];
  assign T85 = T101 | T86;
  assign T86 = T87 & 32'hf0f0f0f0;
  assign T87 = T88 << 3'h4;
  assign T88 = T89[5'h1b:1'h0];
  assign T89 = T99 | T90;
  assign T90 = T91 & 32'hff00ff00;
  assign T91 = T92 << 4'h8;
  assign T92 = T93[5'h17:1'h0];
  assign T93 = T97 | T94;
  assign T94 = T95 & 32'hffff0000;
  assign T95 = T96 << 5'h10;
  assign T96 = alu_a[4'hf:1'h0];
  assign T97 = T148 & 32'hffff;
  assign T148 = {16'h0, T98};
  assign T98 = alu_a >> 5'h10;
  assign T99 = T149 & 32'hff00ff;
  assign T149 = {8'h0, T100};
  assign T100 = T93 >> 4'h8;
  assign T101 = T150 & 32'hf0f0f0f;
  assign T150 = {4'h0, T102};
  assign T102 = T89 >> 3'h4;
  assign T103 = T151 & 32'h33333333;
  assign T151 = {2'h0, T104};
  assign T104 = T85 >> 2'h2;
  assign T105 = T152 & 32'h55555555;
  assign T152 = {1'h0, T106};
  assign T106 = T81 >> 1'h1;
  assign T107 = opcode == 4'h6;
  assign T108 = {T110, T109};
  assign T109 = shift_in[5'h1f:5'h10];
  assign T110 = 16'h0 - T153;
  assign T153 = {15'h0, T111};
  assign T111 = opcode == 4'h7;
  assign T112 = alu_b[3'h4:3'h4];
  assign T113 = {T115, T114};
  assign T114 = T76[5'h1f:4'h8];
  assign T115 = 8'h0 - T154;
  assign T154 = {7'h0, T111};
  assign T116 = alu_b[2'h3:2'h3];
  assign T117 = {T119, T118};
  assign T118 = T75[5'h1f:3'h4];
  assign T119 = 4'h0 - T155;
  assign T155 = {3'h0, T111};
  assign T120 = alu_b[2'h2:2'h2];
  assign T121 = {T123, T122};
  assign T122 = T74[5'h1f:2'h2];
  assign T123 = 2'h0 - T156;
  assign T156 = {1'h0, T111};
  assign T124 = alu_b[1'h1:1'h1];
  assign T125 = {T111, T126};
  assign T126 = T73[5'h1f:1'h1];
  assign T127 = alu_b[1'h0:1'h0];
  assign T128 = T130 | T129;
  assign T129 = opcode == 4'h8;
  assign T130 = opcode == 4'h7;
  assign sum = alu_a + T131;
  assign T131 = T133 ? alu_b : T132;
  assign T132 = 32'h0 - alu_b;
  assign T133 = opcode == 4'h0;
  assign T134 = T136 | T135;
  assign T135 = opcode == 4'h9;
  assign T136 = opcode == 4'h0;
  always @(posedge clk or negedge reset) begin
    if(!reset) begin
      t1reg <= 32'h0;
    end else if(t1_en) begin
      t1reg <= io_t1data;
    end
  end
  always @(posedge clk or negedge reset) begin
    if(!reset) begin
      o1reg <= 32'h0;
    end else if(o1_en) begin
      o1reg <= io_o1data;
    end
  end
  always @(posedge clk or negedge reset) begin
    if(!reset) begin
      opc1reg <= 4'h0;
    end else if(t1_en) begin
      opc1reg <= io_t1opcode;
    end
  end
endmodule

