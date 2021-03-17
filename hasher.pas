unit hasher;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  md5, sha1, DCPBase64
  {$IFNDEF WIN32},unixcrypt{$ENDIF};

type

  { TForm2 }

  TForm2 = class(TForm)
    Memo1: TMemo;
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  Form2: TForm2;
procedure showhash(s:string);
implementation

{$R *.lfm}
procedure showhash(s:string);
begin
form2.memo1.Clear;
form2.memo1.lines.add('B64 : '+Base64EncodeStr(s));
form2.Memo1.Lines.add('MD5 : '+md5.MD5Print(md5.MD5String(s)));
form2.Memo1.Lines.add('SHA1 : '+sha1.SHA1Print(sha1.SHA1String(s)));
{$IFNDEF WIN32}
form2.memo1.lines.add('*nixcrypt(MD5) : '+crypt_password(s,true));
{$ENDIF}
//form2.memo1.lines.add('*** Еще не все ***');
//form2.memo1.lines.add('*nixcrypt(DES) : Not implemented yed');
//form2.memo1.lines.add('*nixcrypt(SHA1) : Not implemented yed');
//form2.memo1.lines.add('*nixcrypt(SHA1) : Not implemented yed');
//form2.memo1.lines.add('*nixcrypt(SHA512) : Not implemented yed');
form2.ShowModal;
end;




end.

