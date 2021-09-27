unit Model.Connection.Rest.Events;

interface

uses Model.Connection.Rest.Interfaces, System.SysUtils;
  type
    TModelConnectionRestEvents = class(TInterfacedObject,
      IModelConnetionRestEvents)
    private
      FOnAfterRequest: TProc<string>;
      [weak]
      FBack: IModelConnectionRestInterfaces;
      class var FInstance: TModelConnectionRestEvents;
    public
      constructor Create(aParent: IModelConnectionRestInterfaces);
      destructor Destroy; override;
      class function GetInstance(aParent: IModelConnectionRestInterfaces) : IModelConnetionRestEvents;
      function OnAfterRequest(aEvent: TProc<string>): IModelConnetionRestEvents;
      function Back: IModelConnectionRestInterfaces;

  end;

implementation

{ TModelConnectionRestEvents }

function TModelConnectionRestEvents.Back: IModelConnectionRestInterfaces;
begin
  Result := FBack;
end;

constructor TModelConnectionRestEvents.Create(aParent:IModelConnectionRestInterfaces);
begin
  FBack := aParent;
end;

destructor TModelConnectionRestEvents.Destroy;
begin

  inherited;
end;

class function TModelConnectionRestEvents.GetInstance(aParent:IModelConnectionRestInterfaces): IModelConnetionRestEvents;
begin
  Result := Self.Create(aParent);
end;

function TModelConnectionRestEvents.OnAfterRequest(aEvent: TProc<string>): IModelConnetionRestEvents;
begin
  Result := Self;
  FOnAfterRequest := aEvent;
end;

end.
