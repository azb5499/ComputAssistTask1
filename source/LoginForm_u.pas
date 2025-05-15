unit LoginForm_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Mask,
  user_auth_u, user_u, System.Hash,AdminDashboardForm_u, Vcl.Imaging.jpeg;

type
  TLoginForm = class(TForm)
    LoginLayoutGridPanel: TGridPanel;
    BannerImage: TImage;
    CentralLoginGridPanel: TGridPanel;
    LeftPanel: TPanel;
    CentrePanel: TPanel;
    RightPanel: TPanel;
    FooterPanel: TPanel;
    LoginButton: TButton;
    UsernameLabelEdit: TLabeledEdit;
    PasswordLabelEdit: TLabeledEdit;
    procedure LoginButtonClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  LoginForm: TLoginForm;

implementation

{$R *.dfm}

uses UserDashboardForm_u;

procedure TLoginForm.FormShow(Sender: TObject);
begin
UsernameLabelEdit.Clear;
PasswordLabelEdit.clear;
end;

procedure TLoginForm.LoginButtonClick(Sender: TObject);
var
  sUserName, sPassword: string;
  objUserAuth: TUserAuth;
  objUser: TUser;
begin
  sUserName := UsernameLabelEdit.Text;
  sPassword := PasswordLabelEdit.Text;

  if sUserName = '' then
  begin
    ShowMessage('Please enter a username!');
    exit;
  end;

  if sPassword = '' then
  begin
    ShowMessage('Please enter a password!');
    exit;
  end;

  objUserAuth := TUserAuth.Create;
  objUser := nil;

  try
    try

      objUser := objUserAuth.AuthenticateUser(sUserName, sPassword);
    except
      on E: Exception do
      begin

        ShowMessage(E.Message);
        Exit;
      end;
    end;


    if objUser.UserRole = 'admin' then
      // …show admin UI…
      begin
         ShowMessage('welcome admin');
         LoginForm.hide;
         AdminDashboardForm.show;
      end
    else if objUser.UserRole = 'user' then
      // …show user UI…
      begin
         ShowMessage('welcome user');
         LoginForm.hide;
         UserDashboardForm.show;
      end;


  finally
    objUserAuth.Free;
    objUser.Free;  // safe: either nil or a valid object
  end;
end;




end.
