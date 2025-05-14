program StockMaintenance_p;

uses
  Vcl.Forms,
  LoginForm_u in 'source\LoginForm_u.pas' {LoginForm},
  user_auth_u in 'source\user_auth_u.pas',
  user_u in 'source\user_u.pas',
  auth_exceptions_u in 'source\auth_exceptions_u.pas',
  user_data_access_u in 'source\user_data_access_u.pas',
  data_module_u in 'source\data_module_u.pas' {StockManagerDataModule: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TLoginForm, LoginForm);
  Application.CreateForm(TStockManagerDataModule, StockManagerDataModule);
  Application.Run;
end.
