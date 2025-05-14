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
  OnCreate = FormCreate
  OnShow = FormShow
  TextHeight = 15
  object ProductManagementPanel: TPanel
    Left = 0
    Top = 0
    Width = 699
    Height = 461
    Align = alClient
    TabOrder = 0
    ExplicitWidth = 697
    ExplicitHeight = 453
    object ProductManagementPageControl: TPageControl
      Left = 1
      Top = 1
      Width = 697
      Height = 459
      ActivePage = BrowseProductsTabSheet
      Align = alClient
      TabOrder = 1
      ExplicitWidth = 695
      ExplicitHeight = 451
      object AddProductTabsheet: TTabSheet
        Caption = 'Add Product'
        OnShow = AddProductTabsheetShow
        object AddProductPanel: TPanel
          Left = 216
          Top = 49
          Width = 265
          Height = 357
          TabOrder = 0
          object BarcodeEditBox: TEdit
            Left = 120
            Top = 24
            Width = 121
            Height = 23
            TabOrder = 0
          end
          object DescriptionEditBox: TEdit
            Left = 120
            Top = 64
            Width = 121
            Height = 23
            TabOrder = 1
          end
          object DepartmentComboBox: TComboBox
            Left = 112
            Top = 104
            Width = 145
            Height = 23
            TabOrder = 2
            OnEnter = DepartmentComboBoxEnter
          end
          object SupplierComboBox: TComboBox
            Left = 112
            Top = 149
            Width = 145
            Height = 23
            TabOrder = 3
            OnEnter = SupplierComboBoxEnter
          end
          object CostPriceSpinEdit: TSpinEdit
            Left = 136
            Top = 194
            Width = 121
            Height = 24
            MaxValue = 0
            MinValue = 0
            TabOrder = 4
            Value = 0
          end
          object QuantitySpinEdit: TSpinEdit
            Left = 136
            Top = 240
            Width = 121
            Height = 24
            MaxValue = 0
            MinValue = 0
            TabOrder = 5
            Value = 0
          end
          object SaveButton: TButton
            Left = 48
            Top = 304
            Width = 75
            Height = 25
            Caption = 'Save'
            TabOrder = 6
            OnClick = SaveButtonClick
          end
          object CancelButton: TButton
            Left = 152
            Top = 304
            Width = 75
            Height = 25
            Caption = 'Cancel'
            TabOrder = 7
            OnClick = CancelButtonClick
          end
        end
      end
      object BrowseProductsTabSheet: TTabSheet
        Caption = 'Browse Products'
        ImageIndex = 1
        OnShow = BrowseProductsTabSheetShow
        object ProductDBGrid: TDBGrid
          Left = 0
          Top = 0
          Width = 689
          Height = 185
          Align = alTop
          DataSource = StockManagerDataSource
          TabOrder = 0
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -12
          TitleFont.Name = 'Segoe UI'
          TitleFont.Style = []
        end
        object BrowseNavPanel: TPanel
          Left = 15
          Top = 191
          Width = 210
          Height = 226
          TabOrder = 1
          object AddModeButton: TButton
            Left = 40
            Top = 90
            Width = 129
            Height = 55
            Caption = 'Add Product'
            TabOrder = 0
            OnClick = AddModeButtonClick
          end
          object UpdateModeButton: TButton
            Left = 40
            Top = 17
            Width = 129
            Height = 56
            Caption = 'Update product'
            TabOrder = 1
            OnClick = UpdateModeButtonClick
          end
        end
        object SearchPanel: TPanel
          Left = 256
          Top = 191
          Width = 185
          Height = 225
          TabOrder = 2
          object SearchButton: TButton
            Left = 38
            Top = 135
            Width = 123
            Height = 65
            Caption = 'Search'
            TabOrder = 0
            OnClick = SearchButtonClick
          end
          object SearchEditBox: TEdit
            Left = 24
            Top = 82
            Width = 145
            Height = 23
            TabOrder = 1
          end
          object SearchFieldCombo: TComboBox
            Left = 24
            Top = 32
            Width = 145
            Height = 23
            TabOrder = 2
            Items.Strings = (
              'Barcode'
              'Description'
              'Supplier'
              'Department')
          end
        end
      end
      object UpdateProductTabSheet: TTabSheet
        Caption = 'Update Product'
        ImageIndex = 2
        OnShow = UpdateProductTabSheetShow
        object UpdateProductPanel: TPanel
          Left = 56
          Top = 38
          Width = 569
          Height = 357
          TabOrder = 0
          object PanelSearchUpdate: TPanel
            Left = 16
            Top = 24
            Width = 185
            Height = 241
            TabOrder = 0
            object BarcodeSearch: TEdit
              Left = 32
              Top = 32
              Width = 121
              Height = 23
              TabOrder = 0
            end
            object SearchUpdateButton: TButton
              Left = 24
              Top = 77
              Width = 145
              Height = 57
              Caption = 'Search'
              TabOrder = 1
              OnClick = SearchUpdateButtonClick
            end
          end
          object UpdatePanel: TPanel
            Left = 239
            Top = 22
            Width = 298
            Height = 323
            TabOrder = 1
            object QuantitySpinEdit2: TSpinEdit
              Left = 136
              Top = 172
              Width = 145
              Height = 24
              MaxValue = 0
              MinValue = 0
              TabOrder = 0
              Value = 0
            end
            object SupplierComboBox2: TComboBox
              Left = 136
              Top = 113
              Width = 145
              Height = 23
              TabOrder = 1
              OnEnter = SupplierComboBox2Enter
            end
            object DescriptionEdit2: TEdit
              Left = 136
              Top = 55
              Width = 145
              Height = 23
              TabOrder = 2
            end
            object DepartmentComboBox2: TComboBox
              Left = 136
              Top = 84
              Width = 145
              Height = 23
              TabOrder = 3
              OnEnter = DepartmentComboBox2Enter
            end
            object CostSpinEdit2: TSpinEdit
              Left = 136
              Top = 142
              Width = 145
              Height = 24
              MaxValue = 0
              MinValue = 0
              TabOrder = 4
              Value = 0
            end
            object ApplyUpdateButton: TButton
              Left = 78
              Top = 224
              Width = 147
              Height = 73
              Caption = 'Apply changes'
              TabOrder = 5
              OnClick = ApplyUpdateButtonClick
            end
            object BarcodeEdit2: TEdit
              Left = 136
              Top = 26
              Width = 145
              Height = 23
              TabOrder = 6
            end
          end
        end
        object CancelUpdate: TButton
          Left = 96
          Top = 210
          Width = 145
          Height = 67
          Caption = 'Cancel'
          TabOrder = 1
          OnClick = CancelUpdateClick
        end
      end
    end
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
  object StockManagerDataSource: TDataSource
    Left = 640
    Top = 392
  end
end
