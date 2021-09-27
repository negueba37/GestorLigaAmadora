unit View.Frame.Time;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.Objects;

type
  TFrameTime = class(TFrame)
    recBackground: TRectangle;
    btnSelecionar: TSpeedButton;
    imgTime: TImage;
    lblTime: TLabel;
    procedure btnSelecionarClick(Sender: TObject);
  private
    FOnCliqueTime: TProc<Integer,Integer, string>;
    FCodigoAspirante: Integer;
    FCodigoTitular: Integer;
    procedure SetCodigoAspirante(const Value: Integer);
    procedure SetCodigoTitular(const Value: Integer);
    procedure SetOnCliqueTime(const Value: TProc<Integer, Integer, string>);
    { Private declarations }
  public
    property OnCliqueTime:TProc<Integer,Integer,string> read FOnCliqueTime write SetOnCliqueTime;
    Property CodigoAspirante:Integer read FCodigoAspirante write SetCodigoAspirante;
    property CodigoTitular:Integer read FCodigoTitular write SetCodigoTitular;
  end;


implementation

{$R *.fmx}

{ TFrameTime }

procedure TFrameTime.btnSelecionarClick(Sender: TObject);
begin
  if Assigned(FOnCliqueTime) then
    FOnCliqueTime(FCodigoAspirante,FCodigoTitular,lblTime.Text);
end;

procedure TFrameTime.SetCodigoAspirante(const Value: Integer);
begin
  FCodigoAspirante := Value;
end;

procedure TFrameTime.SetCodigoTitular(const Value: Integer);
begin
  FCodigoTitular := Value;
end;

procedure TFrameTime.SetOnCliqueTime(const Value: TProc<Integer, Integer, string>);
begin
  FOnCliqueTime := Value;
end;

end.
