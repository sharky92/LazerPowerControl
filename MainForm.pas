unit MainForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, TeEngine, Series, ExtCtrls, TeeProcs, Chart, ComCtrls,
  VclTee.TeeGDIPlus;

type
  TRealPoint = record //���������, ���������� x � y,
    x,y:extended;     //���������� ����� ����� � ��������� �������
  end;
  TRealPointArray=array of TRealPoint; //������ ��������, ���������� x � y

{������� ����� ����������}
  TMainFrm = class(TForm)
    Chart1: TChart;        //������
    Series1: TPointSeries; //�������������� �����
    Series2: TPointSeries; //����������� �����
    lbl_GradPointPrev: TLabel;
    lbl_GradPointNext: TLabel;
    lbl_Power: TLabel;
    lbl_Current: TLabel;
    lbl_TrackBetween: TLabel;
    lbl_ControlPotential: TLabel;
    lbl_Autor: TLabel;
    ed_Power: TEdit;
    ed_Current: TEdit;
    ed_ControlPotential: TEdit;
    TrackBar1: TTrackBar;
    Chart2: TChart;           //������ ��� �����
    Series3: TFastLineSeries; //�������������� �����
    Series4: TPointSeries;    //����������� �����
    Button2: TButton;         //��������� �������������� �����
    Button1: TButton;         //��������� �������������� ��������������
    OpenDialog1: TOpenDialog;
    Chart3: TChart;           //������ ��������� ��������������
    Series5: TLineSeries;     //������ ��������� ��������������
    Button3: TButton;
    btnStart: TButton;
    Timer1: TTimer;
    Series6: TLineSeries;
    ed_OperativePower: TEdit;
    Label1: TLabel;
    Label2: TLabel;         //��������� ��������� ��������������


    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure TrackBar1Change(Sender: TObject);
    procedure btnStartClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);

  private
  public
  end;
{���������� �������}
{��������� - ���������� ������ ���������� ���������.
������� ���������: ������������ ������ �����.
�������� ���������: ������������ M, B � R ��� ���������� ������,
����������� ��������������� ��������� ����� �� �������� �������.}
  procedure LinearLeastSquares(data: TRealPointArray; var M,B, R: extended);
{��������� - ��������� �������������� ������
(������ �������� ������ �� X � Y)}
  procedure GetXY(Val : string; var X, Y: Double);
  //���������� ��������� ����� ����� ����� ��� �������� � ���� �� �����
  function FindGradPointX(p_Series:  TChartSeries; p_Y: Double): Integer;
  //���������� ��������� ����� ����� ����� ��� �������� � ���� �� �����
  function FindGradPointY(p_Series:  TChartSeries; p_X: Double): Integer;

  procedure LinearLeastSquaresForSerie(p_Series: TChartSeries; p_GradPointNum: Integer; var M,B,R: extended);

  procedure LoadGradData(p_Series:  TChartSeries; p_FileName: string; var Y0: Double; var MaxY: Double);
var
  MainFrm: TMainFrm;

implementation

{$R *.dfm}  //��������� �������� �����

{�������� ������}
procedure LoadGradData(p_Series:  TChartSeries; p_FileName: string; var Y0: Double; var MaxY: Double);
var
  X, Y: Double;
  I: Integer;
  Points: array of TPoint;
  pt: TPoint;
  SL : TStringList;
begin
   p_Series.Clear;
   //����������� ������� ������ �����, � �������� ����� ���������� �� ����
   SL := TStringList.Create();
   try
      SL.LoadFromFile(p_FileName); //�������� ���������� ������ �� ���������� �����
      Y0 := 0;
      MaxY := 0;
      for I := 0 to SL.Count -1 do
      begin
        GetXY(Trim(SL.Strings[I]), X, Y);//������ �������� ������ �� X � Y
        if I = 0 then
          Y0 := Y;
        if Y > MaxY then
          MaxY := Y;
        p_Series.AddXY(X, Y, '', clTeeColor);//��������� ����� �� �������
      end;
    finally
      FreeAndNil(SL); {������������ ������,
      ������������ ��������, � ��������������� ��������� ������ �� ����.}
    end;
end;

procedure TMainFrm.Button1Click(Sender: TObject);
var
 MaxY, MinY : Double;
begin
  if OpenDialog1.Execute then
  begin
    LoadGradData(Series1, OpenDialog1.FileName, MinY, MaxY);
    TrackBar1.Max := Round(MaxY) - 1; //����������� ������
    TrackBar1.Min := Round(MinY) + 1;
    TrackBar1.Position := 0;   //�������� ���������� ��������
    {TrdckBar ������� ������ ����� ��� ������� ���������}
  //  TrackBar1.Enabled := (Series1.Count > 0) and (Series3.Count > 0);
    TrackBar1.Update;
  end;
