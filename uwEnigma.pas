unit uwEnigma;

interface

uses
  System.SysUtils,
  System.Generics.Collections,
  System.Classes;

const
  CEnigmaChars = 26;
  CEnigmaKeyboard = AnsiString('ABCDEFGHIJKLMNOPQRSTUVWXYZ');
  CEnigmaRotorWiringFlat = CEnigmaKeyboard;
  CHumanizedCipherWiringCircuit = CEnigmaChars * 3;

const
  CEnigmaMaxRotors = 5;

type
  TEnigmaSignalDirection = (sdIn, sdOut);

  TEnigmaRotorIDs = 0 .. CEnigmaMaxRotors;
  TEnigmaRotorSlots = 0 .. CEnigmaMaxRotors; // 0 Rotor slot unused

  TEnigmaRingOffset = 0 .. CEnigmaChars; // 0 no offset
  TEnigmaRotorPosition = 0 .. CEnigmaChars; // 0 Rotor not in start position
  TEnigmaRotorNotchPosition = 0 .. CEnigmaChars; // 0 turnover disabled
  TEnigmaRotorNotchPositions = set of TEnigmaRotorNotchPosition;

  TEnigmaKeyBoard = string[CEnigmaChars];
  THumanizedCipherWiringCircuit = string[CHumanizedCipherWiringCircuit];

  TEnigmaInPhysicalKeyBoard = TEnigmaKeyBoard;
  TEnigmaOutVirtualKeyBoard = TEnigmaKeyBoard;

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

  TEnigmaSignalSwitchEvent = procedure(Sender : TEnigmaCipher; const SignalDirection : TEnigmaSignalDirection; const aInChar, aOutChar : AnsiChar) of object;

  TEnigmaComponent = class
  end;

  // base enigma chiper class
  TEnigmaCipher = class(TEnigmaComponent)
  strict private
    fCipherWiringCircuit : TEnigmaCipherWiringCircuit;
    fSignalSwitchEventTrigger : Boolean;
    fOnSignalSwitch : TEnigmaSignalSwitchEvent;
    function GetHumanizedCipherWiringCircuit : THumanizedCipherWiringCircuit;
  protected
    procedure SetSingleConnection(const aLeft, aRight : AnsiChar); dynamic;
    procedure SetWiring(const aRightSideConfiguration : TEnigmaOutVirtualKeyBoard); dynamic;
    procedure DoSignalSwitch(const SignalDirection : TEnigmaSignalDirection; const aInChar, aOutChar : AnsiChar); virtual;
  public
    constructor Create(const aCipherRingWiring : TEnigmaOutVirtualKeyBoard); virtual;
    function SignalSwitch(const aChar : AnsiChar; const SignalDirection : TEnigmaSignalDirection = sdIn) : AnsiChar; dynamic;
    property SignalSwitchEventTrigger : Boolean read fSignalSwitchEventTrigger write fSignalSwitchEventTrigger;
    property CipherWiringCircuit : TEnigmaCipherWiringCircuit read fCipherWiringCircuit;
    property HumanizedCipherWiringCircuit : THumanizedCipherWiringCircuit read GetHumanizedCipherWiringCircuit;
    property OnSignalSwitch : TEnigmaSignalSwitchEvent read fOnSignalSwitch write fOnSignalSwitch;
  end;

  // internal rotor Ring
  TEnigmaCipherRing = class(TEnigmaCipher)
  strict private
    fName : String;
    fRingOffset : TEnigmaRingOffset;
  protected
    function FixWiringOffset(const aChar : AnsiChar; const SignalDirection : TEnigmaSignalDirection) : AnsiChar;
    property RingOffset : TEnigmaRingOffset read fRingOffset write fRingOffset;
    property Name : String read fName write fName;
  public
    constructor Create(const aCipherRingWiring : TEnigmaOutVirtualKeyBoard); override;
    function SignalSwitch(const aChar : AnsiChar; const SignalDirection : TEnigmaSignalDirection = sdIn) : AnsiChar; override;
  end;

  // rotor
  TEnigmaRotor = class(TEnigmaCipherRing)
  strict private
    fRotorID : TEnigmaRotorIDs;
    fRotorSlot : TEnigmaRotorSlots;
    fRotorNotchPositions : TEnigmaRotorNotchPositions;
    fRotorCurrentPosition : TEnigmaRotorPosition;
  protected
    function FixRotorOffset(const aChar : AnsiChar; const SignalDirection : TEnigmaSignalDirection) : AnsiChar;
  public
    constructor Create(const aCipherRingWiring : TEnigmaOutVirtualKeyBoard; const aRotorID : TEnigmaRotorIDs); reintroduce; virtual;
    procedure Configure(const aCipherRingWiring : TEnigmaOutVirtualKeyBoard); overload;
    procedure Configure(const aRotorSlot : TEnigmaRotorSlots; const aRotorNotchPositions : TEnigmaRotorNotchPositions); overload;
    procedure Configure(const aRotorSlot : TEnigmaRotorSlots); overload;
    function SignalSwitch(const aChar : AnsiChar; const SignalDirection : TEnigmaSignalDirection = sdIn) : AnsiChar; override;
    procedure IncRotorCurrentPosition;
    procedure DecRotorCurrentPosition;

    property RotorID : TEnigmaRotorIDs read fRotorID;
    property RotorNotchPositions : TEnigmaRotorNotchPositions read fRotorNotchPositions write fRotorNotchPositions;
    property RotorSlot : TEnigmaRotorSlots read fRotorSlot write fRotorSlot;
    property RotorCurrentPosition : TEnigmaRotorPosition read fRotorCurrentPosition write fRotorCurrentPosition;

    property Name;
    property RingOffset;
  end;

  // reflector
  TEnigmaReflector = class(TEnigmaCipherRing)
    procedure Configure(aReflectorWiring : TEnigmaOutVirtualKeyBoard);

    property Name;
    property RingOffset;
  end;

  // plugboard
  TEnigmaPlugBoard = class(TEnigmaCipher)
  public
    procedure Configure(aPlugBoardWiring : TEnigmaOutVirtualKeyBoard);
    procedure Plug(const aLeft, aRight : AnsiChar);
  end;

  TEnigmaRotorSet = array [1 .. 5] of TEnigmaRotor;

  TEnigmaRotors = class(TList<TEnigmaRotor>)
  end;

  TEnigmaMachineChipedCharEvent = procedure(Sender : TEnigmaMachine; const aInChar, aOutChar : AnsiChar) of object;

  TEnigmaMachine = class
  strict private
    fPlugBoard : TEnigmaPlugBoard;
    fReflector : TEnigmaReflector;
    fRotorSet : TEnigmaRotors;
    fModel : string;
    fOnEnigmaMachineChipedChar : TEnigmaMachineChipedCharEvent;
    function GetRotor(aRotorIndex : Integer) : TEnigmaRotor;
    procedure SetRotor(aRotorIndex : Integer; const Value : TEnigmaRotor);
  protected
    procedure DoEnigmaMachineChipedChar(const aInChar, aOutChar : AnsiChar); virtual;
  public
    constructor Create; virtual;
    destructor Destroy; override;

    function RotorIndexFromRotorSlot(aSlot : TEnigmaRotorSlots; var aRotorIndex : Integer) : Boolean;
    function RotorIndexFromRotorID(aRotorID : TEnigmaRotorIDs; var aRotorIndex : Integer) : Boolean;
    procedure IncRotorCurrentPosition(const aRotorSlot : TEnigmaRotorSlots);
    procedure DecRotorCurrentPosition(const aRotorSlot : TEnigmaRotorSlots);

    procedure AddRotor(const aCipherRingWiring : TEnigmaOutVirtualKeyBoard; const aSlot : TEnigmaRotorSlots; const aRotorID : TEnigmaRotorIDs; const aRingOffset : TEnigmaRingOffset; const aRotorNotchPositions : TEnigmaRotorNotchPositions; const aRotorCurrentPosition : TEnigmaRotorPosition); overload;
    procedure AddRotor(const aCipherRingWiring : TEnigmaOutVirtualKeyBoard; const aSlot : TEnigmaRotorSlots; const aRotorID : TEnigmaRotorIDs; const aRingOffset : TEnigmaRingOffset; const aRotorNotchPositions : TEnigmaRotorNotchPositions); overload;

    procedure ConfigureSlot(const aSlot : TEnigmaRotorSlots; const aRotorID : TEnigmaRotorIDs; const aRotorNotchPositions : TEnigmaRotorNotchPositions; const aRotorCurrentPosition : TEnigmaRotorPosition); overload;
    procedure ConfigureSlot(const aSlot : TEnigmaRotorSlots; const aRotorID : TEnigmaRotorIDs; const aRotorCurrentPosition : TEnigmaRotorPosition); overload;
    procedure ConfigureReflector(const aReflectorWiring : TEnigmaOutVirtualKeyBoard); overload;
    procedure ConfigurePlugBoard(aPlugBoardWiring : TEnigmaOutVirtualKeyBoard);

    function GetCiphedChar(aChar : AnsiChar) : AnsiChar;

    property Model : string read fModel write fModel;
    property PlugBoard : TEnigmaPlugBoard read fPlugBoard write fPlugBoard;
    property Reflector : TEnigmaReflector read fReflector write fReflector;
    property RotorSet : TEnigmaRotors read fRotorSet write fRotorSet;
    property Rotor[aRotorIndex : Integer] : TEnigmaRotor read GetRotor write SetRotor;
    property OnEnigmaMachineChipedChar : TEnigmaMachineChipedCharEvent read fOnEnigmaMachineChipedChar write fOnEnigmaMachineChipedChar;
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

