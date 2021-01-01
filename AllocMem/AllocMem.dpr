program AllocMem;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils;

var
  Total: NativeInt;
  i: Integer;
begin
  Total := 1*1024*1024;
  i := 0;
  try

    while True do begin
      System.AllocMem(Total);
      Inc(i);
    end;

  except
    on E: Exception do begin
      Writeln('Total: ' + FloatToStr((i+1)*Total/1024/1024) + 'MB');
      Writeln(E.ClassName, ': ', E.Message);
    end;
  end;
  Readln;
end.

