unit MySQLDM;

interface

uses
  SysUtils, Classes, DBXpress, FMTBcd, DB, DBClient, Provider, SqlExpr;

type
  TDMmySQL = class(TDataModule)
    sconnMySQL: TSQLConnection;
    sdsMySQL: TSQLDataSet;
    dspMySQL: TDataSetProvider;
    cdsMySQL: TClientDataSet;
    dsMySQL: TDataSource;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DMmySQL: TDMmySQL;

implementation

{$R *.dfm}

end.
