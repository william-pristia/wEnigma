unit uwEnigmaForm;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.StdCtrls,
  Vcl.Buttons,
  Vcl.ExtCtrls,
  uwEnigma;

type

  TEnigmaDemoForm = class(TForm)
    BitBtn1 : TBitBtn;
    Edit1 : TEdit;
    Edit2 : TEdit;
    BitBtn2 : TBitBtn;
    procedure BitBtn1Click(Sender : TObject);
    procedure FormCreate(Sender : TObject);
    procedure FormDestroy(Sender : TObject);
    procedure BitBtn2Click(Sender : TObject);
  private
    { Private declarations }
  public
    A : TEnigmaMachine;
  end;

var
  EnigmaDemoForm : TEnigmaDemoForm;

implementation

{$R *.dfm}

const
  // Identify Rotor# in 1941 Rotor Wiring Tables
  CEnigmaReflectorWiringRA = AnsiString('EJMZALYXVBWFCRQUONTSPIKHGD');
  CEnigmaReflectorWiringRB = AnsiString('YRUHQSLDPXNGOKMIEBFZCWVJAT');
  CEnigmaReflectorWiringRC = AnsiString('FVPJIAOYEDRZXWGCTKUQSBNMHL');
  CEnigmaReflectorWiringRBThin = AnsiString('ENKQAUYWJICOPBLMDXZVFTHRGS');

  CEnigmaRotorWiringRI = AnsiString('EKMFLGDQVZNTOWYHXUSPAIBRCJ');
  CEnigmaRotorWiringRII = AnsiString('AJDKSIRUXBLHWTMCQGZNPYFVOE');
  CEnigmaRotorWiringRIII = AnsiString('BDFHJLCPRTXVZNYEIWGAKMUSQO');
  CEnigmaRotorWiringRIV = AnsiString('ESOVPZJAYQUIRHXLNFTGKDCMWB');
  CEnigmaRotorWiringRV = AnsiString('VZBRGITYUPSDNHLXAWMJQOFECK');
  CEnigmaRotorWiringRVI = AnsiString('JPGVOUMFYQBENHZRDKASXLICTW');
  CEnigmaRotorWiringRVII = AnsiString('NZJHGRCXMYSWBOUFAIVLPEKQDT');
  CEnigmaRotorWiringRVIII = AnsiString('FKQHTLXOCBJSPDZRAMEWNIUYGV');

type
  TEnigmaMachineM3 = class(TEnigmaMachine)
  public
    constructor Create; override;
  end;

constructor TEnigmaMachineM3.Create;
begin
  inherited;
  Model := 'M3 Army';
  AddRotor(CEnigmaRotorWiringRI, 1, 1, 13, [17]);
  AddRotor(CEnigmaRotorWiringRII, 2, 2, 3, [5]);
  AddRotor(CEnigmaRotorWiringRIII, 3, 3, 0, [7,21]);
  Reflector.Configure(CEnigmaReflectorWiringRB);
  PlugBoard.Configure(CEnigmaRotorWiringFlat);
end;

procedure TEnigmaDemoForm.BitBtn1Click(Sender : TObject);
begin
  if Edit1.Text <> '' then
  begin
    Edit2.Text := '';
    for var I := 1 to Length(Edit1.Text) do
    begin
      if Trim(Edit1.Text[I]) <> '' then
      begin
        Edit2.Text := Edit2.Text + string(A.GetCiphedChar(AnsiChar(Edit1.Text[I])));
        if I mod 5 = 0 then
        begin
          Edit2.Text := Edit2.Text + ' ';
        end;
      end;
    end;
  end;
end;

procedure TEnigmaDemoForm.BitBtn2Click(Sender : TObject);
begin
  A.ConfigureSlot(1, 1, 0);
  A.ConfigureSlot(2, 2, 0);
  A.ConfigureSlot(3, 3, 0);
  A.ConfigurePlugBoard('XBCDEFIHGJKSMNOPQRLTUVWAYZ');
end;

procedure TEnigmaDemoForm.FormCreate(Sender : TObject);
begin
  A := TEnigmaMachineM3.Create;
  A.ConfigureSlot(1, 1, 0);
  A.ConfigureSlot(2, 2, 0);
  A.ConfigureSlot(3, 3, 0);
  A.ConfigurePlugBoard('XBCDEFIHGJKSMNOPQRLTUVWAYZ');
end;

procedure TEnigmaDemoForm.FormDestroy(Sender : TObject);
begin
  if A <> nil then
  begin
    A.Free;
  end;
end;

end.