class operator TEnigmaCipherWiringCircuit.Initialize(out Dest : TEnigmaCipherWiringCircuit);
begin
  Dest.RightSide := CEnigmaRotorWiringFlat;
end;

constructor TEnigmaCipher.Create(const aCipherRingWiring : TEnigmaOutVirtualKeyBoard);
begin
  fSignalSwitchEventTrigger := True;
  SetWiring(aCipherRingWiring);
end;

procedure TEnigmaCipher.DoSignalSwitch(const SignalDirection : TEnigmaSignalDirection; const aInChar, aOutChar : AnsiChar);
begin
  if fSignalSwitchEventTrigger then
  begin
    if Assigned(fOnSignalSwitch) then
    begin
      fOnSignalSwitch(Self, SignalDirection, aInChar, aOutChar);
    end;
  end;
end;

function TEnigmaCipher.GetHumanizedCipherWiringCircuit : THumanizedCipherWiringCircuit;
begin
  Result := '';
  for var I := 1 to high(TEnigmaKeyBoard) do
  begin
    if fCipherWiringCircuit.LeftSide[I] <> fCipherWiringCircuit.RightSide[I] then
    begin
      if Result = '' then
      begin
        Result := System.AnsiStrings.Format('%S-%S', [fCipherWiringCircuit.LeftSide[I], fCipherWiringCircuit.RightSide[I]]);
      end
      else
      begin
        Result := Result + System.AnsiStrings.Format(', %S-%S', [fCipherWiringCircuit.LeftSide[I], fCipherWiringCircuit.RightSide[I]]);
      end;
    end;
  end;
  if Result = '' then
  begin
    Result := 'FLAT';
  end;
