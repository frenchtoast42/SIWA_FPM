module encoder(x, sel);
  
  input [3:0]x;
  output [3:0]sel; //4Y, 2Y, 3Y, Y
  
  wire neta, netb, netc;
  
  assign neta = x[0] ^ x[1];
  assign netb = x[1] ^ x[2];
  assign netc = x[2] ^ x[3];
  
  assign sel[0] = ~(!neta | netc);
  assign sel[1] = ~(!neta | !netc);
  assign sel[2] = ~(neta | !netb);
  assign sel[3] = ~(neta | netb | !netc);
  
endmodule
