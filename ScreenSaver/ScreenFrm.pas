unit ScreenFrm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.Classes, Vcl.Graphics,
  Vcl.Forms, SHDocVw;

type
  TScreenFrm = class(TForm)
  private
    FCursor: TPoint;
    FWebBrowser: TWebBrowser;

    procedure EventoOnMessage(var Msg : TMsg; var Handled : boolean);
    procedure EventoFormShow(Sender: TObject);
    procedure EventoFormHide(Sender: TObject);
    procedure EventoFormActivate(Sender: TObject);

  public
    constructor Create(AOwner: TComponent); override;
  end;

implementation

uses
  Vcl.Controls;

{$R *.dfm}

{ TScreenFrm }

constructor TScreenFrm.Create(AOwner: TComponent);
begin
  inherited;

  FWebBrowser := TWebBrowser.Create(Self);
  TWinControl(FWebBrowser).Parent := Self;
  with FWebBrowser do begin
    FWebBrowser.Align := alClient;
  end;

  BorderIcons := [];
  BorderStyle := bsNone;
  Caption := 'ScreenSaver';
  Color := clBlack;
  FormStyle := fsStayOnTop;
  Name := 'frmScreen';
  Visible := False;
  OnShow := EventoFormShow;
  OnHide := EventoFormHide;
  OnActivate := EventoFormActivate;
end;

procedure TScreenFrm.EventoFormActivate(Sender: TObject);
begin
  WindowState := wsMaximized;
end;

procedure TScreenFrm.EventoFormHide(Sender: TObject);
begin
  Application.OnMessage := nil;
  ShowCursor(true);
end;

procedure TScreenFrm.EventoFormShow(Sender: TObject);
begin
  GetCursorPos(FCursor);
  Application.OnMessage := EventoOnMessage;
  ShowCursor(false);
  FWebBrowser.Navigate('http://www.google.com');
end;

procedure TScreenFrm.EventoOnMessage(var Msg: TMsg; var Handled: boolean);
var
  bDesativa: boolean;
begin
  if Msg.message = WM_MOUSEMOVE then begin
    bDesativa :=
      (Abs(LOWORD(Msg.lParam) - FCursor.x) > 5) or
      (Abs(HIWORD(Msg.lParam) - FCursor.y) > 5)
  end
  else begin
    bDesativa :=
      (Msg.message = WM_KEYDOWN) or (Msg.message = WM_ACTIVATE) or
      (Msg.message = WM_ACTIVATEAPP) or (Msg.message = WM_NCACTIVATE);
  end;
  if bDesativa then begin
    Close;
  end;
end;

end.
