module full(A, B, Cin, S, Cout);
  
  input A, B, Cin;
  output S;
  output Cout;
  
  wire y1, y2, y3;
  
  assign y1 = A ^ B;
  assign S = y1 ^ Cin;
  assign y2 = y1 & Cin;
  assign y3 = A & B;
  assign Cout = y2 | y3;
  
endmodule
