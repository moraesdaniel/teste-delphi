unit uDmFuncionario;

interface

uses
  System.SysUtils, System.Classes, Data.FMTBcd, Data.DB, Data.SqlExpr,
  uDmConexao, uFuncionario, System.Generics.Collections, uFuncionarioDependente,
  uFuncionarioDependenteController, uDependenteController;

type
  TDmFuncionario = class(TDataModule)
    SQLInserir: TSQLDataSet;
    SQLAlterar: TSQLDataSet;
    SQLExcluir: TSQLDataSet;
  private
    { Private declarations }
  public
    function Inserir(oFuncionario: TFuncionario; out sErro: String): Boolean;
    function Atualizar(oFuncionario: TFuncionario; out sErro: String): Boolean;
    function Excluir(iID: Integer; out sErro: String): Boolean;
    function CPFJaCadastrado(sCPF: String): Boolean;
    function GetIDNovoFuncionario: Integer;
    function CarregarFuncionariosFiltroNome(sNome: String; out oListaFuncionarios: TObjectList<TFuncionario>): Integer;
  end;

var
  DmFuncionario: TDmFuncionario;

implementation

uses
  Data.DBXCommon;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TDmFuncionario }

function TDmFuncionario.Atualizar(oFuncionario: TFuncionario;
  out sErro: String): Boolean;
begin
  with SQLAlterar do begin
    ParamByName('ID').AsInteger := oFuncionario.ID;
    ParamByName('NOME').AsString := oFuncionario.Nome;
    ParamByName('CPF').AsString := oFuncionario.CPF;
    ParamByName('SALARIO').AsFloat := oFuncionario.Salario;
    try
      ExecSQL;
      Result := True;
    except on E:Exception do
      begin
        sErro := 'Erro ao tentar atualizar funcion�rio!' + sLineBreak + E.Message;
        Result := False;
      end;
    end;
  end;
end;

function TDmFuncionario.CPFJaCadastrado(sCPF: String): Boolean;
var
  sqlCPF: TSQLDataset;
begin
  sqlCPF := TSQLDataset.Create(nil);
  try
    sqlCPF.SQLConnection := DmConexao.SQLConexao;
    sqlCPF.CommandText := 'SELECT COUNT(*) AS QTD FROM FUNCIONARIO '+
      'WHERE CPF = '''+sCPF+'''';
    sqlCPF.Open;

    Result := sqlCPF.FieldByName('QTD').AsInteger > 0;
  finally
    FreeAndNil(sqlCPF);
  end;
end;

function TDmFuncionario.Excluir(iID: Integer; out sErro: String): Boolean;
begin
  with SQLExcluir do begin
    ParamByName('ID').AsInteger := iID;
    try
      ExecSQL;
      Result := True;
    except on E: Exception do
      begin
        sErro := 'Erro ao excluir funcion�rio!' + sLineBreak + E.Message;
        Result := False;
      end;
    end;
  end;
end;

function TDmFuncionario.GetIDNovoFuncionario: Integer;
var
  sqlFunc: TSQLDataset;
begin
  sqlFunc := TSQLDataset.Create(nil);
  try
    sqlFunc.SQLConnection := DmConexao.SQLConexao;
    sqlFunc.CommandText := 'SELECT GEN_ID(GEN_ID_FUNCIONARIO, 1) AS ID FROM RDB$DATABASE';
    sqlFunc.Open;

    Result := sqlFunc.FieldByName('ID').AsInteger;
  finally
    FreeAndNil(sqlFunc);
  end;
end;

function TDmFuncionario.Inserir(oFuncionario: TFuncionario; out sErro: String): Boolean;
var
  oTransacao: TDBXTransaction;
  iIndice: Integer;
  oDependenteController: TDependenteController;
  oFuncionarioDependente: TFuncionarioDependente;
  oFuncionarioDependenteController: TFuncionarioDependenteController;
begin
  with SQLInserir do begin
    ParamByName('ID').AsInteger := oFuncionario.ID;
    ParamByName('NOME').AsString := oFuncionario.Nome;
    ParamByName('CPF').AsString := oFuncionario.CPF;
    ParamByName('SALARIO').AsFloat := oFuncionario.Salario;

    oTransacao := DmConexao.SQLConexao.BeginTransaction;
    try
      try
        //Insere o funcion�rio
        ExecSQL;

        if oFuncionario.ListaDependentes.Count > 0 then begin
          oFuncionarioDependente := TFuncionarioDependente.Create;
          oFuncionarioDependenteController := TFuncionarioDependenteController.Create;
          oDependenteController := TDependenteController.Create;
          for iIndice := 0 to oFuncionario.ListaDependentes.Count - 1 do begin
            //Insere o dependente
            if oDependenteController.Inserir(oFuncionario.ListaDependentes[iIndice], sErro) then begin
              oFuncionarioDependente.IDFuncionario := oFuncionario.ID;
              oFuncionarioDependente.IDDependente :=
                oFuncionario.ListaDependentes[iIndice].ID;
              //Insere a rela��o entre funcion�rio e dependente
              if not oFuncionarioDependenteController.Inserir(
                oFuncionarioDependente, sErro) then begin
                raise Exception.Create(sErro);
              end;
            end else begin
              raise Exception.Create(sErro);
            end;
          end;
        end;
        DmConexao.SQLConexao.CommitFreeAndNil(oTransacao);
        Result := True;
      except on E:Exception do
        begin
          sErro := 'Erro ao tentar inserir funcion�rio!' + sLineBreak + E.Message;
          DmConexao.SQLConexao.RollbackFreeAndNil(oTransacao);
          Result := False;
        end;
      end;
    finally
      if Assigned(oFuncionarioDependente) then begin
        FreeAndNil(oFuncionarioDependente);
      end;

      if Assigned(oFuncionarioDependenteController) then begin
        FreeAndNil(oFuncionarioDependenteController);
      end;

      if Assigned(oDependenteController) then begin
        FreeAndNil(oDependenteController);
      end;
    end;
  end;
end;

function TDmFuncionario.CarregarFuncionariosFiltroNome(sNome: String;
  out oListaFuncionarios: TObjectList<TFuncionario>): Integer;
var
  iIndice: Integer;
  sqlFunc: TSQLDataset;
begin
  sqlFunc := TSQLDataset.Create(nil);
  try
    with sqlFunc do begin
      SQLConnection := DmConexao.SQLConexao;
      CommandText := 'SELECT ID, NOME, CPF, SALARIO FROM FUNCIONARIO '+
        'WHERE NOME LIKE (''%'+sNome+'%'') ORDER BY NOME';
      Open;

      iIndice := 0;
      while not eof do begin
        oListaFuncionarios.Add(TFuncionario.Create);
        oListaFuncionarios[iIndice].ID := FieldByName('ID').AsInteger;
        oListaFuncionarios[iIndice].Nome := FieldByName('NOME').AsString;
        oListaFuncionarios[iIndice].CPF := FieldByName('CPF').AsString;
        oListaFuncionarios[iIndice].Salario := FieldByName('SALARIO').AsFloat;
        Inc(iIndice);
        next;
      end;
    end;
  finally
    FreeAndNil(sqlFunc);
    Result := iIndice;
  end;
end;

end.
