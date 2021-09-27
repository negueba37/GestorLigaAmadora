unit View.Frame.Resultado;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Objects, FMX.Effects, FMX.Controls.Presentation, FMX.Layouts,
  Model.Entities.Confronto;

type
  TFrameResultado = class(TFrame)
    Layout6: TLayout;
    Label7: TLabel;
    Rectangle1: TRectangle;
    Rectangle2: TRectangle;
    Label10: TLabel;
    Rectangle5: TRectangle;
    ShadowEffect1: TShadowEffect;
    Image1: TImage;
    Layout1: TLayout;
    lblAspMandante: TLabel;
    lblAspVisitante: TLabel;
    lblGolAspMandante: TLabel;
    lblGolAspVisitante: TLabel;
    Layout2: TLayout;
    Label1: TLabel;
    Rectangle3: TRectangle;
    lblTitMandante: TLabel;
    lblGolTitMandante: TLabel;
    Rectangle4: TRectangle;
    lblTitVisitante: TLabel;
    lblGolTitVisitante: TLabel;
    Label6: TLabel;
    Image2: TImage;
    procedure Image1Click(Sender: TObject);
    procedure Image2Click(Sender: TObject);
  private
    FCodigoConfronto: Integer;
    FOnClickEdit: TProc<TModelEntitiesConfronto>;
    FCodigoAspVisitante: Integer;
    FCodigoTitVisitante: Integer;
    FCodigoAspMandante: Integer;
    FCodigoTitMandante: Integer;
    FOnClickDelete: TProc<TModelEntitiesConfronto>;
    procedure SetCodigoConfronto(const Value: Integer);
    procedure SetOnClickEdit(const Value: TProc<TModelEntitiesConfronto>);
    procedure SetCodigoAspMandante(const Value: Integer);
    procedure SetCodigoAspVisitante(const Value: Integer);
    procedure SetCodigoTitMandante(const Value: Integer);
    procedure SetCodigoTitVisitante(const Value: Integer);
    procedure SetOnClickDelete(const Value: TProc<TModelEntitiesConfronto>);
    { Private declarations }
  public
    property OnClickEdit:TProc<TModelEntitiesConfronto> read FOnClickEdit write SetOnClickEdit;
    property OnClickDelete:TProc<TModelEntitiesConfronto> read FOnClickDelete write SetOnClickDelete;
    property CodigoConfronto:Integer read FCodigoConfronto write SetCodigoConfronto;
    property CodigoAspMandante:Integer read FCodigoAspMandante write SetCodigoAspMandante;
    property CodigoAspVisitante:Integer read FCodigoAspVisitante write SetCodigoAspVisitante;
    property CodigoTitMandante:Integer read FCodigoTitMandante write SetCodigoTitMandante;
    property CodigoTitVisitante:Integer read FCodigoTitVisitante write SetCodigoTitVisitante;

  end;

implementation

{$R *.fmx}

{ TFrameResultado }

procedure TFrameResultado.Image1Click(Sender: TObject);
var
  Dados:TModelEntitiesConfronto;
begin
  Dados.CodigoConfronto := FCodigoConfronto;
  Dados.CodigoAspMandante := CodigoAspMandante;
  Dados.CodigoAspVisitante := CodigoAspVisitante;
  Dados.CodigoTitMandante := CodigoTitMandante;
  Dados.CodigoTitVisitante := CodigoTitVisitante;
  Dados.NomeTimeMandante := lblAspMandante.Text;
  Dados.NomeTimeVisitante :=  lblAspVisitante.Text;
  Dados.GolAspMandante := StrToInt(lblGolAspMandante.Text);
  Dados.GolAspVisitante := StrToInt(lblGolAspVisitante.Text);
  Dados.GolTitMandante := StrToInt(lblGolTitMandante.Text);
  Dados.GolTitVisitante := StrToInt(lblGolTitVisitante.Text);

  if Assigned(FOnClickEdit) then
    FOnClickEdit(Dados);
end;

procedure TFrameResultado.Image2Click(Sender: TObject);
var
  Dados:TModelEntitiesConfronto;
begin
  Dados.CodigoConfronto := CodigoConfronto;
  if Assigned(FOnClickDelete) then
    FOnClickDelete(Dados);
end;

procedure TFrameResultado.SetCodigoAspMandante(const Value: Integer);
begin
  FCodigoAspMandante := Value;
end;

procedure TFrameResultado.SetCodigoAspVisitante(const Value: Integer);
begin
  FCodigoAspVisitante := Value;
end;

procedure TFrameResultado.SetCodigoConfronto(const Value: Integer);
begin
  FCodigoConfronto := Value;
end;

procedure TFrameResultado.SetCodigoTitMandante(const Value: Integer);
begin
  FCodigoTitMandante := Value;
end;

procedure TFrameResultado.SetCodigoTitVisitante(const Value: Integer);
begin
  FCodigoTitVisitante := Value;
end;

procedure TFrameResultado.SetOnClickDelete(
  const Value: TProc<TModelEntitiesConfronto>);
begin
  FOnClickDelete := Value;
end;

procedure TFrameResultado.SetOnClickEdit(
  const Value: TProc<TModelEntitiesConfronto>);
begin
  FOnClickEdit := Value;
end;

end.
