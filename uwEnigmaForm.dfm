object EnigmaDemoForm: TEnigmaDemoForm
  Left = 0
  Top = 0
  Caption = 'EnigmaDemoForm'
  ClientHeight = 441
  ClientWidth = 624
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 15
  object BitBtn1: TBitBtn
    Left = 20
    Top = 15
    Width = 75
    Height = 25
    Caption = 'Execute'
    TabOrder = 0
    OnClick = BitBtn1Click
  end
  object Edit1: TEdit
    Left = 12
    Top = 180
    Width = 583
    Height = 23
    TabOrder = 1
    Text = 'AAAAA'
  end
  object Edit2: TEdit
    Left = 12
    Top = 209
    Width = 583
    Height = 23
    TabOrder = 2
  end
  object BitBtn2: TBitBtn
    Left = 98
    Top = 15
    Width = 75
    Height = 25
    Caption = 'Reset'
    TabOrder = 3
    OnClick = BitBtn2Click
  end
end
