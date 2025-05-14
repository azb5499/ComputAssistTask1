unit ProductManagement_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  stock_data_access_u,
  Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Samples.Spin, Vcl.ComCtrls;

type
  TProductManagementForm = class(TForm)
    BackButton: TButton;
    ProductManagementPanel: TPanel;
    ProductManagementPageControl: TPageControl;
    AddProductTabsheet: TTabSheet;
    BrowseProductsTabSheet: TTabSheet;
    ProductDBGrid: TDBGrid;
    SearchEditBox: TEdit;
    SearchButton: TButton;
    AddModeButton: TButton;
    UpdateModeButton: TButton;
    BarcodeEditBox: TEdit;
    DescriptionEditBox: TEdit;
    AddProductPanel: TPanel;
    DepartmentComboBox: TComboBox;
    SupplierComboBox: TComboBox;
    CostPriceSpinEdit: TSpinEdit;
    QuantitySpinEdit: TSpinEdit;
    SaveButton: TButton;
    CancelButton: TButton;
    StockManagerDataSource: TDataSource;
    BrowseNavPanel: TPanel;
    SearchPanel: TPanel;
    SearchFieldCombo: TComboBox;
    UpdateProductTabSheet: TTabSheet;
    UpdateProductPanel: TPanel;
    BarcodeEdit2: TEdit;
    DescriptionEdit2: TEdit;
    SupplierComboBox2: TComboBox;
    DepartmentComboBox2: TComboBox;
    CostSpinEdit2: TSpinEdit;
    QuantitySpinEdit2: TSpinEdit;
    ApplyUpdateButton: TButton;
    CancelUpdate: TButton;
    PanelSearchUpdate: TPanel;
    BarcodeSearch: TEdit;
    SearchUpdateButton: TButton;
    UpdatePanel: TPanel;
    procedure BackButtonClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure SearchButtonClick(Sender: TObject);
    procedure AddModeButtonClick(Sender: TObject);
    procedure UpdateModeButtonClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure SupplierComboBoxEnter(Sender: TObject);
    procedure DepartmentComboBoxEnter(Sender: TObject);
    procedure SaveButtonClick(Sender: TObject);
    procedure CancelButtonClick(Sender: TObject);
    procedure AddProductTabsheetShow(Sender: TObject);
    procedure UpdateProductTabSheetShow(Sender: TObject);
    procedure SearchUpdateButtonClick(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure DepartmentComboBox2Enter(Sender: TObject);
    procedure SupplierComboBox2Enter(Sender: TObject);
    procedure ApplyUpdateButtonClick(Sender: TObject);
    procedure CancelUpdateClick(Sender: TObject);
    procedure BrowseProductsTabSheetShow(Sender: TObject);
  private
    function  IsDigitsOnly(const S: string): Boolean;
    procedure AutoSizeGridColumns(Grid: TDBGrid; SampleSize: Integer = 100);
    procedure UpdateSupplierCombo;
    procedure UpdateDepartmentCombo;
    procedure UpdateSupplierCombo2;
    procedure UpdateDepartmentCombo2;
    procedure ClearFields;
  public
  end;

var
  ProductManagementForm: TProductManagementForm;

implementation

{$R *.dfm}

uses
  UserDashboardForm_u;

function TProductManagementForm.IsDigitsOnly(const S: string): Boolean;
var
  i: Integer;
begin
  Result := S <> '';
  for i := 1 to Length(S) do
    if not CharInSet(S[i], ['0'..'9']) then
    begin
      Result := False;
      Exit;
    end;
end;

procedure TProductManagementForm.BackButtonClick(Sender: TObject);
begin
  Hide;
  UserDashboardForm.Show;
end;

procedure TProductManagementForm.BrowseProductsTabSheetShow(Sender: TObject);
begin
  StockManagerDataSource.DataSet := StockDataAccess.FetchAllItems;
  AutoSizeGridColumns(ProductDBGrid);
end;

procedure TProductManagementForm.Button2Click(Sender: TObject);
begin
  ProductManagementPageControl.ActivePage := BrowseProductsTabSheet;
  ClearFields;
end;

procedure TProductManagementForm.DepartmentComboBox2Enter(Sender: TObject);
begin
  UpdateDepartmentCombo2;
end;

procedure TProductManagementForm.DepartmentComboBoxEnter(Sender: TObject);
begin
  UpdateDepartmentCombo;
end;

procedure TProductManagementForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  UserDashboardForm.Show;
end;

procedure TProductManagementForm.AddModeButtonClick(Sender: TObject);
begin
  ProductManagementPageControl.ActivePage := AddProductTabsheet;
end;

procedure TProductManagementForm.AddProductTabsheetShow(Sender: TObject);
begin
  ClearFields;
end;

procedure TProductManagementForm.ApplyUpdateButtonClick(Sender: TObject);
const
  MIN_DESC_LEN = 4;
  BARCODE_LEN  = 8;
var
  sBarcode, sDesc, sDept, sSupp: string;
  dCost: Double;
  iQty: Integer;
begin
  sBarcode := Trim(BarcodeEdit2.Text);
  sDesc    := Trim(DescriptionEdit2.Text);
  sDept    := Trim(DepartmentComboBox2.Text);
  sSupp    := Trim(SupplierComboBox2.Text);

  if (Length(sBarcode) <> BARCODE_LEN) or (not IsDigitsOnly(sBarcode)) then
  begin
    ShowMessage(Format('Barcode must be exactly %d digits.', [BARCODE_LEN]));
    BarcodeEdit2.SetFocus;
    Exit;
  end;

  if (sDesc = '') or (Length(sDesc) < MIN_DESC_LEN) then
  begin
    ShowMessage(Format('Description must be at least %d characters.', [MIN_DESC_LEN]));
    DescriptionEdit2.SetFocus;
    Exit;
  end;

  if DepartmentComboBox2.ItemIndex < 0 then
  begin
    ShowMessage('Please select a department.');
    DepartmentComboBox2.SetFocus;
    Exit;
  end;

  if SupplierComboBox2.ItemIndex < 0 then
  begin
    ShowMessage('Please select a supplier.');
    SupplierComboBox2.SetFocus;
    Exit;
  end;

  dCost := CostSpinEdit2.Value;
  if dCost <= 0 then
  begin
    ShowMessage('Cost price must be greater than zero.');
    CostSpinEdit2.SetFocus;
    Exit;
  end;

  iQty := QuantitySpinEdit2.Value;
  if iQty < 0 then
  begin
    ShowMessage('Quantity cannot be negative.');
    QuantitySpinEdit2.SetFocus;
    Exit;
  end;

  if StockDataAccess.UpdateStockItem(sBarcode, sDesc, sDept, sSupp, dCost, iQty) then
  begin
    ShowMessage('Updated successfully.');
    ClearFields;
    ProductManagementPageControl.ActivePage := BrowseProductsTabSheet;
  end
  else
    ShowMessage('Update failed. Please check the data.');
end;

procedure TProductManagementForm.AutoSizeGridColumns(Grid: TDBGrid; SampleSize: Integer);
var
  DS: TDataSet;
  BM: TBookmark;
  Col: TColumn;
  i, Count, MaxW, W: Integer;
  Txt: string;
begin
  DS := Grid.DataSource.DataSet;
  if not Assigned(DS) or (not DS.Active) then Exit;

  Grid.Canvas.Font.Assign(Grid.Font);

  DS.DisableControls;
  try
    BM := DS.GetBookmark;
    try
      for i := 0 to Grid.Columns.Count - 1 do
      begin
        Col := Grid.Columns[i];
        MaxW := Grid.Canvas.TextWidth(Col.Title.Caption);

        DS.First;
        Count := 0;
        while not DS.Eof and (Count < SampleSize) do
        begin
          if Assigned(Col.Field) then
            Txt := Col.Field.DisplayText
          else
            Txt := '';
          W := Grid.Canvas.TextWidth(Txt);
          if W > MaxW then
            MaxW := W;
          Inc(Count);
          DS.Next;
        end;

        Col.Width := MaxW + 16;
      end;

      if DS.BookmarkValid(BM) then
        DS.GotoBookmark(BM);
    finally
      DS.FreeBookmark(BM);
    end;
  finally
    DS.EnableControls;
  end;
end;

procedure TProductManagementForm.FormCreate(Sender: TObject);
begin
  StockManagerDataSource.DataSet := StockDataAccess.FetchAllItems;
  AutoSizeGridColumns(ProductDBGrid);
end;

procedure TProductManagementForm.FormShow(Sender: TObject);
begin
  ProductManagementPageControl.ActivePage := BrowseProductsTabSheet;
end;

procedure TProductManagementForm.SaveButtonClick(Sender: TObject);
const
  MIN_DESC_LEN = 4;
  BARCODE_LEN  = 8;
var
  sBarcode, sDesc, sDept, sSupp: string;
  dCost: Double;
  iQty: Integer;
begin
  sBarcode := Trim(BarcodeEditBox.Text);
  sDesc    := Trim(DescriptionEditBox.Text);
  sDept    := Trim(DepartmentComboBox.Text);
  sSupp    := Trim(SupplierComboBox.Text);

  if (Length(sBarcode) <> BARCODE_LEN) or (not IsDigitsOnly(sBarcode)) then
  begin
    ShowMessage(Format('Barcode must be exactly %d digits.', [BARCODE_LEN]));
    BarcodeEditBox.SetFocus;
    Exit;
  end;

  if (sDesc = '') or (Length(sDesc) < MIN_DESC_LEN) then
  begin
    ShowMessage(Format('Description must be at least %d characters.', [MIN_DESC_LEN]));
    DescriptionEditBox.SetFocus;
    Exit;
  end;

  if DepartmentComboBox.ItemIndex < 0 then
  begin
    ShowMessage('Please select a department.');
    DepartmentComboBox.SetFocus;
    Exit;
  end;

  if SupplierComboBox.ItemIndex < 0 then
  begin
    ShowMessage('Please select a supplier.');
    SupplierComboBox.SetFocus;
    Exit;
  end;

  dCost := CostPriceSpinEdit.Value;
  if dCost <= 0 then
  begin
    ShowMessage('Cost price must be greater than zero.');
    CostPriceSpinEdit.SetFocus;
    Exit;
  end;

  iQty := QuantitySpinEdit.Value;
  if iQty < 0 then
  begin
    ShowMessage('Quantity cannot be negative.');
    QuantitySpinEdit.SetFocus;
    Exit;
  end;

  StockDataAccess.AddStockItem(sBarcode, sDesc, sDept, sSupp, dCost, iQty);
  ShowMessage('Product added successfully.');
  ClearFields;
  ProductManagementPageControl.ActivePage := BrowseProductsTabSheet;
end;

procedure TProductManagementForm.CancelButtonClick(Sender: TObject);
begin
  ClearFields;
  ProductManagementPageControl.ActivePage := BrowseProductsTabSheet;
end;

procedure TProductManagementForm.CancelUpdateClick(Sender: TObject);
begin
  ClearFields;
  ProductManagementPageControl.ActivePage := BrowseProductsTabSheet;
end;

procedure TProductManagementForm.ClearFields;
begin
  BarcodeEditBox.Clear;
  DescriptionEditBox.Clear;
  DepartmentComboBox.Clear;
  SupplierComboBox.Clear;
  CostPriceSpinEdit.Clear;
  QuantitySpinEdit.Clear;

  SearchEditBox.Clear;
  SearchFieldCombo.Clear;

  BarcodeEdit2.Clear;
  DescriptionEdit2.Clear;
  DepartmentComboBox2.Clear;
  SupplierComboBox2.Clear;
  CostSpinEdit2.Clear;
  QuantitySpinEdit2.Clear;
  BarcodeSearch.Clear;
end;

procedure TProductManagementForm.SearchButtonClick(Sender: TObject);
var
  sSearchField, sText: string;
begin
  if SearchFieldCombo.ItemIndex = -1 then
  begin
    ShowMessage('Please select a category to search by!');
    Exit;
  end;

  if Trim(SearchEditBox.Text) = '' then
  begin
    ShowMessage('Please enter text to search by!');
    Exit;
  end;

  sSearchField := SearchFieldCombo.Text;
  sText        := Trim(SearchEditBox.Text);
  StockManagerDataSource.DataSet := StockDataAccess.SearchItems(sSearchField, sText);
  AutoSizeGridColumns(ProductDBGrid);
end;

procedure TProductManagementForm.SearchUpdateButtonClick(Sender: TObject);
const
  BARCODE_LEN = 8;
var
  Data: TArray<string>;
  sBarcode: string;
begin
  sBarcode := Trim(BarcodeSearch.Text);
  if (Length(sBarcode) <> BARCODE_LEN) or (not IsDigitsOnly(sBarcode)) then
  begin
    ShowMessage(Format('Please enter an %d-digit barcode.', [BARCODE_LEN]));
    BarcodeSearch.SetFocus;
    Exit;
  end;

  Data := StockDataAccess.FindProductByBarcode(sBarcode);
  if Length(Data) = 0 then
  begin
    ShowMessage('Product not found.');
    Exit;
  end;

  BarcodeEdit2.Text        := Data[0];
  DepartmentComboBox2.Text := Data[1];
  SupplierComboBox2.Text   := Data[2];
  DescriptionEdit2.Text    := Data[3];
  CostSpinEdit2.Value      := Round(StrTofloat(Data[4]));
  QuantitySpinEdit2.Value  := StrToInt(Data[5]);

  UpdatePanel.Enabled := True;
end;

procedure TProductManagementForm.SupplierComboBox2Enter(Sender: TObject);
begin
  UpdateSupplierCombo2;
end;

procedure TProductManagementForm.SupplierComboBoxEnter(Sender: TObject);
begin
  UpdateSupplierCombo;
end;

procedure TProductManagementForm.UpdateModeButtonClick(Sender: TObject);
begin
  ProductManagementPageControl.ActivePage := UpdateProductTabSheet;
end;

procedure TProductManagementForm.UpdateProductTabSheetShow(Sender: TObject);
begin
  ClearFields;
  UpdatePanel.Enabled := False;
end;

procedure TProductManagementForm.UpdateSupplierCombo;
var
  names: TArray<string>;
  nm: string;
begin
  SupplierComboBox.Items.BeginUpdate;
  try
    SupplierComboBox.Items.Clear;
    names := StockDataAccess.FetchAllSuppliers;
    for nm in names do
      SupplierComboBox.Items.Add(nm);
  finally
    SupplierComboBox.Items.EndUpdate;
  end;
end;

procedure TProductManagementForm.UpdateDepartmentCombo;
var
  names: TArray<string>;
  nm: string;
begin
  DepartmentComboBox.Items.BeginUpdate;
  try
    DepartmentComboBox.Items.Clear;
    names := StockDataAccess.FetchAllDepartments;
    for nm in names do
      DepartmentComboBox.Items.Add(nm);
  finally
    DepartmentComboBox.Items.EndUpdate;
  end;
end;

procedure TProductManagementForm.UpdateSupplierCombo2;
var
  names: TArray<string>;
  nm: string;
begin
  SupplierComboBox2.Items.BeginUpdate;
  try
    SupplierComboBox2.Items.Clear;
    names := StockDataAccess.FetchAllSuppliers;
    for nm in names do
      SupplierComboBox2.Items.Add(nm);
  finally
    SupplierComboBox2.Items.EndUpdate;
  end;
end;

procedure TProductManagementForm.UpdateDepartmentCombo2;
var
  names: TArray<string>;
  nm: string;
begin
  DepartmentComboBox2.Items.BeginUpdate;
  try
    DepartmentComboBox2.Items.Clear;
    names := StockDataAccess.FetchAllDepartments;
    for nm in names do
      DepartmentComboBox2.Items.Add(nm);
  finally
    DepartmentComboBox2.Items.EndUpdate;
  end;
end;

end.

