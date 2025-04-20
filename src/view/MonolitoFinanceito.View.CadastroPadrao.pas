unit MonolitoFinanceito.View.CadastroPadrao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, System.ImageList, Vcl.ImgList,
  Vcl.StdCtrls, Vcl.Grids, Vcl.DBGrids, Vcl.ExtCtrls, Vcl.WinXPanels;

type
  TfrmCadastroPadrao = class(TForm)
    PnlPrincipal: TCardPanel;
    CardCadastro: TCard;
    CardPesquisa: TCard;
    pnlPesquisa: TPanel;
    pnlPesquisarBotoes: TPanel;
    pnlGrid: TPanel;
    DBGrid1: TDBGrid;
    edtPesquisar: TEdit;
    Label1: TLabel;
    btnPesquisar: TButton;
    ImageList1: TImageList;
    btnFechar: TButton;
    btnIncluir: TButton;
    btnAlterar: TButton;
    btnExcluir: TButton;
    btnImprimir: TButton;
    Panel1: TPanel;
    btnCancelar: TButton;
    btnSalvar: TButton;
    procedure btnIncluirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnFecharClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
  private
    { Private declarations }
    procedure HabilitarBotoes;
  public
    { Public declarations }
  protected
    procedure Pesquisar; virtual;
  end;

var
  frmCadastroPadrao: TfrmCadastroPadrao;

implementation

{$R *.dfm}
 uses MonolitoFinanceito.View.Usuarios, Datasnap.DBClient;

procedure TfrmCadastroPadrao.btnAlterarClick(Sender: TObject);
begin
  TClientDataSet(frmusuarios.DataSource1.DataSet).Edit;
  PnlPrincipal.ActiveCard := cardCadastro;
end;

procedure TfrmCadastroPadrao.btnFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmCadastroPadrao.btnIncluirClick(Sender: TObject);
begin
  PnlPrincipal.ActiveCard := cardCadastro;
end;

procedure TfrmCadastroPadrao.btnSalvarClick(Sender: TObject);
var
  Mensagem : String;
begin
    Mensagem := 'Registro alterado com sucesso!';

  if frmusuarios.DataSource1.State in [dsInsert] then
    Mensagem := 'Registro incluído com sucesso!';

  TClientDataSet (frmusuarios.DataSource1.DataSet).Post;
  TClientDataSet (frmusuarios.DataSource1.DataSet).ApplyUpdates(0);

  Application.MessageBox(PWideChar(Mensagem), 'Atenção', MB_OK + MB_ICONINFORMATION);
  Pesquisar;
  pnlPrincipal.ActiveCard := cardPesquisa;
end;

procedure TfrmCadastroPadrao.btnCancelarClick(Sender: TObject);
begin
  TClientDataSet(frmusuarios.datasource1.DataSet).Cancel;
  PnlPrincipal.ActiveCard := cardPesquisa;
end;

procedure TfrmCadastroPadrao.btnExcluirClick(Sender: TObject);
begin
  if Application.MessageBox('Deseja realmente excluir o registro?', 'Pergunta', MB_YESNO + MB_ICONQUESTION) <> mrYes then
    exit;

    try
      TClientDataSet(frmusuarios.datasource1.DataSet).Delete;
      TClientDataSet(frmusuarios.datasource1.DataSet).ApplyUpdates(0);
      Application.MessageBox('Registro excluído com sucesso!', 'Atenção', MB_OK + MB_ICONINFORMATION);

    except on E : Exception do
      Application.MessageBox(PWideChar(E.Message), 'Erro ao excluir registo', MB_OK + MB_ICONERROR);

    end;
end;

procedure TfrmCadastroPadrao.FormShow(Sender: TObject);
begin
  PnlPrincipal.ActiveCard := cardPesquisa;
  Pesquisar;
end;

procedure TfrmCadastroPadrao.HabilitarBotoes;
begin
  btnExcluir.Enabled := not frmUsuarios.DataSource1.DataSet.IsEmpty;
  btnAlterar.Enabled := not frmUsuarios.DataSource1.DataSet.IsEmpty;
end;

procedure TfrmCadastroPadrao.Pesquisar;
begin
  HabilitarBotoes;
end;

end.
