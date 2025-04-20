object dmConexao: TdmConexao
  OnCreate = DataModuleCreate
  Height = 480
  Width = 640
  object SQLConexao: TFDConnection
    Params.Strings = (
      'Database=C:\Projetos\projeto_MEUBOLSO\db\SistemaFinanceiro.db'
      'LockingMode=Normal'
      'DriverID=SQLite')
    LoginPrompt = False
    Left = 48
    Top = 16
  end
end
