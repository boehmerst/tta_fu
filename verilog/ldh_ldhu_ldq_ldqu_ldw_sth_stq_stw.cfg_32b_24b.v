module ldh_ldhu_ldq_ldqu_ldw_sth_stq_stw_32b_24b(input clk, input reset,
    input [23:0] io_t1data,
    input  io_t1load,
    input [2:0] io_t1opcode,
    input [31:0] io_o1data,
    input  io_o1load,
    output[31:0] io_r1data,
    input [31:0] data_in,
    output[31:0] data_out,
    output[21:0] addr,
    output mem_en_x,
    output wr_en_x,
    output[31:0] wr_mask_x,
    input  io_glock
);

  wire[31:0] T0;
  wire[7:0] T1;
  wire[7:0] T159;
  wire T2;
  wire T3;
  reg [3:0] wr_mask_reg;
  wire[3:0] T160;
  wire[3:0] T4;
  wire[3:0] T5;
  wire[3:0] T6;
  wire[3:0] T161;
  wire T7;
  wire T8;
  wire T9;
  wire T10;
  wire T11;
  wire T12;
  wire T13;
  wire[3:0] T14;
  wire[3:0] T15;
  wire[3:0] T16;
  wire[3:0] T17;
  wire[1:0] T18;
  wire T19;
  wire[3:0] T20;
  wire T21;
  wire transfer_en;
  wire glock_n;
  wire[23:0] T22;
  wire[7:0] T23;
  wire[7:0] T162;
  wire T24;
  wire T25;
  wire[15:0] T26;
  wire[7:0] T27;
  wire[7:0] T163;
  wire T28;
  wire T29;
  wire[7:0] T30;
  wire[7:0] T164;
  wire T31;
  wire T32;
  wire T33;
  reg  wr_en_reg;
  wire T165;
  wire T34;
  wire T35;
  wire T36;
  wire T37;
  wire T38;
  wire T39;
  wire T40;
  wire T41;
  wire T42;
  wire T43;
  reg  mem_en_reg;
  wire T166;
  wire T44;
  reg [21:0] addr_reg;
  wire[21:0] T167;
  wire[21:0] T45;
  wire[21:0] T46;
  reg [31:0] data_out_reg;
  wire[31:0] T168;
  wire[31:0] T47;
  wire[31:0] T48;
  wire[31:0] T49;
  wire[31:0] T50;
  wire[31:0] T51;
  reg [31:0] o1shadow_reg;
  wire[31:0] T169;
  wire[31:0] T52;
  wire T53;
  wire[31:0] T54;
  wire[15:0] T55;
  wire[7:0] T56;
  wire T57;
  wire[31:0] T58;
  wire[15:0] T59;
  wire T60;
  reg [31:0] rdata_reg;
  wire[31:0] T170;
  wire[31:0] T61;
  wire[31:0] T62;
  wire[31:0] T63;
  wire[31:0] T64;
  wire[31:0] T65;
  wire[31:0] T66;
  wire[31:0] T67;
  wire[31:0] T68;
  wire[31:0] T69;
  wire[31:0] T70;
  wire[31:0] T71;
  wire[31:0] T72;
  wire[31:0] T73;
  wire[31:0] T74;
  wire[31:0] T75;
  wire[7:0] T76;
  wire T77;
  wire T78;
  reg [1:0] transfer_tag_pip_1_alignment;
  wire[1:0] T79;
  wire[1:0] T171;
  wire[1:0] T80;
  wire[1:0] transfer_tag_in_1_alignment;
  reg [1:0] transfer_tag_pip_0_alignment;
  wire[1:0] T81;
  wire[1:0] T172;
  wire[1:0] T82;
  wire[1:0] transfer_tag_in_0_alignment;
  wire[1:0] T83;
  wire[1:0] T84;
  wire T85;
  reg [2:0] transfer_tag_pip_1_opcode;
  wire[2:0] T86;
  wire[2:0] T173;
  wire[2:0] T87;
  wire[2:0] transfer_tag_in_1_opcode;
  reg [2:0] transfer_tag_pip_0_opcode;
  wire[2:0] T88;
  wire[2:0] T174;
  wire[2:0] T89;
  wire[2:0] transfer_tag_in_0_opcode;
  wire[2:0] T90;
  wire[31:0] T91;
  wire[7:0] T92;
  wire T93;
  wire T94;
  wire[31:0] T95;
  wire[7:0] T96;
  wire T97;
  wire T98;
  wire[31:0] T99;
  wire[7:0] T100;
  wire T101;
  wire T102;
  wire[31:0] T103;
  wire[7:0] T104;
  wire[23:0] T105;
  wire[23:0] T175;
  wire T106;
  wire T107;
  wire T108;
  wire T109;
  wire[31:0] T110;
  wire[7:0] T111;
  wire[23:0] T112;
  wire[23:0] T176;
  wire T113;
  wire T114;
  wire T115;
  wire[31:0] T116;
  wire[7:0] T117;
  wire[23:0] T118;
  wire[23:0] T177;
  wire T119;
  wire T120;
  wire T121;
  wire[31:0] T122;
  wire[7:0] T123;
  wire[23:0] T124;
  wire[23:0] T178;
  wire T125;
  wire T126;
  wire T127;
  wire[31:0] T128;
  wire[15:0] T129;
  wire T130;
  wire T131;
  wire T132;
  wire[31:0] T133;
  wire[15:0] T134;
  wire T135;
  wire T136;
  wire[31:0] T137;
  wire[15:0] T138;
  wire[15:0] T139;
  wire[15:0] T179;
  wire T140;
  wire T141;
  wire T142;
  wire T143;
  wire[31:0] T144;
  wire[15:0] T145;
  wire[15:0] T146;
  wire[15:0] T180;
  wire T147;
  wire T148;
  wire T149;
  wire rdata_en;
  wire T150;
  wire T151;
  wire T152;
  wire T153;
  wire T154;
  wire T155;
  wire T156;
  wire T157;
  wire T158;

