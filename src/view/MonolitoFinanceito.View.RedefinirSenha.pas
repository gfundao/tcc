unit MonolitoFinanceito.View.RedefinirSenha;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  MonolitoFinanceiro.Model.Entidades.Usuario;

type
  TfrmRedefinirSenha = class(TForm)
    pnlPrincipal: TPanel;
    Panel1: TPanel;
    lblNomeAplicacao: TLabel;
    lblUsuario: TLabel;
    Panel2: TPanel;
    Panel3: TPanel;
    Label2: TLabel;
    edtSenha: TEdit;
    Panel4: TPanel;
    Label3: TLabel;
    edtConfirmarSenha: TEdit;
    btnConfirmar: TButton;
    Panel5: TPanel;
    btnCancelar: TButton;
    procedure FormShow(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnConfirmarClick(Sender: TObject);
  private
    FUsuario: TModelEntidadeUsuario;
    procedure SetUsuario(const Value: TModelEntidadeUsuario);
    { Private declarations }
  public
    { Public declarations }
    property Usuario : TModelEntidadeUsuario read FUsuario write SetUsuario;

  end;

var
  frmRedefinirSenha: TfrmRedefinirSenha;

implementation

uses
  MonolitoFinanceiro.Model.Usuarios;

{$R *.dfm}


procedure TfrmRedefinirSenha.btnCancelarClick(Sender: TObject);
begin
  ModalResult := mrCancel;;
end;

procedure TfrmRedefinirSenha.btnConfirmarClick(Sender: TObject);
begin
  edtSenha.Text := Trim(edtSenha.Text);
  edtConfirmarSenha.Text := Trim(edtConfirmarSenha.Text);

   if edtSenha.Text = '' then
  begin
    edtSenha.SetFocus;
    Application.MessageBox('Informe a sua nova senha', 'Atenção', MB_OK + MB_ICONWARNING);
    Abort;
  end;

  if edtConfirmarSenha.Text = '' then
  begin
    edtConfirmarSenha.SetFocus;
    Application.MessageBox('Confirme a sua senha', 'Atenção', MB_OK + MB_ICONWARNING);
    Abort;
  end;

  if edtSenha.Text <> edtConfirmarSenha.Text then
  begin
    edtConfirmarSenha.SetFocus;
    Application.MessageBox('As senhas não coincidem', 'Atenção', MB_OK + MB_ICONWARNING);
    Abort;
  end;

  Usuario.Senha := EdtSenha.Text;
  dmUsuarios.RedefinirSenha(Usuario);
  Application.MessageBox('Senha alterada com sucesso', 'Sucesso', MB_OK + MB_ICONINFORMATION);
  ModalResult := mrOk;
end;

procedure TfrmRedefinirSenha.FormShow(Sender: TObject);
begin
  lblUsuario.Caption := FUsuario.Nome;
end;

procedure TfrmRedefinirSenha.SetUsuario(const Value: TModelEntidadeUsuario);
begin
  FUsuario := Value;
end;

end.
