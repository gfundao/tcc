unit MonolitoFinanceiro.Model.Usuarios;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Datasnap.Provider,
  Datasnap.DBClient, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  MonolitoFinanceiro.Model.Conexao, MonolitoFinanceiro.Model.Entidades.Usuario;
type
  TdmUsuarios = class(TDataModule)
    sqlUsuarios: TFDQuery;
    cdsUsuarios: TClientDataSet;
    dspUsuarios: TDataSetProvider;
    cdsUsuariosid: TStringField;
    cdsUsuariosnome: TStringField;
    cdsUsuarioslogin: TStringField;
    cdsUsuariossenha: TStringField;
    cdsUsuariosstatus: TStringField;
    cdsUsuariosdata_cadastro: TDateField;
    cdsUsuariossenha_temporaria: TStringField;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    FEntidadeUsuario : TModelEntidadeUsuario;
    { Private declarations }
  public
    { Public declarations }
    function TemLoginCadastrado (Login : String; ID: String) : Boolean;
    procedure EfetuarLogin(Login : String; Senha : String);
    function GetUsuarioLogado : TModelEntidadeUsuario;
    procedure LimparSenha (IDUsuario : String);
    procedure RedefinirSenha(Usuario : TModelEntidadeUsuario);
    const TEMP_PASSWORD = '123456';
  end;

var
  dmUsuarios: TdmUsuarios;

implementation

uses
  BCrypt;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TdmUsuarios }

procedure TdmUsuarios.DataModuleCreate(Sender: TObject);
begin
  FEntidadeUsuario := TModelEntidadeusuario.Create;
end;


procedure TdmUsuarios.DataModuleDestroy(Sender: TObject);
begin
  FEntidadeUsuario.Free;
end;

procedure TdmUsuarios.EfetuarLogin(Login, Senha: String);
var
SQLConsulta : TFDQuery;
begin
  SQLConsulta := TFDQuery.Create(nil);
  try
    SQLConsulta.Connection := dmConexao.sqlConexao;
    SQLConsulta.sql.Clear;
    SQLConsulta.sql.Add('SELECT * FROM USUARIOS WHERE LOGIN = :LOGIN');
    SQLConsulta.ParamByName('LOGIN').AsString := Login;
    SQLConsulta.Open;

    if SQLConsulta.IsEmpty then
      raise Exception.Create('Usu�rio e/ou senha inv�lidos');

    if not TBCrypt.CompareHash(Senha, SQLConsulta.FieldByName('SENHA').AsString) then
      raise Exception.Create('Usu�rio e/ou senha inv�lidos');

    if SQLConsulta.FieldByName('STATUS').AsString <> 'A' then
      raise Exception.Create('Usu�rio bloqueado, favor entrar em contato com o administrador');


    FentidadeUsuario.ID := SQLConsulta.FieldByName('ID').AsString;
    FentidadeUsuario.Nome := SQLConsulta.FieldByName('NOME').AsString;
    FentidadeUsuario.Login := SQLConsulta.FieldByName('LOGIN').AsString;
    FentidadeUsuario.Senha := SQLConsulta.FieldByName('SENHA').AsString;
    FentidadeUsuario.SenhaTemporaria := SQLConsulta.FieldByName('SENHA_TEMPORARIA').AsString = 'S';
  finally
    SQLConsulta.Close;
    SQLConsulta.Free;
  end;
end;

function TdmUsuarios.GetUsuarioLogado: TModelEntidadeUsuario;
begin
  Result := FEntidadeUsuario;
end;


procedure TdmUsuarios.LimparSenha(IDUsuario: String);
var
  SQLQuery : TFDQuery;
begin
  SQLQuery := TFDQuery.Create(nil);
  try
    SQLQuery.Connection := dmConexao.sqlConexao;
    SQLQuery.sql.Clear;
    SQLQuery.sql.Add('UPDATE USUARIOS SET SENHA_TEMPORARIA = :SENHA_TEMPORARIA, SENHA = :SENHA WHERE ID = :ID');
    SQLQuery.ParamByName('SENHA_TEMPORARIA').AsString := 'S';
    SQLQuery.ParamByName('SENHA').AsString := TBCrypt.GenerateHash(TEMP_PASSWORD);
    SQLQuery.ParamByName('ID').AsString := IDUsuario;
    SQLQuery.ExecSQL;
  finally
    SQLQuery.Close;
    SQLQuery.Free;
  end;
end;

procedure TdmUsuarios.RedefinirSenha(Usuario: TModelEntidadeUsuario);
var
  SQLQuery : TFDQuery;
begin
  SQLQuery := TFDQuery.Create(nil);
  try
    SQLQuery.Connection := dmConexao.sqlConexao;
    SQLQuery.sql.Clear;
    SQLQuery.sql.Add('UPDATE USUARIOS SET SENHA_TEMPORARIA = :SENHA_TEMPORARIA, SENHA = :SENHA WHERE ID = :ID');
    SQLQuery.ParamByName('SENHA_TEMPORARIA').AsString := 'N';
    SQLQuery.ParamByName('SENHA').AsString := TBCrypt.GenerateHash(Usuario.Senha);
    SQLQuery.ParamByName('ID').AsString := Usuario.ID;
    SQLQuery.ExecSQL;
  finally
    SQLQuery.Close;
    SQLQuery.Free;
  end;

end;

function TdmUsuarios.TemLoginCadastrado(Login, ID: String): Boolean;
var
  SQLConsulta : TFDQuery;
begin
  Result := False;
  SQLConsulta := TFDQuery.Create(nil);
  try
    SQLConsulta.Connection := dmConexao.sqlConexao;
    SQLConsulta.sql.Clear;
    SQLConsulta.sql.Add('SELECT ID FROM USUARIOS WHERE LOGIN = :LOGIN');
    SQLConsulta.ParamByName('LOGIN').AsString := Login;
    SQLConsulta.Open;
    if not SQLConsulta.IsEmpty then
      Result := SQLConsulta.FieldByName('ID').AsString <> ID;


  finally
    SQLConsulta.Close;
    SQLConsulta.Free;
  end;
end;

end.