`ifndef SYNTHESIS
// synthesis translate_off
  integer initvar;
  initial begin
    #0.002;
    wr_mask_reg = {1{$random}};
    wr_en_reg = {1{$random}};
    mem_en_reg = {1{$random}};
    addr_reg = {1{$random}};
    data_out_reg = {1{$random}};
    o1shadow_reg = {1{$random}};
    rdata_reg = {1{$random}};
    transfer_tag_pip_1_alignment = {1{$random}};
    transfer_tag_pip_0_alignment = {1{$random}};
    transfer_tag_pip_1_opcode = {1{$random}};
    transfer_tag_pip_0_opcode = {1{$random}};
  end
// synthesis translate_on
`endif

  assign wr_mask_x = T0;
  assign T0 = {T22, T1};
  assign T1 = 8'h0 - T159;
  assign T159 = {7'h0, T2};
  assign T2 = ~ T3;
  assign T3 = wr_mask_reg[1'h0:1'h0];
  assign T160 = reset ? 4'h0 : T4;
  assign T4 = transfer_en ? T5 : wr_mask_reg;
  assign T5 = T14 & T6;
  assign T6 = 4'h0 - T161;
  assign T161 = {3'h0, T7};
  assign T7 = T9 | T8;
  assign T8 = io_t1opcode == 3'h7;
  assign T9 = T11 | T10;
  assign T10 = io_t1opcode == 3'h2;
  assign T11 = T13 | T12;
  assign T12 = io_t1opcode == 3'h6;
  assign T13 = io_t1opcode == 3'h5;
  assign T14 = T15;
  assign T15 = T21 ? T20 : T16;
  assign T16 = T19 ? T17 : 4'hf;
  assign T17 = 4'h8 >> T18;
  assign T18 = io_t1data[1'h1:1'h0];
  assign T19 = 3'h6 == io_t1opcode;
  assign T20 = 4'hc >> T18;
  assign T21 = 3'h5 == io_t1opcode;
  assign transfer_en = glock_n & io_t1load;
  assign glock_n = io_glock ^ 1'h1;
  assign T22 = {T26, T23};
  assign T23 = 8'h0 - T162;
  assign T162 = {7'h0, T24};
  assign T24 = ~ T25;
  assign T25 = wr_mask_reg[2'h3:2'h3];
  assign T26 = {T30, T27};
  assign T27 = 8'h0 - T163;
  assign T163 = {7'h0, T28};
  assign T28 = ~ T29;
  assign T29 = wr_mask_reg[2'h2:2'h2];
  assign T30 = 8'h0 - T164;
  assign T164 = {7'h0, T31};
  assign T31 = ~ T32;
  assign T32 = wr_mask_reg[2'h3:2'h3];
  assign wr_en_x = T33;
  assign T33 = wr_en_reg == 1'h0;
  assign T165 = reset ? 1'h0 : T34;
  assign T34 = transfer_en ? T35 : wr_en_reg;
  assign T35 = T37 | T36;
  assign T36 = io_t1opcode == 3'h7;
  assign T37 = T39 | T38;
  assign T38 = io_t1opcode == 3'h2;
  assign T39 = T41 | T40;
  assign T40 = io_t1opcode == 3'h6;
  assign T41 = io_t1opcode == 3'h5;
  assign mem_en_x = T42;
  assign T42 = T43 | io_glock;
  assign T43 = mem_en_reg == 1'h0;
  assign T166 = reset ? 1'h0 : T44;
  assign T44 = glock_n ? io_t1load : mem_en_reg;
  assign addr = addr_reg;
  assign T167 = reset ? 22'h0 : T45;
  assign T45 = transfer_en ? T46 : addr_reg;
  assign T46 = io_t1data[5'h17:2'h2];
  assign data_out = data_out_reg;
  assign T168 = reset ? 32'h0 : T47;
  assign T47 = transfer_en ? T48 : data_out_reg;
  assign T48 = T49;
  assign T49 = T60 ? T58 : T50;
  assign T50 = T57 ? T54 : T51;
  assign T51 = io_o1load ? io_o1data : o1shadow_reg;
  assign T169 = reset ? 32'h0 : T52;
  assign T52 = T53 ? io_o1data : o1shadow_reg;
  assign T53 = glock_n & io_o1load;
  assign T54 = {T55, T55};
  assign T55 = {T56, T56};
  assign T56 = T51[3'h7:1'h0];
  assign T57 = 3'h6 == io_t1opcode;
  assign T58 = {T59, T59};
  assign T59 = T51[4'hf:1'h0];
  assign T60 = 3'h5 == io_t1opcode;
  assign io_r1data = rdata_reg;
  assign T170 = reset ? 32'h0 : T61;
  assign T61 = rdata_en ? T62 : rdata_reg;
  assign T62 = T63;
  assign T63 = T148 ? T144 : T64;
  assign T64 = T141 ? T137 : T65;
  assign T65 = T135 ? T133 : T66;
  assign T66 = T130 ? T128 : T67;
  assign T67 = T126 ? T122 : T68;
  assign T68 = T120 ? T116 : T69;
  assign T69 = T114 ? T110 : T70;
  assign T70 = T107 ? T103 : T71;
  assign T71 = T101 ? T99 : T72;
  assign T72 = T97 ? T95 : T73;
  assign T73 = T93 ? T91 : T74;
  assign T74 = T77 ? T75 : data_in;
  assign T75 = {24'h0, T76};
  assign T76 = data_in[5'h1f:5'h18];
  assign T77 = T85 & T78;
  assign T78 = 2'h0 == transfer_tag_pip_1_alignment;
  assign T79 = 2'h0;
  assign T171 = reset ? T79 : T80;
  assign T80 = glock_n ? transfer_tag_in_1_alignment : transfer_tag_pip_1_alignment;
  assign transfer_tag_in_1_alignment = transfer_tag_pip_0_alignment;
  assign T81 = 2'h0;
  assign T172 = reset ? T81 : T82;
  assign T82 = transfer_en ? transfer_tag_in_0_alignment : transfer_tag_pip_0_alignment;
  assign transfer_tag_in_0_alignment = T83;
  assign T83 = T84;
  assign T84 = io_t1data[1'h1:1'h0];
  assign T85 = 3'h3 == transfer_tag_pip_1_opcode;
  assign T86 = 3'h7;
  assign T173 = reset ? T86 : T87;
  assign T87 = glock_n ? transfer_tag_in_1_opcode : transfer_tag_pip_1_opcode;
  assign transfer_tag_in_1_opcode = transfer_tag_pip_0_opcode;
  assign T88 = 3'h7;
  assign T174 = reset ? T88 : T89;
  assign T89 = transfer_en ? transfer_tag_in_0_opcode : transfer_tag_pip_0_opcode;
  assign transfer_tag_in_0_opcode = T90;
  assign T90 = io_t1opcode;
  assign T91 = {24'h0, T92};
  assign T92 = data_in[5'h17:5'h10];
  assign T93 = T85 & T94;
  assign T94 = 2'h1 == transfer_tag_pip_1_alignment;
  assign T95 = {24'h0, T96};
  assign T96 = data_in[4'hf:4'h8];
  assign T97 = T85 & T98;
  assign T98 = 2'h2 == transfer_tag_pip_1_alignment;
  assign T99 = {24'h0, T100};
  assign T100 = data_in[3'h7:1'h0];
  assign T101 = T85 & T102;
  assign T102 = 2'h3 == transfer_tag_pip_1_alignment;
  assign T103 = {T105, T104};
  assign T104 = data_in[5'h1f:5'h18];
  assign T105 = 24'h0 - T175;
  assign T175 = {23'h0, T106};
  assign T106 = data_in[5'h1f:5'h1f];
  assign T107 = T109 & T108;
  assign T108 = 2'h0 == transfer_tag_pip_1_alignment;
  assign T109 = 3'h2 == transfer_tag_pip_1_opcode;
  assign T110 = {T112, T111};
  assign T111 = data_in[5'h17:5'h10];
  assign T112 = 24'h0 - T176;
  assign T176 = {23'h0, T113};
  assign T113 = data_in[5'h17:5'h17];
  assign T114 = T109 & T115;
  assign T115 = 2'h1 == transfer_tag_pip_1_alignment;
  assign T116 = {T118, T117};
  assign T117 = data_in[4'hf:4'h8];
  assign T118 = 24'h0 - T177;
  assign T177 = {23'h0, T119};
  assign T119 = data_in[4'hf:4'hf];
  assign T120 = T109 & T121;
  assign T121 = 2'h2 == transfer_tag_pip_1_alignment;
  assign T122 = {T124, T123};
  assign T123 = data_in[3'h7:1'h0];
  assign T124 = 24'h0 - T178;
  assign T178 = {23'h0, T125};
  assign T125 = data_in[3'h7:3'h7];
  assign T126 = T109 & T127;
  assign T127 = 2'h3 == transfer_tag_pip_1_alignment;
  assign T128 = {16'h0, T129};
  assign T129 = data_in[5'h1f:5'h10];
  assign T130 = T132 & T131;
  assign T131 = 2'h0 == transfer_tag_pip_1_alignment;
  assign T132 = 3'h1 == transfer_tag_pip_1_opcode;
  assign T133 = {16'h0, T134};
  assign T134 = data_in[4'hf:1'h0];
  assign T135 = T132 & T136;
  assign T136 = 2'h2 == transfer_tag_pip_1_alignment;
  assign T137 = {T139, T138};
  assign T138 = data_in[5'h1f:5'h10];
  assign T139 = 16'h0 - T179;
  assign T179 = {15'h0, T140};
  assign T140 = data_in[5'h1f:5'h1f];
  assign T141 = T143 & T142;
  assign T142 = 2'h0 == transfer_tag_pip_1_alignment;
  assign T143 = 3'h0 == transfer_tag_pip_1_opcode;
  assign T144 = {T146, T145};
  assign T145 = data_in[4'hf:1'h0];
  assign T146 = 16'h0 - T180;
  assign T180 = {15'h0, T147};
  assign T147 = data_in[4'hf:4'hf];
  assign T148 = T143 & T149;
  assign T149 = 2'h2 == transfer_tag_pip_1_alignment;
  assign rdata_en = glock_n & T150;
  assign T150 = T152 | T151;
  assign T151 = transfer_tag_pip_1_opcode == 3'h4;
  assign T152 = T154 | T153;
  assign T153 = transfer_tag_pip_1_opcode == 3'h3;
  assign T154 = T156 | T155;
  assign T155 = transfer_tag_pip_1_opcode == 3'h2;
  assign T156 = T158 | T157;
  assign T157 = transfer_tag_pip_1_opcode == 3'h1;
  assign T158 = transfer_tag_pip_1_opcode == 3'h0;
  always @(posedge clk or negedge reset) begin
    if(!reset) begin
      wr_mask_reg <= 4'h0;
    end else if(transfer_en) begin
      wr_mask_reg <= T5;
    end
  end
  always @(posedge clk or negedge reset) begin
    if(!reset) begin
      wr_en_reg <= 1'h0;
    end else if(transfer_en) begin
      wr_en_reg <= T35;
    end
  end
  always @(posedge clk or negedge reset) begin
    if(!reset) begin
      mem_en_reg <= 1'h0;
    end else if(glock_n) begin
      mem_en_reg <= io_t1load;
    end
  end
  always @(posedge clk or negedge reset) begin
    if(!reset) begin
      addr_reg <= 22'h0;
    end else if(transfer_en) begin
      addr_reg <= T46;
    end
  end
  always @(posedge clk or negedge reset) begin
    if(!reset) begin
      data_out_reg <= 32'h0;
    end else if(transfer_en) begin
      data_out_reg <= T48;
    end
  end
  always @(posedge clk or negedge reset) begin
    if(!reset) begin
      o1shadow_reg <= 32'h0;
    end else if(T53) begin
      o1shadow_reg <= io_o1data;
    end
  end
  always @(posedge clk or negedge reset) begin
    if(!reset) begin
      rdata_reg <= 32'h0;
    end else if(rdata_en) begin
      rdata_reg <= T62;
    end
  end
  always @(posedge clk or negedge reset) begin
    if(!reset) begin
      transfer_tag_pip_1_alignment <= T79;
    end else if(glock_n) begin
      transfer_tag_pip_1_alignment <= transfer_tag_in_1_alignment;
    end
  end
  always @(posedge clk or negedge reset) begin
    if(!reset) begin
      transfer_tag_pip_0_alignment <= T81;
    end else if(transfer_en) begin
      transfer_tag_pip_0_alignment <= transfer_tag_in_0_alignment;
    end
  end
  always @(posedge clk or negedge reset) begin
    if(!reset) begin
      transfer_tag_pip_1_opcode <= T86;
    end else if(glock_n) begin
      transfer_tag_pip_1_opcode <= transfer_tag_in_1_opcode;
    end
  end
  always @(posedge clk or negedge reset) begin
    if(!reset) begin
      transfer_tag_pip_0_opcode <= T88;
    end else if(transfer_en) begin
      transfer_tag_pip_0_opcode <= transfer_tag_in_0_opcode;
    end
  end
endmodule

