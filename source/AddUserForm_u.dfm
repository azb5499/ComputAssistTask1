object AddUserForm: TAddUserForm
  Left = 0
  Top = 0
  Caption = 'User Addition Form'
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
  object AddUserBackgroundPanel: TPanel
    Left = 0
    Top = 0
    Width = 624
    Height = 441
    Align = alClient
    TabOrder = 0
    ExplicitWidth = 622
    ExplicitHeight = 433
    object CloseBitButton: TBitBtn
      Left = 536
      Top = 408
      Width = 75
      Height = 25
      Kind = bkClose
      NumGlyphs = 2
      TabOrder = 0
    end
    object AddUserInputPanel: TPanel
      Left = 176
      Top = 52
      Width = 297
      Height = 337
      TabOrder = 1
      object AddUserButton: TButton
        Left = 72
        Top = 176
        Width = 153
        Height = 89
        Caption = 'Add User'
        TabOrder = 0
        OnClick = AddUserButtonClick
      end
      object UsernameLabelEdit: TLabeledEdit
        Left = 88
        Top = 72
        Width = 121
        Height = 23
        EditLabel.Width = 85
        EditLabel.Height = 25
        EditLabel.Caption = 'Username'
        EditLabel.Font.Charset = DEFAULT_CHARSET
        EditLabel.Font.Color = clWindowText
        EditLabel.Font.Height = -19
        EditLabel.Font.Name = 'Segoe UI'
        EditLabel.Font.Style = []
        EditLabel.ParentFont = False
        TabOrder = 1
        Text = ''
      end
      object PasswordLabelEdit: TLabeledEdit
        Left = 88
        Top = 125
        Width = 121
        Height = 23
        EditLabel.Width = 79
        EditLabel.Height = 25
        EditLabel.Caption = 'Password'
        EditLabel.Font.Charset = DEFAULT_CHARSET
        EditLabel.Font.Color = clWindowText
        EditLabel.Font.Height = -19
        EditLabel.Font.Name = 'Segoe UI'
        EditLabel.Font.Style = []
        EditLabel.ParentFont = False
        TabOrder = 2
        Text = ''
      end
    end
  end
end
