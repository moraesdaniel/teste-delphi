unit uCalculadora;

interface

uses
  System.SysUtils, Vcl.Dialogs, uFuncoes, uOperacoes;

type
  TCalculadora = class
    private
      FVisor: String;
      FHistoricoCalculo: String;
      listaComandos : array of String;
      ultimoNumero: Double;
      ultimaOperacao: String;
      ultimoComando: String;
      resultado: Double;
      Funcoes: TFuncoes;
      Operacoes: TOperacoes;
      constructor Create;
      destructor Destroy;
      procedure InterpretarComando(comando: String);
      procedure ArmazenarComandoNumero(var comando: String);
      procedure ArmazenarComandoOperacao(comando: String);
      procedure ArmazenarComandoVirgula;
      procedure ArmazenarComandoIgual;
      procedure ArmazenarComando(comando: String; indice: Integer = -1);
      procedure ArmazenarComandoImposto(comando: String);
      function Calcular() : Integer;
      procedure ZerarCalculadora(textoVisor: String = '0');
      procedure AlimentarHistoricoCalculo;
    protected
    public
      procedure ReceberComando(Comando: String);
    published
      property Visor : String read FVisor;
      property HistoricoCalculo : String read FHistoricoCalculo;
  end;

implementation

{ TCalculadora }

procedure TCalculadora.ReceberComando(Comando: String);
begin
  InterpretarComando(Comando);

  AlimentarHistoricoCalculo();
end;

procedure TCalculadora.InterpretarComando(comando: String);
begin
  //Limpar
  if comando = 'C' then begin
    ZerarCalculadora();
  //V�rgula
  end else if comando = ',' then begin
    ArmazenarComandoVirgula();
    FVisor := listaComandos[Length(listaComandos) - 1];
  //N�meros
  end else if Funcoes.IsNumber(comando) then begin
    ArmazenarComandoNumero(comando);
    FVisor := listaComandos[Length(listaComandos) - 1];
  //Opera��es
  end else if Funcoes.IsOperation(comando) then begin
    ArmazenarComandoOperacao(comando);
    Calcular();
  //Igual
  end else if comando = '=' then begin
    ArmazenarComandoIgual();
    if Calcular() = 1 then begin
      SetLength(listaComandos, 0);
      SetLength(listaComandos, 1);
      listaComandos[0] := FloatToStr(resultado);
    end;
  //Impostos
  end else begin
    ArmazenarComandoImposto(comando);
    ultimoNumero := 0;
    ultimaOperacao := '';
  end;
end;

procedure TCalculadora.ArmazenarComandoIgual;
begin
  if Length(listaComandos) = 0 then begin
    exit;
  end;

  if Funcoes.IsOperation(ultimoComando) then begin
    ArmazenarComando(FloatToStr(ultimoNumero));
  end else if (ultimoComando = '=') and (ultimaOperacao <> '') then begin
    ArmazenarComando(ultimaOperacao);
    ArmazenarComando(FloatToStr(ultimoNumero));
  end;

  ArmazenarComando('=');
end;

procedure TCalculadora.ArmazenarComandoNumero(var comando: String);
begin
  if ultimoComando = '=' then begin
    SetLength(listaComandos, 0);
  end;

  if (Length(listaComandos) <> 0) And (Funcoes.IsNumber(ultimoComando)) then begin
    comando := ultimoComando + comando;
    ArmazenarComando(comando, Length(listaComandos) - 1);
    exit;
  end;

  ArmazenarComando(comando);
end;

procedure TCalculadora.ArmazenarComandoOperacao(comando: String);
begin
  if Funcoes.IsOperation(ultimoComando) then begin
    ArmazenarComando(comando, Length(listaComandos) - 1);
    exit;
  end;

  if Length(listaComandos) = 0 then begin
    ArmazenarComando('0');
  end;

  ArmazenarComando(comando);
end;

