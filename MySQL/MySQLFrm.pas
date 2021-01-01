unit MySQLFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, DBCtrls, Grids, DBGrids, StdCtrls;

type
  TfrmMySQL = class(TForm)
    DBGrid1: TDBGrid;
    Panel1: TPanel;
    DBNavigator1: TDBNavigator;
    Button1: TButton;
    Button2: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMySQL: TfrmMySQL;

implementation

uses MySQLDM;

{$R *.dfm}

procedure TfrmMySQL.Button1Click(Sender: TObject);
begin
  if DMmySQL.cdsMySQL.Active = False then
    DMmySQL.cdsMySQL.Active := True;
end;

procedure TfrmMySQL.Button2Click(Sender: TObject);
begin
  if DMmySQL.cdsMySQL.Active = True then
    DMmySQL.cdsMySQL.Active := False;
end;

end.
