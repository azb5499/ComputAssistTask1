unit stock_data_access_u;

interface

uses
  System.SysUtils, System.Classes,
  FireDAC.Comp.Client, Data.DB,
  data_module_u, stock_exceptions_u, Math,System.Generics.Collections;

  const MarkupFraction = 0.5;
type
  TStockDataAccess = class
  public
    // task related functions
    function AddDepartment(const sDepartmentName: string): Boolean;
    function AddSupplier(const sSupplierName, sContactName, sPhone,
      sEmail: string): Boolean;
    function AddStockItem(const sBarcode, sDescription, sDepartmentName,
      sSupplierName: string; dCostPrice: double; iQuantity: Integer): Boolean;

    // search functionality
    function FetchAllItems: TFDQuery;
    function SearchByBarcode(const sBarcode: string): TFDQuery;
    function SearchByDescription(const sDesc: string): TFDQuery;
    function SearchByDepartment(const sDept: string): TFDQuery;
    function SearchBySupplier(const sSupp: string): TFDQuery;
    function SearchItems(const sField, sValue: string): TFDQuery;
    function FetchAllSuppliers() : TArray<string>;
    function FetchAllDepartments() : TArray<string>;
    function FindProductByBarcode(const ABarcode: string): TArray<string>;
    function UpdateStockItem(
  const sBarcode, sDescription,
  sDepartmentName, sSupplierName: string;
  dCostPrice: Double;
  iQuantity: Integer): Boolean;
  function UpdateProductMarkup(const ABarcode: string;
  const dNewMarkup: Double): Boolean;
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
  sDepartmentName, sSupplierName: string; dCostPrice: double;
  iQuantity: Integer): Boolean;
var
  qry: TFDQuery;
  iDeptID, iSuppID: Integer;
  MarkupFraction: double;
begin
  qry := TFDQuery.Create(nil);
  try
    qry.Connection := StockManagerDataModule.StockManagerFDConnection;
    if not qry.Connection.InTransaction then
      qry.Connection.StartTransaction;


    qry.SQL.Text :=
      'SELECT DepartmentID FROM Department WHERE DepartmentName = :Name';
    qry.ParamByName('Name').AsString := sDepartmentName;
    qry.Open;
    if qry.Eof then
      raise EDepartmentNotFound.CreateFmt('Department "%s" does not exist.',
        [sDepartmentName]);
    iDeptID := qry.FieldByName('DepartmentID').AsInteger;
    qry.Close;


    qry.SQL.Text :=
      'SELECT SupplierID FROM Supplier WHERE SupplierName = :Name';
    qry.ParamByName('Name').AsString := sSupplierName;
    qry.Open;
    if qry.Eof then
      raise ESupplierNotFound.CreateFmt('Supplier "%s" does not exist.',
        [sSupplierName]);
    iSuppID := qry.FieldByName('SupplierID').AsInteger;
    qry.Close;


    qry.SQL.Text := 'SELECT 1 FROM StockItem WHERE Barcode = :BC';
    qry.ParamByName('BC').AsString := sBarcode;
    qry.Open;
    if not qry.Eof then
      raise EStockItemExists.CreateFmt('Item with barcode "%s" already exists.',
        [sBarcode]);
    qry.Close;

    // Insert new StockItem with cost, markup percent, retail price, and quantity
    qry.SQL.Text := 'INSERT INTO StockItem ' +
      '(Barcode, Description, DepartmentID, SupplierID, CostPrice, MarkupPercent, RetailPrice, QuantityOnHand) '
      + 'VALUES (:BC, :Desc, :DeptID, :SuppID, :Cost, :Mark, :Retail, :Qty)';

    qry.ParamByName('BC').AsString := sBarcode;
    qry.ParamByName('Desc').AsString := sDescription;
    qry.ParamByName('DeptID').AsInteger := iDeptID;
    qry.ParamByName('SuppID').AsInteger := iSuppID;

    // Round cost price to 2 decimals
    qry.ParamByName('Cost').AsFloat := RoundTo(dCostPrice, -2);
    // Store markup fraction (50%)
    qry.ParamByName('Mark').AsFloat := MarkupFraction;
    // Calculate and round retail price = cost * (1 + markup)
    qry.ParamByName('Retail').AsFloat :=
      RoundTo(dCostPrice * (1 + MarkupFraction), -2);

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
    'SELECT s.StockItemID, s.Barcode, s.Description, s.CostPrice, ' +
    '       s.MarkupPercent, s.RetailPrice, s.QuantityOnHand, ' +
    '       d.DepartmentName, p.SupplierName ' + 'FROM StockItem s ' +
    'JOIN Department d ON s.DepartmentID = d.DepartmentID ' +
    'JOIN Supplier p ON s.SupplierID = p.SupplierID';
  Result.Open;
