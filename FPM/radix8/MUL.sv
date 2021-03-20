module MUL(
  input [22:0]frc_X, frc_Y,
  output [47:0]frc_Z_full);
  
  //wire [28:0]pp[12:0];
  
  wire [26:0]pp[6:0];
  wire [25:0]pp7;
  wire [22:0]pp8;
  
  booth booth(.X(frc_X), .Y(frc_Y), .pp(pp), .pp7(pp7), .pp8(pp8));
  
  REDUCTION_TREE RED(.pp(pp),
                     .pp7(pp7),
                     .pp8(pp8),
                     
                     .Z(frc_Z_full));
  
  //assign frc_Z_full = {1'b1, frc_X} * {1'b1, frc_Y};
  
endmodule
