module REDUCTION_TREE(
  input [25:0]pp[10:0],
  input [24:0]pp11,
  input [22:0]pp12,
  
  output [47:0]Z);
  
  //REDUCTION 1
  
  wire [47:0]red1_0;
  wire [44:0]red1_1;
  wire [41:0]red1_2;
  wire [37:0]red1_3;
  wire [33:0]red1_4;
  wire [29:0]red1_5;
  wire [25:0]red1_6;
  wire [21:0]red1_7;
  wire [17:0]red1_8;
  wire [13:0]red1_9;
  wire [9:0]red1_10;
  wire [5:0]red1_11;
  wire [1:0]red1_12;
  
  REDUCTION1 REDUCTION1(.pp0(pp[0]), .pp1(pp[1]), .pp2(pp[2]), .pp3(pp[3]),
                        .pp4(pp[4]), .pp5(pp[5]), .pp6(pp[6]), .pp7(pp[7]),
                        .pp8(pp[8]), .pp9(pp[9]), .pp10(pp[10]), .pp11(pp11),
                        .pp12(pp12),
                       
                       .red1_0(red1_0), .red1_1(red1_1), .red1_2(red1_2), .red1_3(red1_3),
                       .red1_4(red1_4), .red1_5(red1_5), .red1_6(red1_6), .red1_7(red1_7),
                       .red1_8(red1_8), .red1_9(red1_9), .red1_10(red1_10), .red1_11(red1_11),
                       .red1_12(red1_12));
  
  //REDUCTION 2
  
  wire [46:0]red2_0;
  wire [45:0]red2_1;
  wire [41:0]red2_2;
  wire [37:0]red2_3;
  wire [33:0]red2_4;
  wire [29:0]red2_5;
  wire [25:0]red2_6;
  wire [22:0]red2_7;
  wire [19:0]red2_8;
  
  REDUCTION2 REDUCTION2(.red1_0(red1_0), .red1_1(red1_1), .red1_2(red1_2), .red1_3(red1_3),
                        .red1_4(red1_4), .red1_5(red1_5), .red1_6(red1_6), .red1_7(red1_7),
                        .red1_8(red1_8), .red1_9(red1_9), .red1_10(red1_10), .red1_11(red1_11),
                        .red1_12(red1_12),
                      
                       .red2_0(red2_0), .red2_1(red2_1), .red2_2(red2_2),
                       .red2_3(red2_3), .red2_4(red2_4), .red2_5(red2_5),
                       .red2_6(red2_6), .red2_7(red2_7), .red2_8(red2_8));
  
  //REDUCTION 3
  
  wire [46:0]red3_0;
  wire [45:0]red3_1;
  wire [41:0]red3_2;
  wire [37:0]red3_3;
  wire [34:0]red3_4;
  wire [31:0]red3_5;
  
  wire [2:0]g3;
  
  REDUCTION3 REDUCTION3(.red2_0(red2_0), .red2_1(red2_1), .red2_2(red2_2),
                        .red2_3(red2_3), .red2_4(red2_4), .red2_5(red2_5),
                        .red2_6(red2_6), .red2_7(red2_7), .red2_8(red2_8),
                        
                        .red3_0(red3_0), .red3_1(red3_1), .red3_2(red3_2),
                        .red3_3(red3_3), .red3_4(red3_4), .red3_5(red3_5), 
                       
                        .g3(g3));
  
  //REDUCTION 4
  
  wire [46:0]red4_0;
  wire [45:0]red4_1;
  wire [42:0]red4_2;
  wire [39:0]red4_3;
  
  wire g4;
  
  REDUCTION4 REDUCTION4(.red3_0(red3_0), .red3_1(red3_1), .red3_2(red3_2),
                        .red3_3(red3_3), .red3_4(red3_4), .red3_5(red3_5),
                        
                        .g3(g3),
                        
                        .red4_0(red4_0), .red4_1(red4_1), .red4_2(red4_2), .red4_3(red4_3),
                       
                        .g4(g4));
  
  //REDUCTION 5
  
  wire [47:0]red5_0;
  wire [45:0]red5_1;
  wire [43:0]red5_2;
  
  REDUCTION5 REDUCTION5(.red4_0(red4_0), .red4_1(red4_1), .red4_2(red4_2), .red4_3(red4_3),
                        
                        .g4(g4),
                        
                        .red5_0(red5_0), .red5_1(red5_1), .red5_2(red5_2));
  
  //REDUCTION 6
  
  wire [47:0]red6_0;
  wire [46:0]red6_1;
  
  REDUCTION6 REDUCTION6(.red5_0(red5_0), .red5_1(red5_1), .red5_2(red5_2),
                        
                        .red6_0(red6_0), .red6_1(red6_1));
  
  //FINAL CPA
  
  CPA CPA(.red6_0(red6_0), .red6_1(red6_1), .Z(Z));
  
  
endmodule
