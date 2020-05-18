unit uFuncionarioController;

interface

uses
  uFuncionario, uDmFuncionario;

type
  TFuncionarioController = class
  private
    { private declarations }
  protected
    { protected declarations }
  public
    function Inserir(oFuncionario: TFuncionario; out sErro: String): Boolean;
    function Atualizar(oFuncionario: TFuncionario; out sErro: String): Boolean;
    function Excluir(iID: Integer; out sErro: String): Boolean;
    function CPFJaCadastrado(sCPF: String): Boolean;
  published
    { published declarations }
  end;

implementation

{ TFuncionarioController }

function TFuncionarioController.Atualizar(oFuncionario: TFuncionario;
  out sErro: String): Boolean;
begin
  Result := DmFuncionario.Atualizar(oFuncionario, sErro);
end;

function TFuncionarioController.CPFJaCadastrado(sCPF: String): Boolean;
begin
  Result := DmFuncionario.CPFJaCadastrado(sCPF);
end;

function TFuncionarioController.Excluir(iID: Integer;
  out sErro: String): Boolean;
begin
  Result := DmFuncionario.Excluir(iID, sErro);
end;

function TFuncionarioController.Inserir(oFuncionario: TFuncionario;
  out sErro: String): Boolean;
begin
  Result := DmFuncionario.Inserir(oFuncionario, sErro);
end;

end.
