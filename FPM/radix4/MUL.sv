module MUL(
  input [22:0]frc_X, frc_Y,
  output [47:0]frc_Z_full);
  
  //wire [28:0]pp[12:0];
  
  wire [25:0]pp[10:0];
  wire [24:0]pp11;
  wire [22:0]pp12;
  
  booth booth(.X(frc_X), .Y(frc_Y), .pp(pp), .pp11(pp11), .pp12(pp12));
  
  REDUCTION_TREE RED(.pp(pp),
                     .pp11(pp11),
                     .pp12(pp12),
                     
                     .Z(frc_Z_full));
  
  //assign frc_Z_full = {1'b1, frc_X} * {1'b1, frc_Y};
  
endmodule
