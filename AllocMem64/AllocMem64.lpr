program AllocMem64;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Classes, SysUtils, CustApp,
  Memds;

type

  { TTeste }

  TTeste = class(TCustomApplication)
  protected
    procedure DoRun; override;
  public
    constructor Create(TheOwner: TComponent); override;
    destructor Destroy; override;
    procedure WriteHelp; virtual;
  end;

{ TTeste }

procedure TTeste.DoRun;
var
  ErrorMsg: String;
  i: Integer;
  objClientDataSet: TMemDataset;
begin
  // quick check parameters
  ErrorMsg:=CheckOptions('h','help');
  if ErrorMsg<>'' then begin
    ShowException(Exception.Create(ErrorMsg));
    Terminate;
    Exit;
  end;

  // parse parameters
  if HasOption('h','help') then begin
    WriteHelp;
    Terminate;
    Exit;
  end;

  //AllocMem(7*1024*1024*1024);

  for i := 0 to Trunc(4e6) do begin
    objClientDataSet := TMemDataset.Create(nil);
  end;

  Readln;

  // stop program loop
  Terminate;
end;

constructor TTeste.Create(TheOwner: TComponent);
begin
  inherited Create(TheOwner);
  StopOnException:=True;
end;

destructor TTeste.Destroy;
begin
  inherited Destroy;
end;

procedure TTeste.WriteHelp;
begin
  { add your help code here }
  writeln('Usage: ',ExeName,' -h');
end;

var
  Application: TTeste;

{$IFDEF WINDOWS}{$R AllocMem64.rc}{$ENDIF}

begin
  Application:=TTeste.Create(nil);
  Application.Title:='Teste';
  Application.Run;
  Application.Free;
end.

