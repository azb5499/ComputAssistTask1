unit stock_data_access_u;

interface

uses
  System.SysUtils, System.Classes,
  FireDAC.Comp.Client, Data.DB,
  data_module_u,stock_exceptions_u;

type
  TStockDataAccess = class
  public
  // task related functions
    function AddDepartment(const sDepartmentName: string): Boolean;
    function AddSupplier(const sSupplierName, sContactName, sPhone,
      sEmail: string): Boolean;
    function AddStockItem(const sBarcode, sDescription, sDepartmentName,
      sSupplierName: string; dCostPrice, dMarkupPercent: Double;
      iQuantity: Integer): Boolean;

  //search functionality
  function FetchAllItems: TFDQuery;
  function SearchByBarcode(const sBarcode: string): TFDQuery;
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

function TStockDataAccess.AddSupplier(const sSupplierName, sContactName, sPhone,
  sEmail: string): Boolean;
var
  qry: TFDQuery;
begin
  qry := TFDQuery.Create(nil);
  try
    qry.Connection := StockManagerDataModule.StockManagerFDConnection;
    if not qry.Connection.InTransaction then
      qry.Connection.StartTransaction;
    qry.SQL.Text := 'SELECT 1 FROM Supplier WHERE SupplierName = :Name';
    qry.ParamByName('Name').AsString := sSupplierName;
    qry.Open;
    if not qry.Eof then
      raise ESupplierExists.CreateFmt('Supplier "%s" already exists.',
        [sSupplierName]);
    qry.Close;

    qry.SQL.Text :=
      'INSERT INTO Supplier (SupplierName, ContactName, Phone, Email) ' +
      'VALUES (:Name, :Contact, :Phone, :Email)';
    qry.ParamByName('Name').AsString := sSupplierName;
    qry.ParamByName('Contact').AsString := sContactName;
    qry.ParamByName('Phone').AsString := sPhone;
    qry.ParamByName('Email').AsString := sEmail;
    qry.ExecSQL;

    qry.Connection.Commit;
    Result := True;
  finally
    qry.Free;
  end;
end;

function TStockDataAccess.AddStockItem(const sBarcode, sDescription,
  sDepartmentName, sSupplierName: string; dCostPrice, dMarkupPercent: Double;
  iQuantity: Integer): Boolean;
var
  qry: TFDQuery;
  iDeptID, iSuppID: Integer;
begin
  qry := TFDQuery.Create(nil);
  try
    qry.Connection := StockManagerDataModule.StockManagerFDConnection;
    if not qry.Connection.InTransaction then
      qry.Connection.StartTransaction; // get DepartmentID
    qry.SQL.Text :=
      'SELECT DepartmentID FROM Department WHERE DepartmentName = :Name';
    qry.ParamByName('Name').AsString := sDepartmentName;
    qry.Open;
    if qry.Eof then
      raise EDepartmentNotFound.CreateFmt('Department "%s" does not exist.',
        [sDepartmentName]);
    iDeptID := qry.FieldByName('DepartmentID').AsInteger;
    qry.Close;

    // get SupplierID
    qry.SQL.Text :=
      'SELECT SupplierID FROM Supplier WHERE SupplierName = :Name';
    qry.ParamByName('Name').AsString := sSupplierName;
    qry.Open;
    if qry.Eof then
      raise ESupplierNotFound.CreateFmt('Supplier "%s" does not exist.',
        [sSupplierName]);
    iSuppID := qry.FieldByName('SupplierID').AsInteger;
    qry.Close;

    // check barcode
    qry.SQL.Text := 'SELECT 1 FROM StockItem WHERE Barcode = :BC';
    qry.ParamByName('BC').AsString := sBarcode;
    qry.Open;
    if not qry.Eof then
      raise EStockItemExists.CreateFmt('Item with barcode "%s" already exists.',
        [sBarcode]);
    qry.Close;

    // insert
    qry.SQL.Text := 'INSERT INTO StockItem ' +
      '(Barcode, Description, DepartmentID, SupplierID, CostPrice, MarkupPercent, QuantityOnHand) '
      + 'VALUES (:BC, :Desc, :DeptID, :SuppID, :Cost, :Mark, :Qty)';
    qry.ParamByName('BC').AsString := sBarcode;
    qry.ParamByName('Desc').AsString := sDescription;
    qry.ParamByName('DeptID').AsInteger := iDeptID;
    qry.ParamByName('SuppID').AsInteger := iSuppID;
    qry.ParamByName('Cost').AsFloat := dCostPrice;
    qry.ParamByName('Mark').AsFloat := dMarkupPercent;
    qry.ParamByName('Qty').AsInteger := iQuantity;
    qry.ExecSQL;

    qry.Connection.Commit;
    Result := True;
  finally
    qry.Free;
  end;
end;

function TStockDataAccess.FetchAllItems: TFDQuery;
begin
  Result := TFDQuery.Create(nil);
  Result.Connection := StockManagerDataModule.StockManagerFDConnection;
  Result.SQL.Text :=
    'SELECT StockItemID, Barcode, Description, CostPrice, ' +
    '       MarkupPercent, RetailPrice, QuantityOnHand ' +
    'FROM StockItem';
  Result.Open;
end;

function TStockDataAccess.SearchByBarcode(const sBarcode: string): TFDQuery;
begin
  Result := TFDQuery.Create(nil);
  Result.Connection := StockManagerDataModule.StockManagerFDConnection;
  Result.SQL.Text :=
    'SELECT * FROM StockItem WHERE Barcode CONTAINING :Term';
  Result.ParamByName('Term').AsString := '%' + sBarcode + '%';
  Result.Open;
end;

initialization

StockDataAccess := TStockDataAccess.Create;

finalization

FreeAndNil(StockDataAccess);

end.
