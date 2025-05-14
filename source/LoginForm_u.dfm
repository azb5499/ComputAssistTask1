object LoginForm: TLoginForm
  Left = 0
  Top = 0
  Caption = 'Login'
  ClientHeight = 474
  ClientWidth = 643
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnShow = FormShow
  TextHeight = 15
  object LoginLayoutGridPanel: TGridPanel
    Left = 0
    Top = 0
    Width = 643
    Height = 474
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
    ExplicitWidth = 641
    ExplicitHeight = 466
    object Image1: TImage
      Left = 1
      Top = 1
      Width = 641
      Height = 115
      Align = alClient
      Stretch = True
      ExplicitLeft = 264
      ExplicitTop = 168
      ExplicitWidth = 105
      ExplicitHeight = 105
    end
    object CentralLoginGridPanel: TGridPanel
      Left = 1
      Top = 116
      Width = 641
      Height = 281
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
      ExplicitTop = 114
      ExplicitWidth = 639
      ExplicitHeight = 276
      object LeftPanel: TPanel
        Left = 1
        Top = 1
        Width = 202
        Height = 279
        Align = alClient
        Color = clLightsteelblue
        ParentBackground = False
        TabOrder = 0
        ExplicitWidth = 201
        ExplicitHeight = 274
      end
      object CentrePanel: TPanel
        Left = 203
        Top = 1
        Width = 236
        Height = 279
        Align = alClient
        BorderWidth = 100
        TabOrder = 1
        ExplicitLeft = 202
        ExplicitHeight = 274
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
          Height = 49
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
          Height = 49
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
        Left = 439
        Top = 1
        Width = 201
        Height = 279
        Align = alClient
        Color = clLightsteelblue
        ParentBackground = False
        TabOrder = 2
        ExplicitLeft = 438
        ExplicitWidth = 200
        ExplicitHeight = 274
      end
    end
    object FooterPanel: TPanel
      AlignWithMargins = True
      Left = 4
      Top = 400
      Width = 635
      Height = 70
      Align = alClient
      Color = clSkyBlue
      ParentBackground = False
      TabOrder = 1
      ExplicitTop = 393
      ExplicitWidth = 633
      ExplicitHeight = 69
    end
  end
end
