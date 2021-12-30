unit uwEnigma;

interface

uses
  System.SysUtils,
  System.Generics.Collections,
  System.Classes;

const
  CEnigmaTotalKeys = 26;
  CEnigmaAlphaChars = AnsiString('ABCDEFGHIJKLMNOPQRSTUVWXYZ');

  CEnigmaIndexSet = [1 .. CEnigmaTotalKeys];
  CEnigmaAlphaCharSet = [Ord('A') .. Ord('Z')];

  CEnigmaKeyboard = CEnigmaAlphaChars;
  CHumanizedCipherWiringCircuit = CEnigmaTotalKeys * 3; // Token format 'A-L';

const
  CEnigmaMaxRotors = 5;
  CEnigmaRotorWiringFlat = CEnigmaKeyboard;

type
  TEnigmaAlphabet = 0 .. CEnigmaTotalKeys;
  TEnigmaRotorBox = 0 .. CEnigmaMaxRotors;

  TEnigmaSignalDirection = (sdIn, sdOut);

  TEnigmaRotorIDs = type TEnigmaRotorBox;
  TEnigmaRotorSlots = type TEnigmaRotorBox; // 0 Rotor slot unused

  TEnigmaRingOffset = type TEnigmaAlphabet; // 0 no offset
  TEnigmaRotorPosition = type TEnigmaAlphabet; // 0 Rotor not in start position
  TEnigmaRotorNotchPosition = type TEnigmaAlphabet; // 0 turnover disabled
  TEnigmaRotorNotchPositions = set of TEnigmaRotorNotchPosition;

  TEnigmaKeyBoard = string[CEnigmaTotalKeys];
  THumanizedCipherWiringCircuit = string[CHumanizedCipherWiringCircuit];

  TEnigmaInPhysicalKeyBoard = type TEnigmaKeyBoard;
  TEnigmaOutVirtualKeyBoard = type TEnigmaKeyBoard;

  // simulate interlnal wiring
  TEnigmaCipherWiringCircuit = record
  const
    LeftSide : TEnigmaInPhysicalKeyBoard = CEnigmaRotorWiringFlat;
  var
    RightSide : TEnigmaOutVirtualKeyBoard;
    class operator Initialize(out Dest : TEnigmaCipherWiringCircuit);
  end;

  TEnigmaCipher = class;
  TEnigmaMachine = class;

  TEnigmaSignalSwitchEvent = procedure(Sender : TEnigmaCipher; const SignalDirection : TEnigmaSignalDirection; const AInChar, AOutChar : AnsiChar) of object;

  TEnigmaComponent = class
  protected
    function IsAlpaChar(const AChar : AnsiChar) : Boolean; inline;
    function IsEnigmaIndex(const AIndex : Integer) : Boolean; inline;
    function AlphaCharToEnigmaIndex(const AChar : AnsiChar) : TEnigmaAlphabet; inline;
    function EnigmaIndexToAlphaChar(const AIndex : TEnigmaAlphabet) : AnsiChar; inline;
  end;

  // base enigma chiper class
  TEnigmaCipher = class(TEnigmaComponent)
  strict private
    FCipherWiringCircuit : TEnigmaCipherWiringCircuit;
    FSignalSwitchEventTrigger : Boolean;
    FOnSignalSwitch : TEnigmaSignalSwitchEvent;
    function GetHumanizedCipherWiringCircuit : THumanizedCipherWiringCircuit;
  protected
    procedure SetSingleConnection(const ALeft, ARight : AnsiChar); dynamic;
    procedure SetWiring(const ARightSideConfiguration : TEnigmaOutVirtualKeyBoard); dynamic;
    procedure DoSignalSwitch(const SignalDirection : TEnigmaSignalDirection; const AInChar, AOutChar : AnsiChar); virtual;
  public
    constructor Create(const ACipherRingWiring : TEnigmaOutVirtualKeyBoard); virtual;
    function SignalSwitch(const AChar : AnsiChar; const SignalDirection : TEnigmaSignalDirection = sdIn) : AnsiChar; dynamic;
    property SignalSwitchEventTrigger : Boolean read FSignalSwitchEventTrigger write FSignalSwitchEventTrigger;
    property CipherWiringCircuit : TEnigmaCipherWiringCircuit read FCipherWiringCircuit;
    property HumanizedCipherWiringCircuit : THumanizedCipherWiringCircuit read GetHumanizedCipherWiringCircuit;
    property OnSignalSwitch : TEnigmaSignalSwitchEvent read FOnSignalSwitch write FOnSignalSwitch;
  end;

  // internal rotor Ring
  TEnigmaCipherRing = class(TEnigmaCipher)
  strict private
    FName : string;
    FRingOffset : TEnigmaRingOffset;
  protected
    function FixWiringOffset(const AChar : AnsiChar; const SignalDirection : TEnigmaSignalDirection) : AnsiChar;
    property RingOffset : TEnigmaRingOffset read FRingOffset write FRingOffset;
    property Name : string read FName write FName;
  public
    constructor Create(const ACipherRingWiring : TEnigmaOutVirtualKeyBoard); override;
    function SignalSwitch(const AChar : AnsiChar; const SignalDirection : TEnigmaSignalDirection = sdIn) : AnsiChar; override;
  end;

  // rotor
  TEnigmaRotor = class(TEnigmaCipherRing)
  strict private
    FRotorID : TEnigmaRotorIDs;
    FRotorSlot : TEnigmaRotorSlots;
    FRotorNotchPositions : TEnigmaRotorNotchPositions;
    FRotorCurrentPosition : TEnigmaRotorPosition;
  protected
    function FixRotorOffset(const AChar : AnsiChar; const SignalDirection : TEnigmaSignalDirection) : AnsiChar;
  public
    constructor Create(const ACipherRingWiring : TEnigmaOutVirtualKeyBoard; const ARotorID : TEnigmaRotorIDs); reintroduce; virtual;
    procedure Configure(const ACipherRingWiring : TEnigmaOutVirtualKeyBoard); overload;
    procedure Configure(const ARotorSlot : TEnigmaRotorSlots; const ARotorNotchPositions : TEnigmaRotorNotchPositions); overload;
    procedure Configure(const ARotorSlot : TEnigmaRotorSlots); overload;
    function SignalSwitch(const AChar : AnsiChar; const SignalDirection : TEnigmaSignalDirection = sdIn) : AnsiChar; override;
    procedure IncRotorCurrentPosition;
    procedure DecRotorCurrentPosition;

    property RotorID : TEnigmaRotorIDs read FRotorID;
    property RotorNotchPositions : TEnigmaRotorNotchPositions read FRotorNotchPositions write FRotorNotchPositions;
    property RotorSlot : TEnigmaRotorSlots read FRotorSlot write FRotorSlot;
    property RotorCurrentPosition : TEnigmaRotorPosition read FRotorCurrentPosition write FRotorCurrentPosition;

    property Name;
    property RingOffset;
  end;

  // reflector
  TEnigmaReflector = class(TEnigmaCipherRing)
    procedure Configure(AReflectorWiring : TEnigmaOutVirtualKeyBoard);

    property Name;
    property RingOffset;
  end;

  // plugboard
  TEnigmaPlugBoard = class(TEnigmaCipher)
  public
    procedure Configure(APlugBoardWiring : TEnigmaOutVirtualKeyBoard);
    procedure Plug(const ALeft, ARight : AnsiChar);
  end;

  TEnigmaRotorSet = array [1 .. 5] of TEnigmaRotor;

  TEnigmaRotors = class(TList<TEnigmaRotor>)
  end;

  TEnigmaMachineChipedCharEvent = procedure(Sender : TEnigmaMachine; const AInChar, AOutChar : AnsiChar) of object;

  TEnigmaMachine = class
  strict private
    FPlugBoard : TEnigmaPlugBoard;
    FReflector : TEnigmaReflector;
    FRotorSet : TEnigmaRotors;
    FModel : string;
    FOnEnigmaMachineChipedChar : TEnigmaMachineChipedCharEvent;
    function GetRotor(ARotorIndex : Integer) : TEnigmaRotor;
  protected
    procedure DoEnigmaMachineChipedChar(const AInChar, AOutChar : AnsiChar); virtual;
    function RotorIndexFromRotorSlot(ASlot : TEnigmaRotorSlots; var ARotorIndex : Integer) : Boolean;
    function RotorIndexFromRotorID(ARotorID : TEnigmaRotorIDs; var ARotorIndex : Integer) : Boolean;
  public
    constructor Create; virtual;
    destructor Destroy; override;

    procedure IncRotorCurrentPosition(const ARotorSlot : TEnigmaRotorSlots);
    procedure DecRotorCurrentPosition(const ARotorSlot : TEnigmaRotorSlots);

    procedure AddRotor(const ACipherRingWiring : TEnigmaOutVirtualKeyBoard; const ASlot : TEnigmaRotorSlots; const ARotorID : TEnigmaRotorIDs; const ARingOffset : TEnigmaRingOffset; const ARotorNotchPositions : TEnigmaRotorNotchPositions; const ARotorCurrentPosition : TEnigmaRotorPosition); overload;
    procedure AddRotor(const ACipherRingWiring : TEnigmaOutVirtualKeyBoard; const ASlot : TEnigmaRotorSlots; const ARotorID : TEnigmaRotorIDs; const ARingOffset : TEnigmaRingOffset; const ARotorNotchPositions : TEnigmaRotorNotchPositions); overload;

    procedure ConfigureSlot(const ASlot : TEnigmaRotorSlots; const ARotorID : TEnigmaRotorIDs; const ARotorNotchPositions : TEnigmaRotorNotchPositions; const ARotorCurrentPosition : TEnigmaRotorPosition); overload;
    procedure ConfigureSlot(const ASlot : TEnigmaRotorSlots; const ARotorID : TEnigmaRotorIDs; const ARotorCurrentPosition : TEnigmaRotorPosition); overload;
    procedure ConfigureReflector(const AReflectorWiring : TEnigmaOutVirtualKeyBoard); overload;
    procedure ConfigurePlugBoard(APlugBoardWiring : TEnigmaOutVirtualKeyBoard);

    function GetCiphedChar(AChar : AnsiChar) : AnsiChar;
    function GetCiphedPhrase(AString : AnsiString) : AnsiString;

    property Model : string read FModel write FModel;
    property PlugBoard : TEnigmaPlugBoard read FPlugBoard write FPlugBoard;
    property Reflector : TEnigmaReflector read FReflector write FReflector;
    property RotorSet : TEnigmaRotors read FRotorSet write FRotorSet;
    property Rotor[ARotorIndex : Integer] : TEnigmaRotor read GetRotor;
    property OnEnigmaMachineChipedChar : TEnigmaMachineChipedCharEvent read FOnEnigmaMachineChipedChar write FOnEnigmaMachineChipedChar;
  end;

