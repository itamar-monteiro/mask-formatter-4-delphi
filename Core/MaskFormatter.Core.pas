unit MaskFormatter.Core;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.StdCtrls,
  Vcl.Controls,
  Vcl.Forms,
  System.Rtti,
  System.TypInfo,
  MaskFormatter.Attributes.MaskFormat,
  MaskFormatter.Attributes,
  MaskFormatter.Types;

type
  TMaskInfo = class(TComponent)
  private
    FMaskType: TMaskType;
    FCustomPattern: string;
    FOriginalOnChange: TNotifyEvent;
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    property MaskType: TMaskType read FMaskType write FMaskType;
    property CustomPattern: string read FCustomPattern write FCustomPattern;
    property OriginalOnChange: TNotifyEvent read FOriginalOnChange write FOriginalOnChange;
  end;

  TMaskFormatter = class
  private
    class procedure FormatCPFCNPJ(const Control: TCustomEdit);
    class procedure FormatCPF(const Control: TCustomEdit);
    class procedure FormatCNPJ(const Control: TCustomEdit);
    class procedure FormatTelefone(const Control: TCustomEdit);
    class procedure FormatCEP(const Control: TCustomEdit);
    class procedure FormatData(const Control: TCustomEdit);
    class procedure FormatCustom(const Control: TCustomEdit; const Pattern: string);
    class function ExtractNumbers(const Text: string): string;
    class procedure OnMaskChangeExecutor(Sender: TObject);
  public
    class procedure Apply(AObject: TObject);
  end;

implementation

class procedure TMaskFormatter.Apply(AObject: TObject);
var
  LRttiContext: TRttiContext;
  LRttiType   : TRttiType;
  LRttiField  : TRttiField;
  LCustomAttr : TCustomAttribute;
  LValue: TValue;
  LMaskAttr: MaskFormat;
  LEdit: TEdit;
  LMaskInfo: TMaskInfo;
begin
  LRttiContext:= TRttiContext.Create;

  try
    LRttiType:= LRttiContext.GetType(AObject.ClassType);
    for LRttiField in LRttiType.GetFields do
    begin
      if (LRttiField.Parent <> LRttiType) then
         Continue;

      LValue:= LRttiField.GetValue(AObject);

      for LCustomAttr in LRttiField.GetAttributes do
      begin
        if LCustomAttr is MaskFormat then
        begin
          if LValue.AsObject is TCustomEdit then
          begin
            LMaskAttr:= MaskFormat(LCustomAttr);
            LEdit    := TEdit(LValue.AsObject);

            // Cria objeto para armazenar informações da máscara
            LMaskInfo:= TMaskInfo.Create(LEdit);
            LMaskInfo.MaskType        := LMaskAttr.MaskType;
            LMaskInfo.CustomPattern   := LMaskAttr.CustomPattern;
            LMaskInfo.OriginalOnChange:= LEdit.OnChange;

            LEdit.Tag:= NativeInt(LMaskInfo);

            // Substitui o OnChange pelo executor
            LEdit.OnChange:= Self.OnMaskChangeExecutor;
          end;
        end;
      end;
    end;
  finally
    LRttiContext.Free;
  end;
end;

class function TMaskFormatter.ExtractNumbers(const Text: string): string;
var
  I: Integer;
begin
  Result:= '';
  for I := 1 to Length(Text) do
    if CharInSet(Text[I], ['0'..'9']) then
       Result:= Result + Text[I];
end;

class procedure TMaskFormatter.FormatCEP(const Control: TCustomEdit);
var
  ApenasNumeros: string;
begin
  ApenasNumeros:= ExtractNumbers(Control.Text);

  if Length(ApenasNumeros) > 8 then
     ApenasNumeros:= Copy(ApenasNumeros, 1, 8);

  if Length(ApenasNumeros) > 5 then
     Insert('-', ApenasNumeros, 6);

  Control.Text    := ApenasNumeros;
  Control.SelStart:= Length(ApenasNumeros);
end;

class procedure TMaskFormatter.FormatCNPJ(const Control: TCustomEdit);
var
  ApenasNumeros: string;
begin
  ApenasNumeros:= ExtractNumbers(Control.Text);

  if Length(ApenasNumeros) > 14 then
     ApenasNumeros:= Copy(ApenasNumeros, 1, 14);

  if Length(ApenasNumeros) > 12 then Insert('-', ApenasNumeros, 13);
  if Length(ApenasNumeros) > 8 then Insert('/', ApenasNumeros, 9);
  if Length(ApenasNumeros) > 5 then Insert('.', ApenasNumeros, 6);
  if Length(ApenasNumeros) > 2 then Insert('.', ApenasNumeros, 3);

  Control.Text:= ApenasNumeros;
  Control.SelStart:= Length(ApenasNumeros);
end;

class procedure TMaskFormatter.FormatCPF(const Control: TCustomEdit);
var
  ApenasNumeros: string;
begin
  ApenasNumeros:= ExtractNumbers(Control.Text);

  if Length(ApenasNumeros) > 11 then
    ApenasNumeros:= Copy(ApenasNumeros, 1, 11);

  if Length(ApenasNumeros) > 9 then Insert('-', ApenasNumeros, 10);
  if Length(ApenasNumeros) > 6 then Insert('.', ApenasNumeros, 7);
  if Length(ApenasNumeros) > 3 then Insert('.', ApenasNumeros, 4);

  Control.Text:= ApenasNumeros;
  Control.SelStart:= Length(ApenasNumeros);
end;

class procedure TMaskFormatter.FormatCPFCNPJ(const Control: TCustomEdit);
var
  ApenasNumeros: string;
