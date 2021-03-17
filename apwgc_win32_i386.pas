program apwgc;

{$mode objfpc}{$H+}

uses mainclass, parsecmdline;



var
   ApwGen: TApwGen =( Minsize:8;
                       MaxSize:8;
                       LowerCases:True;
                       UpperCases:True;
                       Numbers:True;
                       Specials:False;
                       AllUnique:True;
                       CustomChars:''
                       );


begin
  randomize;
  parsecmdlineopts(ApwGen);
  writeln(GeneratePWD(ApwGen));
end.

