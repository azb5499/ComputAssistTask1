unit AddUserForm_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.Mask,user_data_access_u, Vcl.Imaging.jpeg;

type
  TAddUserForm = class(TForm)
    AddUserBackgroundPanel: TPanel;
    CloseBitButton: TBitBtn;
    AddUserInputPanel: TPanel;
    AddUserButton: TButton;
    UsernameLabelEdit: TLabeledEdit;
    PasswordLabelEdit: TLabeledEdit;
    AddUserBackgroundImage: TImage;
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
const
  MIN_LEN = 4;
var
  sUser, sPass: string;
begin
  sUser := Trim(UsernameLabelEdit.Text);
  sPass := Trim(PasswordLabelEdit.Text);


  if sUser = '' then
  begin
    ShowMessage('Please enter a username.');
    UsernameLabelEdit.SetFocus;
    Exit;
  end;

  if sPass = '' then
  begin
    ShowMessage('Please enter a password.');
    PasswordLabelEdit.SetFocus;
    Exit;
  end;

  if Length(sUser) < MIN_LEN then
  begin
    ShowMessage(Format('Username must be at least %d characters long.', [MIN_LEN]));
    UsernameLabelEdit.SetFocus;
    Exit;
  end;

  if Length(sPass) < MIN_LEN then
  begin
    ShowMessage(Format('Password must be at least %d characters long.', [MIN_LEN]));
    PasswordLabelEdit.SetFocus;
    Exit;
  end;


  DataAccess.AddUser(sUser, sPass);

  ShowMessage('New user registered:'#13 +
              '  Username: ' + sUser + #13 +
              '  Password: ' + sPass);

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
