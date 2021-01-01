program Project1;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils;

function MapFunc: TFunc<String, Integer>;
begin
  Result :=
    function(AsValue: String): Integer
    begin
      Result := Length(AsValue);
    end;
end;

procedure PrintMe(AsValue: String; AfncBla: TFunc<String, Integer>);
var
  iValue: Integer;
begin
  iValue := AfncBla(AsValue);
  Writeln(AsValue + ' -> ' + IntToStr(iValue));
end;

begin
  try
    PrintMe('xxx', MapFunc());
    PrintMe('asdlfkjasdlkfaskjdlfjk', MapFunc());
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.
