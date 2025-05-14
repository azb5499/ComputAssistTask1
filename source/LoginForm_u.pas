unit LoginForm_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Mask,
  user_auth_u, user_u, System.Hash;

type
  TLoginForm = class(TForm)
    LoginLayoutGridPanel: TGridPanel;
    Image1: TImage;
    CentralLoginGridPanel: TGridPanel;
    LeftPanel: TPanel;
    CentrePanel: TPanel;
    RightPanel: TPanel;
    FooterPanel: TPanel;
    LoginButton: TButton;
    UsernameLabelEdit: TLabeledEdit;
    PasswordLabelEdit: TLabeledEdit;
    procedure LoginButtonClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  LoginForm: TLoginForm;

implementation

{$R *.dfm}

procedure TLoginForm.LoginButtonClick(Sender: TObject);
var
  sUserName, sPassword: string;
  objUserAuth: TUserAuth;
  objUser: TUser;
begin
  sUserName := UsernameLabelEdit.Text;
  sPassword := PasswordLabelEdit.Text;

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
    else if objUser.UserRole = 'user' then
      // …show user UI…

  finally
    objUserAuth.Free;
    objUser.Free;  // safe: either nil or a valid object
  end;
end;




end.