implementation

uses
  System.AnsiStrings;

const
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

function TEnigmaComponent.AlphaCharToEnigmaIndex(const AChar : AnsiChar) : TEnigmaAlphabet;
var
  LOrdChar : Integer;
begin
  Result := 0;
  LOrdChar := Ord(AChar);
  if LOrdChar in CEnigmaAlphaCharSet then
  begin
    Result := (LOrdChar - 64);
  end;
end;

function TEnigmaComponent.EnigmaIndexToAlphaChar(const AIndex : TEnigmaAlphabet) : AnsiChar;
begin
  Result := #0;
  if AIndex > 0 then
  begin
    Result := AnsiChar(64 + AIndex);
  end;
end;

function TEnigmaComponent.IsAlpaChar(const AChar : AnsiChar) : Boolean;
begin
  Result := (Ord(AChar) in CEnigmaAlphaCharSet);
end;

function TEnigmaComponent.IsEnigmaIndex(const AIndex : Integer) : Boolean;
begin
  Result := AIndex in CEnigmaIndexSet;
end;

class operator TEnigmaCipherWiringCircuit.Initialize(out Dest : TEnigmaCipherWiringCircuit);
begin
  Dest.RightSide := CEnigmaRotorWiringFlat;
end;

constructor TEnigmaCipher.Create(const ACipherRingWiring : TEnigmaOutVirtualKeyBoard);
begin
  FSignalSwitchEventTrigger := True;
  SetWiring(ACipherRingWiring);
