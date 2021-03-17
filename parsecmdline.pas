unit parsecmdline;

{$mode objfpc}{$H+}

interface

uses
  SysUtils,mainclass;
CONST

  {$IFDEF UNIX}
    EXENAME = 'apwgc';
    CRLF  = #10;
  {$ELSE}
    EXENAME = 'apwgc';
    CRLF = #13#10;
  {$ENDIF}

RESOURCESTRING
  HELPSTRING =
             PROJECTNAME+CRLF+
             COPYRIGHT+CRLF+CRLF+
             '  For more information see: '+PROJECTURL+CRLF+CRLF+
             '  Usage: '+EXENAME+' [options]'+CRLF+CRLF+
             'Put + after a boolean switch option to enable it, - to disable it'+CRLF+
             '  -h     This help'+CRLF+
             '  -v     Print version'+CRLF+
             '  -m<n>  Minimum length of the generated password (default 8)'+CRLF+
             '  -x<n>  Maximum length of the generated password (optional)'+CRLF+
             '  -l     Enable/disable lowercase characters (default: enabled)'+CRLF+
             '  -u     Enable/diable upperchase characters (default: enabled)'+CRLF+
             '  -n     Enable/disable numbers (default: enabled)'+CRLF+
             '  -s     Enable/disable special characters (set: '+PWSPECIAL+' (default: disabled)'+CRLF+
             '  -c<x>  Add custom characters'+CRLF+
             '  -q     Enable/disable unique character check (default: enabled)';

procedure parsecmdlineopts(var ApwGen: TApwGen);

implementation

procedure parsecmdlineopts(var ApwGen: TApwGen);
var
  i,x:integer;
   p:string;
  switchPrefixes : TSysCharSet;
begin
   switchPrefixes :=['-'];

  if (FindCmdLineSwitch('l+') AND FindCmdLineSwitch('l-')) OR
     (FindCmdLineSwitch('u+') AND FindCmdLineSwitch('u-')) OR
     (FindCmdLineSwitch('n+') AND FindCmdLineSwitch('n-')) OR
     (FindCmdLineSwitch('s+') AND FindCmdLineSwitch('s-')) OR
     (FindCmdLineSwitch('q+') AND FindCmdLineSwitch('q-'))
  then begin
    WriteLn('Ambiguous switch usage');
    Halt;
  end;

  if FindCmdLineSwitch('h', switchPrefixes,false) then begin
    writeln(HELPSTRING);
    Halt;
  end;

  if FindCmdLineSwitch('v', switchPrefixes,false) then begin
    writeln(PROJECTNAME);
    Halt;
  end;

   if FindCmdLineSwitch('l+') then ApwGen.LowerCases := True;
   if FindCmdLineSwitch('l-') then ApwGen.LowerCases := False;
   if FindCmdLineSwitch('u+') then ApwGen.UpperCases := True;
   if FindCmdLineSwitch('u-') then ApwGen.UpperCases := False;
   if FindCmdLineSwitch('n+') then ApwGen.Numbers := True;
   if FindCmdLineSwitch('n-') then ApwGen.Numbers := False;
   if FindCmdLineSwitch('s+') then ApwGen.Specials := True;
   if FindCmdLineSwitch('s-') then ApwGen.Specials :=False;
   if FindCmdLineSwitch('q+') then ApwGen.AllUnique := True;
   if FindCmdLineSwitch('q-') then ApwGen.AllUnique := False;

   for i := 1 to ParamCount do begin
     if ParamStr(i)[1]='-' then begin

       //read parameter without or with space
       if ParamStr(i)[2] in ['m','x','c'] then begin

         if length(ParamStr(i)) > 2 then begin
          p := RightStr(ParamStr(i),length(ParamStr(i))-2);
          writeln('p:'+p);

         end
         else begin
           if Paramcount < i then begin
             Writeln('No parameters given');
             Halt;
           end;
           if Paramstr(i+1)[1] = '-' then begin
             Writeln('No parameters given');
             Halt;
           end;
           p:= ParamStr(i+1);
         end;

         if (ParamStr(i)[2] in ['m','x']) AND (not TryStrToInt(p,x)) then begin
           Writeln('Invalid parameter given');
           Halt;
         end;

       end;


       case ParamStr(i)[2] of
         'm': begin
                ApwGen.MinSize:=x;
                ApwGen.MaxSize:=x;
              end;
         'x': begin
                ApwGen.MaxSize:=x;
              end;
         'c': begin
                ApwGen.CustomChars:=p;
              end;
       end;


    end;
   end;
end;

end.

