unit uDraw.Base;

interface

uses
  Vcl.Graphics,
  System.Types,
  System.Generics.Collections;

type
  TDrawBase = class
  private
    FColor: TColor;
    FPosition: TList<TPoint>;
  end;

implementation

end.
