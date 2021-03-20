module encoder(x, sel);
  
  input [2:0]x;
  output [2:0]sel; //single, double, neg
  
  assign sel[2] = x[0] ^ x[1];
  assign sel[1] = (x[0] & x[1] & !x[2]) | (!x[0] & !x[1] & x[2]);
  assign sel[0] = x[2];
  
endmodule
