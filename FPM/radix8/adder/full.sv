module full(A, B, C, S, Cout);
  
  input A, B, C;
  output S;
  output Cout;
  
  wire y1, y2, y3;
  
  assign y1 = A ^ B;
  assign S = y1 ^ C;
  assign y2 = y1 & C;
  assign y3 = A & B;
  assign Cout = y2 | y3;
  
endmodule
