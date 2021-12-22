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
    btn_start : TBitBtn;
    edt_InText : TEdit;
    edt_OutText : TEdit;
    btn_reset : TBitBtn;
    pnl_Slot_3 : TPanel;
    pnl_Slot_2 : TPanel;
    pnl_slot_1 : TPanel;
    pnl_slot_1_in_in : TPanel;
    pnl_slot_1_in_out : TPanel;
    pnl_slot_2_in_in : TPanel;
    pnl_slot_2_in_out : TPanel;
    pnl_slot_3_in_out : TPanel;
    pnl_slot_3_in_in : TPanel;
    pnl_Reflector : TPanel;
    pnl_Reflector_in_in : TPanel;
    pnl_Reflector_in_out : TPanel;
    pnl_slot_3_out_in : TPanel;
    pnl_slot_3_out_out : TPanel;
    pnl_slot_2_out_in : TPanel;
    pnl_slot_2_out_out : TPanel;
    pnl_slot_1_out_in : TPanel;
    pnl_slot_1_out_out : TPanel;
    pnl_PlugBoard : TPanel;
    pnl_Pluboard_in_in : TPanel;
    pnl_Pluboard_in_out : TPanel;
    pnl_Pluboard_out_in : TPanel;
    pnl_Pluboard_out_out : TPanel;
    pnl_in_Char : TPanel;
    pnl_out_Char : TPanel;
    btn_Batch : TBitBtn;
    Label1 : TLabel;
    Label2 : TLabel;
    Label3 : TLabel;
    Label4 : TLabel;
    Label5 : TLabel;
    Label6 : TLabel;
    Label7 : TLabel;
    pnl_Info : TPanel;
    Shape1 : TShape;
    Shape2 : TShape;
    Shape3 : TShape;
    Shape4 : TShape;
    Shape5 : TShape;
    Shape6 : TShape;
    Shape7 : TShape;
    Shape8 : TShape;
    Shape9 : TShape;
    Shape10 : TShape;
    Shape11 : TShape;
    Shape12 : TShape;
    Shape13 : TShape;
    Shape14 : TShape;
    Shape15 : TShape;
    Shape16 : TShape;
    Shape17 : TShape;
    Shape18 : TShape;
    btn_Slot_3_up : TBitBtn;
    btn_Slot_3_down : TBitBtn;
    btn_Slot_2_down : TBitBtn;
    btn_Slot_2_up : TBitBtn;
    btn_Slot_1_down : TBitBtn;
    btn_Slot_1_up : TBitBtn;
    edt_PlugboardItem : TEdit;
    btn_PlubBoardAdd : TBitBtn;
    btn_PlubBoardReset : TBitBtn;
    Label8 : TLabel;
    procedure FormCreate(Sender : TObject);
    procedure FormDestroy(Sender : TObject);
    procedure btn_resetClick(Sender : TObject);
    procedure FormKeyDown(Sender : TObject; var Key : Word; Shift : TShiftState);
    procedure btn_startClick(Sender : TObject);
    procedure btn_BatchClick(Sender : TObject);
    procedure btn_Slot_3_upClick(Sender : TObject);
    procedure btn_Slot_2_upClick(Sender : TObject);
    procedure btn_Slot_1_upClick(Sender : TObject);
    procedure btn_Slot_1_downClick(Sender : TObject);
    procedure btn_Slot_2_downClick(Sender : TObject);
    procedure btn_Slot_3_downClick(Sender : TObject);
    procedure btn_PlubBoardResetClick(Sender : TObject);
    procedure btn_PlubBoardAddClick(Sender : TObject);
  private
    { Private declarations }
    fActive : Boolean;
    procedure OnPlugboardSwitch(Sender : TEnigmaCipher; const SignalDirection : TEnigmaSignalDirection; const aInChar, aOutChar : AnsiChar);
    procedure OnRotorSwitch(Sender : TEnigmaCipher; const SignalDirection : TEnigmaSignalDirection; const aInChar, aOutChar : AnsiChar);
    procedure OnReflectorSwitch(Sender : TEnigmaCipher; const SignalDirection : TEnigmaSignalDirection; const aInChar, aOutChar : AnsiChar);
    procedure OnChipedChar(Sender : TEnigmaMachine; const aInChar, aOutChar : AnsiChar);
    procedure ResetGUI;
    procedure ConfigureEnigma;
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

  CEnigmaRotorWiringRI = AnsiString('EKMFLGDQVZNTOWYHXUSPAIBRCJ'); // notch 17
  CEnigmaRotorWiringRII = AnsiString('AJDKSIRUXBLHWTMCQGZNPYFVOE'); // notch 5
  CEnigmaRotorWiringRIII = AnsiString('BDFHJLCPRTXVZNYEIWGAKMUSQO'); // notch 22
  CEnigmaRotorWiringRIV = AnsiString('ESOVPZJAYQUIRHXLNFTGKDCMWB'); // notch 10
  CEnigmaRotorWiringRV = AnsiString('VZBRGITYUPSDNHLXAWMJQOFECK'); // notch 26

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
  AddRotor(CEnigmaRotorWiringRI, 1, 1, 1, [17]);
  AddRotor(CEnigmaRotorWiringRII, 2, 2, 1, [5]);
  AddRotor(CEnigmaRotorWiringRIII, 3, 3, 1, [22]);
  RotorSet[0].Name:='M3 I';
  RotorSet[1].Name:='M3 II';
  RotorSet[2].Name:='M3 III';
  Reflector.Name:='UKW-B';
  Reflector.Configure(CEnigmaReflectorWiringRB);
  PlugBoard.Configure(CEnigmaRotorWiringFlat);
