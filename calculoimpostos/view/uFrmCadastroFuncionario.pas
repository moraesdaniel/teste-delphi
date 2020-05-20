unit uFrmCadastroFuncionario;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms,
  Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Grids, Vcl.ComCtrls, Vcl.Mask, uFuncoes,
  System.ImageList, Vcl.ImgList, uFuncionario, uFuncionarioController,
  uDmFuncionario, System.StrUtils, System.Generics.Collections,
  uDependente, uDependenteController, System.UITypes, uDmDependente,
  uDmFuncionarioDependente;

type
  TAcao = (actNovo, actAtualizar);

  TfrmCadastroFuncionario = class(TForm)
    pgCadastro: TPageControl;
    tbPesquisa: TTabSheet;
    tbCadastro: TTabSheet;
    pnlRodape: TPanel;
    btnNovo: TButton;
    strgridFuncionarios: TStringGrid;
    pnlPesquisa: TPanel;
    edtPesquisar: TLabeledEdit;
    btnAlterar: TButton;
    btnExcluir: TButton;
    pnlCadastro: TPanel;
    pnlRodapeCadastro: TPanel;
    strgridDependentes: TStringGrid;
    edtCPF: TMaskEdit;
    pnlCadastroDependente: TPanel;
    edtNome: TLabeledEdit;
    lblCPF: TLabel;
    edtSalario: TEdit;
    Label1: TLabel;
    btnPesquisar: TButton;
    chkINSS: TCheckBox;
    chkIR: TCheckBox;
    edtNomeDependente: TLabeledEdit;
    btnIncluirDependente: TButton;
    imgList: TImageList;
    btnCancelar: TButton;
    btnGravar: TButton;
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edtSalarioChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure strgridDependentesDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnPesquisarClick(Sender: TObject);
    procedure btnIncluirDependenteClick(Sender: TObject);
    procedure strgridDependentesSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure btnAlterarClick(Sender: TObject);
  private
    bFormatando: Boolean;
    oFuncoes: TFuncoes;
    oFuncionario: TFuncionario;
    oAcao: TAcao;
    procedure FormatarGridPesquisa;
    procedure FormatarGriDependentes;
    procedure InicializarTela;
    procedure CadastrarNovoFuncionario;
    procedure CancelarCadastro;
    procedure LimparPainelCadastro;
    procedure LimparPainelCadastroDependente;
    procedure InserirNovoFuncionario;
    procedure PesquisarFuncionarios(sNome: String);
    procedure AdicionarDependente;
    procedure MostrarDependentesTela;
    procedure AlterarFuncionario;
    procedure AtualizarFuncionario;
  public
    { Public declarations }
  end;

var
  frmCadastroFuncionario: TfrmCadastroFuncionario;

implementation

uses
  Vcl.Dialogs;

{$R *.dfm}

procedure TfrmCadastroFuncionario.AdicionarDependente;
var
  oDependente: TDependente;
  oDependenteController: TDependenteController;
  sMsg: String;
begin
  oDependente := TDependente.Create;
  oDependenteController := TDependenteController.Create;
  try
    oDependente.ID := oDependenteController.GetIDNovoDependente();
    oDependente.Nome := edtNomeDependente.Text;
    oDependente.IsCalculaIR := chkIR.Checked;
    oDependente.IsCalculaINSS := chkINSS.Checked;

    if not oDependenteController.ValidarDados(oDependente, sMsg) then begin
      MessageDlg(sMsg, mtWarning, [mbok], 0);
      Exit;
    end;

    oFuncionario.AdicionarDependente(oDependente);
  finally
    FreeAndNil(oDependente);
    FreeAndNil(oDependenteController);
  end;
end;

procedure TfrmCadastroFuncionario.AlterarFuncionario;
var
  oFuncionarioController: TFuncionarioController;
  iIDFuncionario: Integer;
