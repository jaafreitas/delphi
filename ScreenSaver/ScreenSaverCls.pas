unit ScreenSaverCls;

interface

uses
  Vcl.Forms;

procedure CriaConfig;
procedure CriaScreen;

var
  frmConfig: TForm;
  frmScreen: TForm;

implementation

uses
  ConfigFrm, ScreenFrm;

procedure CriaConfig;
begin
  Application.CreateForm(TConfigFrm, frmConfig);
end;

procedure CriaScreen;
begin
  Application.CreateForm(TScreenFrm, frmScreen);
end;

end.