procedure TCalculadora.ArmazenarComandoVirgula;
begin
  if Pos(',', ultimoComando) > 0 then begin
    exit;
  end;

  if (ultimoComando = '=') and (Length(listaComandos) = 1) then begin
    SetLength(listaComandos, 0);
    ultimaOperacao := '';
    ultimoNumero := 0;
  end;

  if Funcoes.IsNumber(ultimoComando) then begin
    ArmazenarComando(listaComandos[Length(listaComandos) - 1]+',', Length(listaComandos) - 1);
    exit;
  end;

  ArmazenarComando('0,');
end;

procedure TCalculadora.ArmazenarComandoImposto(comando: String);
begin
  if Calcular() = -1 then begin
    exit;
  end;

  SetLength(listaComandos, 1);
  if comando = 'Imp. A' then begin
    listaComandos[0] := FloatToStr(Operacoes.calcularImpostoA(resultado));
  end else if comando = 'Imp. B' then begin
    listaComandos[0] := FloatToStr(Operacoes.calcularImpostoB(resultado));
  end else if comando = 'Imp. C' then begin
    listaComandos[0] := FloatToStr(Operacoes.calcularImpostoC(resultado));
  end;
  FVisor := listaComandos[0];
end;

procedure TCalculadora.AlimentarHistoricoCalculo;
var
  contador: Integer;
begin
  FHistoricoCalculo := '';
  for contador := 0 to Length(listaComandos) - 1 do begin
    FHistoricoCalculo := HistoricoCalculo + listaComandos[contador];
  end;
end;

procedure TCalculadora.ArmazenarComando(comando: String; indice: Integer = -1);
begin
  if (indice > (Length(listaComandos) - 1)) or (indice < 0) then begin
    SetLength(listaComandos, Length(listaComandos) + 1);
    indice := Length(listaComandos) - 1;
  end;

  listaComandos[indice] := comando;

  ultimoComando := comando;

  if Funcoes.IsNumber(comando) then begin
    ultimoNumero := StrToFloat(comando)
  end else if Funcoes.IsOperation(comando) then begin
    ultimaOperacao := comando;
  end;
end;

function TCalculadora.Calcular() : Integer;
var
  posicao: Integer;
  operacao: String;
begin
  resultado := 0;
  operacao := '+';
  for posicao := 0 to Length(listaComandos) - 1 do begin
    if Funcoes.IsNumber(listaComandos[posicao]) then begin
      if operacao = '+' then begin
        resultado := Operacoes.somar(resultado, StrToFloat(listaComandos[posicao]));
      end else if operacao = '-' then begin
        resultado := Operacoes.subtrair(resultado, StrToFloat(listaComandos[posicao]));
      end else if operacao = '*' then begin
        resultado := Operacoes.multiplicar(resultado, StrToFloat(listaComandos[posicao]));
      end else begin
        if StrToFloat(listaComandos[posicao]) = 0 then begin
          ZerarCalculadora('Imposs�vel dividir por zero');
          result := -1;
          exit;
        end;
        resultado := Operacoes.dividir(Resultado, StrToFloat(listaComandos[posicao]));
      end;
    end else begin
      operacao := listaComandos[posicao];
    end;
  end;

  FVisor := FloatToStr(resultado);

  result := 1;
end;

constructor TCalculadora.Create;
begin
  FVisor := '0';
  FHistoricoCalculo := '';
  ultimaOperacao := '';
  ultimoNumero := 0;
  ultimoComando := '';
  Funcoes := TFuncoes.Create;
  Operacoes := TOperacoes.Create;
end;

destructor TCalculadora.Destroy;
begin
  FreeAndNil(Funcoes);
  FreeAndNil(Operacoes);
end;

procedure TCalculadora.ZerarCalculadora(textoVisor: String = '0');
begin
  FHistoricoCalculo := '';
  FVisor := textoVisor;
  Resultado := 0;
  SetLength(listaComandos, 0);
  ultimoComando := '';
  ultimaOperacao := '';
  ultimoNumero := 0;
end;

end.
