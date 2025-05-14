object UserDashboardForm: TUserDashboardForm
  Left = 0
  Top = 0
  Caption = 'User Dashboard'
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
  object UserDashboardPanel: TPanel
    Left = 0
    Top = 0
    Width = 624
    Height = 441
    Align = alClient
    TabOrder = 0
    ExplicitLeft = 232
    ExplicitTop = 224
    ExplicitWidth = 185
    ExplicitHeight = 41
    object ProductManagementButton: TButton
      Left = 240
      Top = 273
      Width = 145
      Height = 57
      Caption = 'Product Management'
      TabOrder = 0
      OnClick = ProductManagementButtonClick
    end
    object BackButton: TButton
      Left = 542
      Top = 408
      Width = 75
      Height = 25
      Caption = 'Back'
      TabOrder = 1
      OnClick = BackButtonClick
    end
  end
end
