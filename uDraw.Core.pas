unit uDraw.Core;

interface

uses
  Vcl.Graphics,
  uDraw.Types,
  uDraw.Ex,
  uDraw.Base,
  System.Generics.Collections;

type
  TDrawCore = class(TDrawEx)
  private
    FDraws: TObjectList<TDrawBase>;
    FCanvas: TCanvas;
  public
    procedure Load(AData: String);
    function Save: String;

    procedure Flip(AFlip: TFlipType);
  end;

implementation

{ TDrawCore }

procedure TDrawCore.Flip(AFlip: TFlipType);
begin

end;

procedure TDrawCore.Load(AData: String);
begin

end;

function TDrawCore.Save: String;
begin

end;

end.
