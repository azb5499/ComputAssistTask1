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
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure RefreshButtonClick(Sender: TObject);
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