end;

function TStockDataAccess.SearchByBarcode(const sBarcode: string): TFDQuery;
begin
  Result := TFDQuery.Create(nil);
  Result.Connection := StockManagerDataModule.StockManagerFDConnection;
  Result.SQL.Text := 'SELECT * FROM StockItem WHERE Barcode CONTAINING :Term';
  Result.ParamByName('Term').AsString := '%' + sBarcode + '%';
  Result.Open;
end;

function TStockDataAccess.SearchByDescription(const sDesc: string): TFDQuery;
var
  Q: TFDQuery;
begin
  Q := TFDQuery.Create(nil);
  try
    Q.Connection := StockManagerDataModule.StockManagerFDConnection;
    Q.SQL.Text := 'SELECT SI.StockItemID, SI.Barcode, SI.Description, ' +
      '       D.DepartmentName, S.SupplierName, ' +
      '       SI.CostPrice, SI.MarkupPercent, SI.RetailPrice, SI.QuantityOnHand '
      + 'FROM StockItem SI ' +
      'LEFT JOIN Department D ON SI.DepartmentID = D.DepartmentID ' +
      'LEFT JOIN Supplier S   ON SI.SupplierID   = S.SupplierID ' +
      'WHERE SI.Description LIKE :SearchVal';
    Q.ParamByName('SearchVal').AsString := '%' + sDesc + '%';
    Q.Open;
    Result := Q;
  except
    Q.Free;
    raise;
  end;
end;

function TStockDataAccess.SearchByDepartment(const sDept: string): TFDQuery;
var
  Q: TFDQuery;
begin
  Q := TFDQuery.Create(nil);
  try
    Q.Connection := StockManagerDataModule.StockManagerFDConnection;
    Q.SQL.Text := 'SELECT SI.StockItemID, SI.Barcode, SI.Description, ' +
      '       D.DepartmentName, S.SupplierName, ' +
      '       SI.CostPrice, SI.MarkupPercent, SI.RetailPrice, SI.QuantityOnHand '
      + 'FROM StockItem SI ' +
      'LEFT JOIN Department D ON SI.DepartmentID = D.DepartmentID ' +
      'LEFT JOIN Supplier S   ON SI.SupplierID   = S.SupplierID ' +
      'WHERE D.DepartmentName LIKE :SearchVal';
    Q.ParamByName('SearchVal').AsString := '%' + sDept + '%';
    Q.Open;
    Result := Q;
  except
    Q.Free;
    raise;
  end;
end;

function TStockDataAccess.SearchBySupplier(const sSupp: string): TFDQuery;
var
  Q: TFDQuery;
begin
  Q := TFDQuery.Create(nil);
  try
    Q.Connection := StockManagerDataModule.StockManagerFDConnection;
    Q.SQL.Text := 'SELECT SI.StockItemID, SI.Barcode, SI.Description, ' +
      '       D.DepartmentName, S.SupplierName, ' +
      '       SI.CostPrice, SI.MarkupPercent, SI.RetailPrice, SI.QuantityOnHand '
      + 'FROM StockItem SI ' +
      'LEFT JOIN Department D ON SI.DepartmentID = D.DepartmentID ' +
      'LEFT JOIN Supplier S   ON SI.SupplierID   = S.SupplierID ' +
      'WHERE S.SupplierName LIKE :SearchVal';
    Q.ParamByName('SearchVal').AsString := '%' + sSupp + '%';
    Q.Open;
    Result := Q;
  except
    Q.Free;
    raise;
  end;
