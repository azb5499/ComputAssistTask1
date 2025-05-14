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
  TextHeight = 15
  object ProductManagementPanel: TPanel
    Left = 0
    Top = 0
    Width = 699
    Height = 461
    Align = alClient
    TabOrder = 0
    object ProductManagementPageControl: TPageControl
      Left = 1
      Top = 1
      Width = 697
      Height = 459
      ActivePage = BrowseProductsTabSheet
      Align = alClient
      TabOrder = 1
      object AddProductTabsheet: TTabSheet
        Caption = 'Add/Update Product'
        object UpdateProductsPanel: TPanel
          Left = 264
          Top = 44
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
          end
          object SupplierComboBox: TComboBox
            Left = 112
            Top = 149
            Width = 145
            Height = 23
            TabOrder = 3
          end
          object CostPriceSpinEdit: TSpinEdit
            Left = 136
            Top = 178
            Width = 121
            Height = 24
            MaxValue = 0
            MinValue = 0
            TabOrder = 4
            Value = 0
          end
          object QuantitySpinEdit: TSpinEdit
            Left = 136
            Top = 208
            Width = 121
            Height = 24
            MaxValue = 0
            MinValue = 0
            TabOrder = 5
            Value = 0
          end
          object SaveButton: TButton
            Left = 48
            Top = 296
            Width = 75
            Height = 25
            Caption = 'Save'
            TabOrder = 6
          end
          object CancelButton: TButton
            Left = 152
            Top = 296
            Width = 75
            Height = 25
            Caption = 'Cancel'
            TabOrder = 7
          end
        end
      end
      object BrowseProductsTabSheet: TTabSheet
        Caption = 'Browse Products'
        ImageIndex = 1
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
        object SearchEditBox: TEdit
          Left = 288
          Top = 200
          Width = 121
          Height = 23
          TabOrder = 1
        end
        object SearchButton: TButton
          Left = 312
          Top = 240
          Width = 75
          Height = 25
          Caption = 'Search'
          TabOrder = 2
        end
        object AddModeButton: TButton
          Left = 232
          Top = 312
          Width = 81
          Height = 25
          Caption = 'Add Product'
          TabOrder = 3
        end
        object UpdateModeButton: TButton
          Left = 352
          Top = 312
          Width = 105
          Height = 25
          Caption = 'Update product'
          TabOrder = 4
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
    Left = 568
    Top = 312
  end
end