end;

procedure TEnigmaCipher.SetSingleConnection(const aLeft, aRight : AnsiChar);
begin
  if Ord(aLeft) in [65 .. 90] then
  begin
    fCipherWiringCircuit.RightSide[Ord(aLeft) - 64] := aRight;
  end;
end;

procedure TEnigmaCipher.SetWiring(const aRightSideConfiguration : TEnigmaOutVirtualKeyBoard);
begin
  if aRightSideConfiguration = '' then
  begin
    for var I := 1 to Length(CEnigmaRotorWiringFlat) do
    begin
      SetSingleConnection(CEnigmaRotorWiringFlat[I], CEnigmaRotorWiringFlat[I]);
    end;
  end
  else
  begin
    for var I := 1 to Length(aRightSideConfiguration) do
    begin
      SetSingleConnection(CEnigmaRotorWiringFlat[I], aRightSideConfiguration[I]);
    end;
  end;
end;

function TEnigmaCipher.SignalSwitch(const aChar : AnsiChar; const SignalDirection : TEnigmaSignalDirection) : AnsiChar;
var
  lCharIndex : Integer;
  lChar : AnsiChar;
  lFound : Boolean;
begin
  lChar := aChar;
  lCharIndex := (Ord(lChar) - 64);
  if lCharIndex in [1 .. CEnigmaChars] then
  begin
    case SignalDirection of
      sdIn :
        begin
          if fCipherWiringCircuit.LeftSide[lCharIndex] = lChar then
          begin
            lChar := fCipherWiringCircuit.RightSide[lCharIndex];
          end
          else
          begin
            Exception.Create('Invalid Char.');
          end;
        end;
      sdOut :
        begin
          lFound := False;
          for lCharIndex := 1 to CEnigmaChars do
          begin
            if fCipherWiringCircuit.RightSide[lCharIndex] = lChar then
            begin
              lChar := fCipherWiringCircuit.LeftSide[lCharIndex];
              lFound := True;
              Break;
            end
          end;
          if not lFound then
          begin
            Exception.Create('Invalid Char.');
          end;
        end;
    end;
  end;
  DoSignalSwitch(SignalDirection, aChar, lChar);
  Result := lChar;
