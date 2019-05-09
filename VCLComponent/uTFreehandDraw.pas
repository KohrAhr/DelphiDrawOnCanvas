unit uTFreehandDraw;

interface

uses
  System.SysUtils, System.Classes, System.UITypes, System.Types,
  System.Generics.Collections,
  { clRed }
  Vcl.Graphics,
  Vcl.Controls, Vcl.ExtCtrls;

type
  TListOfPoints = TList<TPoint>;
  TSingleDraw = class
  public
    Color: TColor;
    Size: Integer;
    Position: TListOfPoints;

    destructor Destroy; override;
  end;

  TDraws = TObjectList<TSingleDraw>;

  TNotifyOn = procedure(Sender: TObject; AX, AY: Integer) of object;

  TFreehandDraw = class(TImage)
  private
    { Private declarations }
    var
      // Indicator: drawing is in progress
      FDrawing: boolean;

      FOnStart: TNotifyOn;
      FOnMove: TNotifyOn;
      FOnEnd: TNotifyOn;

      // All our drawings
      FDraws: TDraws;

      // Current draw
      FCurrentDraw: TSingleDraw;

      // Color we going to use during active/current draw
      FColor: TColor;

      // Size we going to use during active/current draw
      FWidth: Integer;

    procedure InitEvents;

    procedure ImageMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; AX, AY: Integer);
    procedure ImageMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; AX, AY: Integer);
    procedure ImageMouseMove(Sender: TObject; Shift: TShiftState; AX,
      AY: Integer);

    /// <summary>
    ///   Register Position in List of positions
    /// </summary>
    procedure AddPosition(AX, AY: Integer);

    procedure StartDraw(AX, AY, AColor, AWidth: Integer);
    procedure EndDraw(AX, AY: Integer);
  protected
    { Protected declarations }
  public
    { Public declarations }
    property OnStart: TNotifyOn read FOnStart write FOnStart;
    property OnMove: TNotifyOn read FOnMove write FOnMove;
    property OnEnd: TNotifyOn read FOnEnd write FOnEnd;

    property Color: TColor read FColor write FColor default clRed;
    property Size: Integer read FWidth write FWidth default 1;

    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    { Published declarations }
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('1CLICK.LV', [TFreehandDraw]);
end;

{ TFreehandDraw }

constructor TFreehandDraw.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  FColor := clRed;

  FDraws := TDraws.Create;

  InitEvents;
end;

destructor TFreehandDraw.Destroy;
begin
  FDraws.Free;

  inherited;
end;

procedure TFreehandDraw.InitEvents;
begin
  // Set events
  OnMouseDown := ImageMouseDown;
  OnMouseUp := ImageMouseUp;
  OnMouseMove := ImageMouseMove;
end;

procedure TFreehandDraw.ImageMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; AX, AY: Integer);
begin
  // Process started
  FDrawing := True;

  StartDraw(AX, AY, FColor, FWidth);

  // Create new object
  FCurrentDraw := TSingleDraw.Create;

  FCurrentDraw.Color := FColor;
  FCurrentDraw.Size := FWidth;
  FCurrentDraw.Position := TListOfPoints.Create;

  AddPosition(AX, AY);

  if Assigned(OnStart) then
    OnStart(Self, AX, AY);
end;

procedure TFreehandDraw.ImageMouseMove(Sender: TObject; Shift: TShiftState;
  AX, AY: Integer);
begin
  if not FDrawing then
    Exit;

  EndDraw(AX, AY);

  AddPosition(AX, AY);

  if Assigned(OnMove) then
    OnMove(Self, AX, AY);
end;

procedure TFreehandDraw.ImageMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; AX, AY: Integer);
begin
  // Process completed
  FDrawing := False;

  EndDraw(AX, AY);

  AddPosition(AX, AY);

  if Assigned(OnEnd) then
    OnEnd(Self, AX, AY);

  FCurrentDraw.Free;
end;

procedure TFreehandDraw.AddPosition(AX, AY: Integer);
begin
  // Bound check.
  // 0 -- mean already invisible. I just don't want to store negative values
  if AX < 0 then
    AX := 0;
  if AY < 0 then
    AY := 0;

  // Store
  FCurrentDraw.Position.Add(Point(AX, AY));
end;

{$REGION}
procedure TFreehandDraw.StartDraw(AX, AY, AColor, AWidth: Integer);
begin
  with Canvas do
    begin
      Pen.Color := AColor;
      Pen.Width := AWidth;
      MoveTo(AX, AY);
    end;
end;

procedure TFreehandDraw.EndDraw(AX, AY: Integer);
begin
  with Canvas do
    LineTo(AX, AY);
end;
{$ENDREGION}

{ TSingleDraw }

destructor TSingleDraw.Destroy;
begin
  Position.Free;

  inherited;
end;

end.
