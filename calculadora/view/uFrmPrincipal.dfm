object Form1: TForm1
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  Caption = '.: Calculadora :.'
  ClientHeight = 202
  ClientWidth = 155
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object lblBreadCrumb: TLabel
    Left = 8
    Top = 8
    Width = 138
    Height = 13
    Alignment = taRightJustify
    AutoSize = False
    Caption = '...'
  end
  object btnZero: TButton
    Left = 44
    Top = 163
    Width = 30
    Height = 30
    Caption = '0'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 9
  end
  object btnDois: TButton
    Left = 44
    Top = 126
    Width = 30
    Height = 30
    Caption = '2'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 7
  end
  object btnTres: TButton
    Left = 80
    Top = 126
    Width = 30
    Height = 30
    Caption = '3'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 8
  end
  object btnQuatro: TButton
    Left = 8
    Top = 90
    Width = 30
    Height = 30
    Caption = '4'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
  end
  object btnCinco: TButton
    Left = 44
    Top = 90
    Width = 30
    Height = 30
    Caption = '5'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 4
  end
  object btnSete: TButton
    Left = 8
    Top = 54
    Width = 30
    Height = 30
    Caption = '7'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
  end
  object btnOito: TButton
    Left = 44
    Top = 54
    Width = 30
    Height = 30
    Caption = '8'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
  end
  object btnNove: TButton
    Left = 80
    Top = 54
    Width = 30
    Height = 30
    Caption = '9'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
  end
  object btnSeis: TButton
    Left = 80
    Top = 90
    Width = 30
    Height = 30
    Caption = '6'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 5
  end
  object btnUm: TButton
    Left = 8
    Top = 127
    Width = 30
    Height = 30
    Caption = '1'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 6
  end
  object btnSeparadorMilhar: TButton
    Left = 80
    Top = 162
    Width = 30
    Height = 30
    Caption = ','
    TabOrder = 14
  end
  object btnSomar: TButton
    Left = 116
    Top = 54
    Width = 30
    Height = 30
    Caption = '+'
    TabOrder = 10
  end
  object btnSubtrair: TButton
    Left = 116
    Top = 90
    Width = 30
    Height = 30
    Caption = '-'
    TabOrder = 11
  end
  object btnDividir: TButton
    Left = 116
    Top = 126
    Width = 30
    Height = 30
    Caption = '/'
    TabOrder = 12
  end
  object btnMultiplicar: TButton
    Left = 116
    Top = 163
    Width = 30
    Height = 30
    Caption = '*'
    TabOrder = 13
  end
  object btnC: TButton
    Left = 8
    Top = 163
    Width = 30
    Height = 30
    Caption = 'C'
    TabOrder = 15
  end
  object edtVisor: TEdit
    Left = 8
    Top = 27
    Width = 138
    Height = 21
    TabStop = False
    Alignment = taRightJustify
    AutoSize = False
    TabOrder = 16
  end
end
