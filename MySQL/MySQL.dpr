program MySQL;

uses
  Forms,
  MySQLFrm in 'MySQLFrm.pas' {frmMySQL},
  MySQLDM in 'MySQLDM.pas' {DMmySQL: TDataModule},
  Main in 'Main.pas' {frmMain};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TDMmySQL, DMmySQL);
  Application.CreateForm(TfrmMySQL, frmMySQL);
  Application.Run;
end.
