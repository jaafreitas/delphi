program DemoCellClick;

{$mode Delphi}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Classes,
  Math,
  Buttons,
  Forms,
  Controls,
  Dialogs,
  DBGrids,
  Grids,
  Themes,
  DB,
  BufDataset,
  Windows,
  SysUtils;

{$R *.res}

type
  TClientDataSet = class(TBufDataSet)
  end;

  { TDBGridDemo }

  TDBGridDemo = class(TDBGrid)
  protected
    procedure BtnClickEvent(Sender: TObject);

    procedure DrawColumnCellEvent(Sender: TObject;
      const Rect: TRect; DataCol: Integer;
      Column: TColumn; State: TGridDrawState);

  public
    constructor Create(AOwner: TComponent); override;
  end;
  { TDBGridDemo }

  procedure TDBGridDemo.BtnClickEvent(Sender: TObject);
  begin
    if Sender is TSpeedButton then begin
      ShowMessage('Linha ' + IntToStr(TSpeedButton(Sender).Tag));
    end;
  end;

  procedure TDBGridDemo.DrawColumnCellEvent(Sender: TObject; const Rect: TRect;
    DataCol: Integer; Column: TColumn; State: TGridDrawState);
  var
    btn: TSpeedButton;
    iLeft: Integer;
    iWidth: Integer;
  begin
    inherited;

    if Column.Field.FieldName = 'Visualizar' then begin
      Canvas.FillRect(Rect);

      btn := TSpeedButton(Pointer(NativeInt(Column.Field.Value)));
      btn.Visible:=True;

      iWidth := Rect.Right - Rect.Left;
      iLeft := (Rect.Left + Trunc(iWidth/2) - Trunc(btn.Width/2));

      If btn.Left <> iLeft Then
         btn.Left := iLeft;

      If (btn.Top <> Rect.Top) Then
         btn.Top := Rect.Top ;

      If (btn.Height <> (Rect.Bottom-Rect.Top)) Then
         btn.Height := (Rect.Bottom-Rect.Top);
    end;
  end;

  constructor TDBGridDemo.Create(AOwner: TComponent);
  begin
    inherited Create(AOwner);

    OnDrawColumnCell := DrawColumnCellEvent;
  end;

var
  objForm: TForm;
  objGrid: TDBGridDemo;
  objDataSet: TClientDataSet;

function CriaBtn(AiLinha: Integer; AbSelecionado: Boolean): TSpeedButton;
begin
  Result := TSpeedButton.Create(objGrid);
  Result.Parent := objGrid;
  Result.Caption := '...';
  Result.Tag := AiLinha;
  Result.Visible := False;
  Result.OnClick := objGrid.BtnClickEvent;
  objDataSet.InsertRecord([AbSelecionado, AiLinha, 'Linha ' + IntToStr(AiLinha), NativeInt(Result)]);
end;

var
  objDataSource: TDataSource;
  i: Integer;

begin
  RequireDerivedFormResource := True;
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm, objForm);
  objForm.Width:=450;
  objForm.Height:=300;
  objForm.HorzScrollBar.Visible:=False;

  objGrid := TDBGridDemo.Create(objForm);

  objDataSet := TClientDataSet.Create(objForm);
  with objDataSet, FieldDefs do begin
    Add('Selecionado', ftBoolean);
    Add('id', ftInteger);
    Add('Nome', ftString, 15);
    Add('Visualizar', ftInteger);
    CreateDataSet;
    IndexFieldNames := 'id';

    CriaBtn(1, True);
    CriaBtn(2, False);
    CriaBtn(3, True);
    for i := 4 to 10 do begin
      CriaBtn(i, True);
    end;
    First;

    FieldByName('Nome').ReadOnly := True;
    FieldByName('Visualizar').ReadOnly := True;
  end;

  objDataSource := TDataSource.Create(objDataSet);
  objDataSource.DataSet := objDataSet;

  objGrid.Options := objGrid.Options - [dgIndicator];
  objGrid.DataSource := objDataSource;
  objGrid.Parent := objForm;
  objGrid.Align:=alClient;

  Application.Run;
end.

