unit uFrmDemo;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.StdCtrls,
  MaskFormatter.Core,
  MaskFormatter.Attributes;

type
  TFrmDemo = class(TForm)
    lbl_CPFCNPJ: TLabel;
    lbl_CPF: TLabel;
    lbl_CNPJ: TLabel;
    lbl_Telefone: TLabel;
    lbl_Data: TLabel;
    lbl_CEP: TLabel;
    lbl_Custom: TLabel;

    [MaskFormat(mskCPFCNPJ)]
    edt_CPFCNPJ: TEdit;

    [MaskFormat(mskCPF)]
    edt_CPF: TEdit;

    [MaskFormat(mskCNPJ)]
    edt_CNPJ: TEdit;

    [MaskFormat(mskTelefone)]
    edt_Telefone: TEdit;

    [MaskFormat(mskData)]
    edt_Data: TEdit;

    [MaskFormat(mskCEP)]
    edt_CEP: TEdit;

    [MaskFormat(mskCustom, '##-#####')]
    edt_Custom: TEdit;

    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmDemo: TFrmDemo;

implementation

{$R *.dfm}

procedure TFrmDemo.FormCreate(Sender: TObject);
begin
  ReportMemoryLeaksOnShutdown:= True;
  TMaskFormatter.Apply(Self);
end;

end.