end;

function TStockDataAccess.SearchItems(const sField, sValue: string): TFDQuery;
begin
  if SameText(sField, 'Barcode') then
    Result := SearchByBarcode(sValue)
  else if SameText(sField, 'Description') then
    Result := SearchByDescription(sValue)
  else if SameText(sField, 'Department') then
    Result := SearchByDepartment(sValue)
  else if SameText(sField, 'Supplier') then
    Result := SearchBySupplier(sValue)
  else
    // No match: fall back to all items (or raise an exception)
    Result := FetchAllItems;
end;

function TStockDataAccess.FetchAllSuppliers: TArray<string>;
var
  qry: TFDQuery;
  list: TList<string>;
begin
  list := TList<string>.Create;
  qry := TFDQuery.Create(nil);
  try
    qry.Connection := StockManagerDataModule.StockManagerFDConnection;
    qry.SQL.Text :=
      'SELECT SupplierName FROM Supplier ORDER BY SupplierName';
    qry.Open;
    while not qry.Eof do
    begin
      list.Add(qry.FieldByName('SupplierName').AsString);
      qry.Next;
    end;
    Result := list.ToArray;
  finally
    qry.Free;
    list.Free;
  end;
end;

function TStockDataAccess.FetchAllDepartments: TArray<string>;
var
  qry: TFDQuery;
  list: TList<string>;
begin
  list := TList<string>.Create;
  qry := TFDQuery.Create(nil);
  try
    qry.Connection := StockManagerDataModule.StockManagerFDConnection;
    qry.SQL.Text :=
      'SELECT DepartmentName FROM Department ORDER BY DepartmentName';
    qry.Open;
    while not qry.Eof do
    begin
      list.Add(qry.FieldByName('DepartmentName').AsString);
      qry.Next;
    end;
    Result := list.ToArray;
  finally
    qry.Free;
    list.Free;
  end;
end;

function TStockDataAccess.FindProductByBarcode(const ABarcode: string): TArray<string>;
var
  qry: TFDQuery;
begin
  qry := TFDQuery.Create(nil);
  try
    qry.Connection := StockManagerDataModule.StockManagerFDConnection;
    qry.SQL.Text :=
      'SELECT si.Barcode, d.DepartmentName, s.SupplierName, ' +
      '       si.Description, si.CostPrice, si.QuantityOnHand ' +
      'FROM StockItem si ' +
      'JOIN Department d ON si.DepartmentID = d.DepartmentID ' +
      'JOIN Supplier s ON si.SupplierID = s.SupplierID ' +
      'WHERE si.Barcode = :BC';
    qry.ParamByName('BC').AsString := ABarcode;
    qry.Open;

    if qry.Eof then
      Exit(nil);

    SetLength(Result, 6);
    Result[0] := qry.FieldByName('Barcode').AsString;
    Result[1] := qry.FieldByName('DepartmentName').AsString;
    Result[2] := qry.FieldByName('SupplierName').AsString;
    Result[3] := qry.FieldByName('Description').AsString;
    Result[4] := FloatToStrF(qry.FieldByName('CostPrice').AsFloat, ffFixed, 15, 2);
    Result[5] := IntToStr(qry.FieldByName('QuantityOnHand').AsInteger);
  finally
    qry.Free;
  end;
end;



function TStockDataAccess.UpdateProductMarkup(const ABarcode: string;
  const dNewMarkup: Double): Boolean;
var
  qry: TFDQuery;
  oldCost, newRetail: Double;
