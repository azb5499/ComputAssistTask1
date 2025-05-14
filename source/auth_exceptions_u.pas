unit auth_exceptions_u;

interface

uses
  System.SysUtils;

type
  EUserNotFound = class(Exception);
  EPasswordMismatch = class(Exception);
  EUserExists     = class(Exception);
  ERoleNotFound   = class(Exception);

implementation

end.