end;

{���������� ����� ������ ������� �� �������������� ������ �����
������� ��������}
function FindGradPointX(p_Series:  TChartSeries; p_Y: Double): Integer;
var
  I: Integer;
begin
  try
    Result:= 0;
    for I := 0 to p_Series.Count -1 do
    begin
      if p_Series.YValue[I] >= p_Y then
      begin
        Result := I;
        break;
      end;
   end;
  except on E: Exception do
   begin
    ShowMessage(E.Message);  //��������� �������������� ��������
   end;
  end;
end;

{���������� ����� �� �������������� ������, ������� ����� �����
�� �������� ��������}
function FindGradPointY(p_Series:  TChartSeries; p_X: Double): Integer;
var
  I: Integer;
begin
  try
    Result:= 0;
    for I := 0 to p_Series.Count -1 do
    begin
      if p_Series.XValue[I] >= p_X then
      begin
        Result := I;
        break;
      end;
   end;
  except on E: Exception do
   begin
    ShowMessage(E.Message);  //��������� �������������� ��������
   end;
  end;
end;


procedure LinearLeastSquaresForSerie(p_Series: TChartSeries; p_GradPointNum: Integer; var M,B,R: extended);
var
  //������ �� 2 �����
  data: TRealPointArray;
  X_prev, Y_prev, X_next, Y_next : Double;
begin

     M:= 0;
     B:= 0;
     R:= 0;

     if p_GradPointNum = 0 then exit;
     if p_GradPointNum >= p_Series.Count then exit;

   //� ������� ������ ����� ����� ����� 0
     Y_prev := p_Series.YValue[p_GradPointNum-1];
     X_prev := p_Series.XValue[p_GradPointNum-1];

     Y_next := p_Series.YValue[p_GradPointNum];
     X_next := p_Series.XValue[p_GradPointNum];

     //��� �������� �� ����������� Y �� ��������
     if Y_prev = Y_next then
     begin
      Exit;
     end;

      //��������� ����� ������������� ������� � ��� �����
      setlength(data, 2);

      data[0].y := Y_prev;
      data[0].x := X_prev;
      data[1].y := Y_next;
      data[1].x := X_next;

      //���������� �������������
      LinearLeastSquares(data, M, B, R);

end;

procedure TMainFrm.TrackBar1Change(Sender: TObject);
var
  X_calc, Y_calc : Double;
  X_Poten_prev, Y_Poten_prev, X_Poten_next, Y_Poten_next, X_Poten_calc, Y_Poten_calc : Double;
  GradPoint, I : Integer;
  M,B, R: extended;
begin
  try
    //FindGradPoint ���������� �������� �� 1
    GradPoint := FindGradPointX(Series1, TrackBar1.Position);
    if  GradPoint = 0 then exit;
    {����� ����� ������ ������� ����� ����������� �����}
    lbl_GradPointPrev.Caption := IntToStr(GradPoint);   //�����
    lbl_GradPointNext.Caption := IntToStr(GradPoint+1); //������

    LinearLeastSquaresForSerie(Series1, GradPoint, M,B,R);
    if M = 0 then exit;

    {y = Mx + B, ������������� x =(Y - B)/M }
    Y_calc := TrackBar1.Position;
    X_calc := (Y_calc - B)/M;

    //��������� ����� �� ������� (�������� ����� � ������� ����� �����)
    Series2.Clear;
    Series2.AddXY(X_calc, Y_calc, '');
    {����� �������� � ��������� �����������
    brighteness, current}
    ed_Power.Text := FloatToStr(Y_calc);
    ed_Current.Text := FloatToStrF(X_calc, ffFixed, 4, 4);

    X_Poten_calc := X_calc;
    GradPoint := FindGradPointY(Series3, X_Poten_calc);
    if  GradPoint < 0 then exit;
    LinearLeastSquaresForSerie(Series3, GradPoint, M,B,R);

    //y = Mx + B
    Y_Poten_calc := M * X_Poten_calc + B;
    //��������� ����� �� ������� (�������� ����� � ������� ����� �����)
    Series4.Clear;
    Series4.AddXY(X_Poten_calc, Y_Poten_calc);
    {����� control potential � �������� �����������}
    ed_ControlPotential.Text := FloatToStrF(Y_Poten_calc, ffFixed, 4, 4);
  except on E: Exception do
   begin
    ShowMessage(E.Message);  //��������� �������������� ��������
   end;
  end;
