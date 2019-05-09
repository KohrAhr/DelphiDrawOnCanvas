object fmMain: TfmMain
  Left = 0
  Top = 0
  Caption = 'Draw on canvas'
  ClientHeight = 624
  ClientWidth = 965
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object FreehandDraw1: TFreehandDraw
    Left = 279
    Top = 24
    Width = 542
    Height = 542
  end
  object Label1: TLabel
    Left = 8
    Top = 136
    Width = 39
    Height = 13
    Caption = 'Pen size'
  end
  object Label2: TLabel
    Left = 8
    Top = 208
    Width = 37
    Height = 13
    Caption = 'Objects'
  end
  object Label3: TLabel
    Left = 135
    Top = 208
    Width = 44
    Height = 13
    Caption = 'Dump log'
  end
  object btnLoadImage: TButton
    Left = 8
    Top = 8
    Width = 121
    Height = 25
    Caption = 'Load image'
    TabOrder = 0
    OnClick = btnLoadImageClick
  end
  object btnResetImage: TButton
    Left = 8
    Top = 40
    Width = 121
    Height = 25
    Caption = 'Reset image'
    TabOrder = 1
    OnClick = btnResetImageClick
  end
  object cbColor: TColorBox
    Left = 8
    Top = 88
    Width = 121
    Height = 22
    TabOrder = 2
    OnChange = cbColorChange
  end
  object memLog: TMemo
    Left = 135
    Top = 224
    Width = 122
    Height = 393
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 3
  end
  object trPenSize: TTrackBar
    Left = 8
    Top = 155
    Width = 122
    Height = 39
    Max = 25
    Min = 1
    Position = 1
    TabOrder = 4
    OnChange = trPenSizeChange
  end
  object ListBox1: TListBox
    Left = 8
    Top = 224
    Width = 121
    Height = 393
    ItemHeight = 13
    TabOrder = 5
  end
end
