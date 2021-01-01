{
*** Arquivo testes.csv ***

PETR4;1000,15001234;01/01/2008
BBAS3;5000,20000001;01/01/2008
PETR4;2000,40000001;01/01/2008
PETR4;1000,15001234;02/01/2008
BBAS3;5000,20000001;02/01/2008
PETR4;2000,40000001;02/01/2008

TODO: Lista das colunas que serão somadas.

}

program Processador;

{$APPTYPE CONSOLE}

uses
  SysUtils, DBClient, Windows, DB, Classes, Vcl.Controls, Math, StrUtils;

function StringToOem(AsTexto: String): AnsiString;
var
  sConversao: String;
begin
  SetLength(sConversao, Length(AsTexto));
  if Length(sConversao) > 0 then begin
    CharToOem(PChar(AsTexto), PAnsiChar(sConversao));
  end;
  Result := sConversao;
end;

procedure Visualiza(ADataSet: TDataSet);
var
  sString: String;
  i: Integer;
begin
  with ADataSet do begin
    First;
    while not Eof do begin
      sString := Format('%d:', [RecNo]);
      for i := 0 to FieldCount - 1 do begin
        sString := Format('%s | %s', [sString, Fields[i].AsString]);
      end;
      Writeln(sString);
      Next;
    end;
  end;
end;

function LoadFromCSV(AsNome: String): TClientDataSet;
var
  objString: TStringList;
  objAuxString: TStringList;
  i, j: Integer;
  dValor: Double;
  dtData: TDateTime;
  eFieldType: TFieldType;
  iFieldSize: Integer;
begin
  Result := TClientDataSet.Create(nil);
  try
    objString := nil;
    objAuxString := nil;
    try
      objString := TStringList.Create;
      // Neste momento, vamos ter o arquivo inteiro em memória... O que não é nada bom.
      objString.LoadFromFile(AsNome);

      // Objeto auxiliar para quebrar os campos de uma linha.
      objAuxString := TStringList.Create;

      // Os campos são delimitados por ';'.
      objAuxString.Delimiter := ';';

      // Se tivermos pelo menos uma linha, vamos descobrir quantos campos temos.
      if objString.Count > 0 then begin
        objAuxString.DelimitedText := objString.Strings[0];

        // Criando as definições de campos do DataSet.
        for i := 0 to objAuxString.Count - 1 do begin
          // Campo double.
          if TryStrToFloat(objAuxString[i], dValor) then begin
            eFieldType := ftFloat;
            iFieldSize := 0;
          end

          // Campo data.
          else if TryStrToDate(objAuxString[i], dtData) then begin
            eFieldType := ftDate;
            iFieldSize := 0;
          end

          // Campo "genérico".
          else begin
            eFieldType := ftString;
            iFieldSize := 100;
          end;
          
          Result.FieldDefs.Add('FIELD' + IntToStr(i+1), eFieldType, iFieldSize);
        end;

        Result.CreateDataSet;
        Result.LogChanges := False;
      end;

      // Preenchendo os dados.
      for i := 0 to objString.Count - 1 do begin
        objAuxString.DelimitedText := objString.Strings[i];

        // Verifica se a linha é compatível com o formato definido pelo cabeçalho.
        if objAuxString.Count <> Result.FieldCount then begin
          raise Exception.Create(Format(
            'O número de campos da linha %d é incompatível com o cabeçalho.', [i+1]));
        end;

        // Carga dos dados.
        Result.Append;
        for j := 0 to objAuxString.Count - 1 do begin
          Result.Fields[j].AsString := objAuxString[j];
        end;
        Result.Post;
      end;
    finally
      FreeAndNil(objString);
      FreeAndNil(objAuxString);
    end;
  except
    FreeAndNil(Result);
    raise;
  end;
end;

procedure SaveToCSV(ADataSet: TCustomClientDataSet; AsNome: String);
var
  i: Integer;
  objString: TStringList;
  sString: String;
