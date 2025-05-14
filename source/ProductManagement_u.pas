unit ProductManagement_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,stock_data_access_u,
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
    UpdateProductsPanel: TPanel;
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
    procedure BackButtonClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure SearchButtonClick(Sender: TObject);
  private
    { Private declarations }
    procedure AutoSizeGridColumns(Grid: TDBGrid; SampleSize: Integer = 100);
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

procedure TProductManagementForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
UserDashboardForm.show;
end;

procedure TProductManagementForm.AutoSizeGridColumns(Grid: TDBGrid; SampleSize: Integer = 100);
var
  DS: TDataSet;
  BM: TBookmark;
  Col: TColumn;
  i, Count, MaxW, W: Integer;
  Txt: string;
begin

  //Ai generated function for DBGrid resizing

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

procedure TProductManagementForm.SearchButtonClick(Sender: TObject);
var
sSearchField, sText:string;
begin
if SearchFieldCombo.ItemIndex = -1 then
begin
  ShowMessage('Please select a category to search by!');
  exit;
end;

if SearchEditBox.Text = '' then
begin
  ShowMessage('Please enter text to search by!');
  exit;
end;

sSearchField := SearchFieldCombo.Text;
sText := SearchEditBox.Text;
StockManagerDataSource.DataSet := StockDataAccess.SearchItems(sSearchField,sText);
AutoSizeGridColumns(ProductDBGrid);
end;

end.