begin
  if strgridFuncionarios.Row < 1 then begin
    MessageDlg('Por favor, selecione o funcion�rio a ser alterado!',
      mtInformation, [mbok], 0);
    Exit;
  end;

  iIDFuncionario := StrToInt(strgridFuncionarios.Cells[0, strgridFuncionarios.Row]);

  if Assigned(oFuncionario) then begin
    FreeAndNil(oFuncionario);
  end;
  oFuncionario := TFuncionario.Create;

  oFuncionarioController := TFuncionarioController.Create;
  try
    if oFuncionarioController.CarregarFuncionario(iIDFuncionario, oFuncionario) then begin
      edtNome.Text := oFuncionario.Nome;
      edtCPF.Text := oFuncionario.CPF;
      edtSalario.Text := FloatToStrF(oFuncionario.Salario, ffNumber, 11, 2);
      LimparPainelCadastroDependente();
      MostrarDependentesTela();

      pgCadastro.ActivePage := tbCadastro;
      edtNome.SetFocus;

      oAcao := actAtualizar;
    end else begin
      MessageDlg('Problemas ao tentar carregar os dados do funcion�rio!',
        mtInformation, [mbok], 0);
      Exit;
    end;
  finally
    FreeAndNil(oFuncionarioController);
  end;
end;

procedure TfrmCadastroFuncionario.AtualizarFuncionario;
var
  oFuncionarioController: TFuncionarioController;
  sMsg: String;
begin
  oFuncionarioController := TFuncionarioController.Create;
  try
    oFuncionario.Nome := edtNome.Text;
    oFuncionario.CPF := edtCPF.Text;
    oFuncionario.Salario := StrToFloat(ReplaceStr(edtSalario.Text, '.', ''));

    if not oFuncionarioController.ValidarDados(oFuncionario, sMsg) then begin
      MessageDlg(sMsg, mtWarning, [mbok], 0);
      Exit;
    end;

    if oFuncionarioController.Atualizar(oFuncionario, sMsg) then begin
      MessageDlg('Funcion�rio salvo com sucesso!', mtInformation, [mbok], 0);
      pgCadastro.ActivePage := tbPesquisa;
      edtPesquisar.Text := '';
      PesquisarFuncionarios('');
      FreeAndNil(oFuncionario);
    end else begin
      MessageDlg(sMsg, mtError, [mbok], 0);
    end;
  finally
    FreeAndNil(oFuncionarioController);
  end;
end;

procedure TfrmCadastroFuncionario.btnAlterarClick(Sender: TObject);
begin
  AlterarFuncionario();
end;

procedure TfrmCadastroFuncionario.btnCancelarClick(Sender: TObject);
begin
  CancelarCadastro();
end;

procedure TfrmCadastroFuncionario.btnGravarClick(Sender: TObject);
begin
  if oAcao = actNovo then begin
    InserirNovoFuncionario();
  end else begin
    AtualizarFuncionario();
  end;
end;

procedure TfrmCadastroFuncionario.btnIncluirDependenteClick(Sender: TObject);
begin
  AdicionarDependente();
  LimparPainelCadastroDependente();
  edtNomeDependente.SetFocus();
  MostrarDependentesTela();
end;

procedure TfrmCadastroFuncionario.btnNovoClick(Sender: TObject);
begin
  CadastrarNovoFuncionario();
end;

procedure TfrmCadastroFuncionario.btnPesquisarClick(Sender: TObject);
begin
  PesquisarFuncionarios(edtPesquisar.Text);
end;

procedure TfrmCadastroFuncionario.CancelarCadastro;
begin
  if MessageDlg('Deseja realmente cancelar o cadastro e perder os dados n�o'+
    ' salvos?', mtWarning, [mbyes,mbno], 0) = mrYes then begin
    pgCadastro.ActivePage := tbPesquisa;
    FreeAndNil(oFuncionario);
  end;
end;

procedure TfrmCadastroFuncionario.PesquisarFuncionarios(sNome: String);
var
  listaFuncionarios: TObjectList<TFuncionario>;
  oFuncionarioController: TFuncionarioController;
  oFunc: TFuncionario;
  iLinha: Integer;
