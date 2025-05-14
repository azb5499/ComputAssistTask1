unit user_data_access_u;

interface

uses
  System.SysUtils, System.Classes, Data.DB, FireDAC.Comp.Client, user_u,
  data_module_u, System.Hash, auth_exceptions_u;

type
  TUserDataAccess = class
  private
    function CreateUser(const sUsername, sPassword, sRoleName: string): Boolean;
  public
    function GetUserByUsername(const sUsername: string): TUser;
    function AddUser(const sUsername, sPassword: string): Boolean;
    function AddAdmin(const sUsername, sPassword: string): Boolean;
  end;

var
  DataAccess: TUserDataAccess;

implementation

function TUserDataAccess.GetUserByUsername(const sUsername: string): TUser;
var
  objUser: TUser;
  qry: TFDQuery;
begin
  if not Assigned(StockManagerDataModule) then
    raise Exception.Create('StockManagerDataModule is not initialized.');

  if not Assigned(StockManagerDataModule.StockManagerQuery) then
    raise Exception.Create('StockManagerQuery is not initialized.');

  qry := StockManagerDataModule.StockManagerQuery;

  qry.Close;
  qry.SQL.Text := 'SELECT u.Username, u.Password, r.UserRoleName ' +
    'FROM Users u ' + 'LEFT JOIN Role r ON u.UserRoleID = r.UserRoleID ' +
    'WHERE u.Username = :Username';
  qry.ParamByName('Username').AsString := sUsername;
  qry.Open;

  if not qry.Eof then
  begin
    objUser := TUser.Create;
    objUser.Username := qry.FieldByName('Username').AsString;
    objUser.Password := qry.FieldByName('Password').AsString;
    objUser.UserRole := qry.FieldByName('UserRoleName').AsString;
  end
  else
    objUser := nil;

  Result := objUser;
end;

function TUserDataAccess.CreateUser(
  const sUsername, sPassword, sRoleName: string
): Boolean;
var
  qry       : TFDQuery;
  iRoleID   : Integer;
  sHashedPwd: string;
begin
  qry := TFDQuery.Create(nil);
  try
    qry.Connection := StockManagerDataModule.StockManagerFDConnection;

    // 1) Clear out any leftover script transaction
    if qry.Connection.InTransaction then
      qry.Connection.Commit;

    // 2) Start ours
    qry.Connection.StartTransaction;

    // 3) Lookup RoleID
    qry.SQL.Text := 'SELECT UserRoleID FROM Role WHERE UserRoleName = :RoleName';
    qry.ParamByName('RoleName').AsString := sRoleName;
    qry.Open;
    if qry.Eof then
      raise ERoleNotFound.CreateFmt('Role "%s" does not exist.', [sRoleName]);
    iRoleID := qry.Fields[0].AsInteger;
    qry.Close;

    // 4) Check username
    qry.SQL.Text := 'SELECT 1 FROM Users WHERE Username = :Username';
    qry.ParamByName('Username').AsString := sUsername;
    qry.Open;
    if not qry.Eof then
      raise EUserExists.CreateFmt('User "%s" already exists.', [sUsername]);
    qry.Close;

    // 5) Insert
    sHashedPwd := THashSHA2.GetHashString(sPassword);
    qry.SQL.Text :=
      'INSERT INTO Users (Username, Password, UserRoleID) ' +
      'VALUES (:Username, :Password, :RoleID)';
    qry.ParamByName('Username').AsString := sUsername;
    qry.ParamByName('Password').AsString := sHashedPwd;
    qry.ParamByName('RoleID').AsInteger := iRoleID;
    qry.ExecSQL;

    // 6) Commit once
    qry.Connection.Commit;

    Result := True;
  finally
    qry.Free;
  end;
end;





function TUserDataAccess.AddUser(const sUsername, sPassword: string): Boolean;
begin
  Result := CreateUser(sUsername, sPassword, 'user');
end;

function TUserDataAccess.AddAdmin(const sUsername, sPassword: string): Boolean;
begin
  Result := CreateUser(sUsername, sPassword, 'admin');
end;

initialization

DataAccess := TUserDataAccess.Create();

finalization

FreeAndNil(DataAccess);

end.
