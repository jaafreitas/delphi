{--------------------------------------}
{                                      }
{   TClientDataSet Performance test    }
{                                      }
{--------------------------------------}

program ClientDataSetPerformance;

{$APPTYPE CONSOLE}

uses
  SysUtils, SQLdb, DB, Memds {, DBClient, Controls, MMSystem};

const
  iConstMax = 100000;

procedure TestClientDataSet(AbLogChanges: Boolean);
var
  i: Integer;
  objClientDataSet: TMemDataset;
  dtTime: TDateTime;
  dtTotalTime: TDateTime;
begin
  objClientDataSet := TMemDataset.Create(nil);
  try
    with objClientDataSet do begin
      // Choose one...
      FieldDefs.Add('COD', ftInteger);
      //FieldDefs.Add('COD', ftString, 10);
      CreateTable;
      Open;

      dtTime := Now;
      dtTotalTime := dtTime;
      for i := 1 to iConstMax do begin
        // Insert is really bad...
        Insert;
        //Append;
        FieldByName('COD').AsInteger := i;
        Post;

        if i mod Trunc(iConstMax / 10) = 0 then begin
          Writeln(Format('%d ms | Records: %d',
            [Trunc((Now - dtTime)*10000000), objClientDataSet.RecordCount]));
          dtTime := Now;
        end;
      end;

      Writeln(Format('Total time: %d ms | Records: %d',
        [Trunc((Now - dtTotalTime)*10000000), objClientDataSet.RecordCount]));
    end;
  finally
    FreeAndNil(objClientDataSet);
  end;
end;

begin
  Writeln(Format('Testing %d appends.', [iConstMax]));
  TestClientDataSet(False);

  Writeln;

  Readln;
end.
