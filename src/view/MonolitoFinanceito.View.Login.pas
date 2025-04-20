unit MonolitoFinanceito.View.Login;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.Imaging.pngimage,
  Vcl.StdCtrls;

type
  TfrmLogin = class(TForm)
    pnlEsquerda: TPanel;
    imgLogo: TImage;
    pnlPrincipal: TPanel;
    Panel1: TPanel;
    Panel2: TPanel;
    lblNomeAplicacao: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    Panel3: TPanel;
    edtSenha: TEdit;
    Panel4: TPanel;
    Label3: TLabel;
    edtLogin: TEdit;
    btnEntrar: TButton;
    procedure btnEntrarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmLogin: TfrmLogin;

implementation

{$R *.dfm}

uses MonolitoFinanceiro.Model.Usuarios, MonolitoFinanceiro.Model.Sistema;

procedure TfrmLogin.btnEntrarClick(Sender: TObject);
begin
  if Trim(edtLogin.Text) = '' then
  begin
    edtLogin.SetFocus;
    Application.MessageBox('Informe o seu usu�rio.', 'Aten��o', MB_Ok + MB_ICONWARNING);
    Abort;
  end;
  if Trim(edtSenha.Text) = '' then
  begin
    edtSenha.SetFocus;
    Application.MessageBox('Informe a sua senha.', 'Aten��o', MB_Ok + MB_ICONWARNING);
    Abort;
  end;
  try
    dmUsuarios.EfetuarLogin(Trim(edtLogin.Text), Trim(edtSenha.Text));
    dmSistema.DataUltimoAcesso(Now);
    dmSistema.UsuarioUltimoAcesso(dmUsuarios.GetUsuarioLogado.Login);
    ModalResult := mrOK;
  except
    on Erro: Exception do
    begin
      Application.MessageBox(PwideChar(Erro.Message), 'Aten��o', MB_Ok + MB_ICONWARNING);
      edtLogin.SetFocus;
    end;

  end;
end;

procedure TfrmLogin.FormShow(Sender: TObject);
begin
  edtLogin.Text := dmSistema.UsuarioUltimoAcesso;
end;

end.
