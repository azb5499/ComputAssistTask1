unit user_u;

interface

type
TUser = class
private
FUsername: string;
FPassword: string;
FUserRole: string;
public
property Username: string read FUsername write FUsername;
property Password: string read FPassword write FPassword;
property UserRole: string read FUserRole write FUserRole;
end;

implementation

end.