end;

procedure TEnigmaCipher.DoSignalSwitch(const SignalDirection : TEnigmaSignalDirection; const AInChar, AOutChar : AnsiChar);
begin
  if FSignalSwitchEventTrigger then
  begin
    if Assigned(FOnSignalSwitch) then
    begin
      FOnSignalSwitch(Self, SignalDirection, AInChar, AOutChar);
    end;
  end;
end;

function TEnigmaCipher.GetHumanizedCipherWiringCircuit : THumanizedCipherWiringCircuit;
begin
  Result := '';
  for var I := 1 to High(TEnigmaKeyBoard) do
  begin
    if FCipherWiringCircuit.LeftSide[I] <> FCipherWiringCircuit.RightSide[I] then
    begin
      if Result = '' then
      begin
        Result := System.AnsiStrings.Format('%S-%S', [FCipherWiringCircuit.LeftSide[I], FCipherWiringCircuit.RightSide[I]]);
      end
      else
      begin
        Result := Result + System.AnsiStrings.Format(', %S-%S', [FCipherWiringCircuit.LeftSide[I], FCipherWiringCircuit.RightSide[I]]);
      end;
    end;
  end;
  if Result = '' then
  begin
    Result := 'FLAT';
  end;
end;

procedure TEnigmaCipher.SetSingleConnection(const ALeft, ARight : AnsiChar);
begin
  if IsAlpaChar(ALeft) then
  begin
    FCipherWiringCircuit.RightSide[AlphaCharToEnigmaIndex(ALeft)] := ARight;
  end;
