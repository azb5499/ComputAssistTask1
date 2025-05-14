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
  private
    { Private declarations }
    procedure AutoSizeGridColumns(Grid: TDBGrid; SampleSize: Integer = 100);
    procedure UpdateSupplierCombo();
    procedure UpdateDepartmentCombo();
    procedure UpdateSupplierCombo2();
    procedure UpdateDepartmentCombo2();
    procedure ClearFields();

  public
    { Public declarations }
  end;

var
  ProductManagementForm: TProductManagementForm;

implementation

{$R *.dfm}

uses UserDashboardForm_u;

procedure TProductManagementForm.BackButtonClick(Sender: TObject);
begin
  ProductManagementForm.hide;
  UserDashboardForm.show;
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
  UserDashboardForm.show;
end;

procedure TProductManagementForm.AddModeButtonClick(Sender: TObject);
begin
  ProductManagementPageControl.ActivePage := AddProductTabsheet;;
end;

procedure TProductManagementForm.AddProductTabsheetShow(Sender: TObject);
begin
  ClearFields;
end;

procedure TProductManagementForm.ApplyUpdateButtonClick(Sender: TObject);
begin
if StockDataAccess.UpdateStockItem(
     BarcodeEdit2.Text,
     DescriptionEdit2.Text,
     DepartmentComboBox2.Text,
     SupplierComboBox2.Text,
     StrToFloat(CostSpinEdit2.Text),
     StrToInt(QuantitySpinEdit2.Text)
   ) then
  begin
    ShowMessage('Updated successfully');
    ClearFields;
    UpdatePanel.Enabled := false;
  end;

end;

procedure TProductManagementForm.AutoSizeGridColumns(Grid: TDBGrid;
  SampleSize: Integer = 100);
var
  DS: TDataSet;
  BM: TBookmark;
  Col: TColumn;
  i, Count, MaxW, W: Integer;
  Txt: string;
begin

  // Ai generated function for DBGrid resizing

  // make sure we have data
  DS := Grid.DataSource.DataSet;
  if not Assigned(DS) or (not DS.Active) then
    Exit;

  // use the grid’s font for measuring
  Grid.Canvas.Font.Assign(Grid.Font);

  DS.DisableControls;
  try
    BM := DS.GetBookmark;
    try
      // for each visible column…
      for i := 0 to Grid.Columns.Count - 1 do
      begin
        Col := Grid.Columns[i];

        // start with header width
        MaxW := Grid.Canvas.TextWidth(Col.Title.Caption);

        // scan up to SampleSize rows to find the widest cell
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

        // give it a little breathing room
        Col.Width := MaxW + 16;
      end;

      // restore original record
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
var
  sBarcode, sDescription, sDepartmentName, sSupplierName: string;
  dCostPrice: double;
  iQuanitity: Integer;
begin

  sBarcode := BarcodeEditBox.Text;
  sDescription := DescriptionEditBox.Text;
  sDepartmentName := DepartmentComboBox.Text;
  sSupplierName := SupplierComboBox.Text;
  dCostPrice := StrToFloat(CostPriceSpinEdit.Text);
  iQuanitity := StrToInt(QuantitySpinEdit.Text);
  StockDataAccess.AddStockItem(sBarcode, sDescription, sDepartmentName,
    sSupplierName, dCostPrice, iQuanitity);
  ClearFields;

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

  if SearchEditBox.Text = '' then
  begin
    ShowMessage('Please enter text to search by!');
    Exit;
  end;

  sSearchField := SearchFieldCombo.Text;
  sText := SearchEditBox.Text;
  StockManagerDataSource.DataSet := StockDataAccess.SearchItems
    (sSearchField, sText);
  AutoSizeGridColumns(ProductDBGrid);
end;

procedure TProductManagementForm.SearchUpdateButtonClick(Sender: TObject);
var
  Data: TArray<string>;
  sBarcode: string;
begin
  sBarcode := BarcodeSearch.Text;
  if VarIsEmpty(sBarcode) then
  begin
    ShowMessage('Please enter a barcode');
    Exit;
  end;
  Data := StockDataAccess.FindProductByBarcode(sBarcode);
  if Length(Data) = 0 then
  begin
    ShowMessage('Product not found.');
    Exit;
  end;
  // Bind array values to fields
  BarcodeEdit2.Text := Data[0];
  DepartmentComboBox2.Text := Data[1];
  SupplierComboBox2.Text := Data[2];
  DescriptionEdit2.Text := Data[3];
  CostSpinEdit2.Text := Data[4];
  QuantitySpinEdit2.Text := Data[5];
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
  name: string;
begin
  SupplierComboBox.Items.BeginUpdate;
  try
    SupplierComboBox.Items.Clear;
    names := StockDataAccess.FetchAllSuppliers;
    for name in names do
      SupplierComboBox.Items.Add(name);
  finally
    SupplierComboBox.Items.EndUpdate;
  end;
end;

procedure TProductManagementForm.UpdateDepartmentCombo;
var
  names: TArray<string>;
  name: string;
begin
  DepartmentComboBox.Items.BeginUpdate;
  try
    DepartmentComboBox.Items.Clear;
    names := StockDataAccess.FetchAllDepartments;
    for name in names do
      DepartmentComboBox.Items.Add(name);
  finally
    DepartmentComboBox.Items.EndUpdate;
  end;
end;

procedure TProductManagementForm.UpdateSupplierCombo2;
var
  names: TArray<string>;
  name: string;
begin
  SupplierComboBox2.Items.BeginUpdate;
  try
    SupplierComboBox2.Items.Clear;
    names := StockDataAccess.FetchAllSuppliers;
    for name in names do
      SupplierComboBox2.Items.Add(name);
  finally
    SupplierComboBox2.Items.EndUpdate;
  end;
end;

procedure TProductManagementForm.UpdateDepartmentCombo2;
var
  names: TArray<string>;
  name: string;
begin
  DepartmentComboBox2.Items.BeginUpdate;
  try
    DepartmentComboBox2.Items.Clear;
    names := StockDataAccess.FetchAllDepartments;
    for name in names do
      DepartmentComboBox2.Items.Add(name);
  finally
    DepartmentComboBox2.Items.EndUpdate;
  end;
end;

end.
