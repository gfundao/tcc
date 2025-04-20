program MonolitoFinanceiro;

uses
  Vcl.Forms,
  MonolitoFinanceito.View.Principal in 'src\View\MonolitoFinanceito.View.Principal.pas' {FrmPrincipal},
  MonolitoFinanceito.View.CadastroPadrao in 'src\View\MonolitoFinanceito.View.CadastroPadrao.pas' {frmCadastroPadrao},
  MonolitoFinanceito.View.Splash in 'src\View\MonolitoFinanceito.View.Splash.pas' {frmSplash},
  MonolitoFinanceiro.Model.Conexao in 'src\Model\MonolitoFinanceiro.Model.Conexao.pas' {dmConexao: TDataModule},
  MonolitoFinanceito.View.Usuarios in 'src\View\MonolitoFinanceito.View.Usuarios.pas' {frmUsuarios},
  MonolitoFinanceiro.Model.Usuarios in 'src\Model\MonolitoFinanceiro.Model.Usuarios.pas' {dmUsuarios: TDataModule},
  MonolitoFinanceito.Utilitarios in 'src\Util\MonolitoFinanceito.Utilitarios.pas',
  MonolitoFinanceito.View.Login in 'src\View\MonolitoFinanceito.View.Login.pas' {frmLogin},
  MonolitoFinanceiro.Model.Entidades.Usuario in 'src\Model\Entidades\MonolitoFinanceiro.Model.Entidades.Usuario.pas',
  MonolitoFinanceiro.Model.Sistema in 'src\Model\MonolitoFinanceiro.Model.Sistema.pas' {dmSistema: TDataModule},
  MonolitoFinanceito.View.RedefinirSenha in 'src\View\MonolitoFinanceito.View.RedefinirSenha.pas' {frmRedefinirSenha};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TdmConexao, dmConexao);
  Application.CreateForm(TdmUsuarios, dmUsuarios);
  Application.CreateForm(TFrmPrincipal, FrmPrincipal);
  Application.CreateForm(TfrmCadastroPadrao, frmCadastroPadrao);
  Application.CreateForm(TfrmUsuarios, frmUsuarios);
  Application.CreateForm(TdmSistema, dmSistema);
  Application.Run;
end.
