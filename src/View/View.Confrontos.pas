unit View.Confrontos;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Layouts,
  FMX.ListView.Types, FMX.ListView.Appearances, FMX.ListView.Adapters.Base,
  FMX.ListView, FMX.Controls.Presentation, FMX.Edit, FMX.TabControl,
  FMX.StdCtrls, FMX.Objects, System.Actions, FMX.ActnList, View.ListaTime,
  FMX.DateTimeCtrls, RESTRequest4D, System.JSON, FMX.Gestures,
  FMX.DialogService,View.Frame.Resultado, Model.Entities.Confronto, FMX.VirtualKeyboard,FMX.Platform,
  Model.Connection.Rest.RequestGS, Model.Connection.Rest.Interfaces;
type
  TEnumStatusCampo = (tpMandante,tpVisitante);
type
  TfrmConfronto = class(TForm)
    TabControl: TTabControl;
    TabDados: TTabItem;
    TabConfronto: TTabItem;
    Layout1: TLayout;
    Layout2: TLayout;
    Layout4: TLayout;
    btnBackConfronto: TCircle;
    Image1: TImage;
    recBackGroundConfronto: TRectangle;
    TabResultado: TTabItem;
    ActionList: TActionList;
    actDados: TChangeTabAction;
    actConfronto: TChangeTabAction;
    actResultado: TChangeTabAction;
    recBackGroundResultado: TRectangle;
    recBackGroundDado: TRectangle;
    Layout9: TLayout;
    btnBackDados: TCircle;
    Image3: TImage;
    Layout10: TLayout;
    Layout8: TLayout;
    Label2: TLabel;
    StyleBook1: TStyleBook;
    Rectangle4: TRectangle;
    edtGolAspMandante: TEdit;
    Rectangle3: TRectangle;
    edtGolAspVisitante: TEdit;
    lblAspMandante: TLabel;
    btnAspMandante: TButton;
    btnAspVisitante: TButton;
    lblAspVisitante: TLabel;
    Layout5: TLayout;
    btnBackResultado: TCircle;
    Image2: TImage;
    Rectangle7: TRectangle;
    btnInserirConfrontos: TButton;
    Label6: TLabel;
    Label3: TLabel;
    recLancar: TRectangle;
    btnLancar: TButton;
    Label4: TLabel;
    Layout12: TLayout;
    recLimpar: TRectangle;
    btnLimpar: TButton;
    Label5: TLabel;
    Layout6: TLayout;
    Label7: TLabel;
    Rectangle1: TRectangle;
    edtGolTitMandante: TEdit;
    Rectangle2: TRectangle;
    edtGolTitVisitante: TEdit;
    btnTitMandante: TButton;
    lblTitMandante: TLabel;
    btnTitVisitante: TButton;
    lblTitVisitante: TLabel;
    Label10: TLabel;
    Layout13: TLayout;
    Rectangle5: TRectangle;
    edtNumeroRodada: TEdit;
    Label8: TLabel;
    Rectangle6: TRectangle;
    Label9: TLabel;
    edtDataRodada: TDateEdit;
    VertScrollBox1: TVertScrollBox;
    actAlterarResultado: TChangeTabAction;
    Rectangle15: TRectangle;
    Rectangle16: TRectangle;
    Button7: TButton;
    Label21: TLabel;
    Layout11: TLayout;
    Layout14: TLayout;
    Layout15: TLayout;
    Label11: TLabel;
    Label12: TLabel;
    lblNrRodada: TLabel;
    lblDataConfronto: TLabel;
    Rectangle8: TRectangle;
    recVerResultado: TRectangle;
    btnVerResultado: TButton;
    Label1: TLabel;
    Rectangle9: TRectangle;
    Rectangle10: TRectangle;
    Button1: TButton;
    Label15: TLabel;
    Layout3: TLayout;
    procedure FormCreate(Sender: TObject);
    procedure btnVerResultadoClick(Sender: TObject);
    procedure btnBackConfrontoClick(Sender: TObject);
    procedure btnBackResultadoClick(Sender: TObject);
    procedure btnInserirConfrontosClick(Sender: TObject);
    procedure btnAspMandanteClick(Sender: TObject);
    procedure btnAspVisitanteClick(Sender: TObject);
    procedure btnTitVisitanteClick(Sender: TObject);
    procedure btnTitMandanteClick(Sender: TObject);
    procedure btnLimparClick(Sender: TObject);
    procedure btnLancarClick(Sender: TObject);
    procedure btnBackAlterarResultadoClick(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure Button7Click(Sender: TObject);
    procedure edtGolAspMandanteEnter(Sender: TObject);
  private
    FButtom:TButton;
    FCodigoConfronto:Integer;
    FRequest:IModelConnectionRestInterfaces;
    FTpMandoCampo:TEnumStatusCampo;
    procedure ShowFormTime;
    procedure AddAspMandante();
    procedure AddAspVisitante();
    procedure AddTitMandante();
    procedure AddTitVisitante();
    procedure OnCliqueTime(Sender:TObject);
    procedure SelectTime(CodigoAsp,CodigoTit: Integer; Nome: string);
    procedure CarregarResultado(Rodada:integer);
    procedure OnAfterRequestResultado(Content:string);
    procedure LimparResultado();
    procedure UpdateResultado(Dados:TModelEntitiesConfronto);
    procedure DeleteResultado(Dados:TModelEntitiesConfronto);
  public
  end;

var
  frmConfronto: TfrmConfronto;

implementation

{$R *.fmx}

procedure TfrmConfronto.btnVerResultadoClick(Sender: TObject);
begin
  CarregarResultado(StrToIntDef(edtNumeroRodada.Text,0));
  actResultado.Execute;
end;

procedure TfrmConfronto.Button3Click(Sender: TObject);
begin
  actResultado.Execute;
end;

procedure TfrmConfronto.Button7Click(Sender: TObject);
begin
  CarregarResultado(StrToIntDef(edtNumeroRodada.Text,0));
  lblNrRodada.Text := edtNumeroRodada.Text;
  lblDataConfronto.Text := edtDataRodada.Text;
  actResultado.Execute;
end;

procedure TfrmConfronto.CarregarResultado(Rodada: integer);
begin
  LimparResultado;
  FRequest := TModelConnectionRestRequestGS.GetInstance.BaseURL('http://192.168.237.65:9000/Confronto/'+Rodada.ToString)
                                           .Action
                                           .OnAfterRequest(OnAfterRequestResultado)
                                           .Get
                                           .Back;
end;

procedure TfrmConfronto.DeleteResultado(Dados: TModelEntitiesConfronto);
var
  LResponse:IResponse;
begin
  TDialogService.MessageDialog('Deseja realmente excluir o registro ?"',
                               TMsgDlgType.mtConfirmation,
                               [TMsgDlgBtn.mbYes, TMsgDlgBtn.mbNo],
                               TMsgDlgBtn.mbNo,
                               0,
                               procedure(const AResult: TModalResult)
                               begin
                                 if AResult = mrYes then
                                 begin
                                   LResponse := TRequest.New.BaseURL('http://192.168.237.65:9000/Confronto/'+Dados.CodigoConfronto.ToString)
                                     .Accept('application/json')
                                     .Delete;
                                   CarregarResultado(StrToIntDef(edtNumeroRodada.Text,0));
                                 end;
                               end);

end;

procedure TfrmConfronto.edtGolAspMandanteEnter(Sender: TObject);
begin
  TEdit(Sender).Text := EmptyStr;
end;

procedure TfrmConfronto.btnTitMandanteClick(Sender: TObject);
begin
  FTpMandoCampo := tpMandante;
  ShowFormTime;
end;

procedure TfrmConfronto.btnAspMandanteClick(Sender: TObject);
begin
  FTpMandoCampo := tpMandante;
  ShowFormTime;
end;

procedure TfrmConfronto.btnTitVisitanteClick(Sender: TObject);
begin
  FTpMandoCampo := tpVisitante;
  ShowFormTime;
end;

procedure TfrmConfronto.btnAspVisitanteClick(Sender: TObject);
begin
  FTpMandoCampo := tpVisitante;
  ShowFormTime;
end;

procedure TfrmConfronto.AddAspMandante;
begin

end;

procedure TfrmConfronto.AddAspVisitante;
begin

end;

procedure TfrmConfronto.AddTitMandante;
begin

end;

procedure TfrmConfronto.AddTitVisitante;
begin

end;

procedure TfrmConfronto.btnBackAlterarResultadoClick(Sender: TObject);
begin
  actResultado.Execute;
end;

procedure TfrmConfronto.btnBackConfrontoClick(Sender: TObject);
begin
  actDados.Execute;
end;

procedure TfrmConfronto.btnBackResultadoClick(Sender: TObject);
begin
  actConfronto.Execute;
end;

procedure TfrmConfronto.btnInserirConfrontosClick(Sender: TObject);
begin
  if (StrToInt(edtNumeroRodada.Text) <= 0) then
  begin
    ShowMessage('Informe o numero da rodada');
    Abort;
  end;
  lblNrRodada.Text := edtNumeroRodada.Text;
  lblDataConfronto.Text := edtDataRodada.Text;
  actConfronto.Execute;
end;

procedure TfrmConfronto.btnLancarClick(Sender: TObject);
var
  LResponse: IResponse;
  LJSON:TJSONObject;
begin
  LJSON := TJSONObject.Create;
  try
    LJSON.AddPair('CodigoConfronto',IntToStr(FCodigoConfronto));
    LJSON.AddPair('CodigoAspMandante',lblAspMandante.tag.ToString);
    LJSON.AddPair('CodigoAspVisitante',lblAspVisitante.tag.ToString);
    LJSON.AddPair('CodigoTitMandante',lblTitMandante.tag.ToString);
    LJSON.AddPair('CodigoTitVisitante',lblTitVisitante.tag.ToString);
    LJSON.AddPair('GolAspMandante',edtGolAspMandante.Text);
    LJSON.AddPair('GolAspVisitante',edtGolAspVisitante.Text);
    LJSON.AddPair('GolTitMandante',edtGolTitMandante.Text);
    LJSON.AddPair('GolTitVisitante',edtGolTitVisitante.Text);
    LJSON.AddPair('NumeroRodada',edtNumeroRodada.Text);
    LJSON.AddPair('DataRodada',edtDataRodada.Text);

    if FCodigoConfronto <= 0 then
      LResponse := TRequest.New.BaseURL('http://192.168.237.65:9000/Confronto')
        .Accept('application/json')
        .AddBody(LJSON,False)
        .Post
    else
      LResponse := TRequest.New.BaseURL('http://192.168.237.65:9000/Confronto')
        .Accept('application/json')
        .AddBody(LJSON,False)
        .Put;
    FCodigoConfronto := 0;
    btnLimparClick(Sender);
  finally
    LJSON.Free;
  end;
end;

procedure TfrmConfronto.btnLimparClick(Sender: TObject);
begin
  lblAspMandante.Text := 'Asp. Mandante';
  lblAspVisitante.Text := 'Asp. Visitante';
  lblTitMandante.Text := 'Tit. Mandante';
  lblTitVisitante.Text := 'Tit. Visitante';

  edtGolAspMandante.Text := '0';
  edtGolAspVisitante.Text := '0';
  edtGolTitMandante.Text := '0';
  edtGolTitVisitante.Text := '0';
end;

procedure TfrmConfronto.FormCreate(Sender: TObject);
begin
  TabControl.TabPosition := TTabPosition.None;
  TabControl.ActiveTab := TabDados;
  edtDataRodada.Date := Now;
end;

procedure TfrmConfronto.FormKeyUp(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
{$IFDEF ANDROID}
var
  FService:IFMXVirtualKeyboardService;
{$ENDIF}
begin
{$IFDEF ANDROID}
  if Key = vkHardwareBack then
  begin
    TPlatformServices.Current.SupportsPlatformService(IFMXVirtualKeyboardService,IInterface(FService));
    if (FService <> nil) and (TVirtualKeyboardState.Visible in FService.VirtualKeyboardState) then
    begin

    end
    else
    begin
      if TabControl.ActiveTab = TabConfronto then
      begin
        Key := 0;
        actDados.Execute;
      end
      else if TabControl.ActiveTab = TabResultado then
      begin
        Key := 0;
        actConfronto.Execute;
      end;
    end;

  end;
{$ENDIF}
end;

procedure TfrmConfronto.LimparResultado;
var
  i: Integer;
begin
  for i := Pred(VertScrollBox1.Content.ChildrenCount) downto 0 do
  begin
    if (VertScrollBox1.Content.Children[i] is TFrameResultado) then
      TFrameResultado(VertScrollBox1.Content.Children[i]).Free;
  end;
end;

procedure TfrmConfronto.OnAfterRequestResultado(Content: string);
var
  LFrame :TFrameResultado;
begin
  if not(FRequest.DataSet.Active)then
    Exit;
  FRequest.DataSet.First;
  while not(FRequest.DataSet.Eof) do
  begin
    LFrame := TFrameResultado.Create(nil);
    LFrame.Parent := VertScrollBox1;
    LFrame.Name := 'Frame'+FRequest.DataSet.RecNo.ToString;
    LFrame.OnClickEdit := UpdateResultado;
    LFrame.OnClickDelete := DeleteResultado;
    LFrame.CodigoConfronto := FRequest.DataSet.FieldByName('cdConfronto').AsInteger;
    LFrame.CodigoAspMandante := FRequest.DataSet.FieldByName('cdAspMandante').AsInteger;
    LFrame.CodigoAspVisitante := FRequest.DataSet.FieldByName('cdAspVisitante').AsInteger;
    LFrame.CodigoTitMandante := FRequest.DataSet.FieldByName('cdTitMandante').AsInteger;
    LFrame.CodigoTitVisitante := FRequest.DataSet.FieldByName('cdTitVisitante').AsInteger;

    LFrame.lblAspMandante.Text := FRequest.DataSet.FieldByName('dsAspMandante').AsString;
    LFrame.lblAspVisitante.Text := FRequest.DataSet.FieldByName('dsAspVisitante').AsString;
    LFrame.lblGolAspMandante.Text := FRequest.DataSet.FieldByName('golAspMandante').AsString;
    LFrame.lblGolAspVisitante.Text := FRequest.DataSet.FieldByName('golAspVisitante').AsString;

    LFrame.lblTitMandante.Text := FRequest.DataSet.FieldByName('dsTitMandante').AsString;
    LFrame.lblTitVisitante.Text := FRequest.DataSet.FieldByName('dsTitVisitante').AsString;
    LFrame.lblGolTitMandante.Text := FRequest.DataSet.FieldByName('golTitMandante').AsString;
    LFrame.lblGolTitVisitante.Text := FRequest.DataSet.FieldByName('golTitVisitante').AsString;
    FRequest.DataSet.Next;
  end;
end;

procedure TfrmConfronto.OnCliqueTime(Sender: TObject);
begin
end;

procedure TfrmConfronto.SelectTime(CodigoAsp,CodigoTit: Integer; Nome: string);
var
  I: Integer;
begin
  if (FTpMandoCampo = tpMandante)then
  begin
    lblAspMandante.Tag := CodigoAsp;
    lblAspMandante.Text := Nome;
    lblTitMandante.Tag := CodigoTit;
    lblTitMandante.Text := Nome;

  end
  else if (FTpMandoCampo = tpVisitante)then
  begin
    lblAspVisitante.Tag := CodigoAsp;
    lblAspVisitante.Text := Nome;
    lblTitVisitante.Tag := CodigoTit;
    lblTitVisitante.Text := Nome;
  end;
end;

procedure TfrmConfronto.ShowFormTime;
begin

  if not Assigned(frmListaTimes)then
    Application.CreateForm(TfrmListaTimes,frmListaTimes);

  frmListaTimes.OnCliqueTime := SelectTime;
  frmListaTimes.Show;
end;

procedure TfrmConfronto.UpdateResultado(Dados:TModelEntitiesConfronto);
var
  LResponse: IResponse;
  LJSON:TJSONObject;
begin

  actConfronto.Execute;

  LJSON := TJSONObject.Create;
  try
    FCodigoConfronto := Dados.CodigoConfronto;
    lblAspMandante.Tag := Dados.CodigoAspMandante;
    lblAspVisitante.Tag := Dados.CodigoAspVisitante;
    lblTitMandante.Tag := Dados.CodigoTitMandante;
    lblTitVisitante.Tag := Dados.CodigoTitVisitante;

    lblAspMandante.Text := Dados.NomeTimeMandante;
    lblAspVisitante.Text := Dados.NomeTimeVisitante;
    lblTitMandante.Text := Dados.NomeTimeMandante;
    lblTitVisitante.Text := Dados.NomeTimeVisitante;

    edtGolAspMandante.Text := Dados.GolAspMandante.ToString;
    edtGolAspVisitante.Text := Dados.GolAspVisitante.ToString;
    edtGolTitMandante.Text := Dados.GolTitMandante.ToString;
    edtGolTitVisitante.Text := Dados.GolTitVisitante.ToString;
    LResponse := TRequest.New.BaseURL('http://192.168.237.65:9000/Confronto')
    .Accept('application/json')
    .AddBody(LJSON,False)
    .Put;
  finally
    LJSON.Free;
  end;end;

end.
