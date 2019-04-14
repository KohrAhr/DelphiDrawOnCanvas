program DrawOnCanvas;

uses
  Vcl.Forms,
  ufmMain in 'ufmMain.pas' {fmMain},
  uDraw.Base in 'uDraw.Base.pas',
  uDraw.Types in 'uDraw.Types.pas',
  uDraw.Basic in 'uDraw.Basic.pas',
  uDraw.Ex in 'uDraw.Ex.pas',
  uDraw.Core in 'uDraw.Core.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfmMain, fmMain);
  Application.Run;
end.
