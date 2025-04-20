unit MonolitoFinanceito.Utilitarios;

interface

uses
  Vcl.DBGrids;
type
  TUtilitarios = class
    class function GetID : String;
    class function LikeFind(Pesquisa : String; Grid : TDBGrid) : string;
  end;

implementation

uses
  System.SysUtils;

{ TUtilitario }

class function TUtilitarios.GetID: String;
begin
  Result := TGUID.NewGuid.TOString;
  Result := StringReplace(Result, '{', '', [rfReplaceAll]);
  Result := StringReplace(Result, '}', '', [rfReplaceAll]);
end;

class function TUtilitarios.LikeFind(Pesquisa: String; Grid: TDBGrid): string;
var
  LContador : Integer;

begin
  Result := '';
  if Pesquisa.Trim.IsEmpty then
    exit;
  for LContador := 0 to Pred(Grid.Columns.Count) do
  begin
    Result := Result + Grid.Columns.Items[LContador].FieldName + ' Like ' + QuotedStr('%' + Trim(Pesquisa) + '%') + ' OR ';
  end;
    Result := ' WHERE ' + Copy(Result, 1 , Length(Result) -4)
end;

end.
