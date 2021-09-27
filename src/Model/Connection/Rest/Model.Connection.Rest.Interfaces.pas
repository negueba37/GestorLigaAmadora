unit Model.Connection.Rest.Interfaces;

interface

uses
  System.SysUtils,REST.Client, Data.DB;
type
  IModelConnectionRestAction = interface;
  IModelConnetionRestEvents = interface;

  IModelConnectionRestInterfaces = interface
    ['{32F08335-7E65-4DAD-B1A3-04CE65EBBFDF}']
    function Action: IModelConnectionRestAction;
    function AddBody(aField:string;aValue:string):IModelConnectionRestInterfaces;
    function BaseURL(aValue:string):IModelConnectionRestInterfaces;
    function ClearBody:IModelConnectionRestInterfaces;
    function DataSet:TDataSet;
    function Events: IModelConnetionRestEvents;
    function Resource(aValue:string):IModelConnectionRestInterfaces;
    function Request:TRestRequest;
    function Response:TRestResponse;
  end;

  IModelConnectionRestAction = interface
    ['{E97F01CD-F317-4E0F-B522-8A014B81811A}']
    function Get: IModelConnectionRestAction;
    function Post: IModelConnectionRestAction;
    function Put: IModelConnectionRestAction;
    function Delete: IModelConnectionRestAction;
    function OnAfterRequest(aEvent:TProc<string>):IModelConnectionRestAction;
    function Back:IModelConnectionRestInterfaces;
  end;
  IModelConnetionRestEvents = interface
    ['{3BE73BC0-844F-41B9-A93E-08ED0854504A}']
    function OnAfterRequest(aEvent:TProc<string>):IModelConnetionRestEvents;
    function Back:IModelConnectionRestInterfaces;
  end;
implementation

end.
