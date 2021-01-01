unit Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ActnColorMaps, ActnMan, ToolWin, ActnCtrls, ActnMenus,
  XPStyleActnCtrls, ActnList, StdCtrls, WinSkinStore, WinSkinData,
  ExtActns, StdActns, ImgList;

type
  TfrmMain = class(TForm)
    actnmnmnubr: TActionMainMenuBar;
    actnmngr: TActionManager;
    XPColorMap: TXPColorMap;
    StandardColorMap: TStandardColorMap;
    TwilightColorMap: TTwilightColorMap;
    SkinData: TSkinData;
    SkinStore: TSkinStore;
    actnArquivoSair: TAction;
    actnProdutosVisualizar: TAction;
    actnProdutosCadastrar: TAction;
    actnClientesVisualizar: TAction;
    actnClientesCadastrar: TAction;
    actnAlugueisAlugados: TAction;
    actnAlugueisReparo: TAction;
    actnAjudaSobre: TAction;
    imglst: TImageList;
    procedure actnArquivoSairExecute(Sender: TObject);
    procedure actnAjudaSobreExecute(Sender: TObject);
    procedure actnProdutosVisualizarExecute(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

uses MySQLFrm;

{$R *.dfm}

procedure TfrmMain.actnArquivoSairExecute(Sender: TObject);
begin
  Close;
end;

procedure TfrmMain.actnAjudaSobreExecute(Sender: TObject);
begin
  ShowMessage('Ainda não disponível');
end;

procedure TfrmMain.actnProdutosVisualizarExecute(Sender: TObject);
begin
  frmMySQL.ShowModal;
end;

end.
