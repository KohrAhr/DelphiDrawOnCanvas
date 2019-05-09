program DelphiOwnComponentTestDrive;

uses
  Vcl.Forms,
  ufmMain in 'ufmMain.pas' {fmMain};

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown := True;

  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfmMain, fmMain);
  Application.Run;
end.
