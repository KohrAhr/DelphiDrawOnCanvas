unit ufmMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, dxGDIPlusClasses, Vcl.ExtCtrls,
  Vcl.StdCtrls;

type
  TfmMain = class(TForm)
    imgTarget: TImage;
    cbColorForDraw: TColorBox;
    memLog: TMemo;
    rgDrawingOption: TRadioGroup;
    procedure imgTargetMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure imgTargetMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure imgTargetMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
  private
    { Private declarations }
    var
      FDrawing: boolean;

    procedure StartDraw(AImage: TImage; AX, AY: Integer; AColor: Integer);
    procedure EndDraw(AImage: TImage; AX, AY: Integer);
    procedure Log(AMessage: String);
  public
    { Public declarations }
  end;

var
  fmMain: TfmMain;

implementation

{$R *.dfm}

procedure TfmMain.imgTargetMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  FDrawing := True;

  StartDraw(imgTarget, X, Y, cbColorForDraw.Selected);

  Log('Start: ' + X.ToString + ', ' + Y.ToString + '. Color: ' +
    IntToStr(cbColorForDraw.Selected));
end;

procedure TfmMain.imgTargetMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  // Lineart? Exit
  if rgDrawingOption.ItemIndex = 0 then
    Exit;

  if not FDrawing then
    Exit;

  EndDraw(imgTarget, X, Y);

  Log(X.ToString + ', ' + Y.ToString);
end;

procedure TfmMain.imgTargetMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  FDrawing := False;

  EndDraw(imgTarget, X, Y);

  Log('End: ' + X.ToString + ', ' + Y.ToString);
end;

procedure TfmMain.Log(AMessage: String);
begin
  memLog.Lines.Add(AMessage);
end;

{$REGION}

procedure TfmMain.StartDraw(AImage: TImage; AX, AY: Integer; AColor: Integer);
begin
  if AImage = nil then
    Exit;

  with AImage.Canvas do
    begin
      Pen.Color := AColor;
      MoveTo(AX, AY);
    end;
end;

procedure TfmMain.EndDraw(AImage: TImage; AX, AY: Integer);
begin
  if AImage = nil then
    Exit;

  with AImage.Canvas do
    LineTo(AX, AY);
end;

{$ENDREGION}

end.