end;

procedure TEnigmaCipher.SetWiring(const ARightSideConfiguration : TEnigmaOutVirtualKeyBoard);
begin
  if ARightSideConfiguration = '' then
  begin
    for var I := 1 to Length(CEnigmaRotorWiringFlat) do
    begin
      SetSingleConnection(CEnigmaRotorWiringFlat[I], CEnigmaRotorWiringFlat[I]);
    end;
  end
  else
  begin
    for var I := 1 to Length(ARightSideConfiguration) do
    begin
      SetSingleConnection(CEnigmaRotorWiringFlat[I], ARightSideConfiguration[I]);
    end;
  end;
end;

function TEnigmaCipher.SignalSwitch(const AChar : AnsiChar; const SignalDirection : TEnigmaSignalDirection) : AnsiChar;
var
  LCharIndex : Integer;
  LChar : AnsiChar;
  LFound : Boolean;
begin
  LChar := AChar;
  LCharIndex := AlphaCharToEnigmaIndex(LChar);
  if IsEnigmaIndex(LCharIndex) then
  begin
    case SignalDirection of
      sdIn :
        begin
          if FCipherWiringCircuit.LeftSide[LCharIndex] = LChar then
          begin
            LChar := FCipherWiringCircuit.RightSide[LCharIndex];
          end
          else
          begin
            Exception.Create('Invalid Char.');
          end;
        end;
      sdOut :
        begin
          LFound := False;
          for LCharIndex := 1 to CEnigmaTotalKeys do
          begin
            if FCipherWiringCircuit.RightSide[LCharIndex] = LChar then
            begin
              LChar := FCipherWiringCircuit.LeftSide[LCharIndex];
              LFound := True;
              Break;
            end
          end;
          if not LFound then
          begin
            Exception.Create('Invalid Char.');
          end;
        end;
    end;
  end;
  DoSignalSwitch(SignalDirection, AChar, LChar);
  Result := LChar;
end;

constructor TEnigmaCipherRing.Create(const ACipherRingWiring : TEnigmaOutVirtualKeyBoard);
begin
  inherited Create(ACipherRingWiring);
  FName := '';
  FRingOffset := 0;
end;

function TEnigmaCipherRing.FixWiringOffset(const AChar : AnsiChar; const SignalDirection : TEnigmaSignalDirection) : AnsiChar;
var
  LCharIndex : Integer;
  LChar : AnsiChar;
begin
  LChar := UpCase(AChar);
  LCharIndex := AlphaCharToEnigmaIndex(LChar);
  case SignalDirection of
    sdIn :
      begin
        if (FRingOffset <> 0) then
        begin
          LCharIndex := LCharIndex + (FRingOffset - 1);
          if LCharIndex > High(TEnigmaRingOffset) then
          begin
            LCharIndex := LCharIndex - High(TEnigmaRingOffset);
          end;
        end;
      end;
    sdOut :
      begin
        if (FRingOffset <> 0) then
        begin
          LCharIndex := LCharIndex - (FRingOffset - 1);
          if LCharIndex < 1 then
          begin
            LCharIndex := High(TEnigmaRingOffset) + LCharIndex;
          end;
        end;
      end;
  end;
  LChar := EnigmaIndexToAlphaChar(LCharIndex);
  Result := LChar;
end;

