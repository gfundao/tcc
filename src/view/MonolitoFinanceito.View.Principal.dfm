object FrmPrincipal: TFrmPrincipal
  Left = 0
  Top = 0
  Caption = 'MEUBOLSO'
  ClientHeight = 441
  ClientWidth = 624
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -16
  Font.Name = 'Segoe UI'
  Font.Style = []
  Menu = MainMenu1
  Position = poScreenCenter
  WindowState = wsMaximized
  OnCreate = FormCreate
  TextHeight = 21
  object StatusBar1: TStatusBar
    Left = 0
    Top = 422
    Width = 624
    Height = 19
    Panels = <
      item
        Width = 150
      end
      item
        Width = 300
      end>
  end
  object MainMenu1: TMainMenu
    Left = 40
    Top = 16
    object mnuCadastro: TMenuItem
      Caption = 'Cadastros'
      object mnuUsuarios: TMenuItem
        Caption = 'Usu'#225'rios'
        OnClick = mnuUsuariosClick
      end
    end
    object mnuRelatorios: TMenuItem
      Caption = 'Relat'#243'rios'
    end
    object mnuAjuda: TMenuItem
      Caption = 'Ajuda'
    end
  end
  object Timer1: TTimer
    OnTimer = Timer1Timer
    Left = 528
    Top = 360
  end
end