end;

constructor TEnigmaCipherRing.Create(const aCipherRingWiring : TEnigmaOutVirtualKeyBoard);
begin
  inherited Create(aCipherRingWiring);
  fName := '';
  fRingOffset := 0;
end;

function TEnigmaCipherRing.FixWiringOffset(const aChar : AnsiChar; const SignalDirection : TEnigmaSignalDirection) : AnsiChar;
var
  lCharIndex : Integer;
  lChar : AnsiChar;
begin
  lChar := UpCase(aChar);
  lCharIndex := (Ord(lChar) - 64);
  case SignalDirection of
    sdIn :
      begin
        if (fRingOffset <> 0) then
        begin
          lCharIndex := lCharIndex + (fRingOffset - 1);
          if lCharIndex > high(TEnigmaRingOffset) then
          begin
            lCharIndex := lCharIndex - high(TEnigmaRingOffset);
          end;
        end;
      end;
    sdOut :
      begin
        if (fRingOffset <> 0) then
        begin
          lCharIndex := lCharIndex - (fRingOffset - 1);
          if lCharIndex < 1 then
          begin
            lCharIndex := high(TEnigmaRingOffset) + lCharIndex;
          end;
        end;
      end;
  end;
  lChar := AnsiChar(64 + lCharIndex);
  Result := lChar;
end;

function TEnigmaCipherRing.SignalSwitch(const aChar : AnsiChar; const SignalDirection : TEnigmaSignalDirection) : AnsiChar;
var
  lChar : AnsiChar;
  lCanChangeSwitchTrigger : Boolean;
begin
  lCanChangeSwitchTrigger := False;
  if SignalSwitchEventTrigger then
  begin
    lCanChangeSwitchTrigger := True;
    SignalSwitchEventTrigger := False;
  end;
  lChar := FixWiringOffset(aChar, sdIn);
  lChar := inherited SignalSwitch(lChar, SignalDirection);
  lChar := FixWiringOffset(lChar, sdOut);
  if lCanChangeSwitchTrigger then
  begin
    SignalSwitchEventTrigger := True;
  end;
  DoSignalSwitch(SignalDirection, aChar, lChar);
  Result := lChar;
end;

