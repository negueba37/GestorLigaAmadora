unit Model.Utils;

interface

uses
  Data.DB,REST.Response.Adapter,System.JSON, FireDAC.Comp.Client;
  type
  TModelUtils = class
    class procedure JsonConverteDataSet(aDataSet:TDataSet;aJson:String);
  end;

implementation

{ TModelUtils }

class procedure TModelUtils.JsonConverteDataSet(aDataSet: TDataSet;aJson: String);
var
  vConv: TCustomJSONDataSetAdapter;
  LJsonArray:TJSONArray;
begin
  vConv := TCustomJSONDataSetAdapter.Create(Nil);
  LJsonArray := TJSONObject.ParseJSONValue(aJson) as TJSONArray;
  try
    vConv.StringFieldSize := 10000;
    vConv.Dataset := aDataSet;
    vConv.UpdateDataSet(LJsonArray);
  finally
    LJsonArray.Free;
    vConv.Free;
  end;
end;

end.
