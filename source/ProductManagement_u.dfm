object ProductManagementForm: TProductManagementForm
  Left = 0
  Top = 0
  Caption = 'Product Management'
  ClientHeight = 461
  ClientWidth = 699
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnClose = FormClose
  TextHeight = 15
  object ProductManagementPanel: TPanel
    Left = 0
    Top = 0
    Width = 699
    Height = 461
    Align = alClient
    TabOrder = 0
    ExplicitLeft = 264
    ExplicitTop = 232
    ExplicitWidth = 185
    ExplicitHeight = 41
    object BackButton: TButton
      Left = 616
      Top = 428
      Width = 75
      Height = 25
      Caption = 'Back'
      TabOrder = 0
      OnClick = BackButtonClick
    end
  end
end
