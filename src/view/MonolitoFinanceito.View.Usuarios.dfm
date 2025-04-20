inherited frmUsuarios: TfrmUsuarios
  Caption = 'Cadastro de Usu'#225'rios'
  StyleElements = [seFont, seClient, seBorder]
  TextHeight = 21
  inherited PnlPrincipal: TCardPanel
    StyleElements = [seFont, seClient, seBorder]
    inherited CardCadastro: TCard
      StyleElements = [seFont, seClient, seBorder]
      object Label2: TLabel [0]
        Left = 8
        Top = 43
        Width = 43
        Height = 21
        Caption = 'Nome'
      end
      object Label3: TLabel [1]
        Left = 8
        Top = 78
        Width = 39
        Height = 21
        Caption = 'Login'
      end
      object Label5: TLabel [2]
        Left = 8
        Top = 115
        Width = 43
        Height = 21
        Caption = 'Nome'
      end
      inherited Panel1: TPanel
        StyleElements = [seFont, seClient, seBorder]
      end
      object edtNome: TEdit
        Left = 72
        Top = 40
        Width = 449
        Height = 29
        TabOrder = 1
      end
      object edtLogin: TEdit
        Left = 72
        Top = 75
        Width = 449
        Height = 29
        TabOrder = 2
      end
      object ToggleStatus: TToggleSwitch
        Left = 72
        Top = 115
        Width = 130
        Height = 23
        StateCaptions.CaptionOn = 'Ativo'
        StateCaptions.CaptionOff = 'Bloqueado'
        TabOrder = 3
      end
    end
    inherited CardPesquisa: TCard
      StyleElements = [seFont, seClient, seBorder]
      inherited pnlPesquisa: TPanel
        StyleElements = [seFont, seClient, seBorder]
        inherited Label1: TLabel
          StyleElements = [seFont, seClient, seBorder]
        end
        inherited edtPesquisar: TEdit
          StyleElements = [seFont, seClient, seBorder]
        end
        inherited btnPesquisar: TButton
          OnClick = btnPesquisarClick
        end
      end
      inherited pnlPesquisarBotoes: TPanel
        StyleElements = [seFont, seClient, seBorder]
      end
      inherited pnlGrid: TPanel
        StyleElements = [seFont, seClient, seBorder]
        inherited DBGrid1: TDBGrid
          DataSource = DataSource1
          PopupMenu = PopupMenu1
          Columns = <
            item
              Expanded = False
              FieldName = 'nome'
              Title.Caption = 'Nome'
              Width = 323
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'login'
              Title.Caption = 'Login'
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'status'
              Title.Caption = 'Status'
              Width = 64
              Visible = True
            end>
        end
      end
    end
  end
  object DataSource1: TDataSource
    AutoEdit = False
    DataSet = dmUsuarios.cdsUsuarios
    Left = 649
    Top = 354
  end
  object PopupMenu1: TPopupMenu
    Left = 601
    Top = 162
    object mnuLimparSenha: TMenuItem
      Caption = 'Limpar Senha'
      OnClick = mnuLimparSenhaClick
    end
  end
end
