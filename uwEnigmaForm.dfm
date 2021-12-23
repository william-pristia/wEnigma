object EnigmaDemoForm: TEnigmaDemoForm
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'EnigmaDemoForm'
  ClientHeight = 783
  ClientWidth = 930
  Color = clWindow
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  KeyPreview = True
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 15
  object Label1: TLabel
    Left = 657
    Top = 316
    Width = 103
    Height = 15
    Alignment = taCenter
    AutoSize = False
    Caption = 'Rotor 1'
  end
  object Label2: TLabel
    Left = 449
    Top = 316
    Width = 98
    Height = 15
    Alignment = taCenter
    AutoSize = False
    Caption = 'Rotor 2'
  end
  object Label3: TLabel
    Left = 230
    Top = 316
    Width = 96
    Height = 15
    Alignment = taCenter
    AutoSize = False
    Caption = 'Rotor 3'
  end
  object Label4: TLabel
    Left = 20
    Top = 316
    Width = 95
    Height = 15
    Alignment = taCenter
    AutoSize = False
    Caption = 'Reflector'
  end
  object Label5: TLabel
    Left = 375
    Top = 532
    Width = 55
    Height = 15
    Caption = 'Plugboard'
  end
  object Label6: TLabel
    Left = 20
    Top = 603
    Width = 32
    Height = 15
    Caption = 'Key In'
  end
  object Label7: TLabel
    Left = 131
    Top = 603
    Width = 40
    Height = 15
    Caption = 'Key out'
  end
  object Shape1: TShape
    Left = 63
    Top = 747
    Width = 720
    Height = 4
    Brush.Color = 11549711
    Pen.Color = 11549711
  end
  object Shape2: TShape
    Left = 779
    Top = 564
    Width = 4
    Height = 187
    Brush.Color = 11549711
    Pen.Color = 11549711
  end
  object Shape3: TShape
    Left = 791
    Top = 381
    Width = 80
    Height = 4
    Brush.Color = 11549711
    Pen.Color = 11549711
  end
  object Shape4: TShape
    Left = 867
    Top = 189
    Width = 4
    Height = 193
    Brush.Color = 11549711
    Pen.Color = 11549711
  end
  object Shape5: TShape
    Left = 791
    Top = 189
    Width = 80
    Height = 4
    Brush.Color = 11549711
    Pen.Color = 11549711
  end
  object Shape6: TShape
    Left = 563
    Top = 189
    Width = 80
    Height = 4
    Brush.Color = 11549711
    Pen.Color = 11549711
  end
  object Shape7: TShape
    Left = 347
    Top = 189
    Width = 80
    Height = 4
    Brush.Color = 11549711
    Pen.Color = 11549711
  end
  object Shape8: TShape
    Left = 131
    Top = 189
    Width = 80
    Height = 4
    Brush.Color = 11549711
    Pen.Color = 11549711
  end
  object Shape9: TShape
    Left = 131
    Top = 282
    Width = 80
    Height = 4
    Brush.Color = 4210816
  end
  object Shape10: TShape
    Left = 563
    Top = 282
    Width = 80
    Height = 4
    Brush.Color = 4210816
  end
  object Shape11: TShape
    Left = 347
    Top = 282
    Width = 80
    Height = 4
    Brush.Color = 4210816
  end
  object Shape12: TShape
    Left = 779
    Top = 282
    Width = 4
    Height = 61
    Brush.Color = 4210816
  end
  object Shape13: TShape
    Left = 717
    Top = 339
    Width = 66
    Height = 4
    Brush.Color = 4210816
  end
  object Shape14: TShape
    Left = 717
    Top = 339
    Width = 4
    Height = 46
    Brush.Color = 4210816
  end
  object Shape15: TShape
    Left = 717
    Top = 564
    Width = 4
    Height = 46
    Brush.Color = 4210816
  end
  object Shape16: TShape
    Left = 177
    Top = 606
    Width = 544
    Height = 4
    Brush.Color = 4210816
  end
  object Shape17: TShape
    Left = 177
    Top = 606
    Width = 4
    Height = 46
    Brush.Color = 4210816
  end
  object Shape18: TShape
    Left = 63
    Top = 705
    Width = 4
    Height = 46
    Brush.Color = 11549711
    Pen.Color = 11549711
  end
  object Label8: TLabel
    Left = 221
    Top = 384
    Width = 214
    Height = 15
    Caption = 'PlugBoard connection format : AX, FT, ...'
  end
  object Label9: TLabel
    Left = 714
    Top = 142
    Width = 24
    Height = 15
    Caption = 'Ring'
  end
  object Label10: TLabel
    Left = 503
    Top = 142
    Width = 24
    Height = 15
    Caption = 'Ring'
  end
  object Label11: TLabel
    Left = 618
    Top = 142
    Width = 32
    Height = 15
    Caption = 'Offset'
  end
  object Label12: TLabel
    Left = 406
    Top = 142
    Width = 32
    Height = 15
    Caption = 'Offset'
  end
  object Label13: TLabel
    Left = 273
    Top = 142
    Width = 32
    Height = 15
    Caption = 'Offset'
  end
  object btn_start: TBitBtn
    Left = 145
    Top = 15
    Width = 123
    Height = 25
    Caption = 'Start typing'
    TabOrder = 1
    OnClick = btn_startClick
  end
  object edt_InText: TEdit
    Left = 20
    Top = 46
    Width = 779
    Height = 23
    TabStop = False
    CharCase = ecUpperCase
    TabOrder = 2
  end
  object edt_OutText: TEdit
    Left = 20
    Top = 75
    Width = 779
    Height = 23
    TabStop = False
    CharCase = ecUpperCase
    ReadOnly = True
    TabOrder = 13
  end
  object btn_reset: TBitBtn
    Left = 20
    Top = 15
    Width = 119
    Height = 25
    Caption = 'Reset/Stop typing'
    TabOrder = 0
    OnClick = btn_resetClick
  end
  object pnl_Slot_3: TPanel
    Left = 228
    Top = 168
    Width = 103
    Height = 142
    BevelKind = bkSoft
    BevelOuter = bvNone
    Caption = 'A'
    Color = 15987699
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -64
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentBackground = False
    ParentFont = False
    TabOrder = 14
    object btn_Slot_3_up: TBitBtn
      AlignWithMargins = True
      Left = 3
      Top = 3
      Width = 93
      Height = 25
      Align = alTop
      Glyph.Data = {
        36050000424D3605000000000000360400002800000010000000100000000100
        08000000000000010000120B0000120B0000000100000000000000000000FFFF
        FF00FF00FF00EAEAEA00D6D6D600CECECE00BABABA0096969600444444000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000020202020202
        0202020202020202020202020202020202020202020202020202020202020208
        0808080808020202020202020202080404040404040802020202020202020804
        0404040404080202020202020202080504050405040802020202020208080804
        0504050405080808020202080505050505050505050505050802020803050505
        0505050505050503080202080703050605060506050603070802020208070305
        0605060506030708020202020208070306060606030708020202020202020807
        0306060307080202020202020202020807030307080202020202020202020202
        0808080802020202020202020202020202020202020202020202}
      TabOrder = 0
      OnClick = btn_Slot_3_upClick
    end
    object btn_Slot_3_down: TBitBtn
      AlignWithMargins = True
      Left = 3
      Top = 110
      Width = 93
      Height = 25
      Align = alBottom
      Glyph.Data = {
        36050000424D3605000000000000360400002800000010000000100000000100
        08000000000000010000120B0000120B0000000100000000000000000000FFFF
        FF00FF00FF008E928E00E6E6E600DEDEDE00CECECE00BABABA008A8A8A004444
        4400000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000020202020202
        0202020202020202020202020202020202020202020202020202020202020202
        0909090902020202020202020202020908050508090202020202020202020908
        0505050508090202020202020209080505050505050809020202020209080506
        0506050605060809020202090806060606060606060606030902020906060606
        0606060606060606090202090404040406070607040404040902020209090904
        0706070604090909020202020202090407070707040902020202020202020904
        0707070704090202020202020202090404040404040902020202020202020209
        0909090909020202020202020202020202020202020202020202}
      TabOrder = 1
      OnClick = btn_Slot_3_downClick
    end
  end
  object pnl_Slot_2: TPanel
    Left = 444
    Top = 168
    Width = 103
    Height = 142
    BevelKind = bkFlat
    BevelOuter = bvNone
    Caption = 'A'
    Color = 15987699
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -64
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentBackground = False
    ParentFont = False
    TabOrder = 15
    object btn_Slot_2_down: TBitBtn
      AlignWithMargins = True
      Left = 3
      Top = 110
      Width = 93
      Height = 25
      Align = alBottom
      Glyph.Data = {
        36050000424D3605000000000000360400002800000010000000100000000100
        08000000000000010000120B0000120B0000000100000000000000000000FFFF
        FF00FF00FF008E928E00E6E6E600DEDEDE00CECECE00BABABA008A8A8A004444
        4400000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000020202020202
        0202020202020202020202020202020202020202020202020202020202020202
        0909090902020202020202020202020908050508090202020202020202020908
        0505050508090202020202020209080505050505050809020202020209080506
        0506050605060809020202090806060606060606060606030902020906060606
        0606060606060606090202090404040406070607040404040902020209090904
        0706070604090909020202020202090407070707040902020202020202020904
        0707070704090202020202020202090404040404040902020202020202020209
        0909090909020202020202020202020202020202020202020202}
      TabOrder = 0
      OnClick = btn_Slot_2_downClick
    end
    object btn_Slot_2_up: TBitBtn
      AlignWithMargins = True
      Left = 3
      Top = 3
      Width = 93
      Height = 25
      Align = alTop
      Glyph.Data = {
        36050000424D3605000000000000360400002800000010000000100000000100
        08000000000000010000120B0000120B0000000100000000000000000000FFFF
        FF00FF00FF00EAEAEA00D6D6D600CECECE00BABABA0096969600444444000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000020202020202
        0202020202020202020202020202020202020202020202020202020202020208
        0808080808020202020202020202080404040404040802020202020202020804
        0404040404080202020202020202080504050405040802020202020208080804
        0504050405080808020202080505050505050505050505050802020803050505
        0505050505050503080202080703050605060506050603070802020208070305
        0605060506030708020202020208070306060606030708020202020202020807
        0306060307080202020202020202020807030307080202020202020202020202
        0808080802020202020202020202020202020202020202020202}
      TabOrder = 1
      OnClick = btn_Slot_2_upClick
    end
  end
  object pnl_slot_1: TPanel
    Left = 657
    Top = 168
    Width = 103
    Height = 142
    BevelKind = bkFlat
    BevelOuter = bvNone
    Caption = 'A'
    Color = 15987699
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -64
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentBackground = False
    ParentFont = False
    TabOrder = 16
    object btn_Slot_1_down: TBitBtn
      AlignWithMargins = True
      Left = 3
      Top = 110
      Width = 93
      Height = 25
      Align = alBottom
      Glyph.Data = {
        36050000424D3605000000000000360400002800000010000000100000000100
        08000000000000010000120B0000120B0000000100000000000000000000FFFF
        FF00FF00FF008E928E00E6E6E600DEDEDE00CECECE00BABABA008A8A8A004444
        4400000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000020202020202
        0202020202020202020202020202020202020202020202020202020202020202
        0909090902020202020202020202020908050508090202020202020202020908
        0505050508090202020202020209080505050505050809020202020209080506
        0506050605060809020202090806060606060606060606030902020906060606
        0606060606060606090202090404040406070607040404040902020209090904
        0706070604090909020202020202090407070707040902020202020202020904
        0707070704090202020202020202090404040404040902020202020202020209
        0909090909020202020202020202020202020202020202020202}
      TabOrder = 0
      OnClick = btn_Slot_1_downClick
    end
    object btn_Slot_1_up: TBitBtn
      AlignWithMargins = True
      Left = 3
      Top = 3
      Width = 93
      Height = 25
      Align = alTop
      Glyph.Data = {
        36050000424D3605000000000000360400002800000010000000100000000100
        08000000000000010000120B0000120B0000000100000000000000000000FFFF
        FF00FF00FF00EAEAEA00D6D6D600CECECE00BABABA0096969600444444000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000020202020202
        0202020202020202020202020202020202020202020202020202020202020208
        0808080808020202020202020202080404040404040802020202020202020804
        0404040404080202020202020202080504050405040802020202020208080804
        0504050405080808020202080505050505050505050505050802020803050505
        0505050505050503080202080703050605060506050603070802020208070305
        0605060506030708020202020208070306060606030708020202020202020807
        0306060307080202020202020202020807030307080202020202020202020202
        0808080802020202020202020202020202020202020202020202}
      TabOrder = 1
      OnClick = btn_Slot_1_upClick
    end
  end
  object pnl_slot_1_in_in: TPanel
    Left = 759
    Top = 168
    Width = 40
    Height = 49
    BevelKind = bkFlat
    BevelOuter = bvNone
    Color = 14875367
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -32
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentBackground = False
    ParentFont = False
    TabOrder = 17
  end
  object pnl_slot_1_in_out: TPanel
    Left = 618
    Top = 168
    Width = 40
    Height = 49
    BevelKind = bkFlat
    BevelOuter = bvNone
    Color = 15528187
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -32
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentBackground = False
    ParentFont = False
    TabOrder = 18
  end
  object pnl_slot_2_in_in: TPanel
    Left = 546
    Top = 168
    Width = 40
    Height = 49
    BevelKind = bkFlat
    BevelOuter = bvNone
    Color = 14875367
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -32
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentBackground = False
    ParentFont = False
    TabOrder = 19
  end
  object pnl_slot_2_in_out: TPanel
    Left = 405
    Top = 168
    Width = 40
    Height = 49
    BevelKind = bkFlat
    BevelOuter = bvNone
    Color = 15528187
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -32
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentBackground = False
    ParentFont = False
    TabOrder = 20
  end
  object pnl_slot_3_in_out: TPanel
    Left = 189
    Top = 168
    Width = 40
    Height = 49
    BevelKind = bkFlat
    BevelOuter = bvNone
    Color = 15528187
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -32
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentBackground = False
    ParentFont = False
    TabOrder = 21
  end
  object pnl_slot_3_in_in: TPanel
    Left = 329
    Top = 168
    Width = 40
    Height = 49
    BevelKind = bkFlat
    BevelOuter = bvNone
    Color = 14875367
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -32
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentBackground = False
    ParentFont = False
    TabOrder = 22
  end
  object pnl_Reflector: TPanel
    Left = 20
    Top = 168
    Width = 95
    Height = 142
    BevelKind = bkFlat
    BevelOuter = bvNone
    Color = 15987699
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -64
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentBackground = False
    ParentFont = False
    TabOrder = 23
  end
  object pnl_Reflector_in_in: TPanel
    Left = 114
    Top = 168
    Width = 40
    Height = 49
    BevelKind = bkFlat
    BevelOuter = bvNone
    Color = 14875367
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -32
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentBackground = False
    ParentFont = False
    TabOrder = 24
  end
  object pnl_Reflector_in_out: TPanel
    Left = 114
    Top = 261
    Width = 40
    Height = 49
    BevelKind = bkFlat
    BevelOuter = bvNone
    Color = 15528187
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -32
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentBackground = False
    ParentFont = False
    TabOrder = 25
  end
  object pnl_slot_3_out_in: TPanel
    Left = 189
    Top = 261
    Width = 40
    Height = 49
    BevelKind = bkFlat
    BevelOuter = bvNone
    Color = 14875367
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -32
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentBackground = False
    ParentFont = False
    TabOrder = 26
  end
  object pnl_slot_3_out_out: TPanel
    Left = 329
    Top = 261
    Width = 40
    Height = 49
    BevelKind = bkFlat
    BevelOuter = bvNone
    Color = 15528187
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -32
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentBackground = False
    ParentFont = False
    TabOrder = 27
  end
  object pnl_slot_2_out_in: TPanel
    Left = 405
    Top = 261
    Width = 40
    Height = 49
    BevelKind = bkFlat
    BevelOuter = bvNone
    Color = 14875367
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -32
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentBackground = False
    ParentFont = False
    TabOrder = 28
  end
  object pnl_slot_2_out_out: TPanel
    Left = 546
    Top = 261
    Width = 40
    Height = 49
    BevelKind = bkFlat
    BevelOuter = bvNone
    Color = 15528187
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -32
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentBackground = False
    ParentFont = False
    TabOrder = 29
  end
  object pnl_slot_1_out_in: TPanel
    Left = 618
    Top = 261
    Width = 40
    Height = 49
    BevelKind = bkFlat
    BevelOuter = bvNone
    Color = 14875367
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -32
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentBackground = False
    ParentFont = False
    TabOrder = 30
  end
  object pnl_slot_1_out_out: TPanel
    Left = 759
    Top = 261
    Width = 40
    Height = 49
    BevelKind = bkFlat
    BevelOuter = bvNone
    Color = 15528187
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -32
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentBackground = False
    ParentFont = False
    TabOrder = 31
  end
  object pnl_PlugBoard: TPanel
    Left = 20
    Top = 411
    Width = 779
    Height = 115
    BevelKind = bkFlat
    BevelOuter = bvNone
    Color = 15987699
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -21
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentBackground = False
    ParentFont = False
    TabOrder = 32
  end
  object pnl_Pluboard_in_in: TPanel
    Left = 759
    Top = 525
    Width = 40
    Height = 49
    BevelKind = bkFlat
    BevelOuter = bvNone
    Color = 14875367
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -32
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentBackground = False
    ParentFont = False
    TabOrder = 33
  end
  object pnl_Pluboard_in_out: TPanel
    Left = 759
    Top = 363
    Width = 40
    Height = 49
    BevelKind = bkFlat
    BevelOuter = bvNone
    Color = 15528187
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -32
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentBackground = False
    ParentFont = False
    TabOrder = 34
  end
  object pnl_Pluboard_out_in: TPanel
    Left = 698
    Top = 363
    Width = 40
    Height = 49
    BevelKind = bkFlat
    BevelOuter = bvNone
    Color = 14875367
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -32
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentBackground = False
    ParentFont = False
    TabOrder = 35
  end
  object pnl_Pluboard_out_out: TPanel
    Left = 698
    Top = 525
    Width = 40
    Height = 49
    BevelKind = bkFlat
    BevelOuter = bvNone
    Color = 15528187
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -32
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentBackground = False
    ParentFont = False
    TabOrder = 36
  end
  object pnl_in_Char: TPanel
    Left = 20
    Top = 621
    Width = 92
    Height = 115
    BevelKind = bkSoft
    BevelOuter = bvNone
    Color = 14875367
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -64
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentBackground = False
    ParentFont = False
    TabOrder = 37
  end
  object pnl_out_Char: TPanel
    Left = 128
    Top = 621
    Width = 92
    Height = 115
    BevelKind = bkSoft
    BevelOuter = bvNone
    Color = 15528187
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -64
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentBackground = False
    ParentFont = False
    TabOrder = 38
  end
  object btn_Batch: TBitBtn
    Left = 801
    Top = 45
    Width = 109
    Height = 53
    Caption = 'Batch'
    TabOrder = 3
    OnClick = btn_BatchClick
  end
  object pnl_Info: TPanel
    Left = 274
    Top = 15
    Width = 525
    Height = 25
    BevelKind = bkTile
    BevelOuter = bvNone
    Color = clWhite
    ParentBackground = False
    TabOrder = 39
  end
  object edt_PlugboardItem: TEdit
    Left = 20
    Top = 380
    Width = 32
    Height = 23
    CharCase = ecUpperCase
    MaxLength = 2
    TabOrder = 40
  end
  object btn_PlubBoardAdd: TBitBtn
    Left = 58
    Top = 380
    Width = 75
    Height = 25
    Caption = 'Add'
    TabOrder = 41
    OnClick = btn_PlubBoardAddClick
  end
  object btn_PlubBoardReset: TBitBtn
    Left = 139
    Top = 380
    Width = 75
    Height = 25
    Caption = 'Reset'
    TabOrder = 42
    OnClick = btn_PlubBoardResetClick
  end
  object cmb_Slot_1: TComboBox
    Left = 618
    Top = 110
    Width = 181
    Height = 23
    Style = csDropDownList
    TabOrder = 7
    TabStop = False
    OnClick = cmb_Slot_1Click
    Items.Strings = (
      'Enigma M3 RI'
      'Enigma M3 RII'
      'Enigma M3 RIII'
      'Enigma M3 RIV'
      'Enigma M3 RV')
  end
  object cmb_Slot_2: TComboBox
    Left = 405
    Top = 110
    Width = 181
    Height = 23
    Style = csDropDownList
    TabOrder = 6
    TabStop = False
    OnClick = cmb_Slot_2Click
    Items.Strings = (
      'Enigma M3 RI'
      'Enigma M3 RII'
      'Enigma M3 RIII'
      'Enigma M3 RIV'
      'Enigma M3 RV')
  end
  object cmb_Slot_3: TComboBox
    Left = 188
    Top = 110
    Width = 181
    Height = 23
    Style = csDropDownList
    TabOrder = 5
    TabStop = False
    OnClick = cmb_Slot_3Click
    Items.Strings = (
      'Enigma M3 RI'
      'Enigma M3 RII'
      'Enigma M3 RIII'
      'Enigma M3 RIV'
      'Enigma M3 RV')
  end
  object cmb_Reflector: TComboBox
    Left = 20
    Top = 110
    Width = 134
    Height = 23
    Style = csDropDownList
    TabOrder = 4
    TabStop = False
    OnClick = cmb_ReflectorClick
    Items.Strings = (
      'Enigma M3 A'
      'Enigma M3 B'
      'Enigma M3 C'
      'Enigma M3 B Thin'
      'Enigma M3 C Thin')
  end
  object cmb_Notch_Slot_1: TComboBox
    Left = 741
    Top = 139
    Width = 58
    Height = 23
    Style = csDropDownList
    TabOrder = 12
    TabStop = False
    OnClick = cmb_Notch_Slot_1Click
    Items.Strings = (
      '01 - A'
      '02 - B'
      '03 - C'
      '04 - D'
      '05 - E'
      '06 - F'
      '07 - G'
      '08 - H'
      '09 - I'
      '10 - J'
      '11 - K'
      '12 - L'
      '13 - M'
      '14 - N'
      '15 - O'
      '16 - P'
      '17 - Q'
      '18 - R'
      '19 - S'
      '20 - T'
      '21 - U'
      '22 - V'
      '23 - W'
      '24 - X'
      '25 - Y'
      '26 - Z')
  end
  object cmb_Notch_Slot_2: TComboBox
    Left = 528
    Top = 139
    Width = 58
    Height = 23
    Style = csDropDownList
    TabOrder = 10
    TabStop = False
    OnClick = cmb_Notch_Slot_2Click
    Items.Strings = (
      '01 - A'
      '02 - B'
      '03 - C'
      '04 - D'
      '05 - E'
      '06 - F'
      '07 - G'
      '08 - H'
      '09 - I'
      '10 - J'
      '11 - K'
      '12 - L'
      '13 - M'
      '14 - N'
      '15 - O'
      '16 - P'
      '17 - Q'
      '18 - R'
      '19 - S'
      '20 - T'
      '21 - U'
      '22 - V'
      '23 - W'
      '24 - X'
      '25 - Y'
      '26 - Z')
  end
  object cmb_Offset_Slot_1: TComboBox
    Left = 653
    Top = 139
    Width = 58
    Height = 23
    Style = csDropDownList
    TabOrder = 11
    TabStop = False
    OnClick = cmb_Offset_Slot_1Click
    Items.Strings = (
      'None'
      '01 - A'
      '02 - B'
      '03 - C'
      '04 - D'
      '05 - E'
      '06 - F'
      '07 - G'
      '08 - H'
      '09 - I'
      '10 - J'
      '11 - K'
      '12 - L'
      '13 - M'
      '14 - N'
      '15 - O'
      '16 - P'
      '17 - Q'
      '18 - R'
      '19 - S'
      '20 - T'
      '21 - U'
      '22 - V'
      '23 - W'
      '24 - X'
      '25 - Y'
      '26 - Z')
  end
  object cmb_Offset_Slot_2: TComboBox
    Left = 441
    Top = 139
    Width = 58
    Height = 23
    Style = csDropDownList
    TabOrder = 9
    TabStop = False
    OnClick = cmb_Offset_Slot_2Click
    Items.Strings = (
      'None'
      '01 - A'
      '02 - B'
      '03 - C'
      '04 - D'
      '05 - E'
      '06 - F'
      '07 - G'
      '08 - H'
      '09 - I'
      '10 - J'
      '11 - K'
      '12 - L'
      '13 - M'
      '14 - N'
      '15 - O'
      '16 - P'
      '17 - Q'
      '18 - R'
      '19 - S'
      '20 - T'
      '21 - U'
      '22 - V'
      '23 - W'
      '24 - X'
      '25 - Y'
      '26 - Z')
  end
  object cmb_Offset_Slot_3: TComboBox
    Left = 311
    Top = 139
    Width = 58
    Height = 23
    Style = csDropDownList
    TabOrder = 8
    TabStop = False
    OnClick = cmb_Offset_Slot_3Click
    Items.Strings = (
      'None'
      '01 - A'
      '02 - B'
      '03 - C'
      '04 - D'
      '05 - E'
      '06 - F'
      '07 - G'
      '08 - H'
      '09 - I'
      '10 - J'
      '11 - K'
      '12 - L'
      '13 - M'
      '14 - N'
      '15 - O'
      '16 - P'
      '17 - Q'
      '18 - R'
      '19 - S'
      '20 - T'
      '21 - U'
      '22 - V'
      '23 - W'
      '24 - X'
      '25 - Y'
      '26 - Z')
  end
end
