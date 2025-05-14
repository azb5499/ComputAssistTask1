unit user_data_access_u;

interface

uses
  System.SysUtils, System.Classes, Data.DB, FireDAC.Comp.Client, user_u,
  data_module_u;

type
  TUserDataAccess = class
  public
    function GetUserByUsername(const sUsername: string): TUser;
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
  qry.SQL.Text :=
    'SELECT u.Username, u.Password, r.UserRoleName ' +
    'FROM Users u ' +
    'LEFT JOIN Role r ON u.UserRoleID = r.UserRoleID ' +
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


initialization

DataAccess := TUserDataAccess.Create();

finalization

FreeAndNil(DataAccess);

end.
