unit user_auth_u;

interface

uses
  System.SysUtils, System.Classes, System.Hash, user_u, user_data_access_u,
  auth_exceptions_u;

type
  TUserAuth = class
  public
    function AuthenticateUser(const AUsername, APassword: string): TUser;
  end;

implementation

function TUserAuth.AuthenticateUser(const AUsername, APassword: string): TUser;
var
  RetrievedUser: TUser;
  HashedInputPassword: string;
begin
  // Assume input is validated elsewhere

  RetrievedUser := DataAccess.GetUserByUsername(AUsername);
  if not Assigned(RetrievedUser) then
    raise EUserNotFound.CreateFmt('User "%s" not found.', [AUsername]);

  try
    HashedInputPassword := THashSHA2.GetHashString(APassword);

    if RetrievedUser.Password <> HashedInputPassword then
      raise EPasswordMismatch.Create('Password is incorrect.');

    // Authentication successful
    Result := RetrievedUser;

  except
    RetrievedUser.Free;
    raise;
  end;
end;

end.
