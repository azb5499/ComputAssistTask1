unit ProductManagement_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,stock_data_access_u,
  Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TProductManagementForm = class(TForm)
    BackButton: TButton;
    ProductManagementPanel: TPanel;
    procedure BackButtonClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
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

end.
