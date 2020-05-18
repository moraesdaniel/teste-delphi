unit uFuncionario;

interface

uses
  System.SysUtils, System.Generics.Collections, uDependente;

type
  TFuncionario = class
  private
    FID: Integer;
    FNome: String;
    FCPF: String;
    FSalario: Double;
    FListaDependentes: TObjectList<TDependente>;
    procedure SetCPF(const Value: String);
    procedure SetNome(const Value: String);
  protected
    { protected declarations }
  public
    procedure AdicionarDependente(oDependente: TDependente);
    function LocalizarDependente(iIDDependente: Integer): Integer;
    procedure ExcluirDependente(iIDDependente: Integer);
  published
    property ID: Integer read FID write FID;
    property Nome: String read FNome write SetNome;
    property CPF: String read FCPF write SetCPF;
    property Salario: Double read FSalario write FSalario;
    property ListaDependentes: TObjectList<TDependente> read FListaDependentes
      write FListaDependentes;
  end;

implementation

{ TFuncionario }

procedure TFuncionario.AdicionarDependente(oDependente: TDependente);
var
  iIndice: Integer;
begin
  FListaDependentes.Add(TDependente.Create);
  iIndice := FListaDependentes.Count - 1;
  FListaDependentes[iIndice].ID := oDependente.ID;
  FListaDependentes[iIndice].Nome := oDependente.Nome;
  FListaDependentes[iIndice].IsCalculaIR := oDependente.IsCalculaIR;
  FListaDependentes[iIndice].IsCalculaINSS := oDependente.IsCalculaINSS;
  FListaDependentes[iIndice].Status := TStatus.stNovo;
end;

procedure TFuncionario.ExcluirDependente(iIDDependente: Integer);
var
  iIndice: Integer;
begin
  iIndice := LocalizarDependente(iIDDependente);
  if iIndice >= 0 then begin
    if FListaDependentes[iIndice].Status = TStatus.stNone then begin
      FListaDependentes[iIndice].Status := TStatus.stExcluir;
    end else begin
      FListaDependentes.Delete(iIndice);
    end;
  end;
end;

function TFuncionario.LocalizarDependente(iIDDependente: Integer): Integer;
var
  iIndice: Integer;
begin
  Result := -1;
  for iIndice := 0 to FListaDependentes.Count - 1 do begin
    if iIDDependente = FListaDependentes[iIndice].ID then begin
      Result := iIndice;
      Exit;
    end;
  end;
end;

procedure TFuncionario.SetCPF(const Value: String);
begin
  if Length(Trim(Value)) > 11 then begin
    raise EArgumentException.Create('O CPF deve conter apenas 11 caracteres');
  end;

  FCPF := Trim(Value);
end;

procedure TFuncionario.SetNome(const Value: String);
begin
if Length(Trim(Value)) > 200 then begin
    raise EArgumentException.Create('O nome deve conter apenas 200 caracteres');
  end;

  FNome := Trim(Value);
end;

end.
