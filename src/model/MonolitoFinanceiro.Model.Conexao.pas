unit MonolitoFinanceiro.Model.Conexao;

interface

uses
  System.SysUtils, System.Classes, System.IniFiles,
  FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.SQLite,
  FireDAC.Phys.SQLiteDef, FireDAC.Stan.ExprFuncs,
  FireDAC.Phys.SQLiteWrapper.Stat, FireDAC.VCLUI.Wait, Data.DB,
  FireDAC.Comp.Client, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.DApt, FireDAC.Comp.DataSet;

type
  TdmConexao = class(TDataModule)
    SQLConexao: TFDConnection;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
    const ARQUIVOCONFIGURACAO = 'MonolitoFinanceiro.txt';
  public
    { Public declarations }
    vLocalDB : String;
    procedure CarregarConfiguracoes;
    procedure CarregarConfiguracoesIni;
    procedure Conectar;
    procedure Desconectar;
  end;

var
  dmConexao: TdmConexao;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TDataModule1 }

procedure TdmConexao.CarregarConfiguracoes;
var
  ParametroNome : String;
  ParametroValor : String;
  Contador : Integer;
  ListaParametros : TStringList;
  vArquivo : String;
begin
  vArquivo := ExtractFilePath(ParamStr(0)) + ARQUIVOCONFIGURACAO;
  if FileExists(vArquivo) then
    raise Exception.Create('Arquivo de configuração não encontrado');

  ListaParametros := TStringList.Create;
  try
    ListaParametros.LoadFromFile(vArquivo, TEncoding.ASCII);

    SQLConexao.Params.Clear;
    for Contador := 0 to Pred(ListaParametros.Count) do
    begin
      if ListaParametros[Contador].IndexOf('=') > 0 then
      begin
        ParametroNome := ListaParametros[Contador].Split(['='])[0].Trim;
        ParametroValor := ListaParametros[Contador].Split(['='])[1].Trim;
        SQLConexao.Params.Add(ParametroNome + '=' + ParametroValor);
      end;

    end;

  finally
    ListaParametros.Free;
  end;

end;

procedure TdmConexao.CarregarConfiguracoesIni;
var
  vPasta   : String;
  vArqIni  : TiniFile;

begin
  vPasta   := ExtractFilePath( ParamStr(0) );
  vLocalDB := '';

  // Lê arquivo de configuração
  // ==========================
  if not( FileExists( vPasta + 'Config1.ini' ) ) then
  begin
    vArqIni := TIniFile.Create( vPasta + 'Config1.ini'   );
    try
      vArqIni.WriteString('INDICE', 'LocalDB' , vPasta + 'SistemaFinanceiro.db' );
    finally
      vArqIni.Free;
    end;
  end
  else
  begin
    vArqIni := TIniFile.Create( vPasta + 'Config1.ini' );
    try
      vLocalDB  := vArqIni.ReadString('INDICE' , 'LocalDB'  , '');
    finally
      vArqIni.Free;
    end;
  end;

  SqlConexao.Connected := False;
  SqlConexao.Params.Values['Database'] := vLocalDB;
end;

procedure TdmConexao.Conectar;
begin
  SqlConexao.Connected := True;
end;

procedure TdmConexao.DataModuleCreate(Sender: TObject);
begin
  CarregarConfiguracoesIni;
  Conectar;
end;

procedure TdmConexao.Desconectar;
begin
  SqlConexao.Connected := False;
end;

end.