procedure TEnigmaRotor.Configure(const aRotorSlot : TEnigmaRotorSlots; const aRotorNotchPositions : TEnigmaRotorNotchPositions);
begin
  fRotorSlot := aRotorSlot;
  fRotorNotchPositions := aRotorNotchPositions;
end;

procedure TEnigmaRotor.Configure(const aRotorSlot : TEnigmaRotorSlots);
begin
  fRotorSlot := aRotorSlot;
end;

procedure TEnigmaRotor.Configure(const aCipherRingWiring: TEnigmaOutVirtualKeyBoard);
begin
  SetWiring(aCipherRingWiring);
end;

constructor TEnigmaRotor.Create(const aCipherRingWiring : TEnigmaOutVirtualKeyBoard; const aRotorID : TEnigmaRotorIDs);
begin
  inherited Create(aCipherRingWiring);
  fRotorID := aRotorID;
  fRotorSlot := 0;
  fRotorNotchPositions := [];
  fRotorCurrentPosition := 0;
end;

procedure TEnigmaRotor.DecRotorCurrentPosition;
begin
  if fRotorCurrentPosition > 1 then
  begin
    fRotorCurrentPosition := fRotorCurrentPosition - 1;
  end
  else
  begin
    fRotorCurrentPosition := high(TEnigmaRotorPosition);
  end;
end;

function TEnigmaRotor.FixRotorOffset(const aChar : AnsiChar; const SignalDirection : TEnigmaSignalDirection) : AnsiChar;
var
  lCharIndex : Integer;
  lChar : AnsiChar;
begin
  lChar := UpCase(aChar);
  lCharIndex := (Ord(lChar) - 64);
  case SignalDirection of
    sdIn :
      begin
        lCharIndex := lCharIndex + (fRotorCurrentPosition - 1);
        if lCharIndex > high(TEnigmaRotorPosition) then
        begin
          lCharIndex := lCharIndex - high(TEnigmaRotorPosition);
        end;
      end;
    sdOut :
      begin
        lCharIndex := lCharIndex - (fRotorCurrentPosition - 1);
        if lCharIndex < 1 then
        begin
          lCharIndex := high(TEnigmaRotorPosition) + lCharIndex;
        end;
      end;
  end;
  lChar := AnsiChar(64 + (lCharIndex));
  Result := lChar;
end;

procedure TEnigmaRotor.IncRotorCurrentPosition;
begin
  if fRotorCurrentPosition < high(TEnigmaRotorPosition) then
  begin
    fRotorCurrentPosition := fRotorCurrentPosition + 1;
  end
  else
  begin
    fRotorCurrentPosition := 1;
  end;
end;

function TEnigmaRotor.SignalSwitch(const aChar : AnsiChar; const SignalDirection : TEnigmaSignalDirection) : AnsiChar;
var
  lChar : AnsiChar;
  lCanChangeSwitchTrigger : Boolean;
begin
  lCanChangeSwitchTrigger := False;
  if SignalSwitchEventTrigger then
  begin
    lCanChangeSwitchTrigger := True;
    SignalSwitchEventTrigger := False;
  end;
  lChar := UpCase(aChar);
  lChar := FixRotorOffset(lChar, sdIn);
  lChar := inherited SignalSwitch(lChar, SignalDirection);
  lChar := FixRotorOffset(lChar, sdOut);
  if lCanChangeSwitchTrigger then
  begin
    SignalSwitchEventTrigger := True;
  end;
  DoSignalSwitch(SignalDirection, aChar, lChar);
  Result := lChar;
end;

procedure TEnigmaReflector.Configure(aReflectorWiring : TEnigmaOutVirtualKeyBoard);
begin
  SetWiring(aReflectorWiring);
end;

procedure TEnigmaPlugBoard.Configure(aPlugBoardWiring : TEnigmaOutVirtualKeyBoard);
begin
  SetWiring(aPlugBoardWiring);
end;