end;

procedure TEnigmaDemoForm.btn_startClick(Sender : TObject);
begin
  fActive := True;
  edt_InText.Enabled := False;
  pnl_Info.Caption := 'Typing enabled, press any ALPHA key to get chiped result';
end;

procedure TEnigmaDemoForm.ConfigureEnigma;
begin
  A.ConfigureSlot(1, 1, 1);
  A.ConfigureSlot(2, 2, 1);
  A.ConfigureSlot(3, 3, 1);
  // A.ConfigurePlugBoard('MBCDEIGHFJKLAVOSQRPUTNZXYW');
  ResetGUI;
end;

procedure TEnigmaDemoForm.btn_resetClick(Sender : TObject);
begin
  fActive := False;
  edt_InText.Enabled := True;
  pnl_Info.Caption := 'Typing disabled';
  edt_InText.Text := '';
  edt_OutText.Text := '';
  ConfigureEnigma;
end;

procedure TEnigmaDemoForm.btn_Slot_1_downClick(Sender : TObject);
begin
  A.RotorSet[0].DecRotorCurrentPosition;
  pnl_slot_1.Caption := string(AnsiChar(64 + A.RotorSet[0].RotorCurrentPosition));
end;

procedure TEnigmaDemoForm.btn_Slot_1_upClick(Sender : TObject);
begin
  A.RotorSet[0].IncRotorCurrentPosition;
  pnl_slot_1.Caption := string(AnsiChar(64 + A.RotorSet[0].RotorCurrentPosition));
end;

procedure TEnigmaDemoForm.btn_Slot_2_downClick(Sender : TObject);
begin
  A.RotorSet[1].DecRotorCurrentPosition;
  pnl_Slot_2.Caption := string(AnsiChar(64 + A.RotorSet[1].RotorCurrentPosition));
end;

procedure TEnigmaDemoForm.btn_Slot_2_upClick(Sender : TObject);
begin
  A.RotorSet[1].IncRotorCurrentPosition;
  pnl_Slot_2.Caption := string(AnsiChar(64 + A.RotorSet[1].RotorCurrentPosition));
end;

procedure TEnigmaDemoForm.btn_Slot_3_downClick(Sender : TObject);
begin
  A.RotorSet[2].DecRotorCurrentPosition;
  pnl_Slot_3.Caption := string(AnsiChar(64 + A.RotorSet[2].RotorCurrentPosition));
end;

