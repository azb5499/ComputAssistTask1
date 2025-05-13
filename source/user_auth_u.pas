unit user_auth_u;

interface

uses System.SysUtils,System.classes;

Type
TUserAuth = class
  public
  function AuthenticateUser(const sUsername,sPassword : string): Boolean;
  private
end;

implementation

function TUserAuth.AuthenticateUser(const sUsername,sPassword:string): Boolean;
begin

Result := True;
end;
end.