begin
  ApenasNumeros:= ExtractNumbers(Control.Text);

  if Length(ApenasNumeros) <= 11 then
    begin
      if Length(ApenasNumeros) > 11 then
        ApenasNumeros:= Copy(ApenasNumeros, 1, 11);

      if Length(ApenasNumeros) > 9 then Insert('-', ApenasNumeros, 10);
      if Length(ApenasNumeros) > 6 then Insert('.', ApenasNumeros, 7);
      if Length(ApenasNumeros) > 3 then Insert('.', ApenasNumeros, 4);
    end
  else
    begin
      if Length(ApenasNumeros) > 14 then
        ApenasNumeros:= Copy(ApenasNumeros, 1, 14);

      if Length(ApenasNumeros) > 12 then Insert('-', ApenasNumeros, 13);
      if Length(ApenasNumeros) > 8 then Insert('/', ApenasNumeros, 9);
      if Length(ApenasNumeros) > 5 then Insert('.', ApenasNumeros, 6);
      if Length(ApenasNumeros) > 2 then Insert('.', ApenasNumeros, 3);
    end;

  Control.Text:= ApenasNumeros;
  Control.SelStart:= Length(ApenasNumeros);
end;

class procedure TMaskFormatter.FormatCustom(const Control: TCustomEdit; const Pattern: string);
var
  ApenasNumeros: string;
  Resultado: string;
  I, NumIdx: Integer;
begin
  ApenasNumeros:= ExtractNumbers(Control.Text);
  Resultado    := '';
  NumIdx       := 1;

  // Pattern usa '0' para números e outros caracteres são literais
  // Exemplo: "000.000.000-00" ou "(00) 00000-0000"
  for I:= 1 to Length(Pattern) do
  begin
    if Pattern[I] = '#' then
      begin
        if NumIdx <= Length(ApenasNumeros) then
          begin
            Resultado:= Resultado + ApenasNumeros[NumIdx];
            Inc(NumIdx);
          end
        else
          Break;
      end
    else
      begin
        if NumIdx > 1 then // Só adiciona separadores se já houver números
          Resultado:= Resultado + Pattern[I];
      end;
  end;

  Control.Text    := Resultado;
  Control.SelStart:= Length(Resultado);
end;

class procedure TMaskFormatter.FormatData(const Control: TCustomEdit);
var
  ApenasNumeros: string;
begin
  ApenasNumeros:= ExtractNumbers(Control.Text);

  if Length(ApenasNumeros) > 8 then
     ApenasNumeros:= Copy(ApenasNumeros, 1, 8);

  if Length(ApenasNumeros) > 4 then Insert('/', ApenasNumeros, 5);
  if Length(ApenasNumeros) > 2 then Insert('/', ApenasNumeros, 3);

  Control.Text    := ApenasNumeros;
  Control.SelStart:= Length(ApenasNumeros);
end;

class procedure TMaskFormatter.FormatTelefone(const Control: TCustomEdit);
var
  ApenasNumeros: string;
begin
  ApenasNumeros:= ExtractNumbers(Control.Text);

  if Length(ApenasNumeros) > 11 then
    ApenasNumeros:= Copy(ApenasNumeros, 1, 11);

  if Length(ApenasNumeros) <= 10 then
    begin
      if Length(ApenasNumeros) > 6 then Insert('-', ApenasNumeros, 7);
      if Length(ApenasNumeros) > 2 then Insert(') ', ApenasNumeros, 3);
      if Length(ApenasNumeros) > 0 then Insert('(', ApenasNumeros, 1);
    end
  else
    begin
      if Length(ApenasNumeros) > 7 then Insert('-', ApenasNumeros, 8);
      if Length(ApenasNumeros) > 2 then Insert(') ', ApenasNumeros, 3);
      if Length(ApenasNumeros) > 0 then Insert('(', ApenasNumeros, 1);
    end;

  Control.Text:= ApenasNumeros;
  Control.SelStart:= Length(ApenasNumeros);
end;

class procedure TMaskFormatter.OnMaskChangeExecutor(Sender: TObject);
var
  LControl: TCustomEdit;
  LMaskInfo: TMaskInfo;
  LOriginalEvent: TNotifyEvent;
begin
  if Sender is TEdit then
  begin
    LControl:= TEdit(Sender);

    // Recupera as informações da máscara
    if LControl.Tag <> 0 then
    begin
      LMaskInfo     := TMaskInfo(LControl.Tag);
      LOriginalEvent:= LMaskInfo.OriginalOnChange;

      // Remove temporariamente o OnChange para evitar recursão
      TEdit(LControl).OnChange:= nil;
      try
        case LMaskInfo.MaskType of
          mskCPFCNPJ:  FormatCPFCNPJ(LControl);
          mskCPF:      FormatCPF(LControl);
          mskCNPJ:     FormatCNPJ(LControl);
          mskTelefone: FormatTelefone(LControl);
          mskCEP:      FormatCEP(LControl);
          mskData:     FormatData(LControl);
          mskCustom:   FormatCustom(LControl, LMaskInfo.CustomPattern);
        end;

        // Executa o evento OnChange original, se existir
        if Assigned(LOriginalEvent) then
           LOriginalEvent(Sender);

      finally
        TEdit(LControl).OnChange:= OnMaskChangeExecutor;
      end;
    end;
  end;
end;

{ TMaskInfo }

procedure TMaskInfo.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited;
  // Quando o controle associado for destruído
  if (Operation = opRemove) and (AComponent = Owner) then
    Free;
end;

end.
