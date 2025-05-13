object LoginForm: TLoginForm
  Left = 0
  Top = 0
  Caption = 'Login'
  ClientHeight = 441
  ClientWidth = 624
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  TextHeight = 15
  object LoginLayoutGridPanel: TGridPanel
    Left = 0
    Top = 0
    Width = 624
    Height = 441
    Align = alClient
    ColumnCollection = <
      item
        Value = 100.000000000000000000
      end>
    ControlCollection = <
      item
        Column = 0
        Control = Image1
        Row = 0
      end
      item
        Column = 0
        Control = CentralLoginGridPanel
        Row = 1
      end
      item
        Column = 0
        Control = FooterPanel
        Row = 2
      end>
    RowCollection = <
      item
        Value = 24.315392750944920000
      end
      item
        Value = 59.588777294747210000
      end
      item
        Value = 16.095829954307870000
      end
      item
        SizeStyle = ssAuto
      end>
    TabOrder = 0
    ExplicitLeft = 112
    ExplicitWidth = 512
    object Image1: TImage
      Left = 1
      Top = 1
      Width = 622
      Height = 107
      Align = alClient
      Stretch = True
      ExplicitLeft = 264
      ExplicitTop = 168
      ExplicitWidth = 105
      ExplicitHeight = 105
    end
    object CentralLoginGridPanel: TGridPanel
      Left = 1
      Top = 108
      Width = 622
      Height = 261
      Align = alClient
      ColumnCollection = <
        item
          Value = 31.555617444640100000
        end
        item
          Value = 37.000000000000000000
        end
        item
          Value = 31.444382555359910000
        end>
      ControlCollection = <
        item
          Column = 0
          Control = LeftPanel
          Row = 0
        end
        item
          Column = 1
          Control = CentrePanel
          Row = 0
        end
        item
          Column = 2
          Control = RightPanel
          Row = 0
        end>
      RowCollection = <
        item
          Value = 100.000000000000000000
        end>
      TabOrder = 0
      ExplicitLeft = -15
      ExplicitTop = -60
      object LeftPanel: TPanel
        Left = 1
        Top = 1
        Width = 196
        Height = 259
        Align = alClient
        Color = clLightsteelblue
        ParentBackground = False
        TabOrder = 0
        ExplicitLeft = 216
        ExplicitTop = 112
        ExplicitWidth = 185
        ExplicitHeight = 41
      end
      object CentrePanel: TPanel
        Left = 197
        Top = 1
        Width = 229
        Height = 259
        Align = alClient
        BorderWidth = 100
        TabOrder = 1
        ExplicitLeft = 216
        ExplicitTop = 112
        ExplicitWidth = 185
        ExplicitHeight = 41
        object LoginButton: TButton
          AlignWithMargins = True
          Left = 50
          Top = 171
          Width = 135
          Height = 62
          Margins.Left = 5
          Margins.Top = 5
          Margins.Right = 5
          Margins.Bottom = 2
          Caption = 'LOGIN'
          TabOrder = 0
          OnClick = LoginButtonClick
        end
        object UsernameLabelEdit: TLabeledEdit
          Left = 56
          Top = 39
          Width = 121
          Height = 34
          EditLabel.Width = 101
          EditLabel.Height = 15
          EditLabel.Caption = 'UsernameLabelEdit'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Sans Serif Collection'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
          Text = ''
        end
        object PasswordLabelEdit: TLabeledEdit
          Left = 56
          Top = 114
          Width = 121
          Height = 31
          EditLabel.Width = 101
          EditLabel.Height = 15
          EditLabel.Caption = 'UsernameLabelEdit'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Sans Serif Collection'
          Font.Style = []
          ParentFont = False
          TabOrder = 2
          Text = ''
        end
      end
      object RightPanel: TPanel
        Left = 426
        Top = 1
        Width = 195
        Height = 259
        Align = alClient
        Color = clLightsteelblue
        ParentBackground = False
        TabOrder = 2
        ExplicitLeft = 216
        ExplicitTop = 112
        ExplicitWidth = 185
        ExplicitHeight = 41
      end
    end
    object FooterPanel: TPanel
      AlignWithMargins = True
      Left = 4
      Top = 372
      Width = 616
      Height = 65
      Align = alClient
      Color = clSkyBlue
      ParentBackground = False
      TabOrder = 1
      ExplicitLeft = 224
      ExplicitTop = 200
      ExplicitWidth = 185
      ExplicitHeight = 41
    end
  end
end