begin
  oFuncionarioController := TFuncionarioController.Create;
  listaFuncionarios := TObjectList<TFuncionario>.Create;
  oFunc := TFuncionario.Create;
  try
    if oFuncionarioController.CarregarFuncionariosFiltroNome(sNome,
      listaFuncionarios) > 0 then begin
      strgridFuncionarios.RowCount := 1;
      for oFunc in listaFuncionarios do begin
        iLinha := strgridFuncionarios.RowCount;
        strgridFuncionarios.RowCount := iLinha + 1;
        strgridFuncionarios.Cells[0, iLinha] := IntToStr(oFunc.ID);
        strgridFuncionarios.Cells[1, iLinha] := oFunc.Nome;
      end;
    end;
  finally
    FreeAndNil(oFuncionarioController);
    FreeAndNil(oFunc);
  end;
end;

procedure TfrmCadastroFuncionario.edtSalarioChange(Sender: TObject);
begin
  if not bFormatando then begin
    bFormatando := True;
    edtSalario.Text := oFuncoes.FormatarMoeda(edtSalario.Text);
    edtSalario.SelStart := Length(edtSalario.Text);
    bFormatando := False;
  end;
end;

procedure TfrmCadastroFuncionario.FormatarGriDependentes;
begin
  strgridDependentes.Cells[0, 0] := 'C�digo';
  strgridDependentes.ColWidths[0] := 50;
  strgridDependentes.Cells[1, 0] := 'Nome dependente';
  strgridDependentes.ColWidths[1] := 260;
  strgridDependentes.Cells[2, 0] := 'Calcula INSS';
  strgridDependentes.Cells[3, 0] := 'Calcula IR';
  strgridDependentes.ColWidths[4] := 25;
end;

procedure TfrmCadastroFuncionario.FormatarGridPesquisa;
begin
  strgridFuncionarios.Cells[0, 0] := 'C�digo';
  strgridFuncionarios.Cells[1, 0] := 'Nome';
  strgridFuncionarios.ColWidths[1] := 400;
end;

procedure TfrmCadastroFuncionario.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
  frmCadastroFuncionario := nil;
end;

procedure TfrmCadastroFuncionario.FormCreate(Sender: TObject);
begin
  oFuncoes := TFuncoes.Create;
  bFormatando := False;
  DmFuncionario := TDmFuncionario.Create(nil);
  DmDependente := TDmDependente.Create(nil);
  DmFuncionarioDependente := TDmFuncionarioDependente.Create(nil);
  FormatarGridPesquisa();
  FormatarGriDependentes();
  InicializarTela();
end;

procedure TfrmCadastroFuncionario.FormDestroy(Sender: TObject);
begin
  FreeAndNil(oFuncoes);
  FreeAndNil(DmFuncionario);
  FreeAndNil(DmDependente);
  FreeAndNil(DmFuncionarioDependente);
end;

procedure TfrmCadastroFuncionario.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if key = #13 then begin
    key := #0;
    Perform(WM_NEXTDLGCTL, 0, 0);
  end;

end;

procedure TfrmCadastroFuncionario.InicializarTela;
begin
  tbPesquisa.TabVisible := False;
  tbCadastro.TabVisible := False;
  pgCadastro.ActivePage := tbPesquisa;
  PesquisarFuncionarios('');
end;

procedure TfrmCadastroFuncionario.InserirNovoFuncionario;
var
  oFuncionarioController: TFuncionarioController;
  sMsg: String;
begin
  oFuncionarioController := TFuncionarioController.Create;
  try
    oFuncionario.Nome := edtNome.Text;
    oFuncionario.CPF := edtCPF.Text;
    oFuncionario.Salario := StrToFloat(ReplaceStr(edtSalario.Text, '.', ''));

    if not oFuncionarioController.ValidarDados(oFuncionario, sMsg) then begin
      MessageDlg(sMsg, mtWarning, [mbok], 0);
      Exit;
    end;

    if oFuncionarioController.Inserir(oFuncionario, sMsg) then begin
      MessageDlg('Funcion�rio salvo com sucesso!', mtInformation, [mbok], 0);
      pgCadastro.ActivePage := tbPesquisa;
      edtPesquisar.Text := '';
      PesquisarFuncionarios('');
      FreeAndNil(oFuncionario);
    end else begin
      MessageDlg(sMsg, mtError, [mbok], 0);
    end;
  finally
    FreeAndNil(oFuncionarioController);
  end;
