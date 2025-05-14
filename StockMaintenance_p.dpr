program StockMaintenance_p;

uses
  Vcl.Forms,
  LoginForm_u in 'source\LoginForm_u.pas' {LoginForm},
  user_auth_u in 'source\user_auth_u.pas',
  user_u in 'source\user_u.pas',
  auth_exceptions_u in 'source\auth_exceptions_u.pas',
  user_data_access_u in 'source\user_data_access_u.pas',
  data_module_u in 'source\data_module_u.pas' {StockManagerDataModule: TDataModule},
  stock_data_access_u in 'source\stock_data_access_u.pas',
  stock_exceptions_u in 'source\stock_exceptions_u.pas',
  ProductManagement_u in 'source\ProductManagement_u.pas' {ProductManagementForm},
  UserDashboardForm_u in 'source\UserDashboardForm_u.pas' {UserDashboardForm},
  AdminDashboardForm_u in 'source\AdminDashboardForm_u.pas' {AdminDashboardForm},
  AddUserForm_u in 'source\AddUserForm_u.pas' {AddUserForm},
  UpdateMarkupForm_u in 'source\UpdateMarkupForm_u.pas' {UpdateMarkupForm},
  ReportDataModule_u in 'source\ReportDataModule_u.pas' {ReportDataModule: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
Application.CreateForm(TStockManagerDataModule, StockManagerDataModule);
  Application.CreateForm(TLoginForm, LoginForm);
  Application.CreateForm(TProductManagementForm, ProductManagementForm);
  Application.CreateForm(TUserDashboardForm, UserDashboardForm);
  Application.CreateForm(TAdminDashboardForm, AdminDashboardForm);
  Application.CreateForm(TAddUserForm, AddUserForm);
  Application.CreateForm(TUpdateMarkupForm, UpdateMarkupForm);
  Application.CreateForm(TReportDataModule, ReportDataModule);
  Application.Run;
end.
