unit LoginForm_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Mask;

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
sPassword, sUserName : string;
begin
sUserName := UsernameLabelEdit.Text;
sPassword := PasswordLabelEdit.text;
if (sUserName = 'John') and (sPassword = '1234') then
begin
ShowMessage('proceed');
end;
end;

end.
