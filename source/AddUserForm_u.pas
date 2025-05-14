unit AddUserForm_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.Mask,user_data_access_u;

type
  TAddUserForm = class(TForm)
    AddUserBackgroundPanel: TPanel;
    CloseBitButton: TBitBtn;
    AddUserInputPanel: TPanel;
    AddUserButton: TButton;
    UsernameLabelEdit: TLabeledEdit;
    PasswordLabelEdit: TLabeledEdit;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure AddUserButtonClick(Sender: TObject);
  private
    { Private declarations }
    procedure ClearFields();
  public
    { Public declarations }
  end;

var
  AddUserForm: TAddUserForm;

implementation

{$R *.dfm}

uses AdminDashboardForm_u;

procedure TAddUserForm.AddUserButtonClick(Sender: TObject);
begin
if UsernameLabelEdit.Text = '' then
begin
  ShowMessage('Enter Username');
  exit;
end;

if PasswordLabelEdit.Text = '' then
begin
  ShowMessage('Enter Password');
  Exit;
end;


DataAccess.AddUser(UsernameLabelEdit.Text,PasswordLabelEdit.Text);

ShowMessage('New user registered.');
ShowMessage('Username: '+UsernameLabelEdit.Text+'. Password: '+PasswordLabelEdit.Text+'.');

ClearFields;
end;

procedure TAddUserForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
ClearFields;
AddUserForm.hide;
AdminDashboardForm.show;
end;

procedure TAddUserForm.ClearFields();
begin
  UsernameLabelEdit.clear;
  PasswordLabelEdit.clear;
end;

end.
