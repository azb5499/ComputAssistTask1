unit data_module_u;

interface

uses
  System.SysUtils, System.Classes, Dialogs, System.IOUtils,
  FireDAC.Comp.Client, FireDAC.Comp.Script, FireDAC.Phys.Intf,
  FireDAC.Phys.FB, FireDAC.Phys.FBDef, FireDAC.Phys.IBBase, FireDAC.UI.Intf,
  FireDAC.Stan.Async, FireDAC.Comp.ScriptCommands, FireDAC.Stan.Util,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Phys, FireDAC.VCLUI.Wait, FireDAC.Stan.Param,
  FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet;

type
  TStockManagerDataModule = class(TDataModule)
    StockManagerFDConnection: TFDConnection;
    StockManagerScript: TFDScript;
    StockManagerQuery: TFDQuery;
    StockManagerFBDriverLink: TFDPhysFBDriverLink;
    procedure DataModuleCreate(Sender: TObject);
  private
    procedure InitializeDatabase;
    function GetDatabasePath: string;
    function GetScriptPath: string;
  public
    { Public declarations }
  end;

var
  StockManagerDataModule: TStockManagerDataModule;

implementation

uses user_data_access_u,stock_data_access_u;
{%CLASSGROUP 'Vcl.Controls.TControl'}
{$R *.dfm}

procedure TStockManagerDataModule.DataModuleCreate(Sender: TObject);
begin
  InitializeDatabase;
end;

function TStockManagerDataModule.GetDatabasePath: string;
begin
  Result := TPath.GetFullPath('../../database/System.fdb');
end;

function TStockManagerDataModule.GetScriptPath: string;
begin
  Result := TPath.GetFullPath('../../database/initialise/initialise.sql');
end;

procedure TStockManagerDataModule.InitializeDatabase;
var
  ScriptPath: string;
begin
  ScriptPath := GetScriptPath();

  if not FileExists(ScriptPath) then
  begin
    ShowMessage('Initialization SQL script not found: ' + ScriptPath);
    Exit;
  end;

  StockManagerFDConnection.Connected := False;
  StockManagerFDConnection.Params.Clear;
  StockManagerFDConnection.Params.DriverID := 'FB';
  StockManagerFDConnection.Params.Database := GetDatabasePath;
  StockManagerFDConnection.Params.UserName := 'sysdba';
  StockManagerFDConnection.Params.Password := 'masterkey';
  StockManagerFDConnection.Params.Values['Server'] := 'localhost';
  StockManagerFDConnection.Params.Values['Protocol'] := 'TCPIP';

  if not FileExists(GetDatabasePath) then
  begin
    StockManagerFDConnection.Params.Values['CreateDatabase'] := 'Yes';
    StockManagerFDConnection.Connected := True;

    StockManagerScript.Connection := StockManagerFDConnection;
    StockManagerScript.SQLScripts.Clear;
    StockManagerScript.SQLScripts.Add;
    StockManagerScript.SQLScripts[0].SQL.LoadFromFile(ScriptPath);
    StockManagerScript.ExecuteAll;

    DataAccess.AddAdmin('admin','admin');
    DataAccess.AddUser('staff','staffLogin');

    StockDataAccess.AddDepartment('General');
    StockDataAccess.AddSupplier('SuperU','Sales','0845546698','superu@gmail.com');

    StockDataAccess.AddStockItem('0021445','Fruity Lick','General','SuperU',56.99,100);
    ShowMessage('Database created and initialized.');
    ShowMessage('Your default Admin credentials are: Username > admin / Password > admin ')
  end
  else
  begin
    StockManagerFDConnection.Params.Values['CreateDatabase'] := 'No';
    StockManagerFDConnection.Connected := True;
    ShowMessage('Database exists. Connected.');
  end;
end;

end.

