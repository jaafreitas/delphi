unit ConfigFrm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs;

type
  TConfigFrm = class(TForm)
  private
    procedure EventoOk(Sender: TObject);
    procedure EventoTestar(Sender: TObject);

  public
    constructor Create(AOwner: TComponent); override;
  end;

implementation

uses
  Vcl.Buttons, ScreenSaverCls;

{$R *.dfm}

{ TConfigFrm }

constructor TConfigFrm.Create(AOwner: TComponent);
begin
  inherited;

  BorderIcons := [biSystemMenu];
  BorderStyle := bsDialog;
  Caption := 'Configuração';
  Height := 162;
  Name := 'frmConfig';
  Position := poScreenCenter;
  Visible := False;
  Width := 266;

  with TBitBtn.Create(Self) do begin
    Parent := Self;
    Left := 153;
    Top := 11;
    Width := 89;
    Height := 34;
    Caption := 'Ok';
    OnClick := EventoOk;
  end;

  with TBitBtn.Create(Self) do begin
    Parent := Self;
    Left := 153;
    Top := 91;
    Width := 89;
    Height := 34;
    Caption := 'Testar';
    OnClick := EventoTestar;
  end;
end;

procedure TConfigFrm.EventoOk(Sender: TObject);
begin
  frmConfig.Close;
end;

procedure TConfigFrm.EventoTestar(Sender: TObject);
begin
  frmScreen.Show;
end;

end.
