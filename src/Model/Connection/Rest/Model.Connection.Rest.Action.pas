unit Model.Connection.Rest.Action;

interface

uses Model.Connection.Rest.Interfaces,REST.Types, System.Classes,
  System.SysUtils, Model.Utils;

type
  TModelConnectionRestAction = class(TInterfacedObject,IModelConnectionRestAction)
  private
  [weak]
  FParent:IModelConnectionRestInterfaces;
  FEventOnAfterRequest:TProc<string>;
  procedure Execute(Method:TRESTRequestMethod);
  procedure OnTerminate(Sender:TObject);
  public
    constructor Create(aParent:IModelConnectionRestInterfaces);
    destructor Destroy; override;
    class function GetInstance(aParent:IModelConnectionRestInterfaces): IModelConnectionRestAction;
    function Get: IModelConnectionRestAction;
    function Post: IModelConnectionRestAction;
    function Put: IModelConnectionRestAction;
    function Delete: IModelConnectionRestAction;
    function OnAfterRequest(aEvent:TProc<string>):IModelConnectionRestAction;
    function Back:IModelConnectionRestInterfaces;
  end;

implementation

{ TModelConnectionRestAction }

function TModelConnectionRestAction.Back: IModelConnectionRestInterfaces;
begin
  Result := FParent;
end;

constructor TModelConnectionRestAction.Create(aParent:IModelConnectionRestInterfaces);
begin
  FParent := aParent;
end;

function TModelConnectionRestAction.Delete: IModelConnectionRestAction;
begin
  Result := Self;
  Execute(rmDELETE);
end;

destructor TModelConnectionRestAction.Destroy;
begin

  inherited;
end;

procedure TModelConnectionRestAction.Execute(Method:TRESTRequestMethod);
var
  LThread:TThread;
begin
  LThread :=
  TThread.CreateAnonymousThread(
  procedure()
  begin
    try
      FParent.Request.Method := Method;;
      FParent.Request.Execute;

    except
      begin

      end;
    end;

  end);
  LThread.FreeOnTerminate := True;
  LThread.OnTerminate := OnTerminate;
  LThread.Start;
end;

function TModelConnectionRestAction.Get: IModelConnectionRestAction;
begin
  Result := Self;
  Execute(rmGET);
end;

class function TModelConnectionRestAction.GetInstance(aParent:IModelConnectionRestInterfaces): IModelConnectionRestAction;
begin
  Result := Self.create(aParent);
end;

function TModelConnectionRestAction.OnAfterRequest(aEvent: TProc<string>): IModelConnectionRestAction;
begin
  Result := Self;
  FEventOnAfterRequest := aEvent;
end;

procedure TModelConnectionRestAction.OnTerminate(Sender: TObject);
begin 
  TModelUtils.JsonConverteDataSet(FParent.DataSet,FParent.Response.Content);
  if Assigned(FEventOnAfterRequest) then
  begin
    FEventOnAfterRequest(FParent.Response.Content);
    FParent.ClearBody;
  end;
end;

function TModelConnectionRestAction.Post: IModelConnectionRestAction;
begin
  Result := Self;
  Execute(rmPOST);
end;

function TModelConnectionRestAction.Put: IModelConnectionRestAction;
begin
  Result := Self;
  Execute(rmPUT);
end;

end.
