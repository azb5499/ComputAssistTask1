unit stock_data_access_u;

interface

uses
  System.SysUtils, System.Classes,
  FireDAC.Comp.Client, Data.DB,
  data_module_u,stock_exceptions_u;

type
  TStockDataAccess = class
  public
    function AddDepartment(const sDepartmentName: string): Boolean;

  end;

var
  StockDataAccess: TStockDataAccess;

implementation

uses
  FireDAC.Stan.Param;

{ TStockDataAccess }

function TStockDataAccess.AddDepartment(const sDepartmentName: string): Boolean;
var
  qry: TFDQuery;
begin
  qry := TFDQuery.Create(nil);
  try
    qry.Connection := StockManagerDataModule.StockManagerFDConnection;
    if not qry.Connection.InTransaction then
      qry.Connection.StartTransaction;
    qry.SQL.Text := 'SELECT 1 FROM Department WHERE DepartmentName = :Name';
    qry.ParamByName('Name').AsString := sDepartmentName;
    qry.Open;
    if not qry.Eof then
      raise EDepartmentExists.CreateFmt('Department "%s" already exists.',
        [sDepartmentName]);
    qry.Close;

    qry.SQL.Text := 'INSERT INTO Department (DepartmentName) VALUES (:Name)';
    qry.ParamByName('Name').AsString := sDepartmentName;
    qry.ExecSQL;

    qry.Connection.Commit;
    Result := True;
  finally
    qry.Free;
  end;
end;


initialization

StockDataAccess := TStockDataAccess.Create;

finalization

FreeAndNil(StockDataAccess);

end.