procedure TEnigmaPlugBoard.Plug(const aLeft, aRight : AnsiChar);
begin
  SetSingleConnection(aLeft, aRight);
  SetSingleConnection(aRight, aLeft);
end;

procedure TEnigmaMachine.ConfigurePlugBoard(aPlugBoardWiring : TEnigmaOutVirtualKeyBoard);
begin
  fPlugBoard.Configure(aPlugBoardWiring);
end;

procedure TEnigmaMachine.ConfigureReflector(const aReflectorWiring : TEnigmaOutVirtualKeyBoard);
begin
  fReflector.Configure(aReflectorWiring);
end;

procedure TEnigmaMachine.ConfigureSlot(const aSlot : TEnigmaRotorSlots; const aRotorID : TEnigmaRotorIDs; const aRotorCurrentPosition : TEnigmaRotorPosition);
var
  lRotorIndex : Integer;
begin
  if RotorIndexFromRotorID(aRotorID, lRotorIndex) then
  begin
    fRotorSet[lRotorIndex].Configure(aSlot);
    fRotorSet[lRotorIndex].RotorCurrentPosition := aRotorCurrentPosition;
  end;
end;

procedure TEnigmaMachine.ConfigureSlot(const aSlot : TEnigmaRotorSlots; const aRotorID : TEnigmaRotorIDs; const aRotorNotchPositions : TEnigmaRotorNotchPositions; const aRotorCurrentPosition : TEnigmaRotorPosition);
var
  lRotorIndex : Integer;
begin
  if RotorIndexFromRotorID(aRotorID, lRotorIndex) then
  begin
    fRotorSet[lRotorIndex].Configure(aSlot, aRotorNotchPositions);
    fRotorSet[lRotorIndex].RotorCurrentPosition := aRotorCurrentPosition;
  end;
end;

constructor TEnigmaMachine.Create;
begin
  fModel := '';
  fReflector := TEnigmaReflector.Create(CEnigmaRotorWiringFlat);
  fRotorSet := TEnigmaRotors.Create;
  fPlugBoard := TEnigmaPlugBoard.Create(CEnigmaRotorWiringFlat);
end;

procedure TEnigmaMachine.DecRotorCurrentPosition(const aRotorSlot : TEnigmaRotorSlots);
var
  lRotorIndex : Integer;
  lRotor : TEnigmaRotor;
begin
  if RotorIndexFromRotorSlot(aRotorSlot, lRotorIndex) then
  begin
    lRotor := fRotorSet[lRotorIndex];
    lRotor.DecRotorCurrentPosition;
  end;
end;

destructor TEnigmaMachine.Destroy;
begin
  for var I : Integer := 0 to Pred(fRotorSet.Count) do
  begin
    fRotorSet[I].Free;
  end;
  fRotorSet.Free;
  fReflector.Free;
  fPlugBoard.Free;
  inherited;
end;

procedure TEnigmaMachine.DoEnigmaMachineChipedChar(const aInChar, aOutChar : AnsiChar);
begin
  if Assigned(fOnEnigmaMachineChipedChar) then
  begin
    fOnEnigmaMachineChipedChar(Self, aInChar, aOutChar);
  end;
end;

procedure TEnigmaMachine.AddRotor(const aCipherRingWiring : TEnigmaOutVirtualKeyBoard; const aSlot : TEnigmaRotorSlots; const aRotorID : TEnigmaRotorIDs; const aRingOffset : TEnigmaRingOffset; const aRotorNotchPositions : TEnigmaRotorNotchPositions);
begin
  AddRotor(aCipherRingWiring, aSlot, aRotorID, aRingOffset, aRotorNotchPositions, 0);
end;

procedure TEnigmaMachine.AddRotor(const aCipherRingWiring : TEnigmaOutVirtualKeyBoard; const aSlot : TEnigmaRotorSlots; const aRotorID : TEnigmaRotorIDs; const aRingOffset : TEnigmaRingOffset; const aRotorNotchPositions : TEnigmaRotorNotchPositions; const aRotorCurrentPosition : TEnigmaRotorPosition);
var
  lRotor : TEnigmaRotor;