procedure TEnigmaDemoForm.ResetGUI;
begin
  pnl_Pluboard_in_in.Caption := '';
  pnl_Pluboard_in_out.Caption := '';
  pnl_Pluboard_out_in.Caption := '';
  pnl_Pluboard_out_out.Caption := '';
  pnl_slot_1_in_in.Caption := '';
  pnl_slot_1_in_out.Caption := '';
  pnl_slot_2_in_in.Caption := '';
  pnl_slot_2_in_out.Caption := '';
  pnl_slot_3_in_in.Caption := '';
  pnl_slot_3_in_out.Caption := '';
  pnl_slot_1_out_in.Caption := '';
  pnl_slot_1_out_out.Caption := '';
  pnl_slot_2_out_in.Caption := '';
  pnl_slot_2_out_out.Caption := '';
  pnl_slot_3_out_in.Caption := '';
  pnl_slot_3_out_out.Caption := '';
  pnl_Reflector_in_in.Caption := '';
  pnl_Reflector_in_out.Caption := '';
  pnl_in_Char.Caption := '';
  pnl_out_Char.Caption := '';
  pnl_PlugBoard.Caption := string(A.PlugBoard.HumanizedCipherWiringCircuit);
  pnl_slot_1.Caption := string(AnsiChar(64 + A.RotorSet[0].RotorCurrentPosition));
  pnl_Slot_2.Caption := string(AnsiChar(64 + A.RotorSet[1].RotorCurrentPosition));
  pnl_Slot_3.Caption := string(AnsiChar(64 + A.RotorSet[2].RotorCurrentPosition));
  Label1.Caption:=A.RotorSet[0].Name;
  Label2.Caption:=A.RotorSet[1].Name;
  Label3.Caption:=A.RotorSet[2].Name;
  Label4.Caption:=A.Reflector.Name;
end;

procedure TEnigmaDemoForm.btn_Slot_3_upClick(Sender : TObject);
begin
  A.RotorSet[2].IncRotorCurrentPosition;
  pnl_Slot_3.Caption := string(AnsiChar(64 + A.RotorSet[2].RotorCurrentPosition));
end;

procedure TEnigmaDemoForm.btn_PlubBoardAddClick(Sender : TObject);
begin
  if Length(edt_PlugboardItem.Text) = 2 then
  begin
    A.PlugBoard.Plug(AnsiChar(edt_PlugboardItem.Text[1]), AnsiChar(edt_PlugboardItem.Text[2]));
    pnl_PlugBoard.Caption := string(A.PlugBoard.HumanizedCipherWiringCircuit);
  end;
end;

procedure TEnigmaDemoForm.btn_PlubBoardResetClick(Sender : TObject);
begin
  ConfigureEnigma;
  A.PlugBoard.Configure(CEnigmaRotorWiringFlat);
  ResetGUI;
end;

procedure TEnigmaDemoForm.btn_BatchClick(Sender : TObject);
var
  lInChar, lOutChar : AnsiChar;
begin
  if edt_InText.Text <> '' then
  begin
    edt_OutText.Text := '';
    for var I := 1 to Length(edt_InText.Text) do
    begin
      if Trim(edt_InText.Text[I]) <> '' then
      begin
        lInChar := AnsiChar(edt_InText.Text[I]);
        lOutChar := A.GetCiphedChar(lInChar);
        edt_OutText.Text := edt_OutText.Text + string(lOutChar);
      end;
    end;
  end;
end;

procedure TEnigmaDemoForm.FormCreate(Sender : TObject);
begin
  fActive := False;
  pnl_Info.Caption := 'Typing disabled';
  A := TEnigmaMachineM3.Create;
  A.RotorSet[0].OnSignalSwitch := OnRotorSwitch;
  A.RotorSet[1].OnSignalSwitch := OnRotorSwitch;
  A.RotorSet[2].OnSignalSwitch := OnRotorSwitch;
  A.Reflector.OnSignalSwitch := OnReflectorSwitch;
  A.PlugBoard.OnSignalSwitch := OnPlugboardSwitch;
  A.OnEnigmaMachineChipedChar := OnChipedChar;
  ConfigureEnigma;
end;

procedure TEnigmaDemoForm.FormDestroy(Sender : TObject);
begin
  if A <> nil then
  begin
    A.Free;
  end;
end;

procedure TEnigmaDemoForm.FormKeyDown(Sender : TObject; var Key : Word; Shift : TShiftState);
var
  lInChar : AnsiChar;
