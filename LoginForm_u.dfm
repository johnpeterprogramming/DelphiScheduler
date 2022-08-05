object LoginForm: TLoginForm
  Left = 0
  Top = 0
  Caption = 'LoginForm'
  ClientHeight = 561
  ClientWidth = 939
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 336
    Top = 168
    Width = 48
    Height = 13
    Caption = 'Username'
  end
  object Label2: TLabel
    Left = 336
    Top = 207
    Width = 46
    Height = 13
    Caption = 'Password'
  end
  object Label3: TLabel
    Left = 335
    Top = 264
    Width = 284
    Height = 13
    Caption = 'Need new Account? Login as Admin to create new account.'
  end
  object edtUsername: TEdit
    Left = 400
    Top = 165
    Width = 121
    Height = 21
    TabOrder = 0
    Text = 'admin'
  end
  object edtPassword: TEdit
    Left = 400
    Top = 204
    Width = 121
    Height = 21
    TabOrder = 1
    Text = '1234'
  end
  object BitBtn2: TBitBtn
    Left = 544
    Top = 174
    Width = 75
    Height = 46
    Caption = 'Log In'
    TabOrder = 2
    OnClick = BitBtn2Click
  end
  object tblAccounts: TDBGrid
    Left = 368
    Top = 336
    Width = 193
    Height = 73
    TabOrder = 3
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    Visible = False
  end
end