end;

procedure TfrmCadastroFuncionario.LimparPainelCadastro;
begin
  edtNome.Text := '';
  edtSalario.Text := '0,00';
  edtCPF.Text := '';
end;

procedure TfrmCadastroFuncionario.LimparPainelCadastroDependente;
begin
  edtNomeDependente.Text := '';
  chkINSS.Checked := False;
  chkIR.Checked := False;
  strgridDependentes.RowCount := 1;
end;

procedure TfrmCadastroFuncionario.MostrarDependentesTela;
var
  iNovaLinha, iIndice: Integer;
begin
  strgridDependentes.RowCount := 1;
  for iIndice := 0 To oFuncionario.ListaDependentes.Count - 1 do begin
    if oFuncionario.ListaDependentes[iIndice].Status = TStatus.stExcluir then begin
      Continue;
    end;

    iNovaLinha := strgridDependentes.RowCount;
    strgridDependentes.RowCount := iNovaLinha + 1;
    strgridDependentes.Cells[0, iNovaLinha] := IntToStr(oFuncionario.ListaDependentes[iIndice].ID);
    strgridDependentes.Cells[1, iNovaLinha] := oFuncionario.ListaDependentes[iIndice].Nome;
    if oFuncionario.ListaDependentes[iIndice].IsCalculaINSS then begin
      strgridDependentes.Cells[2, iNovaLinha] := 'X';
    end;
    if oFuncionario.ListaDependentes[iIndice].IsCalculaIR then begin
      strgridDependentes.Cells[3, iNovaLinha] := 'X';
    end;
  end;
end;

procedure TfrmCadastroFuncionario.CadastrarNovoFuncionario;
var
  oFuncionarioController: TFuncionarioController;
begin
  if Assigned(oFuncionario) then begin
    FreeAndNil(oFuncionario);
  end;
  oFuncionario := TFuncionario.Create;

  oFuncionarioController := TFuncionarioController.Create;
  try
    oFuncionario.ID := oFuncionarioController.GetIDNovoFuncionario;
  finally
    FreeAndNil(oFuncionarioController);
  end;

  LimparPainelCadastro;
  LimparPainelCadastroDependente;

  pgCadastro.ActivePage := tbCadastro;
  edtNome.SetFocus;

  oAcao := actNovo;
end;

procedure TfrmCadastroFuncionario.strgridDependentesDrawCell(Sender: TObject;
  ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
var
  oBMP: TBitmap;
  iEixoX, iEixoY: Integer;
begin
  //Incluindo imagens nas colunas que servir�o como bot�es
  if (ARow <> 0) And (ACol in [4]) then begin
    oBMP := TBitmap.Create;
    try
      if ACol = 4 then begin
        imgList.GetBitmap(0, oBMP);
      end;
      iEixoX := Rect.Left + ((Rect.Right - Rect.Left) - oBMP.Width) div 2;
      iEixoY := Rect.Top + ((Rect.Bottom - Rect.Top) - oBMP.Height) div 2;
      strgridDependentes.Canvas.Draw(iEixoX,iEixoY, oBMP);
    finally
      FreeAndNil(oBMP);
    end;
  end;
end;

procedure TfrmCadastroFuncionario.strgridDependentesSelectCell(Sender: TObject;
  ACol, ARow: Integer; var CanSelect: Boolean);
begin
  if (ACol = 4) and (ARow <> 0) then begin
    if MessageDlg('Deseja excluir o dependente '+
      strgridDependentes.Cells[2, ARow], mtConfirmation, [mbyes,mbno], 0) = mrYes then begin
      oFuncionario.ExcluirDependente(StrToInt(strgridDependentes.Cells[0, ARow]));
      MostrarDependentesTela();
    end;
  end;
end;

end.
