object UpdateMarkupForm: TUpdateMarkupForm
  Left = 0
  Top = 0
  Caption = 'Markup Form'
  ClientHeight = 441
  ClientWidth = 624
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnClose = FormClose
  OnCreate = FormCreate
  TextHeight = 15
  object MarkupPanel: TPanel
    Left = 0
    Top = 0
    Width = 624
    Height = 441
    Align = alClient
    TabOrder = 0
    ExplicitWidth = 622
    ExplicitHeight = 433
    object CloseBitButton: TBitBtn
      Left = 528
      Top = 400
      Width = 75
      Height = 25
      Kind = bkClose
      NumGlyphs = 2
      TabOrder = 0
    end
    object MarkupGrid: TDBGrid
      Left = 1
      Top = 1
      Width = 622
      Height = 160
      Align = alTop
      DataSource = MarkupDataSource
      TabOrder = 1
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -12
      TitleFont.Name = 'Segoe UI'
      TitleFont.Style = []
    end
    object RefreshButton: TButton
      Left = 272
      Top = 289
      Width = 113
      Height = 80
      Caption = 'Refresh data'
      TabOrder = 2
      OnClick = RefreshButtonClick
    end
  end
  object MarkupDataSource: TDataSource
    Left = 304
    Top = 224
  end
end