begin
  qry := TFDQuery.Create(nil);
  try
    qry.Connection := StockManagerDataModule.StockManagerFDConnection;
    if not qry.Connection.InTransaction then
      qry.Connection.StartTransaction;

    // 1) Fetch current cost
    qry.SQL.Text :=
      'SELECT CostPrice FROM StockItem WHERE Barcode = :BC';
    qry.ParamByName('BC').AsString := ABarcode;
    qry.Open;
    if qry.Eof then
    begin
      Result := False;
      Exit;
    end;
    oldCost := qry.FieldByName('CostPrice').AsFloat;
    qry.Close;

    // 2) Calculate new retail
    newRetail := RoundTo(oldCost * (1 + dNewMarkup), -2);

    // 3) Update markup and retail
    qry.SQL.Text :=
      'UPDATE StockItem ' +
      'SET MarkupPercent = :Mark, RetailPrice = :Retail ' +
      'WHERE Barcode = :BC';
    qry.ParamByName('Mark').AsFloat   := dNewMarkup;
    qry.ParamByName('Retail').AsFloat := newRetail;
    qry.ParamByName('BC').AsString    := ABarcode;

    qry.ExecSQL;
    // <-- ExecSQL is a procedure; now check RowsAffected:
    Result := qry.RowsAffected > 0;
    if Result then
      qry.Connection.Commit
    else
      qry.Connection.Rollback;
  finally
    qry.Free;
  end;
end;



function TStockDataAccess.UpdateStockItem(
  const sBarcode, sDescription,
  sDepartmentName, sSupplierName: string;
  dCostPrice: Double;
  iQuantity: Integer): Boolean;
var
  qry: TFDQuery;
  iDeptID, iSuppID: Integer;
begin
  qry := TFDQuery.Create(nil);
  try
    qry.Connection := StockManagerDataModule.StockManagerFDConnection;
    if not qry.Connection.InTransaction then
      qry.Connection.StartTransaction;

    // Resolve DepartmentID
    qry.SQL.Text :=
      'SELECT DepartmentID FROM Department WHERE DepartmentName = :Name';
    qry.ParamByName('Name').AsString := sDepartmentName;
    qry.Open;
    if qry.Eof then
      raise EDepartmentNotFound.CreateFmt(
        'Department "%s" does not exist.', [sDepartmentName]);
    iDeptID := qry.FieldByName('DepartmentID').AsInteger;
    qry.Close;

    // Resolve SupplierID
    qry.SQL.Text :=
      'SELECT SupplierID FROM Supplier WHERE SupplierName = :Name';
    qry.ParamByName('Name').AsString := sSupplierName;
    qry.Open;
    if qry.Eof then
      raise ESupplierNotFound.CreateFmt(
        'Supplier "%s" does not exist.', [sSupplierName]);
    iSuppID := qry.FieldByName('SupplierID').AsInteger;
    qry.Close;

    // Update StockItem record
    qry.SQL.Text :=
      'UPDATE StockItem SET ' +
      '  Description     = :Desc, ' +
      '  DepartmentID    = :DeptID, ' +
      '  SupplierID      = :SuppID, ' +
      '  CostPrice       = :Cost, ' +
      '  MarkupPercent   = :Mark, ' +
      '  RetailPrice     = :Retail, ' +
      '  QuantityOnHand  = :Qty ' +
      'WHERE Barcode = :BC';

    qry.ParamByName('BC').AsString := sBarcode;
    qry.ParamByName('Desc').AsString := sDescription;
    qry.ParamByName('DeptID').AsInteger := iDeptID;
    qry.ParamByName('SuppID').AsInteger := iSuppID;
    qry.ParamByName('Cost').AsFloat := RoundTo(dCostPrice, -2);
    qry.ParamByName('Mark').AsFloat := MarkupFraction;
    qry.ParamByName('Retail').AsFloat := RoundTo(dCostPrice * (1 + MarkupFraction), -2);
    qry.ParamByName('Qty').AsInteger := iQuantity;

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
