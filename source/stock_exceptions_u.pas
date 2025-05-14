unit stock_exceptions_u;

interface
uses System.SysUtils;
type
  EDepartmentExists = class(Exception);
  ESupplierExists = class(Exception);
  EDepartmentNotFound = class(Exception);
  ESupplierNotFound = class(Exception);
  EStockItemExists = class(Exception);
  EStockItemNotFound = class(Exception);
implementation

end.
