program LigaGestor;

uses
  System.StartUpCopy,
  FMX.Forms,
  View.Principal in 'View\View.Principal.pas' {Form1},
  View.Confrontos in 'View\View.Confrontos.pas' {frmConfronto},
  View.Frame.Time in 'View\Frame\View.Frame.Time.pas' {FrameTime: TFrame},
  View.ListaTime in 'View\View.ListaTime.pas' {frmListaTimes},
  View.Frame.Resultado in 'View\Frame\View.Frame.Resultado.pas' {FrameResultado: TFrame},
  Model.Entities.Confronto in 'Model\Entities\Model.Entities.Confronto.pas',
  Model.Connection.Rest.Interfaces in 'Model\Connection\Rest\Model.Connection.Rest.Interfaces.pas',
  Model.Connection.Rest.Events in 'Model\Connection\Rest\Model.Connection.Rest.Events.pas',
  Model.Connection.Rest.RequestGS in 'Model\Connection\Rest\Model.Connection.Rest.RequestGS.pas',
  Model.Connection.Rest.Action in 'Model\Connection\Rest\Model.Connection.Rest.Action.pas',
  Model.Utils in 'Model\Utils\Model.Utils.pas';

{$R *.res}

begin
  Application.Initialize;
  ReportMemoryLeaksOnShutdown := True;
  Application.CreateForm(TfrmConfronto, frmConfronto);
  Application.Run;
end.