function TEnigmaCipherRing.SignalSwitch(const AChar : AnsiChar; const SignalDirection : TEnigmaSignalDirection) : AnsiChar;
var
  LChar : AnsiChar;
  LCanChangeSwitchTrigger : Boolean;
begin
  LCanChangeSwitchTrigger := False;
  if SignalSwitchEventTrigger then
  begin
    LCanChangeSwitchTrigger := True;
    SignalSwitchEventTrigger := False;
  end;
  LChar := FixWiringOffset(AChar, sdIn);
  LChar := inherited SignalSwitch(LChar, SignalDirection);
  LChar := FixWiringOffset(LChar, sdOut);
  if LCanChangeSwitchTrigger then
  begin
    SignalSwitchEventTrigger := True;
  end;
  DoSignalSwitch(SignalDirection, AChar, LChar);
  Result := LChar;
end;

procedure TEnigmaRotor.Configure(const ARotorSlot : TEnigmaRotorSlots; const ARotorNotchPositions : TEnigmaRotorNotchPositions);
begin
  FRotorSlot := ARotorSlot;
  FRotorNotchPositions := ARotorNotchPositions;
end;

procedure TEnigmaRotor.Configure(const ARotorSlot : TEnigmaRotorSlots);
begin
  FRotorSlot := ARotorSlot;
end;

procedure TEnigmaRotor.Configure(const ACipherRingWiring : TEnigmaOutVirtualKeyBoard);
begin
  SetWiring(ACipherRingWiring);
end;

constructor TEnigmaRotor.Create(const ACipherRingWiring : TEnigmaOutVirtualKeyBoard; const ARotorID : TEnigmaRotorIDs);
begin
  inherited Create(ACipherRingWiring);
  FRotorID := ARotorID;
  FRotorSlot := 0;
  FRotorNotchPositions := [];
  FRotorCurrentPosition := 0;
end;

procedure TEnigmaRotor.DecRotorCurrentPosition;
begin
  if FRotorCurrentPosition > 1 then
  begin
    FRotorCurrentPosition := FRotorCurrentPosition - 1;
  end
  else
  begin
    FRotorCurrentPosition := High(TEnigmaRotorPosition);
  end;
end;

function TEnigmaRotor.FixRotorOffset(const AChar : AnsiChar; const SignalDirection : TEnigmaSignalDirection) : AnsiChar;
var
  LCharIndex : Integer;
  LChar : AnsiChar;
begin
  LChar := UpCase(AChar);
  LCharIndex := AlphaCharToEnigmaIndex(LChar);
  case SignalDirection of
    sdIn :
      begin
        LCharIndex := LCharIndex + (FRotorCurrentPosition - 1);
        if LCharIndex > High(TEnigmaRotorPosition) then
        begin
          LCharIndex := LCharIndex - High(TEnigmaRotorPosition);
        end;
      end;
    sdOut :
      begin
        LCharIndex := LCharIndex - (FRotorCurrentPosition - 1);
        if LCharIndex < 1 then
        begin
          LCharIndex := High(TEnigmaRotorPosition) + LCharIndex;
        end;
      end;
  end;
  LChar := EnigmaIndexToAlphaChar(LCharIndex);
  Result := LChar;
end;

procedure TEnigmaRotor.IncRotorCurrentPosition;
begin
  if FRotorCurrentPosition < High(TEnigmaRotorPosition) then
  begin
    FRotorCurrentPosition := FRotorCurrentPosition + 1;
  end
  else
  begin
    FRotorCurrentPosition := 1;
  end;
end;

function TEnigmaRotor.SignalSwitch(const AChar : AnsiChar; const SignalDirection : TEnigmaSignalDirection) : AnsiChar;
var
  LChar : AnsiChar;
  LCanChangeSwitchTrigger : Boolean;
begin
  LCanChangeSwitchTrigger := False;
  if SignalSwitchEventTrigger then
  begin
    LCanChangeSwitchTrigger := True;
    SignalSwitchEventTrigger := False;
  end;
  LChar := UpCase(AChar);
  LChar := FixRotorOffset(LChar, sdIn);
  LChar := inherited SignalSwitch(LChar, SignalDirection);
  LChar := FixRotorOffset(LChar, sdOut);
  if LCanChangeSwitchTrigger then
  begin
    SignalSwitchEventTrigger := True;
  end;
  DoSignalSwitch(SignalDirection, AChar, LChar);
  Result := LChar;
end;

