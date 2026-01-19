unit MaskFormatter.Attributes.MaskFormat;

interface

uses
  MaskFormatter.Types;

type
  MaskFormat = class(TCustomAttribute)
  private
    FCustomPattern: string;
    FMaskType: TMaskType;
  public
    constructor Create(const AMaskType: TMaskType); overload;
    constructor Create(const AMaskType: TMaskType; const ACustomPattern: string); overload;
    property MaskType: TMaskType read FMaskType;
    property CustomPattern: string read FCustomPattern;
  end;

implementation

constructor MaskFormat.Create(const AMaskType: TMaskType);
begin
  Self.Create(AMaskType, '');
end;

constructor MaskFormat.Create(const AMaskType: TMaskType; const ACustomPattern: string);
begin
  FMaskType     := AMaskType;
  FCustomPattern:= ACustomPattern;
end;

end.
