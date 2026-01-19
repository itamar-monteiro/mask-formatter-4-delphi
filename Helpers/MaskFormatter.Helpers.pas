unit MaskFormatter.Helpers;

interface

uses
  System.SysUtils,
  System.RTTI;

type
  TRttiFieldyHelper = class helper for TRttiField
  public
    function GetCustomAttribute<T: TCustomAttribute>: T;
  end;

implementation

function TRttiFieldyHelper.GetCustomAttribute<T>: T;
var
  LCustomAttribute: TCustomAttribute;
begin
  Result:= nil;

  for LCustomAttribute in GetAttributes do
    if LCustomAttribute is T then
      Exit(T(LCustomAttribute));
end;

end.
