unit AdminDashboardForm_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Buttons,
  ppComm, ppRelatv, ppProd, ppClass, ppReport,ReportDataModule_u;

type
  TAdminDashboardForm = class(TForm)
    AdminDahsboardBackgroundPanel: TPanel;
    AddUserButton: TButton;
    UpdateMarkupButton: TButton;
    CloseBitButton: TBitBtn;
    TotalStockValueReport: TButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure AddUserButtonClick(Sender: TObject);
    procedure UpdateMarkupButtonClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure TotalStockValueReportClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  AdminDashboardForm: TAdminDashboardForm;

implementation

{$R *.dfm}

uses LoginForm_u, AddUserForm_u, UpdateMarkupForm_u;

procedure TAdminDashboardForm.AddUserButtonClick(Sender: TObject);
begin
AdminDashboardForm.hide;
AddUserForm.show;
end;

procedure TAdminDashboardForm.Button1Click(Sender: TObject);
begin
ReportDataModule.ppReport1.Print;
end;

procedure TAdminDashboardForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
AdminDashboardForm.hide;
LoginForm.show;

end;

procedure TAdminDashboardForm.TotalStockValueReportClick(Sender: TObject);
begin
ReportDataModule.GetReport();
end;

procedure TAdminDashboardForm.UpdateMarkupButtonClick(Sender: TObject);
begin
AdminDashboardForm.hide;
UpdateMarkupForm.show;
end;

end.
