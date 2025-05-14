object AdminDashboardForm: TAdminDashboardForm
  Left = 0
  Top = 0
  Caption = 'Admin Dashboard'
  ClientHeight = 441
  ClientWidth = 624
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnClose = FormClose
  TextHeight = 15
  object AdminDahsboardBackgroundPanel: TPanel
    Left = 0
    Top = 0
    Width = 624
    Height = 441
    Align = alClient
    TabOrder = 0
    ExplicitWidth = 622
    ExplicitHeight = 433
    object AddUserButton: TButton
      Left = 168
      Top = 248
      Width = 305
      Height = 81
      Caption = 'Add user'
      TabOrder = 0
      OnClick = AddUserButtonClick
    end
    object UpdateMarkupButton: TButton
      Left = 168
      Top = 152
      Width = 305
      Height = 81
      Caption = 'Update Markups'
      TabOrder = 1
      OnClick = UpdateMarkupButtonClick
    end
    object CloseBitButton: TBitBtn
      Left = 536
      Top = 408
      Width = 75
      Height = 25
      Kind = bkClose
      NumGlyphs = 2
      TabOrder = 2
    end
    object TotalStockValueReport: TButton
      Left = 168
      Top = 48
      Width = 305
      Height = 90
      Caption = 'View Total Stock Value Report'
      TabOrder = 3
      OnClick = TotalStockValueReportClick
    end
  end
end
