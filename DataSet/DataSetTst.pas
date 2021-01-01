unit DataSetTst;

interface

uses
  TestFramework, DB, DataSetCls, DBClient;

type
  TestIDataSet = class(TTestCase)
  strict private
    FDataSet: TClientDataSet;
    FIDataSet: IDataSet;

    function CriaDataSet: TClientDataSet;

  public
    procedure SetUp; override;
    procedure TearDown; override;

  published
    procedure TestNext;
  end;

implementation

uses
  SysUtils;

function TestIDataSet.CriaDataSet: TClientDataSet;
begin
  Result :=  TClientDataSet.Create(nil);
  try
    with Result do begin
      with FieldDefs do begin
        Add('COD_OPER', ftInteger);
        Add('PRODUTO', ftString, 10);
      end;
      CreateDataSet;
      InsertRecord([1, 'b']);
      InsertRecord([2, 'b']);
      InsertRecord([3, 'b']);
      InsertRecord([4, 'b']);
      InsertRecord([5, 'b']);
      InsertRecord([6, 'a']);
    end;
  except
    FreeAndNil(Result);
    raise;
  end;
end;

procedure TestIDataSet.SetUp;
begin
  inherited;

  FDataSet := CriaDataSet;
  FIDataSet := Iterator(FDataSet);
end;

procedure TestIDataSet.TearDown;
begin
  FreeAndNil(FDataSet);
  FIDataSet := nil;

  inherited;
end;

procedure TestIDataSet.TestNext;
var
  i: Integer;
  iobjDataSet: IDataSet;
begin
  i := 1;
  while FIDataSet.Next do begin
    CheckEquals(i, FIDataSet.FieldByName('COD_OPER').AsInteger);
    Inc(i);
  end;

  iobjDataSet := FIDataSet
    .Where('COD_OPER > 3')
    .GroupBy('PRODUTO')
    .OrderBy('PRODUTO;COD_OPER')
    .Select(['COD_OPER', 'PRODUTO']);

  CheckEquals(3, iobjDataSet.RecordCount);
  CheckEquals(6, iobjDataSet.FieldByName('COD_OPER').AsInteger);
  CheckEquals('a', iobjDataSet.FieldByName('PRODUTO').AsString);  
end;

initialization
  RegisterTest(TestIDataSet.Suite);
end.

