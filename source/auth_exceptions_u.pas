unit auth_exceptions_u;

interface

uses
  System.SysUtils;

type
  EUserNotFound = class(Exception);
  EPasswordMismatch = class(Exception);

implementation

end.

