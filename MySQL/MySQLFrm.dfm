object frmMySQL: TfrmMySQL
  Left = 201
  Top = 144
  Width = 673
  Height = 325
  Caption = 'Conex'#227'o com MySQL'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object DBGrid1: TDBGrid
    Left = 0
    Top = 41
    Width = 665
    Height = 257
    Align = alClient
    DataSource = DMmySQL.dsMySQL
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 665
    Height = 41
    Align = alTop
    TabOrder = 1
    DesignSize = (
      665
      41)
    object DBNavigator1: TDBNavigator
      Left = 11
      Top = 8
      Width = 240
      Height = 25
      DataSource = DMmySQL.dsMySQL
      Anchors = [akTop]
      TabOrder = 0
    end
    object Button1: TButton
      Left = 264
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Conectar'
      TabOrder = 1
      OnClick = Button1Click
    end
    object Button2: TButton
      Left = 352
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Desconectar'
      TabOrder = 2
      OnClick = Button2Click
    end
  end
end