procedure TEnigmaReflector.Configure(AReflectorWiring : TEnigmaOutVirtualKeyBoard);
begin
  SetWiring(AReflectorWiring);
end;

procedure TEnigmaPlugBoard.Configure(APlugBoardWiring : TEnigmaOutVirtualKeyBoard);
begin
  SetWiring(APlugBoardWiring);
end;

procedure TEnigmaPlugBoard.Plug(const ALeft, ARight : AnsiChar);
begin
  SetSingleConnection(ALeft, ARight);
  SetSingleConnection(ARight, ALeft);
end;

procedure TEnigmaMachine.ConfigurePlugBoard(APlugBoardWiring : TEnigmaOutVirtualKeyBoard);
begin
  FPlugBoard.Configure(APlugBoardWiring);
end;

procedure TEnigmaMachine.ConfigureReflector(const AReflectorWiring : TEnigmaOutVirtualKeyBoard);
begin
  FReflector.Configure(AReflectorWiring);
end;

procedure TEnigmaMachine.ConfigureSlot(const ASlot : TEnigmaRotorSlots; const ARotorID : TEnigmaRotorIDs; const ARotorCurrentPosition : TEnigmaRotorPosition);
var
  LRotorIndex : Integer;
begin
  if RotorIndexFromRotorID(ARotorID, LRotorIndex) then
  begin
    FRotorSet[LRotorIndex].Configure(ASlot);
    FRotorSet[LRotorIndex].RotorCurrentPosition := ARotorCurrentPosition;
  end;
end;

procedure TEnigmaMachine.ConfigureSlot(const ASlot : TEnigmaRotorSlots; const ARotorID : TEnigmaRotorIDs; const ARotorNotchPositions : TEnigmaRotorNotchPositions; const ARotorCurrentPosition : TEnigmaRotorPosition);
var
  LRotorIndex : Integer;
begin
  if RotorIndexFromRotorID(ARotorID, LRotorIndex) then
  begin
    FRotorSet[LRotorIndex].Configure(ASlot, ARotorNotchPositions);
    FRotorSet[LRotorIndex].RotorCurrentPosition := ARotorCurrentPosition;
  end;
end;

constructor TEnigmaMachine.Create;
begin
  FModel := '';
  FReflector := TEnigmaReflector.Create(CEnigmaRotorWiringFlat);
  FRotorSet := TEnigmaRotors.Create;
  FPlugBoard := TEnigmaPlugBoard.Create(CEnigmaRotorWiringFlat);
end;

procedure TEnigmaMachine.DecRotorCurrentPosition(const ARotorSlot : TEnigmaRotorSlots);
var
  LRotorIndex : Integer;
  LRotor : TEnigmaRotor;
begin
  if RotorIndexFromRotorSlot(ARotorSlot, LRotorIndex) then
  begin
    LRotor := FRotorSet[LRotorIndex];
    LRotor.DecRotorCurrentPosition;
  end;
end;

destructor TEnigmaMachine.Destroy;
begin
  for var I : Integer := 0 to Pred(FRotorSet.Count) do
  begin
    FRotorSet[I].Free;
  end;
  FRotorSet.Free;
  FReflector.Free;
  FPlugBoard.Free;
  inherited;
end;

procedure TEnigmaMachine.DoEnigmaMachineChipedChar(const AInChar, AOutChar : AnsiChar);
begin
  if Assigned(FOnEnigmaMachineChipedChar) then
  begin
    FOnEnigmaMachineChipedChar(Self, AInChar, AOutChar);
  end;
end;

procedure TEnigmaMachine.AddRotor(const ACipherRingWiring : TEnigmaOutVirtualKeyBoard; const ASlot : TEnigmaRotorSlots; const ARotorID : TEnigmaRotorIDs; const ARingOffset : TEnigmaRingOffset; const ARotorNotchPositions : TEnigmaRotorNotchPositions);
begin
  AddRotor(ACipherRingWiring, ASlot, ARotorID, ARingOffset, ARotorNotchPositions, 0);
end;

procedure TEnigmaMachine.AddRotor(const ACipherRingWiring : TEnigmaOutVirtualKeyBoard; const ASlot : TEnigmaRotorSlots; const ARotorID : TEnigmaRotorIDs; const ARingOffset : TEnigmaRingOffset; const ARotorNotchPositions : TEnigmaRotorNotchPositions; const ARotorCurrentPosition : TEnigmaRotorPosition);
var
  LRotor : TEnigmaRotor;
