program ScreenSaver;

uses
  Vcl.Forms,
  Winapi.Windows,
  System.SysUtils,
  ScreenSaverCls in 'ScreenSaverCls.pas',
  ScreenFrm in 'ScreenFrm.pas' {Form1},
  ConfigFrm in 'ConfigFrm.pas' {frmConfig};

var
  objMutex: THandle;

begin

  objMutex := CreateMutex(nil, True, '{B92378D3-80F4-4175-92F1-87BDE039B09C}');
  if (objMutex = 0) or (GetLastError = ERROR_ALREADY_EXISTS) then begin
    Application.Terminate;
  end
  else begin
    Application.Initialize;
    Application.MainFormOnTaskbar := False;

    try
      if (ParamCount > 0) and FindCmdLineSwitch('s', True) then begin
        CriaScreen;
        CriaConfig;
      end
      else begin
        CriaConfig;
        CriaScreen;
      end;

      Application.Run;
    finally
      if objMutex <> 0 then begin
        CloseHandle(objMutex);
      end;
    end;
  end;
end.

