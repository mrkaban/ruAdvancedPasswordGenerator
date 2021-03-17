program apwgc;

{$mode objfpc}{$H+}

uses mainclass, parsecmdline;

begin
  randomize;
  parsecmdlineopts(ApwGen);
  writeln(GeneratePWD(ApwGen));
end.