end;


{��������� - ���������� ������ ���������� ���������.}
procedure LinearLeastSquares(data: TRealPointArray; var M,B,R: extended);
 {Line "Y = mX + b" is linear least squares line for the input array, "data",
  of TRealPoint}
var
  SumX, SumY, SumX2, SumY2, SumXY: extended;
  Sx,Sy:extended;
  n, i: Integer;
begin
  n := Length(data); {���������� �����}
  SumX := 0.0;   SumY := 0.0;
  SumX2 := 0.0;  SumY2:=0.0;
  SumXY := 0.0;

  for i := 0 to n - 1 do
  begin
    //������� ��� X
    SumX := SumX + data[i].X;
    //������� ��� Y
    SumY := SumY + data[i].Y;
    //������� �������� X
    SumX2 := SumX2 + data[i].X*data[i].X;
    //������� �������� Y
    SumY2 := SumY2 + data[i].Y*data[i].Y;
    //������� ������������ X � Y
    SumXY := SumXY + data[i].X*data[i].Y;
  end;
{�������� �� ��, ��� ������ �� ������� �� �����,
� ������� ���������� ���������� �� ����}
  if (n*SumX2=SumX*SumX) or (n*SumY2=SumY*SumY)
  then
  begin
    showmessage('LeastSquares() Error - X or Y  values cannot all be the same');
    M:=0;
    B:=0;
  end
  else{����� �������� ��������, ��������� �������� ���}
  begin
    M:=((n * SumXY) - (SumX * SumY)) / ((n * SumX2) - (SumX * SumX)); {������ ������ (M)}
    B:=(SumY-M*SumX)/n;  {������ ������ (B)}
    Sx:=sqrt(SumX2-sqr(SumX)/n);
    Sy:=Sqrt(SumY2-sqr(SumY)/n);
    r:=(SumXY-SumX*SumY/n)/(Sx*Sy); //����������� ����������
  end;
end;

// ������ �������� ������ �� X � Y
procedure GetXY(Val : string; var X, Y: Double);
var
  temp : string;
  DelimPos : Integer;
begin
  DelimPos := Pos(';', Val); //����� ������� ����������� (;)
  temp := Copy(Val, 0, DelimPos - 1);
  X := StrToFloat(temp);     //X-����� �� �����������
  temp := Copy(Val, DelimPos+1, 999);
  Y := StrToFloat(temp);     //Y-����� ����� �����������
end;

procedure TMainFrm.Button2Click(Sender: TObject);
var
  Y0, MaY : Double;
begin
 if OpenDialog1.Execute then
  begin
    LoadGradData(Series3, OpenDialog1.FileName, Y0, MaY);
  end;
 // TrackBar1.Enabled := (Series1.Count > 0) and (Series3.Count > 0);
end;

procedure TMainFrm.Button3Click(Sender: TObject);
var
  Y1, MxY : Double;
begin
 if OpenDialog1.Execute then
  begin
    LoadGradData(Series5, OpenDialog1.FileName, Y1, MxY);
    Series6.Clear;
    Series6.AddXY(0, 0);
  end;
 // TrackBar1.Enabled := (Series1.Count > 0) and (Series3.Count > 0);
end;

procedure TMainFrm.btnStartClick(Sender: TObject);
begin
  Timer1.Enabled := not Timer1.Enabled;
  if not Timer1.Enabled then
    btnStart.Caption := 'Start';
end;

procedure TMainFrm.Timer1Timer(Sender: TObject);
var
  X, Y, X1, Y1 : Double;
  Ind : Integer;
  M,B, R: extended;
begin
  X := Series6.XValue[0];
  Y := Series5.MaxYValue;
  Series6.Clear;
  X := X + 0.1;
  Series6.AddXY(X, Y);
  Series6.AddXY(X, 0);

  Ind := FindGradPointY(Series5, X);
  LinearLeastSquaresForSerie(Series5, Ind, M, B, R);
  if (M = 0) and (B = 0) then
    Y1 := Series5.YValues[Ind]
  else // y = Mx + B,
    Y1 := M * X + B;
  TrackBar1.Position := Round(Y1);
  ed_OperativePower.Text := FloatToStrF(Y1, ffFixed, 4, 2);

  btnStart.Caption := 'Pause';

  if X >= Series5.MaxXValue then
  begin
    Timer1.Enabled := false;
    Series6.Clear;
    Series6.AddXY(0, 0);
    btnStart.Caption := 'Start';
  end;

end;


end.
