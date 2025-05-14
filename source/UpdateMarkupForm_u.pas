unit UpdateMarkupForm_u;

interface

uses
  Winapi.Windows, Winapi.Messages,
  System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls,
  Data.DB, Vcl.Grids, Vcl.DBGrids,
  stock_data_access_u;

type
  TUpdateMarkupForm = class(TForm)
    MarkupPanel: TPanel;
    CloseBitButton: TBitBtn;
    MarkupGrid: TDBGrid;
    MarkupDataSource: TDataSource;
    RefreshButton: TButton;
    MarkupControlsPanel: TPanel;
    Button1: TButton;
    UpdateAllMarkup: TButton;
    UpdateSingleMarkup: TButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure RefreshButtonClick(Sender: TObject);
    procedure UpdateSingleMarkupClick(Sender: TObject);
    procedure UpdateAllMarkupClick(Sender: TObject);
  private
    procedure PopulateDBGrid;
    procedure AutoSizeGridColumns(Grid: TDBGrid; SampleSize: Integer = 100);
  public
  end;

var
  UpdateMarkupForm: TUpdateMarkupForm;

implementation

{$R *.dfm}

uses
  AdminDashboardForm_u;

procedure TUpdateMarkupForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Hide;
  AdminDashboardForm.Show;
end;

procedure TUpdateMarkupForm.FormCreate(Sender: TObject);
begin
  PopulateDBGrid;
  AutoSizeGridColumns(MarkupGrid);
end;

procedure TUpdateMarkupForm.PopulateDBGrid;
begin
  MarkupDataSource.DataSet := StockDataAccess.FetchAllItems;
  AutoSizeGridColumns(MarkupGrid);
end;

procedure TUpdateMarkupForm.RefreshButtonClick(Sender: TObject);
begin
  PopulateDBGrid;
end;

procedure TUpdateMarkupForm.UpdateAllMarkupClick(Sender: TObject);
var
  MarkupStr: string;
  dMarkup: Double;
  dlgRes: Integer;
  DataAccess: TStockDataAccess;
begin
  try

    if not InputQuery('Re-Mark All Products',
      'Enter new markup fraction (e.g. 0.5 for 50%):',
      MarkupStr) then
      Exit;


    try
      dMarkup := StrToFloat(MarkupStr);
    except
      on E: EConvertError do
      begin
        ShowMessage('Invalid input. Please enter a number like 0.5.');
        Exit;
      end;
    end;


    dlgRes := MessageDlg(
      Format('Apply a %.0f%% markup to ALL products?', [dMarkup * 100]),
      mtConfirmation,
      [mbYes, mbNo],
      0
    );
    if dlgRes <> mrYes then
      Exit;


    DataAccess := TStockDataAccess.Create;
    try
      if DataAccess.UpdateAllMarkups(dMarkup) then
        ShowMessage('All products have been re-marked successfully.')
      else
        ShowMessage('No products were updated.');
    finally
      DataAccess.Free;
      PopulateDBGrid;
    end;

  except
    on E: Exception do
      ShowMessageFmt('Error during bulk markup update: %s – %s',
        [E.ClassName, E.Message]);
  end;
end;


procedure TUpdateMarkupForm.UpdateSingleMarkupClick(Sender: TObject);
var
  Barcode, MarkupStr: string;
  dMarkup: Double;
  details: TArray<string>;
  dlgRes: Integer;
  DataAccess: TStockDataAccess;
begin
  try

    if not InputQuery('Update Markup', 'Enter the product barcode:', Barcode) then
      Exit;

    DataAccess := TStockDataAccess.Create;
    try

      details := DataAccess.FindProductByBarcode(Barcode);
      if Length(details) = 0 then
      begin
        ShowMessageFmt('No product found with barcode "%s".', [Barcode]);
        Exit;
      end;


      if not InputQuery('Update Markup',
        'Enter new markup (e.g. 0.5 for 50%):', MarkupStr) then
        Exit;


      try
        dMarkup := StrToFloat(MarkupStr);
      except
        on E: EConvertError do
        begin
          ShowMessage('Invalid markup value. Please enter a number like 0.5 for 50%.');
          Exit;
        end;
      end;

      dlgRes := MessageDlg(
        Format('Apply a %.0f%% markup to barcode %s?', [dMarkup * 100, Barcode]),
        mtConfirmation,
        [mbYes, mbNo],
        0
      );
      if dlgRes <> mrYes then
        Exit;

      if DataAccess.UpdateProductMarkup(Barcode, dMarkup) then
        ShowMessage('Markup updated successfully.')
      else
        ShowMessage('Update failed: no rows affected.');

    finally
      DataAccess.Free;
      PopulateDBGrid;
    end;

  except
    on E: Exception do
      ShowMessageFmt('An error occurred (%s): %s', [E.ClassName, E.Message]);
  end;
end;



procedure TUpdateMarkupForm.AutoSizeGridColumns(Grid: TDBGrid; SampleSize: Integer);
var
  DS: TDataSet;
  BM: TBookmark;
  Col: TColumn;
  i, Count, MaxW, W: Integer;
  Txt: string;
begin
  DS := Grid.DataSource.DataSet;
  if not Assigned(DS) or (not DS.Active) then
    Exit;

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

end.

