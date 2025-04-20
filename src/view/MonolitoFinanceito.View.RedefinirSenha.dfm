object frmRedefinirSenha: TfrmRedefinirSenha
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Redefinir Senha'
  ClientHeight = 438
  ClientWidth = 624
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -16
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  OnShow = FormShow
  TextHeight = 21
  object pnlPrincipal: TPanel
    Left = 0
    Top = 0
    Width = 624
    Height = 438
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    ExplicitLeft = 150
    ExplicitTop = -63
    ExplicitWidth = 474
    ExplicitHeight = 504
    object Panel1: TPanel
      Left = 0
      Top = 0
      Width = 624
      Height = 161
      Align = alTop
      BevelOuter = bvNone
      Padding.Top = 30
      TabOrder = 0
      ExplicitWidth = 474
      object lblNomeAplicacao: TLabel
        Left = 0
        Top = 67
        Width = 624
        Height = 21
        Align = alTop
        Alignment = taCenter
        Caption = 'Informe a sua nova senha'
        Color = clHighlight
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clDefault
        Font.Height = -16
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentColor = False
        ParentFont = False
        ExplicitWidth = 178
      end
      object lblUsuario: TLabel
        Left = 0
        Top = 30
        Width = 624
        Height = 37
        Align = alTop
        Alignment = taCenter
        Caption = 'Usu'#225'rio'
        Color = clHighlight
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clHighlight
        Font.Height = -27
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentColor = False
        ParentFont = False
        ExplicitTop = 24
      end
    end
    object Panel2: TPanel
      Left = 0
      Top = 161
      Width = 624
      Height = 277
      Align = alClient
      BevelOuter = bvNone
      Padding.Left = 50
      Padding.Right = 50
      TabOrder = 1
      ExplicitWidth = 474
      ExplicitHeight = 343
      object Panel3: TPanel
        Left = 50
        Top = 0
        Width = 524
        Height = 73
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 1
        object Label2: TLabel
          Left = 0
          Top = 0
          Width = 524
          Height = 21
          Align = alTop
          Caption = 'Senha:'
          ExplicitWidth = 46
        end
        object edtSenha: TEdit
          Left = 0
          Top = 21
          Width = 524
          Height = 29
          Align = alTop
          PasswordChar = '*'
          TabOrder = 0
          ExplicitTop = 27
        end
      end
      object Panel4: TPanel
        Left = 50
        Top = 73
        Width = 524
        Height = 96
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 0
        object Label3: TLabel
          Left = 0
          Top = 0
          Width = 524
          Height = 21
          Align = alTop
          Caption = 'Confirme a sua senha:'
          ExplicitWidth = 153
        end
        object edtConfirmarSenha: TEdit
          Left = 0
          Top = 21
          Width = 524
          Height = 29
          Align = alTop
          PasswordChar = '*'
          TabOrder = 0
        end
      end
      object Panel5: TPanel
        Left = 50
        Top = 169
        Width = 524
        Height = 39
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 2
        ExplicitTop = 178
        object btnConfirmar: TButton
          Left = 329
          Top = 0
          Width = 195
          Height = 39
          Align = alRight
          Caption = 'Confirmar'
          TabOrder = 0
          OnClick = btnConfirmarClick
          ExplicitLeft = 328
          ExplicitTop = 1
          ExplicitHeight = 67
        end
        object btnCancelar: TButton
          Left = 0
          Top = 0
          Width = 195
          Height = 39
          Align = alLeft
          Caption = 'Cancelar'
          TabOrder = 1
          OnClick = btnCancelarClick
          ExplicitTop = 6
          ExplicitHeight = 67
        end
      end
    end
  end
end
