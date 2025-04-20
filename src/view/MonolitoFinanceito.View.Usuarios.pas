unit MonolitoFinanceito.View.Usuarios;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, MonolitoFinanceito.View.CadastroPadrao,
  Data.DB, System.ImageList, Vcl.ImgList, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls,
  Vcl.ExtCtrls, Vcl.WinXPanels, MonolitoFinanceiro.Model.Conexao, Vcl.WinXCtrls,
  Vcl.Menus;

type
  TfrmUsuarios = class(TfrmCadastroPadrao)
    DataSource1: TDataSource;
    edtNome: TEdit;
    edtLogin: TEdit;
    ToggleStatus: TToggleSwitch;
    Label2: TLabel;
    Label3: TLabel;
    Label5: TLabel;
    PopupMenu1: TPopupMenu;
    mnuLimparSenha: TMenuItem;
    procedure btnPesquisarClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure mnuLimparSenhaClick(Sender: TObject);

//    procedure FormShow(Sender: TObject);
//    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    procedure LimparCampos;
  public
    { Public declarations }
  protected
    procedure Pesquisar; override;
  end;

var
  frmUsuarios: TfrmUsuarios;

implementation



{$R *.dfm}

uses

  MonolitoFinanceiro.Model.Usuarios,
  MonolitoFinanceito.Utilitarios,
  BCrypt;

{
procedure TfrmUsuarios.FormShow(Sender: TObject);
begin
  inherited;
  DataSource1.DataSet := dmConexao.FDQuery1;
  DataSource1.DataSet.Open;
end;

procedure TfrmUsuarios.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  DataSource1.DataSet.Close;
end;
}

procedure TfrmUsuarios.btnAlterarClick(Sender: TObject);
begin
  inherited;
  edtNome.Text := dmUsuarios.cdsUsuariosnome.AsString;
  edtLogin.Text := dmUsuarios.cdsUsuarioslogin.AsString;

  ToggleStatus.State := tssOn;
  if dmUsuarios.cdsUsuariosstatus.AsString = 'B' then
    ToggleStatus.State := tssOff;

end;

procedure TfrmUsuarios.btnIncluirClick(Sender: TObject);
begin
  inherited;
  LimparCampos;
  dmUsuarios.cdsUsuarios.Insert;
end;

procedure TfrmUsuarios.btnPesquisarClick(Sender: TObject);
begin
  Pesquisar;
end;

procedure TfrmUsuarios.btnSalvarClick(Sender: TObject);
var
  LStatus : String;
begin
  if Trim(edtNome.Text) = '' then
  begin
    edtNome.SetFocus;
    Application.MessageBox('O Campo nome não pode ser vazio', 'Atenção', MB_OK + MB_ICONWARNING);
    Abort;
  end;
  if Trim(edtLogin.Text) = '' then
  begin
    edtLogin.SetFocus;
    Application.MessageBox('O Campo login não pode ser vazio', 'Atenção', MB_OK + MB_ICONWARNING);
    Abort;
  end;

  if dmUsuarios.TemLoginCadastrado(Trim(edtLogin.text), dmUsuarios.cdsUsuarios.FieldByName('ID').AsString) then
  begin
    edtLogin.SetFocus;
    Application.MessageBox(PWideChar(Format('O login %s já se encontra cadastrado', [edtLogin.Text])), 'Atenção', MB_OK + MB_ICONWARNING);
    Abort;
  end;

  LStatus := 'A';

  if ToggleStatus.State = tssOff then
    LStatus := 'B';

  if dmUsuarios.cdsUsuarios.State in [dsInsert] then
  begin
    dmUsuarios.cdsUsuariosid.AsString := TUtilitarios.GetID;
    dmUsuarios.cdsUsuariosdata_cadastro.AsDateTime := now;
    dmUsuarios.cdsUsuariossenha.AsString := TBCrypt.GenerateHash(dmUsuarios.TEMP_PASSWORD);
    dmUsuarios.cdsUsuariossenha_temporaria.AsString := 'S';
  end;



  dmUsuarios.cdsUsuariosnome.AsString := Trim(edtNome.Text);
  dmUsuarios.cdsUsuarioslogin.AsString := Trim(edtLogin.Text);
  dmUsuarios.cdsUsuariosstatus.AsString := LStatus;

  dmUsuarios.cdsUsuarios.Post;
  dmUsuarios.cdsUsuarios.ApplyUpdates(0);

  // Application.MessageBox('Atenção', MB_OK + MB_ICONINFORMATION);

  pnlPrincipal.ActiveCard := cardPesquisa;

  inherited;
end;

procedure TfrmUsuarios.LimparCampos;
var
  contador : integer;
begin
  for contador := 0 to Pred(ComponentCount) do
  begin
    if Components[Contador] is TCustomEdit then
      TCustomEdit(Components[Contador]).Clear
    else if Components[Contador] is TToggleSwitch then
      TToggleSwitch(Components[Contador]).state := tssOn;
  end;

end;


procedure TfrmUsuarios.mnuLimparSenhaClick(Sender: TObject);
begin
  inherited;
  if not datasource1.DataSet.IsEmpty then
  begin
    dmUsuarios.LimparSenha(DataSource1.DataSet.FieldByName('ID').AsString);
    Application.MessageBox(PWideChar(format('Foi definida a senha padrão para o usuário "%s"', [DataSource1.DataSet.FieldByName('NOME').AsString])),'Atenção', MB_OK + MB_ICONINFORMATION);
  end;
end;

procedure TfrmUsuarios.Pesquisar;
var
  FiltroPesquisa : String;
begin
  FiltroPesquisa := TUtilitarios.LikeFind(edtPesquisar.Text, DBGrid1);
  dmUsuarios.cdsUsuarios.Close;
  dmUsuarios.cdsUsuarios.CommandText := 'Select * from Usuarios' + FiltroPesquisa;
  dmUsuarios.cdsUsuarios.Open;
  inherited;
end;

end.
