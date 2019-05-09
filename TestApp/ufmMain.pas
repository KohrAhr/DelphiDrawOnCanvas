unit ufmMain;

interface

uses
  Winapi.Windows, Winapi.Messages,
  System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls,
  Vcl.StdCtrls,
  uTFreehandDraw, dxGDIPlusClasses, Vcl.ComCtrls;

type
  TfmMain = class(TForm)
    FreehandDraw1: TFreehandDraw;
    btnLoadImage: TButton;
    btnResetImage: TButton;
    cbColor: TColorBox;
    memLog: TMemo;
    Label1: TLabel;
    trPenSize: TTrackBar;
    ListBox1: TListBox;
    Label2: TLabel;
    Label3: TLabel;
    procedure btnLoadImageClick(Sender: TObject);
    procedure btnResetImageClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure trPenSizeChange(Sender: TObject);
    procedure cbColorChange(Sender: TObject);
  private
    { Private declarations }
    var
      FTotal: Integer;
    procedure Log(AMessage: String);
  public
    { Public declarations }
    procedure EventOnStart(Sender: TObject; AX, AY: Integer);
    procedure EventOnMove(Sender: TObject; AX, AY: Integer);
    procedure EventOnEnd(Sender: TObject; AX, AY: Integer);
  end;

var
  fmMain: TfmMain;

implementation

{$R *.dfm}

procedure TfmMain.btnLoadImageClick(Sender: TObject);
begin
  try
    FreehandDraw1.Picture.LoadFromFile(
      '..\..\TestImage.bmp');
  except
    on EInvalidGraphic do
      FreehandDraw1.Picture.Graphic := nil;
  end;
end;

procedure TfmMain.btnResetImageClick(Sender: TObject);
begin
  FreehandDraw1.Picture.Bitmap.FreeImage;
  FreehandDraw1.Picture.Bitmap := nil;
end;

procedure TfmMain.cbColorChange(Sender: TObject);
begin
  FreehandDraw1.Color := cbColor.Selected;
end;

procedure TfmMain.EventOnEnd(Sender: TObject; AX, AY: Integer);
begin
  Log('End: ' + AX.ToString + ', ' + AY.ToString);

  //
  Inc(FTotal);
  ListBox1.Items.Add('Object ' + FTotal.ToString);
end;

procedure TfmMain.EventOnMove(Sender: TObject; AX, AY: Integer);
begin
  Log(AX.ToString + ', ' + AY.ToString);
end;

procedure TfmMain.EventOnStart(Sender: TObject; AX, AY: Integer);
begin
  Log('Start: ' + AX.ToString + ', ' + AY.ToString);
end;

procedure TfmMain.FormCreate(Sender: TObject);
begin
  FreehandDraw1.OnStart := EventOnStart;
  FreehandDraw1.OnMove := EventOnMove;
  FreehandDraw1.OnEnd := EventOnEnd;

  cbColorChange(Sender);
end;

procedure TfmMain.Log(AMessage: String);
begin
  memLog.Lines.Add(AMessage);
end;

procedure TfmMain.trPenSizeChange(Sender: TObject);
begin
  FreehandDraw1.Size := trPenSize.Position;
end;

end.
