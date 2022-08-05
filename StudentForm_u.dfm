object StudentForm: TStudentForm
  Left = 0
  Top = 0
  Caption = 'StudentForm'
  ClientHeight = 548
  ClientWidth = 856
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object lblWelcome: TLabel
    Left = 184
    Top = 8
    Width = 538
    Height = 81
    Caption = 'Welcome Student!'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -67
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label1: TLabel
    Left = 368
    Top = 104
    Width = 137
    Height = 13
    Caption = 'Take a look at your schedule'
  end
  object stLoadedGrid: TStringGrid
    Left = 176
    Top = 251
    Width = 497
    Height = 246
    TabOrder = 0
  end
  object btnLoadFromTextFile: TBitBtn
    Left = 384
    Top = 200
    Width = 97
    Height = 33
    Caption = 'Load Time Table'
    TabOrder = 1
    OnClick = btnLoadFromTextFileClick
  end
  object tblStudents: TDBGrid
    Left = 16
    Top = 8
    Width = 105
    Height = 52
    TabOrder = 2
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    Visible = False
  end
  object BitBtn1: TBitBtn
    Left = 744
    Top = 472
    Width = 75
    Height = 25
    Kind = bkClose
    NumGlyphs = 2
    TabOrder = 3
  end
end
