object MainFrm: TMainFrm
  Left = 420
  Top = 6
  Caption = 'Laser Power Control'
  ClientHeight = 671
  ClientWidth = 839
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object lbl_Power: TLabel
    Left = 40
    Top = 72
    Width = 30
    Height = 13
    Caption = 'Power'
  end
  object lbl_Current: TLabel
    Left = 40
    Top = 136
    Width = 34
    Height = 13
    Caption = 'Current'
  end
  object lbl_ControlPotential: TLabel
    Left = 40
    Top = 184
    Width = 77
    Height = 13
    Caption = 'Control Potential'
  end
  object lbl_GradPointPrev: TLabel
    Left = 118
    Top = 24
    Width = 6
    Height = 13
    Caption = '0'
  end
  object lbl_TrackBetween: TLabel
    Left = 40
    Top = 24
    Width = 72
    Height = 13
    Caption = 'Track between'
  end
  object lbl_GradPointNext: TLabel
    Left = 144
    Top = 24
    Width = 6
    Height = 13
    Caption = '0'
  end
  object lbl_Autor: TLabel
    Left = 616
    Top = 8
    Width = 214
    Height = 13
    Caption = 'Author: Konnov D.D. konnovd92@gmail.com'
  end
  object Label1: TLabel
    Left = 160
    Top = 72
    Width = 79
    Height = 13
    Caption = 'Operative Power'
  end
  object Label2: TLabel
    Left = 168
    Top = 24
    Width = 185
    Height = 13
    Caption = 'point on Energetic Characteristics chart'
  end
  object Chart1: TChart
    Left = 296
    Top = 80
    Width = 537
    Height = 361
    BackWall.Brush.Style = bsClear
    Title.Text.Strings = (
      'Energetic Characteristics')
    BottomAxis.LabelsFormat.TextAlignment = taCenter
    BottomAxis.Title.Caption = 'Current'
    DepthAxis.LabelsFormat.TextAlignment = taCenter
    DepthTopAxis.LabelsFormat.TextAlignment = taCenter
    LeftAxis.GridCentered = True
    LeftAxis.LabelsFormat.TextAlignment = taCenter
    LeftAxis.Title.Caption = 'Power'
    RightAxis.LabelsFormat.TextAlignment = taCenter
    TopAxis.LabelsFormat.TextAlignment = taCenter
    View3D = False
    Zoom.Pen.Mode = pmNotXor
    TabOrder = 0
    DefaultCanvas = 'TGDIPlusCanvas'
    ColorPaletteIndex = 13
    object Series1: TPointSeries
      Marks.Visible = False
      Marks.Callout.Length = 8
      SeriesColor = clRed
      Title = 'Graduation'
      ClickableLine = False
      Pointer.Brush.Gradient.EndColor = clRed
      Pointer.Gradient.EndColor = clRed
      Pointer.InflateMargins = True
      Pointer.Style = psRectangle
      Pointer.Visible = True
      XValues.Name = 'X'
      XValues.Order = loAscending
      YValues.Name = 'Y'
      YValues.Order = loNone
    end
    object Series2: TPointSeries
      Marks.Visible = False
      Marks.Callout.Length = 8
      SeriesColor = clGreen
      Title = 'Operative point'
      ClickableLine = False
      Pointer.Brush.Gradient.EndColor = clGreen
      Pointer.Gradient.EndColor = clGreen
      Pointer.InflateMargins = True
      Pointer.Style = psRectangle
      Pointer.Visible = True
      XValues.Name = 'X'
      XValues.Order = loAscending
      YValues.Name = 'Y'
      YValues.Order = loNone
    end
  end
  object Button1: TButton
    Left = 712
    Top = 88
    Width = 113
    Height = 25
    Caption = 'Graduation'
    TabOrder = 1
    OnClick = Button1Click
  end
  object ed_Power: TEdit
    Left = 40
    Top = 88
    Width = 49
    Height = 21
    TabOrder = 2
    Text = '0'
  end
  object ed_Current: TEdit
    Left = 40
    Top = 152
    Width = 129
    Height = 21
    TabOrder = 3
    Text = '0'
  end
  object ed_ControlPotential: TEdit
    Left = 40
    Top = 200
    Width = 129
    Height = 21
    TabOrder = 4
    Text = '0'
  end
  object TrackBar1: TTrackBar
    Left = 40
    Top = 40
    Width = 769
    Height = 25
    Max = 10000
    Position = 1050
    TabOrder = 5
    OnChange = TrackBar1Change
  end
  object Chart2: TChart
    Left = 8
    Top = 240
    Width = 281
    Height = 201
    BackWall.Brush.Style = bsClear
    Title.Text.Strings = (
      'Lamp Characteristic')
    BottomAxis.LabelsFormat.TextAlignment = taCenter
    BottomAxis.Title.Caption = 'Current'
    DepthAxis.LabelsFormat.TextAlignment = taCenter
    DepthTopAxis.LabelsFormat.TextAlignment = taCenter
    LeftAxis.LabelsFormat.TextAlignment = taCenter
    LeftAxis.Title.Caption = 'Voltage'
    RightAxis.LabelsFormat.TextAlignment = taCenter
    TopAxis.LabelsFormat.TextAlignment = taCenter
    View3D = False
    Zoom.Pen.Mode = pmNotXor
    TabOrder = 6
    DefaultCanvas = 'TGDIPlusCanvas'
    ColorPaletteIndex = 13
    object Series3: TFastLineSeries
      Marks.Visible = False
      SeriesColor = clRed
      Title = 'Characteristic'
      LinePen.Color = clRed
      XValues.Name = 'X'
      XValues.Order = loAscending
      YValues.Name = 'Y'
      YValues.Order = loNone
    end
    object Series4: TPointSeries
      Marks.Visible = False
      SeriesColor = clGreen
      Title = 'Operative point'
      ClickableLine = False
      Pointer.Brush.Gradient.EndColor = clGreen
      Pointer.Gradient.EndColor = clGreen
      Pointer.InflateMargins = True
      Pointer.Style = psRectangle
      Pointer.Visible = True
      XValues.Name = 'X'
      XValues.Order = loAscending
      YValues.Name = 'Y'
      YValues.Order = loNone
    end
  end
  object Button2: TButton
    Left = 168
    Top = 408
    Width = 113
    Height = 25
    Caption = 'Characteristic'
    TabOrder = 7
    OnClick = Button2Click
  end
  object Chart3: TChart
    Left = 6
    Top = 447
    Width = 825
    Height = 217
    BackWall.Brush.Style = bsClear
    Title.Text.Strings = (
      'Operative Data')
    BottomAxis.LabelsFormat.TextAlignment = taCenter
    BottomAxis.Title.Caption = 'Time'
    DepthAxis.LabelsFormat.TextAlignment = taCenter
    DepthTopAxis.LabelsFormat.TextAlignment = taCenter
    LeftAxis.LabelsFormat.TextAlignment = taCenter
    LeftAxis.Title.Caption = 'Power'
    RightAxis.LabelsFormat.TextAlignment = taCenter
    TopAxis.LabelsFormat.TextAlignment = taCenter
    View3D = False
    Zoom.Pen.Mode = pmNotXor
    TabOrder = 8
    DefaultCanvas = 'TGDIPlusCanvas'
    ColorPaletteIndex = 13
    object Series5: TLineSeries
      Marks.Visible = False
      SeriesColor = clRed
      Brush.BackColor = clDefault
      Pointer.InflateMargins = True
      Pointer.Style = psRectangle
      Pointer.Visible = False
      XValues.Name = 'X'
      XValues.Order = loAscending
      YValues.Name = 'Y'
      YValues.Order = loNone
    end
    object Series6: TLineSeries
      Marks.Visible = False
      Brush.BackColor = clDefault
      Pointer.InflateMargins = True
      Pointer.Style = psRectangle
      Pointer.Visible = False
      XValues.Name = 'X'
      XValues.Order = loAscending
      YValues.Name = 'Y'
      YValues.Order = loNone
    end
  end
  object Button3: TButton
    Left = 168
    Top = 448
    Width = 113
    Height = 25
    Caption = 'Load Operative Data'
    TabOrder = 9
    OnClick = Button3Click
  end
  object btnStart: TButton
    Left = 87
    Top = 447
    Width = 75
    Height = 25
    Caption = 'Start'
    TabOrder = 10
    OnClick = btnStartClick
  end
  object ed_OperativePower: TEdit
    Left = 160
    Top = 88
    Width = 79
    Height = 21
    TabOrder = 11
    Text = '0'
  end
  object OpenDialog1: TOpenDialog
    Filter = 'Text Files|*.txt'
    Left = 760
    Top = 376
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 50
    OnTimer = Timer1Timer
    Left = 760
    Top = 312
  end
end