begin
  objString := TStringList.Create;
  try
    ADataSet.First;

    while not ADataSet.Eof do begin
      sString := '';
      // Preenche até o penúltimo campo.
      for i := 0 to ADataSet.FieldCount - 2 do begin
        sString := sString + ADataSet.Fields[i].AsString + ';';
      end;

      // Preenche o último campo.
      sString := sString + ADataSet.Fields[ADataSet.FieldCount -1].AsString;

      // Inclui na lista de strings.
      objString.Add(sString);
      
      ADataSet.Next;
    end;

    // Por fim, salva o arquivo.
    objString.SaveToFile(AsNome);
  finally
    FreeAndNil(objString);
  end;
end;

procedure Processa;
var
  cdsDataSet: TClientDataSet;
  iGroupingLevel: Integer;
  objCamposIndice: TStringList;
  objValoresIndice: TStringList;
  i: Integer;
  iCampoIndice: Integer;
begin
  iGroupingLevel := 0;
  cdsDataSet := nil;
  objCamposIndice := nil;

  try
    cdsDataSet := LoadFromCSV('teste.csv');

    // Verificando a existência de índices.
    if (ParamCount > 0) then begin

      // Montando a lista dos campos que fazem parte do índice.
      objCamposIndice := TStringList.Create;
      objCamposIndice.Delimiter := ';';
      objCamposIndice.DelimitedText := ParamStr(1);
      for i := 0 to objCamposIndice.Count - 1 do begin
        // Verifica se é um inteiro válido.
        if not TryStrToInt(objCamposIndice[i], iCampoIndice) then begin
          raise Exception.Create(Format(
            'A coluna %s não é válida. Utilize apenas os índices das colunas.',
            [QuotedStr(objCamposIndice[i])]));
        end;

        // Verifica se está dentro da margem de colunas definidas.
        if not InRange(iCampoIndice, 1, cdsDataSet.FieldCount) then begin
          raise Exception.Create(Format(
            'A coluna %d não é uma válida. As colunas válidas estão entre 1 e %d.',
            [iCampoIndice, cdsDataSet.FieldCount]));
        end;
        objCamposIndice[i] := 'FIELD' + objCamposIndice[i];
      end;

      with cdsDataSet.IndexDefs.AddIndexDef do begin
        Name :=  'idx';
        Fields := objCamposIndice.DelimitedText;
        iGroupingLevel := objCamposIndice.Count;
      end;
    end;

    // Definindo a agregação.
    with cdsDataSet.Aggregates.Add do begin
      Expression := 'Sum(FIELD2)';
      IndexName := 'idx';
      GroupingLevel := iGroupingLevel;
      AggregateName := 'SUM_FIELD2';
      Visible := True;
      Active := True;
    end;
    cdsDataSet.AggregatesActive := True;

    // Visualização do DataSet ordenado.
    cdsDataSet.IndexName := IfThen(ParamCount > 0, 'idx', '');
    Visualiza(cdsDataSet);
    Writeln('');

    // Visualização do resultado das agregações.
    if Assigned(cdsDataSet.ActiveAggs[iGroupingLevel]) then begin
      cdsDataSet.First;
      objValoresIndice := TStringList.Create;
      try
        objValoresIndice.Delimiter := ';';
        while not cdsDataSet.Eof do begin
          if (gbFirst in cdsDataSet.GetGroupState(iGroupingLevel)) then begin
            objValoresIndice.Clear;
            for i := 0 to objCamposIndice.Count -1 do begin
              objValoresIndice.Add(cdsDataSet.FieldByName(objCamposIndice[i]).AsString);
            end;

            Writeln(Format('%s: %s', [objValoresIndice.DelimitedText,
              cdsDataSet.Aggregates[0].Value]))
          end;
          cdsDataSet.Next;
        end;
      finally
        FreeAndNil(objValoresIndice);
      end;
    end;
  finally
    FreeAndNil(cdsDataSet);
    FreeAndNil(objCamposIndice);
  end;
end;

begin
  try
    Processa;
  except
    on E:Exception do begin
      Writeln(StringToOem(Format('Erro: %s', [E.Message])));
    end;
  end;
end.


