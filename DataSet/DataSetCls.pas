unit DataSetCls;

interface

uses
  DB, DBClient;

type
  IDataSet = interface
    ['{B236634F-D317-403C-AEC4-558282164480}']
    function Next: Boolean;
    function RecordCount: Integer;
    function Fields: TFields;
    function FieldByName(const FieldName: string): TField;

    function Where(AsFilter: string): IDataSet;
    function GroupBy(AsIndex: string): IDataSet;
    function OrderBy(AsIndex: string): IDataSet;
    function Select(AsCampos: array of string): IDataSet;
  end;

  TDataSetIterator = class(TInterfacedObject, IDataSet)
  private
    FDataSet: TClientDataSet;
    FNextWasCalled: Boolean;

  public
    constructor Create(AobjDataSet: TClientDataSet);

    function Next: Boolean;
    function RecordCount: Integer;
    function Fields: TFields;
    function FieldByName(const FieldName: string): TField;

    function Where(AsFilter: string): IDataSet;
    function OrderBy(AsIndex: string): IDataSet;
    function GroupBy(AsIndex: string): IDataSet;
    function Select(AsCampos: array of string): IDataSet;
  end;

  function Iterator(const AobjDataSet: TClientDataSet): IDataSet;

implementation

function Iterator(const AobjDataSet: TClientDataSet): IDataSet;
begin
  Result := TDataSetIterator.Create(AobjDataSet);
end;

{ TDataSetIterator }

constructor TDataSetIterator.Create(AobjDataSet: TClientDataSet);
begin
  FDataSet := AobjDataSet;
  FDataSet.First;
  FDataSet.DisableControls;
  FNextWasCalled := False;
end;

function TDataSetIterator.FieldByName(const FieldName: string): TField;
begin
  Result := FDataSet.FieldByName(FieldName);
end;

function TDataSetIterator.Fields: TFields;
begin
  Result := FDataSet.Fields;
end;

function TDataSetIterator.GroupBy(AsIndex: string): IDataSet;
begin
  Result := Self;
  with FDataSet do begin
    First;
  end;
end;

function TDataSetIterator.Next: Boolean;
begin
  { O DataSet j� se encontra posicionado no primeiro   }
  { registro no momento da primeira chamada a Next,    }
  { ent�o para que o m�todo possa corretamente         }
  { executar as suas duas terefas, isto �, mover para  }
  { o pr�ximo registro e informar se existe algum      }
  { registro al�m daquele, � preciso que a primeira    }
  { chamada a next n�o mova para o pr�ximo registro    }
  if FNextWasCalled then begin
    FDataSet.Next;
  end;
  FNextWasCalled := True;
  Result := not FDataSet.Eof;
end;

function TDataSetIterator.OrderBy(AsIndex: string): IDataSet;
begin
  Result := Self;
  with FDataSet do begin
    First;
    IndexFieldNames := AsIndex;
  end;
end;

function TDataSetIterator.RecordCount: Integer;
begin
  Result := FDataSet.RecordCount;
end;

function TDataSetIterator.Select(AsCampos: array of string): IDataSet;
begin
  Result := Self;
  with FDataSet do begin
    First;
  end;
end;

function TDataSetIterator.Where(AsFilter: string): IDataSet;
begin
  Result := Self;
  with FDataSet do begin
    First;
    Filter := AsFilter;
    Filtered := True;
  end;
end;

end.
