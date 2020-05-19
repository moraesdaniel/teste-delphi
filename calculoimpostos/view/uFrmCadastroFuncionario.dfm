object frmCadastroFuncionario: TfrmCadastroFuncionario
  Left = 0
  Top = 0
  Caption = 'Cadastro de pessoa'
  ClientHeight = 397
  ClientWidth = 520
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnKeyPress = FormKeyPress
  PixelsPerInch = 96
  TextHeight = 13
  object pgCadastro: TPageControl
    Left = 0
    Top = 0
    Width = 520
    Height = 397
    ActivePage = tbCadastro
    Align = alClient
    TabOrder = 0
    object tbPesquisa: TTabSheet
      Caption = 'tbPesquisa'
      object pnlRodape: TPanel
        Left = 0
        Top = 328
        Width = 512
        Height = 41
        Align = alBottom
        BevelOuter = bvNone
        ParentBackground = False
        TabOrder = 2
        object btnNovo: TButton
          Left = 8
          Top = 8
          Width = 75
          Height = 25
          Caption = '&Novo'
          TabOrder = 0
          OnClick = btnNovoClick
        end
        object btnAlterar: TButton
          Left = 89
          Top = 8
          Width = 75
          Height = 25
          Caption = '&Alterar'
          TabOrder = 1
        end
        object btnExcluir: TButton
          Left = 170
          Top = 8
          Width = 75
          Height = 25
          Caption = '&Excluir'
          TabOrder = 2
        end
      end
      object strgridFuncionarios: TStringGrid
        Left = 0
        Top = 52
        Width = 512
        Height = 276
        Align = alClient
        ColCount = 2
        DefaultColWidth = 60
        DrawingStyle = gdsGradient
        FixedCols = 0
        RowCount = 1
        FixedRows = 0
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goRowSelect]
        TabOrder = 1
      end
      object pnlPesquisa: TPanel
        Left = 0
        Top = 0
        Width = 512
        Height = 52
        Align = alTop
        ParentBackground = False
        TabOrder = 0
        object edtPesquisar: TLabeledEdit
          Left = 8
          Top = 23
          Width = 413
          Height = 21
          EditLabel.Width = 46
          EditLabel.Height = 13
          EditLabel.Caption = 'Pesquisar'
          TabOrder = 0
        end
        object btnPesquisar: TButton
          Left = 429
          Top = 20
          Width = 75
          Height = 25
          Caption = '&Pesquisar'
          TabOrder = 1
          OnClick = btnPesquisarClick
        end
      end
    end
    object tbCadastro: TTabSheet
      Caption = 'tbCadastro'
      ImageIndex = 1
      object pnlCadastro: TPanel
        Left = 0
        Top = 0
        Width = 512
        Height = 51
        Align = alTop
        ParentBackground = False
        TabOrder = 0
        object lblCPF: TLabel
          Left = 414
          Top = 6
          Width = 19
          Height = 13
          Caption = 'CPF'
        end
        object Label1: TLabel
          Left = 316
          Top = 6
          Width = 32
          Height = 13
          Caption = 'Sal'#225'rio'
        end
        object edtCPF: TMaskEdit
          Left = 414
          Top = 21
          Width = 87
          Height = 21
          EditMask = '999\.999\.999\-99;0;_'
          MaxLength = 14
          TabOrder = 2
          Text = ''
        end
        object edtNome: TLabeledEdit
          Left = 8
          Top = 22
          Width = 300
          Height = 21
          EditLabel.Width = 75
          EditLabel.Height = 13
          EditLabel.Caption = 'Nome Completo'
          MaxLength = 200
          TabOrder = 0
        end
        object edtSalario: TEdit
          Left = 316
          Top = 22
          Width = 90
          Height = 21
          Alignment = taRightJustify
          TabOrder = 1
          Text = '0,00'
          OnChange = edtSalarioChange
        end
      end
      object pnlRodapeCadastro: TPanel
        Left = 0
        Top = 328
        Width = 512
        Height = 41
        Align = alBottom
        ParentBackground = False
        TabOrder = 3
        object btnCancelar: TButton
          Left = 8
          Top = 8
          Width = 75
          Height = 25
          Caption = '&Cancelar'
          TabOrder = 0
          OnClick = btnCancelarClick
        end
        object btnGravar: TButton
          Left = 91
          Top = 8
          Width = 75
          Height = 25
          Caption = '&Gravar'
          TabOrder = 1
          OnClick = btnGravarClick
        end
      end
      object strgridDependentes: TStringGrid
        Left = 0
        Top = 102
        Width = 512
        Height = 226
        Align = alClient
        DefaultColWidth = 70
        DrawingStyle = gdsGradient
        FixedCols = 0
        RowCount = 2
        FixedRows = 0
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goRowSelect]
        TabOrder = 2
        OnDrawCell = strgridDependentesDrawCell
      end
      object pnlCadastroDependente: TPanel
        Left = 0
        Top = 51
        Width = 512
        Height = 51
        Align = alTop
        ParentBackground = False
        TabOrder = 1
        object chkINSS: TCheckBox
          Left = 316
          Top = 10
          Width = 81
          Height = 17
          Caption = 'Calcula INSS'
          TabOrder = 1
        end
        object chkIR: TCheckBox
          Left = 316
          Top = 28
          Width = 73
          Height = 17
          Caption = 'Calcula IR'
          TabOrder = 2
        end
        object edtNomeDependente: TLabeledEdit
          Left = 8
          Top = 22
          Width = 300
          Height = 21
          EditLabel.Width = 88
          EditLabel.Height = 13
          EditLabel.Caption = 'Nome dependente'
          MaxLength = 200
          TabOrder = 0
        end
        object btnIncluirDependente: TButton
          Left = 426
          Top = 20
          Width = 75
          Height = 25
          Caption = '&Incluir'
          TabOrder = 3
          OnClick = btnIncluirDependenteClick
        end
      end
    end
  end
  object imgList: TImageList
    Left = 476
    Top = 136
    Bitmap = {
      494C010101000800040010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000001000000001002000000000000010
      00000000000000000000000000000000000000000000000000002B2B2B000101
      0100000000000101010000000000010101000000000002020200000000003333
      3300000000000000000000000000FCFCFC000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FAFAFA0000000000000000000404
      0400030303000303030000000000000000000505050000000000020202000000
      00000000000000000000F9F9F900000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000F9F9F900020202000202
      0200DADADA00E5E5E5000000000007070700E8E8E800E5E5E500000000000404
      0400F6F6F6000000000000000000F6F6F6000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FDFDFD00010101000000
      000000000000FAFAFA001E1E1E0000000000F9F9F900FBFBFB00232323000000
      000000000000FEFEFE00FDFDFD00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000F7F7F70000000000010101000000
      0000FEFEFE00000000002222220004040400FEFEFE00000000001F1F1F000000
      00000000000000000000FAFAFA00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000404
      0400FAFAFA00FCFCFC001A1A1A0000000000FCFCFC00FEFEFE001B1B1B000000
      0000FBFBFB0000000000FCFCFC00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FBFBFB00000000000000
      000000000000000000001C1C1C0002020200FEFEFE0000000000151515000505
      0500FDFDFD000000000000000000FDFDFD000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FDFDFD0000000000000000000101
      0100FCFCFC00FBFBFB001F1F1F0000000000FCFCFC00000000001F1F1F000000
      0000FDFDFD00FDFDFD0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FEFEFE0000000000000000000000
      000000000000000000001515150002020200FAFAFA0000000000171717000303
      0300FDFDFD000000000000000000FDFDFD000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000F8F8F800040404000202
      0200F3F3F300000000001F1F1F0002020200FDFDFD0000000000212121000000
      0000FAFAFA0000000000F8F8F800FDFDFD000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FEFEFE0000000000000000000000
      000000000000FEFEFE00FEFEFE00FEFEFE0000000000F7F7F700000000000000
      0000FAFAFA000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FCFCFC00FCFCFC00FBFB
      FB00F8F8F8000000000000000000FEFEFE0000000000FEFEFE0000000000FBFB
      FB0000000000FEFEFE00FCFCFC00FCFCFC000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000004B4B4B0006060600000000000707
      0700030303000000000007070700000000000000000002020200000000000303
      0300000000005151510000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000DBDBDB0054545400000000000000
      0000040404000101010001010100000000000404040000000000000000000202
      020057575700D8D8D80000000000FAFAFA000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FCFCFC000000000000000000FBFB
      FB004C4C4C00090909000000000006060600000000005959590000000000FDFD
      FD00F3F3F30000000000F7F7F700000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FCFCFC000000
      0000D8D8D8004E4E4E00030303000000000050505000D8D8D800FBFBFB000000
      0000000000000000000000000000FCFCFC000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000100000000100010000000000800000000000000000000000
      000000000000000000000000FFFFFF00C00E000000000000400D000000000000
      80060000000000008809000000000000444D000000000000C005000000000000
      8C4600000000000040430000000000004C460000000000008444000000000000
      78B700000000000086A800000000000000030000000000000002000000000000
      6025000000000000D01E00000000000000000000000000000000000000000000
      000000000000}
  end
end
