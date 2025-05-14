object StockManagerDataModule: TStockManagerDataModule
  OnCreate = DataModuleCreate
  Height = 750
  Width = 1000
  PixelsPerInch = 120
  object StockManagerFDConnection: TFDConnection
    Left = 304
    Top = 240
  end
  object StockManagerScript: TFDScript
    SQLScripts = <>
    Connection = StockManagerFDConnection
    Params = <>
    Macros = <>
    Left = 480
    Top = 360
  end
  object StockManagerQuery: TFDQuery
    Connection = StockManagerFDConnection
    Left = 536
    Top = 184
  end
  object StockManagerFBDriverLink: TFDPhysFBDriverLink
    Left = 616
    Top = 304
  end
end
