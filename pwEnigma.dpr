program pwEnigma;

uses
  Vcl.Forms,
  uwEnigmaForm in 'uwEnigmaForm.pas' {EnigmaDemoForm},
  uwEnigma in 'uwEnigma.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TEnigmaDemoForm, EnigmaDemoForm);
  Application.Run;
end.
