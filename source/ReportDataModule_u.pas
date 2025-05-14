unit ReportDataModule_u;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, stock_data_access_u,data_module_u,
  ppPrnabl, ppClass, ppCtrls, ppBands, ppCache, ppDesignLayer, ppParameter,
  ppComm, ppRelatv, ppProd, ppReport, ppDB, ppDBPipe,Vcl.Dialogs;

type
  TReportDataModule = class(TDataModule)
    qryStockDetails: TFDQuery;
    qryTotalValue: TFDQuery;
    dsStockDetails: TDataSource;
    dsTotalValue: TDataSource;
    ppReport1: TppReport;
    ppStockDBPipeline: TppDBPipeline;
    ppTotalDBPipeline: TppDBPipeline;
    ppParameterList1: TppParameterList;
    ppDesignLayers1: TppDesignLayers;
    ppDesignLayer1: TppDesignLayer;
    ppHeaderBand1: TppHeaderBand;
    ppDetailBand1: TppDetailBand;
    ppFooterBand1: TppFooterBand;
    ppDBText1: TppDBText;
    DBTextBarcode: TppDBText;
    DBTextDesc: TppDBText;
    DBTextRetail: TppDBText;
    DBTextQty: TppDBText;
    DBTextValue: TppDBText;
    ppLabel1: TppLabel;
    procedure DataModuleCreate(Sender: TObject);
    procedure GetReport();
    function HasStockRecords: Boolean;
  private
    DAL: TStockDataAccess;
  public
  end;

var
  ReportDataModule: TReportDataModule;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}
{$R *.dfm}

procedure TReportDataModule.DataModuleCreate(Sender: TObject);
begin
  DAL := TStockDataAccess.Create;


  qryStockDetails.Connection := StockManagerDataModule.StockManagerFDConnection;
  qryStockDetails.SQL.Text :=
    'SELECT Barcode, Description, RetailPrice, QuantityOnHand, (RetailPrice * QuantityOnHand) AS StockValue FROM StockItem';
  qryStockDetails.Open;
  dsStockDetails.DataSet := qryStockDetails;

  qryTotalValue.Connection := StockManagerDataModule.StockManagerFDConnection;
  qryTotalValue.SQL.Text :=
    'SELECT SUM(RetailPrice * QuantityOnHand) AS TotalValue FROM StockItem';
  qryTotalValue.Open;
  dsTotalValue.DataSet := qryTotalValue;
end;

function TReportDataModule.HasStockRecords: Boolean;
begin
  Result := not qryStockDetails.IsEmpty;
end;

procedure TReportDataModule.GetReport;
begin
  if not HasStockRecords then
  begin
    ShowMessage('No stock items in the database — report not generated.');
    Exit;
  end;

  ppReport1.Print;
end;


end.

