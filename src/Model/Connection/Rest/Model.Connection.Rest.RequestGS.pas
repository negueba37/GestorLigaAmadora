unit Model.Connection.Rest.RequestGS;

interface

uses Model.Connection.Rest.Interfaces,REST.Client,
  Model.Connection.Rest.Events, Model.Connection.Rest.Action, System.JSON,
  Data.DB, FireDAC.Comp.Client;

type
  TModelConnectionRestRequestGS = class(TInterfacedObject,IModelConnectionRestInterfaces)
  private
    FAction:IModelConnectionRestAction;
    FEvents:IModelConnetionRestEvents;
    FBaseURL:string;
    FBody:TJSONObject;
    FDataSet:TFDMemTable;
    FResource:string;
    FClient: TRestClient;
    FRequest: TRestRequest;
    FResponse: TRestResponse;
  public
    constructor Create();
    destructor Destroy; override;
    class function GetInstance:IModelConnectionRestInterfaces;
    function Action: IModelConnectionRestAction;
    function AddBody(aField:string;aValue:string):IModelConnectionRestInterfaces;
    function BaseURL(aValue: string): IModelConnectionRestInterfaces;
    function ClearBody:IModelConnectionRestInterfaces;
    function DataSet:TDataSet;
    function Events: IModelConnetionRestEvents;
    function Resource(aValue: string): IModelConnectionRestInterfaces;
    function Request:TRestRequest;
    function Response:TRestResponse;
  end;

implementation

{ TModelConnectionRestRequestGS }

function TModelConnectionRestRequestGS.Action: IModelConnectionRestAction;
begin
  FClient.BaseURL := FBaseURL + FResource;
  FRequest.Body.ClearBody;
  if FBody.Count > 0  then
    Request.Body.Add(FBody);

  if not Assigned(FAction) then
    FAction := TModelConnectionRestAction.create(Self);
  Result := FAction;
end;

function TModelConnectionRestRequestGS.AddBody(aField,aValue: string): IModelConnectionRestInterfaces;
begin
  Result := Self;
  FBody.AddPair(aField,aValue);
end;

function TModelConnectionRestRequestGS.BaseURL(aValue: string): IModelConnectionRestInterfaces;
begin
  Result := Self;
  FBaseURL := aValue;
end;

function TModelConnectionRestRequestGS.ClearBody: IModelConnectionRestInterfaces;
var
  I: Integer;
begin
  Result := Self;
  for I := 0 to Pred(FBody.Count) do
    FBody.RemovePair(FBody.Pairs[i].Value);
end;

constructor TModelConnectionRestRequestGS.Create;
begin
  FClient := TRESTClient.Create(nil);
  FRequest := TRESTRequest.Create(nil);
  FResponse := TRESTResponse.Create(nil);
  FBody := TJSONObject.Create;
  FDataSet := TFDMemTable.Create(nil);

  FRequest.Client := FClient;
  FRequest.Response := FResponse;
  FRequest.Params.Clear;
//  if ApiToken <> EmptyStr then
//    Request.AddParameter('x-api-key', 'Bearer ' + ApiToken, pkHTTPHEADER, [poDoNotEncode]);


  //Result := TJSONObject(TJSONObject.ParseJSONValue(Response.Content));
end;

function TModelConnectionRestRequestGS.DataSet: TDataSet;
begin
  Result := FDataSet;
end;

destructor TModelConnectionRestRequestGS.Destroy;
begin
  FResponse.Free;
  FRequest.Free;
  FClient.Free;
  FBody.Free;
  FDataSet.Free;
  inherited;
end;

function TModelConnectionRestRequestGS.Events: IModelConnetionRestEvents;
begin
  if not Assigned(FEvents) then
    FEvents := TModelConnectionRestEvents.Create(Self);
  Result := FEvents;
end;

class function TModelConnectionRestRequestGS.GetInstance: IModelConnectionRestInterfaces;
begin
  Result := Self.Create;
end;

function TModelConnectionRestRequestGS.Request: TRestRequest;
begin
  Result := FRequest;
end;

function TModelConnectionRestRequestGS.Resource(aValue: string): IModelConnectionRestInterfaces;
begin
  Result := Self;
  FResource := aValue;
end;

function TModelConnectionRestRequestGS.Response: TRestResponse;
begin
  Result := FResponse;
end;

end.
