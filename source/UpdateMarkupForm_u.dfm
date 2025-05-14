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
    object MarkupControlsPanel: TPanel
      Left = 208
      Top = 182
      Width = 233
      Height = 227
      TabOrder = 2
      object UpdateAllMarkup: TButton
        Left = 48
        Top = 32
        Width = 145
        Height = 57
        Caption = 'Update all markups'
        TabOrder = 0
        OnClick = UpdateAllMarkupClick
      end
      object UpdateSingleMarkup: TButton
        Left = 48
        Top = 120
        Width = 145
        Height = 57
        Caption = 'Update single Markup'
        TabOrder = 1
        OnClick = UpdateSingleMarkupClick
      end
    end
    object RefreshButton: TButton
      Left = 466
      Top = 182
      Width = 145
      Height = 123
      Caption = 'Refresh data'
      TabOrder = 3
      OnClick = RefreshButtonClick
    end
  end
  object Button1: TButton
    Left = 480
    Top = 392
    Width = 1
    Height = 25
    Caption = 'Button1'
    TabOrder = 1
  end
  object MarkupDataSource: TDataSource
    Left = 504
    Top = 312
  end
end
