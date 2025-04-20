unit MonolitoFinanceito.View.Splash;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.StdCtrls,
  Vcl.Imaging.pngimage, Vcl.ExtCtrls;

type
  TfrmSplash = class(TForm)
    pnlPrincipal: TPanel;
    imgLogo: TImage;
    lblStatus: TLabel;
    ProgressBar1: TProgressBar;
    lblNomeAplicacao: TLabel;
    Timer1: TTimer;
    imgDll: TImage;
    imgConfiguracoes: TImage;
    imgBancoDeDados: TImage;
    imgIniciando: TImage;
    procedure Timer1Timer(Sender: TObject);
  private
    { Private declarations }
    procedure AtualizarStatus (Mensagem : String; Imagem : Timage);

  public
    { Public declarations }
  end;

var
  frmSplash: TfrmSplash;

implementation

{$R *.dfm}

procedure TfrmSplash.AtualizarStatus(Mensagem: String; Imagem: Timage);
begin
  lblStatus.Caption := Mensagem;
  Imagem.Visible := True;
end;

procedure TfrmSplash.Timer1Timer(Sender: TObject);
begin
  if ProgressBar1.Position <= 100 then
  begin
    ProgressBar1.StepIt;
    case ProgressBar1.Position of
      10 : AtualizarStatus('Carregando Dependências ...',imgdll);
      25 : AtualizarStatus('Conectando ao Banco de Dados ...',imgBancoDeDados);
      45 : AtualizarStatus('Carregando as configurações ...',imgConfiguracoes);
      75 : AtualizarStatus('Iniciando o Sistema ...',imgIniciando);
    end;
  end;
  if ProgressBar1.Position = 100 then
  Close;
end;

end.
