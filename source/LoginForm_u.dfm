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
  object Edit1: TEdit
    Left = 264
    Top = 224
    Width = 121
    Height = 23
    TabOrder = 0
    Text = 'Edit1'
  end
  object Edit2: TEdit
    Left = 264
    Top = 272
    Width = 121
    Height = 23
    TabOrder = 1
    Text = 'Edit2'
  end
  object Button1: TButton
    Left = 280
    Top = 320
    Width = 75
    Height = 25
    Caption = 'Button1'
    TabOrder = 2
  end
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
      end>
    TabOrder = 3
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
          Value = 16.711790889479020000
        end
        item
          Value = 63.377182637698820000
        end
        item
          Value = 19.911026472822140000
        end>
      ControlCollection = <>
      RowCollection = <
        item
          Value = 100.000000000000000000
        end>
      TabOrder = 0
      ExplicitLeft = 25
      ExplicitTop = 114
    end
  end
end
