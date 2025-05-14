unit UserDashboardForm_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,ProductManagement_u,
  Vcl.ExtCtrls;

type
  TUserDashboardForm = class(TForm)
    BackButton: TButton;
    ProductManagementButton: TButton;
    UserDashboardPanel: TPanel;
    procedure BackButtonClick(Sender: TObject);
    procedure ProductManagementButtonClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  UserDashboardForm: TUserDashboardForm;

implementation

{$R *.dfm}

uses LoginForm_u;

procedure TUserDashboardForm.BackButtonClick(Sender: TObject);
begin
UserDashboardForm.Hide;
LoginForm.show;
end;

procedure TUserDashboardForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
LoginForm.show;
end;

procedure TUserDashboardForm.ProductManagementButtonClick(Sender: TObject);
begin
UserDashboardForm.hide;
ProductManagementForm.show;
end;

end.
