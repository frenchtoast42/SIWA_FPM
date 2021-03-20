module REDUCTION_TREE(
  input [26:0]pp[6:0],
  input [25:0]pp7,
  input [22:0]pp8,
  
  output [47:0]Z);
  
  //REDUCTION 1 (only took 1 hour and 40 minutes!)
  
  wire [47:0]red1_0;
  wire [43:0]red1_1;
  wire [38:0]red1_2;
  wire [32:0]red1_3;
  wire [26:0]red1_4;
  wire [20:0]red1_5;
  wire [14:0]red1_6;
  wire [8:0]red1_7;
  wire [2:0]red1_8;
  
  REDUCTION1 REDUCTION1(.pp0(pp[0]), .pp1(pp[1]), .pp2(pp[2]), .pp3(pp[3]), .pp4(pp[4]), .pp5(pp[5]), .pp6(pp[6]), .pp7(pp7), .pp8(pp8),
                       
                       .red1_0(red1_0), .red1_1(red1_1), .red1_2(red1_2), .red1_3(red1_3),
                       .red1_4(red1_4), .red1_5(red1_5), .red1_6(red1_6), .red1_7(red1_7),
                       .red1_8(red1_8));
  
  //REDUCTION 2
  
  wire [46:0]red2_0;
  wire [44:0]red2_1;
  wire [38:0]red2_2;
  wire [32:0]red2_3;
  wire [27:0]red2_4;
  wire [23:0]red2_5;
  
  REDUCTION2 REDUCTION2(.red1_0(red1_0), .red1_1(red1_1), .red1_2(red1_2), .red1_3(red1_3),
                        .red1_4(red1_4), .red1_5(red1_5), .red1_6(red1_6), .red1_7(red1_7),
                        .red1_8(red1_8),
                      
                       .red2_0(red2_0), .red2_1(red2_1), .red2_2(red2_2),
                       .red2_3(red2_3), .red2_4(red2_4), .red2_5(red2_5));
  
  //REDUCTION 3
  
  wire [46:0]red3_0;
  wire [44:0]red3_1;
  wire [40:0]red3_2;
  wire [35:0]red3_3;
  
  REDUCTION3 REDUCTION3(.red2_0(red2_0), .red2_1(red2_1), .red2_2(red2_2),
                        .red2_3(red2_3), .red2_4(red2_4), .red2_5(red2_5),
                        
                        .red3_0(red3_0), .red3_1(red3_1), .red3_2(red3_2),
                        .red3_3(red3_3));
  
  //REDUCTION 4
  
  wire [47:0]red4_0;
  wire [44:0]red4_1;
  wire [41:0]red4_2;
  
  REDUCTION4 REDUCTION4(.red3_0(red3_0), .red3_1(red3_1), .red3_2(red3_2),
                        .red3_3(red3_3),
                        
                        .red4_0(red4_0), .red4_1(red4_1), .red4_2(red4_2));
  
  //REDUCTION 5
  
  wire [47:0]red5_0;
  wire [45:0]red5_1;
  
  REDUCTION5 REDUCTION5(.red4_0(red4_0), .red4_1(red4_1), .red4_2(red4_2),
                        
                        .red5_0(red5_0), .red5_1(red5_1));
  
  
  //FINAL CPA
  
  CPA CPA(.red5_0(red5_0), .red5_1(red5_1), .Z(Z));
  
endmodule
