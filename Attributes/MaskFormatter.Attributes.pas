unit MaskFormatter.Attributes;

interface

uses
  MaskFormatter.Types,
  MaskFormatter.Attributes.MaskFormat;

type
  MaskFormat = MaskFormatter.Attributes.MaskFormat.MaskFormat;

  // Alias para o enum TMaskType (re-exporta o tipo completo)
  TMaskType = MaskFormatter.Types.TMaskType;

const
  // Re-exporta os valores do enum como constantes
  mskCPFCNPJ  = MaskFormatter.Types.mskCPFCNPJ;
  mskCPF      = MaskFormatter.Types.mskCPF;
  mskCNPJ     = MaskFormatter.Types.mskCNPJ;
  mskTelefone = MaskFormatter.Types.mskTelefone;
  mskCEP      = MaskFormatter.Types.mskCEP;
  mskData     = MaskFormatter.Types.mskData;
  mskCustom   = MaskFormatter.Types.mskCustom;

implementation

end.
