unit View.ListaTime;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Layouts,RESTRequest4D,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, View.Frame.Time,
  FMX.TabControl, FMX.Objects, FMX.StdCtrls, FMX.Controls.Presentation,DataSet.Serialize,
  System.JSON, Model.Connection.Rest.RequestGS, Model.Connection.Rest.Interfaces;

type
  TfrmListaTimes = class(TForm)
    Layout1: TLayout;
    Layout2: TLayout;
    ScrollBoxTimeAsp: TVertScrollBox;
    memTimeAspirante: TFDMemTable;
    memTimeTitular: TFDMemTable;
    TabControl: TTabControl;
    TabAspirante: TTabItem;
    btnBackTime: TCircle;
    Image1: TImage;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnBackTimeClick(Sender: TObject);
  private
    FRequest:IModelConnectionRestInterfaces;
    FOnCliqueTime: TProc<integer, Integer, string>;
    procedure CarregarDadosAspirante(Json:string);
    procedure SetOnCliqueTime(const Value: TProc<integer, Integer, string>);
  public
    FTpTime:string;
    procedure POnCliqueTime(CodigoAsp,CodigoTit: Integer; Nome: string);
    property OnCliqueTime:TProc<integer,Integer,string> read FOnCliqueTime write SetOnCliqueTime;
  end;

var
  frmListaTimes: TfrmListaTimes;

implementation

{$R *.fmx}

procedure TfrmListaTimes.btnBackTimeClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmListaTimes.CarregarDadosAspirante(Json:string);
var
  LFrame:TFrameTime;
  LJaTimes:TJSONArray;
  I: Integer;
begin
  LJaTimes := TJSONObject.ParseJSONValue(TEncoding.UTF8.GetBytes(Json),0) as TJSONArray;
  try
    for I := 0 to Pred(LJaTimes.Count) do
    begin
      LFrame := TFrameTime.Create(ScrollBoxTimeAsp);
      LFrame.Parent := ScrollBoxTimeAsp;
      LFrame.OnCliqueTime := Self.POnCliqueTime;
      LFrame.Name := 'FrameTime'+i.ToString;
      LFrame.lblTime.Text := LJaTimes.Get(i).GetValue<string>('nomeTime');
      LFrame.CodigoAspirante := LJaTimes.Get(i).GetValue<Integer>('cdAsp');
      LFrame.CodigoTitular := LJaTimes.Get(i).GetValue<Integer>('cdTit');
    end;
  finally
    LJaTimes.Free;
  end;
end;

procedure TfrmListaTimes.FormCreate(Sender: TObject);
begin
  FRequest := TModelConnectionRestRequestGS.GetInstance.BaseURL('http://192.168.237.65:9000/Time')
    .Action
    .OnAfterRequest(CarregarDadosAspirante)
    .Get
    .Back;
  TabControl.TabPosition := TTabPosition.None;
end;

procedure TfrmListaTimes.FormShow(Sender: TObject);
begin
  TabControl.ActiveTab := TabAspirante;
  ScrollBoxTimeAsp.ScrollBy(0,10000);
end;


procedure TfrmListaTimes.POnCliqueTime(CodigoAsp,CodigoTit: Integer; Nome: string);
begin
  FOnCliqueTime(CodigoAsp,CodigoTit, Nome);
  Close;
end;

procedure TfrmListaTimes.SetOnCliqueTime(
  const Value: TProc<integer, Integer, string>);
begin
  FOnCliqueTime := Value;
end;

end.