begin
  LRotor := TEnigmaRotor.Create(ACipherRingWiring, ARotorID);
  LRotor.Configure(ASlot, ARotorNotchPositions);
  LRotor.RingOffset := ARingOffset;
  LRotor.RotorCurrentPosition := ARotorCurrentPosition;
  FRotorSet.Add(LRotor);
end;

procedure TEnigmaMachine.IncRotorCurrentPosition(const ARotorSlot : TEnigmaRotorSlots);
var
  LRotorIndex : Integer;
  LRotor : TEnigmaRotor;
begin
  if RotorIndexFromRotorSlot(ARotorSlot, LRotorIndex) then
  begin
    LRotor := FRotorSet[LRotorIndex];
    LRotor.IncRotorCurrentPosition;
    if (LRotor.RotorCurrentPosition in LRotor.RotorNotchPositions) or (LRotor.RotorNotchPositions = [0]) then
    begin
      if LRotor.RotorSlot < High(TEnigmaRotorSlots) then
      begin
        IncRotorCurrentPosition(ARotorSlot + 1);
      end;
    end;
  end;
end;

function TEnigmaMachine.GetCiphedChar(AChar : AnsiChar) : AnsiChar;
var
  LSlot : TEnigmaRotorSlots;
  LRotorIndex : Integer;
  C : AnsiChar;
begin
  IncRotorCurrentPosition(1);
  C := AChar;
  // Plugboard in switching
  C := FPlugBoard.SignalSwitch(C, sdIn);
  for LSlot := 1 to CEnigmaMaxRotors do
  begin
    // RightLeft Signal Direction
    if RotorIndexFromRotorSlot(LSlot, LRotorIndex) then
    begin
      C := FRotorSet[LRotorIndex].SignalSwitch(C, sdIn);
    end;
  end;
  // Reflector switching
  C := FReflector.SignalSwitch(C);
  for LSlot := CEnigmaMaxRotors downto 1 do
  begin
    // LeftToRight Signal Direction
    if RotorIndexFromRotorSlot(LSlot, LRotorIndex) then
    begin
      C := FRotorSet[LRotorIndex].SignalSwitch(C, sdOut);
    end;
  end;
  // Plugboard out switching
  C := FPlugBoard.SignalSwitch(C, sdOut);
  DoEnigmaMachineChipedChar(AChar, C);
  Result := C;
  // Rollup Rotors
end;

function TEnigmaMachine.GetCiphedPhrase(AString: AnsiString): AnsiString;
var
  LInChar, LOutChar: AnsiChar;
begin
  Result:='';
  if AString <> '' then
  begin
    for var I := 1 to Length(AString) do
    begin
      if Trim(AString[I]) <> '' then
      begin
        LInChar := AnsiChar(AString[I]);
        LOutChar := GetCiphedChar(LInChar);
        Result := Result + LOutChar;
      end;
    end;
  end;
end;

function TEnigmaMachine.GetRotor(ARotorIndex : Integer) : TEnigmaRotor;
begin
  Result := FRotorSet[ARotorIndex];
end;

function TEnigmaMachine.RotorIndexFromRotorID(ARotorID : TEnigmaRotorIDs; var ARotorIndex : Integer) : Boolean;
var
  LRotorIndex : Integer;
begin
  Result := False;
  ARotorIndex := -1;
  for LRotorIndex := 0 to Pred(FRotorSet.Count) do
  begin
    if FRotorSet[LRotorIndex] <> nil then
    begin
      if FRotorSet[LRotorIndex].RotorID = ARotorID then
      begin
        ARotorIndex := LRotorIndex;
        Result := True;
        Break;
      end;
    end;
  end;
end;

function TEnigmaMachine.RotorIndexFromRotorSlot(ASlot : TEnigmaRotorSlots; var ARotorIndex : Integer) : Boolean;
var
  LRotorIndex : Integer;
begin
  Result := False;
  ARotorIndex := -1;
  for LRotorIndex := 0 to Pred(FRotorSet.Count) do
  begin
    if FRotorSet[LRotorIndex] <> nil then
    begin
      if FRotorSet[LRotorIndex].RotorSlot = ASlot then
      begin
        ARotorIndex := LRotorIndex;
        Result := True;
        Break;
      end;
    end;
  end;
end;

end.
