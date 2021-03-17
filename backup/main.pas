unit main;

{$mode objfpc}{$H+}

interface

uses
  Classes,
  SysUtils,
  LCLIntf,
  Forms,
  Controls,
  Graphics,
  Dialogs,
  StdCtrls,
  Clipbrd,
  unit1,
  ExtCtrls, Spin, Menus, Buttons;

CONST
  PWLOWERCASESTRINGS: String = 'abcdefghijklmnopqrstuvwxyz';
  PWUPPERCASESTRINGS: String = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
  PWNUMBERS: String = '0123456789';
  PWSPECIAL: String = '$@&#!+%';
  PROJECTURL = 'https://sourceforge.net/projects/apwg/';
  WIKIURL    = 'https://sourceforge.net/p/apwg/wiki/Home/';

type

  { TForm1 }

  TForm1 = class(TForm)
    Bevel1: TBevel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    CheckBox4: TCheckBox;
    CheckBox5: TCheckBox;
    CheckBox6: TCheckBox;
    CheckBox7: TCheckBox;
    Edit1: TEdit;
    Edit2: TEdit;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    Image1: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    MainMenu1: TMainMenu;
    MenuItem1: TMenuItem;
    mExit: TMenuItem;
    MenuItem4: TMenuItem;
    mAbout: TMenuItem;
    SpinEdit1: TSpinEdit;
    SpinEdit2: TSpinEdit;
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure CheckBox1Change(Sender: TObject);
    procedure Edit2Change(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Image2Click(Sender: TObject);
    procedure Label4Click(Sender: TObject);
    procedure mExitClick(Sender: TObject);
    procedure MenuItem3Click(Sender: TObject);
    procedure mAboutClick(Sender: TObject);
    procedure SpinEdit1Change(Sender: TObject);
    procedure SpinEdit2Change(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  Form1: TForm1;

implementation uses hasher, mainclass;

{$R *.lfm}

{ TForm1 }

procedure TForm1.Edit2Change(Sender: TObject);
begin

end;

procedure TForm1.FormShow(Sender: TObject);
begin
  spinedit2.MinValue:= spinedit1.Value;
  if checkbox1.checked then begin
    Label2.enabled := false;
    spinedit2.Enabled:= false;
    spinedit2.Value:= spinedit1.Value;
  end;
  if spinedit1.Value <= 7 then image1.Visible := true
   else image1.visible := false;

end;

procedure TForm1.Image2Click(Sender: TObject);
begin
  OpenURL(PROJECTURL);
end;

procedure TForm1.Label4Click(Sender: TObject);
begin
 OpenURL(PROJECTURL);
end;

procedure TForm1.CheckBox1Change(Sender: TObject);
begin
  if checkbox1.checked then begin
    Label2.enabled := false;
    spinedit2.Enabled:= false;
    spinedit2.Value:= spinedit1.Value;
  end else begin
    Label2.enabled := true;
    spinedit2.Enabled:= true;
  end;

end;

procedure TForm1.BitBtn1Click(Sender: TObject);
var
  chars:string;
begin

  chars :='';
  Mainclass.ApwGen.LowerCases:=false;
  Mainclass.ApwGen.UpperCases:=false;
  Mainclass.ApwGen.Numbers:=false;
  Mainclass.ApwGen.Specials:=false;
  Mainclass.ApwGen.CustomChars:='';

  mainclass.Apwgen.MinSize:=Spinedit1.value;
  mainclass.Apwgen.MaxSize:=Spinedit2.value;

  if checkbox2.Checked then
     Mainclass.ApwGen.LowerCases:=true;

  if checkbox3.Checked then
       Mainclass.ApwGen.UpperCases:=true;

  if checkbox4.Checked then
       Mainclass.ApwGen.Numbers:=true;

  if checkbox6.Checked then
       Mainclass.ApwGen.Specials:=true;

  if checkbox7.checked then
       Mainclass.ApwGen.CustomChars:=Edit2.Text;

  edit1.text := GeneratePWD(Apwgen);
end;

procedure TForm1.BitBtn1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin

end;

procedure TForm1.BitBtn2Click(Sender: TObject);
begin
  Clipboard.AsText := Edit1.text;
end;

procedure TForm1.BitBtn3Click(Sender: TObject);
begin
     if edit1.PasswordChar = #0 then
    edit1.PasswordChar:= chr(Ord('#'))
  else
    edit1.PasswordChar:= #0;
end;

procedure TForm1.BitBtn4Click(Sender: TObject);
begin
  if trim(edit1.text) <> '' then
  hasher.showhash(edit1.text);
end;

procedure TForm1.mExitClick(Sender: TObject);
begin
  Close;
end;

procedure TForm1.MenuItem3Click(Sender: TObject);
begin
  OpenURL(WIKIURL);
end;

procedure TForm1.mAboutClick(Sender: TObject);
begin
   Form3.ShowModal;
end;

procedure TForm1.SpinEdit1Change(Sender: TObject);
begin

   spinedit2.MinValue:= spinedit1.Value;
   if checkbox1.checked AND (spinedit2.value <> spinedit1.value) then begin
      spinedit2.Value:= spinedit1.Value;
   end;

   if spinedit1.Value > spinedit2.Value then
      spinedit2.Value:= spinedit1.Value;

   if spinedit1.Value <= 7 then image1.Visible := true
   else image1.visible := false;

end;

procedure TForm1.SpinEdit2Change(Sender: TObject);
begin

end;

end.