begin
  lRotor := TEnigmaRotor.Create(aCipherRingWiring, aRotorID);
  lRotor.Configure(aSlot, aRotorNotchPositions);
  lRotor.RingOffset := aRingOffset;
  lRotor.RotorCurrentPosition := aRotorCurrentPosition;
  fRotorSet.Add(lRotor);
end;

procedure TEnigmaMachine.IncRotorCurrentPosition(const aRotorSlot : TEnigmaRotorSlots);
var
  lRotorIndex : Integer;
  lRotor : TEnigmaRotor;
begin
  if RotorIndexFromRotorSlot(aRotorSlot, lRotorIndex) then
  begin
    lRotor := fRotorSet[lRotorIndex];
    lRotor.IncRotorCurrentPosition;
    if lRotor.RotorCurrentPosition in lRotor.RotorNotchPositions then
    begin
      if lRotor.RotorSlot < high(TEnigmaRotorSlots) then
      begin
        IncRotorCurrentPosition(aRotorSlot + 1);
      end;
    end;
  end;
end;

function TEnigmaMachine.GetCiphedChar(aChar : AnsiChar) : AnsiChar;
var
  lSlot : TEnigmaRotorSlots;
  lRotorIndex : Integer;
  C : AnsiChar;
begin
  IncRotorCurrentPosition(1);
  C := aChar;
  // Plugboard in switching
  C := fPlugBoard.SignalSwitch(C, sdIn);
  for lSlot := 1 to CEnigmaMaxRotors do
  begin
    // RightLeft Signal Direction
    if RotorIndexFromRotorSlot(lSlot, lRotorIndex) then
    begin
      C := fRotorSet[lRotorIndex].SignalSwitch(C, sdIn);
    end;
  end;
  // Reflector switching
  C := fReflector.SignalSwitch(C);
  for lSlot := CEnigmaMaxRotors downto 1 do
  begin
    // LeftToRight Signal Direction
    if RotorIndexFromRotorSlot(lSlot, lRotorIndex) then
    begin
      C := fRotorSet[lRotorIndex].SignalSwitch(C, sdOut);
    end;
  end;
  // Plugboard out switching
  C := fPlugBoard.SignalSwitch(C, sdOut);
  DoEnigmaMachineChipedChar(aChar, C);
  Result := C;
  // Rollup Rotors
end;

function TEnigmaMachine.GetRotor(aRotorIndex : Integer) : TEnigmaRotor;
begin
  Result := fRotorSet[aRotorIndex];
end;

function TEnigmaMachine.RotorIndexFromRotorID(aRotorID : TEnigmaRotorIDs; var aRotorIndex : Integer) : Boolean;
var
  lRotorIndex : Integer;
begin
  Result := False;
  aRotorIndex := -1;
  for lRotorIndex := 0 to Pred(fRotorSet.Count) do
  begin
    if fRotorSet[lRotorIndex] <> nil then
    begin
      if fRotorSet[lRotorIndex].RotorID = aRotorID then
      begin
        aRotorIndex := lRotorIndex;
        Result := True;
        Break;
      end;
    end;
  end;
end;

function TEnigmaMachine.RotorIndexFromRotorSlot(aSlot : TEnigmaRotorSlots; var aRotorIndex : Integer) : Boolean;
var
  lRotorIndex : Integer;
begin
  Result := False;
  aRotorIndex := -1;
  for lRotorIndex := 0 to Pred(fRotorSet.Count) do
  begin
    if fRotorSet[lRotorIndex] <> nil then
    begin
      if fRotorSet[lRotorIndex].RotorSlot = aSlot then
      begin
        aRotorIndex := lRotorIndex;
        Result := True;
        Break;
      end;
    end;
  end;
end;

procedure TEnigmaMachine.SetRotor(aRotorIndex : Integer; const Value : TEnigmaRotor);
begin
  fRotorSet[aRotorIndex] := Value;
end;

end.
