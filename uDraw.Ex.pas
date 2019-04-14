unit uDraw.Ex;

interface

uses
  uDraw.Basic,
  uDraw.Types;

type
  TDrawEx = class(TDrawBasic)
  public
    procedure Flip(AFlip: TFlipType);
    procedure Rotate(AAngle: Integer);
    procedure Highlight;
  end;

implementation

{ TDrawEx }

procedure TDrawEx.Flip(AFlip: TFlipType);
begin

end;

procedure TDrawEx.Highlight;
begin

end;

procedure TDrawEx.Rotate(AAngle: Integer);
begin

end;

end.
