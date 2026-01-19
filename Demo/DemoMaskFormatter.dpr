program DemoMaskFormatter;

uses
  Vcl.Forms,
  uFrmDemo in 'uFrmDemo.pas' {FrmDemo},
  MaskFormatter.Helpers in '..\Helpers\MaskFormatter.Helpers.pas',
  MaskFormatter.Attributes.MaskFormat in '..\Attributes\MaskFormatter.Attributes.MaskFormat.pas',
  MaskFormatter.Attributes in '..\Attributes\MaskFormatter.Attributes.pas',
  MaskFormatter.Core in '..\Core\MaskFormatter.Core.pas',
  MaskFormatter.Types in '..\Core\MaskFormatter.Types.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFrmDemo, FrmDemo);
  Application.Run;
end.
