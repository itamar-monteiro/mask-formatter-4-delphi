object FrmDemo: TFrmDemo
  Left = 0
  Top = 0
  Caption = 'FrmDemo'
  ClientHeight = 290
  ClientWidth = 775
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  OnCreate = FormCreate
  TextHeight = 15
  object lbl_CPFCNPJ: TLabel
    Left = 24
    Top = 24
    Width = 59
    Height = 15
    Caption = 'CPF / CNPJ'
  end
  object lbl_CPF: TLabel
    Left = 200
    Top = 24
    Width = 21
    Height = 15
    Caption = 'CPF'
  end
  object lbl_CNPJ: TLabel
    Left = 376
    Top = 24
    Width = 27
    Height = 15
    Caption = 'CNPJ'
  end
  object lbl_Telefone: TLabel
    Left = 552
    Top = 24
    Width = 44
    Height = 15
    Caption = 'Telefone'
  end
  object lbl_Data: TLabel
    Left = 24
    Top = 72
    Width = 24
    Height = 15
    Caption = 'Data'
  end
  object lbl_CEP: TLabel
    Left = 200
    Top = 72
    Width = 21
    Height = 15
    Caption = 'CEP'
  end
  object lbl_Custom: TLabel
    Left = 376
    Top = 72
    Width = 105
    Height = 15
    Caption = 'Custom (Cod. IBGE)'
  end
  object edt_CPFCNPJ: TEdit
    Left = 24
    Top = 39
    Width = 153
    Height = 23
    TabOrder = 0
  end
  object edt_CPF: TEdit
    Left = 200
    Top = 39
    Width = 153
    Height = 23
    TabOrder = 1
  end
  object edt_CNPJ: TEdit
    Left = 376
    Top = 39
    Width = 153
    Height = 23
    TabOrder = 2
  end
  object edt_Telefone: TEdit
    Left = 552
    Top = 39
    Width = 153
    Height = 23
    TabOrder = 3
  end
  object edt_Data: TEdit
    Left = 24
    Top = 87
    Width = 153
    Height = 23
    TabOrder = 4
  end
  object edt_CEP: TEdit
    Left = 200
    Top = 87
    Width = 153
    Height = 23
    TabOrder = 5
  end
  object edt_Custom: TEdit
    Left = 376
    Top = 87
    Width = 153
    Height = 23
    TabOrder = 6
  end
end