begin
  if fActive then
  begin
    if Key in [65 .. 90] then
    begin
      lInChar := UpCase(AnsiChar(Key));
      A.GetCiphedChar(lInChar);
    end;
  end;
end;

procedure TEnigmaDemoForm.OnChipedChar(Sender : TEnigmaMachine; const aInChar, aOutChar : AnsiChar);
begin
  if Sender is TEnigmaMachine then
  begin
    pnl_in_Char.Caption := string(aInChar);
    pnl_out_Char.Caption := string(aOutChar);
    if fActive then
    begin
      edt_InText.Text := edt_InText.Text + pnl_in_Char.Caption;
      edt_OutText.Text := edt_OutText.Text + pnl_out_Char.Caption;
    end;
  end;
end;

procedure TEnigmaDemoForm.OnPlugboardSwitch(Sender : TEnigmaCipher; const SignalDirection : TEnigmaSignalDirection; const aInChar, aOutChar : AnsiChar);
begin
  if Sender is TEnigmaPlugBoard then
  begin
    case SignalDirection of
      sdIn :
        begin
          pnl_Pluboard_in_in.Caption := string(aInChar);
          pnl_Pluboard_in_out.Caption := string(aOutChar);
        end;
      sdOut :
        begin
          pnl_Pluboard_out_in.Caption := string(aInChar);
          pnl_Pluboard_out_out.Caption := string(aOutChar);
        end;
    end;
  end;
end;

procedure TEnigmaDemoForm.OnReflectorSwitch(Sender : TEnigmaCipher; const SignalDirection : TEnigmaSignalDirection; const aInChar, aOutChar : AnsiChar);
begin
  if Sender is TEnigmaReflector then
  begin
    pnl_Reflector_in_in.Caption := string(aInChar);
    pnl_Reflector_in_out.Caption := string(aOutChar);
  end;
end;

procedure TEnigmaDemoForm.OnRotorSwitch(Sender : TEnigmaCipher; const SignalDirection : TEnigmaSignalDirection; const aInChar, aOutChar : AnsiChar);
begin
  if Sender is TEnigmaRotor then
  begin
    case SignalDirection of
      sdIn :
        begin
          case TEnigmaRotor(Sender).RotorSlot of
            1 :
              begin
                pnl_slot_1.Caption := string(AnsiChar(64 + TEnigmaRotor(Sender).RotorCurrentPosition));
                pnl_slot_1_in_in.Caption := string(aInChar);
                pnl_slot_1_in_out.Caption := string(aOutChar);
              end;
            2 :
              begin
                pnl_Slot_2.Caption := string(AnsiChar(64 + TEnigmaRotor(Sender).RotorCurrentPosition));
                pnl_slot_2_in_in.Caption := string(aInChar);
                pnl_slot_2_in_out.Caption := string(aOutChar);
              end;
            3 :
              begin
                pnl_Slot_3.Caption := string(AnsiChar(64 + TEnigmaRotor(Sender).RotorCurrentPosition));
                pnl_slot_3_in_in.Caption := string(aInChar);
                pnl_slot_3_in_out.Caption := string(aOutChar);
              end;
          end;
        end;
      sdOut :
        begin
          case TEnigmaRotor(Sender).RotorSlot of
            1 :
              begin
                pnl_slot_1.Caption := string(AnsiChar(64 + TEnigmaRotor(Sender).RotorCurrentPosition));
                pnl_slot_1_out_in.Caption := string(aInChar);
                pnl_slot_1_out_out.Caption := string(aOutChar);
              end;
            2 :
              begin
                pnl_Slot_2.Caption := string(AnsiChar(64 + TEnigmaRotor(Sender).RotorCurrentPosition));
                pnl_slot_2_out_in.Caption := string(aInChar);
                pnl_slot_2_out_out.Caption := string(aOutChar);
              end;
            3 :
              begin
                pnl_Slot_3.Caption := string(AnsiChar(64 + TEnigmaRotor(Sender).RotorCurrentPosition));
                pnl_slot_3_out_in.Caption := string(aInChar);
                pnl_slot_3_out_out.Caption := string(aOutChar);
              end;
          end;
        end;
    end;
  end;
end;

end.
