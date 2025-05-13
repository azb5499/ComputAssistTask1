program StockMaintenance_p;

uses
  Vcl.Forms,
  LoginForm_u in 'source\LoginForm_u.pas' {LoginForm},
  user_auth_u in 'source\user_auth_u.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TLoginForm, LoginForm);
  Application.Run;
end.
