object DMSqLiteForm: TDMSqLiteForm
  Left = 0
  Top = 0
  Caption = 'DMSqLiteForm'
  ClientHeight = 712
  ClientWidth = 1131
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnActivate = FormActivate
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter2: TSplitter
    Left = 0
    Top = 663
    Width = 1131
    Height = 3
    Cursor = crVSplit
    Align = alBottom
    ExplicitTop = 524
    ExplicitWidth = 1128
  end
  object spl1: TSplitter
    Left = 562
    Top = 0
    Height = 663
    ExplicitLeft = 468
    ExplicitTop = 240
    ExplicitHeight = 100
  end
  object GroupBox3: TGroupBox
    Left = 0
    Top = 0
    Width = 562
    Height = 663
    Align = alLeft
    Caption = 'Base Paradox'
    TabOrder = 0
    object Splitter1: TSplitter
      Left = 2
      Top = 218
      Width = 558
      Height = 3
      Cursor = crVSplit
      Align = alTop
      ExplicitWidth = 393
    end
    object Label2: TLabel
      Left = 374
      Top = 452
      Width = 136
      Height = 13
      Caption = #1055#1086' '#1091#1084#1086#1083#1095#1072#1085#1080#1102' '#1079#1072' '#1086#1076#1080#1085' '#1075#1086#1076
    end
    object Label1: TLabel
      Left = 3
      Top = 466
      Width = 44
      Height = 13
      Caption = 'Alias BDE'
    end
    object dbgrdBde: TDBGrid
      Left = 2
      Top = 221
      Width = 558
      Height = 208
      Align = alTop
      DataSource = ds1
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
    end
    object CheckListBox1: TCheckListBox
      Left = 2
      Top = 15
      Width = 558
      Height = 203
      Align = alTop
      TabOrder = 1
      OnClick = CheckListBox1Click
    end
    object btnTestBaseBde: TButton
      Left = 187
      Top = 582
      Width = 75
      Height = 25
      Caption = 'TestBaseBde'
      TabOrder = 2
      Visible = False
      OnClick = btnTestBaseBdeClick
    end
    object MonthCalendar1: TMonthCalendar
      Left = 365
      Top = 471
      Width = 191
      Height = 160
      Date = 42614.000000000000000000
      TabOrder = 3
    end
    object ButtonCheckAllTblBde: TButton
      Left = 3
      Top = 435
      Width = 124
      Height = 25
      Caption = 'Checked All Tables'
      TabOrder = 4
      OnClick = ButtonCheckAllTblBdeClick
    end
    object ButtonCheckUsesTblBde: TButton
      Left = 0
      Top = 520
      Width = 124
      Height = 25
      Caption = 'Checked Uses Tables'
      TabOrder = 5
      Visible = False
      OnClick = ButtonCheckUsesTblBdeClick
    end
    object CheckBoxAfterDate: TCheckBox
      Left = 365
      Top = 435
      Width = 208
      Height = 17
      Caption = #1050#1086#1087#1080#1088#1086#1074#1072#1090#1100' '#1076#1072#1085#1085#1099#1077' '#1087#1086#1089#1083#1077' '#1076#1072#1090#1099
      Checked = True
      State = cbChecked
      TabOrder = 6
    end
    object ComboBoxAlias: TComboBox
      Left = 3
      Top = 488
      Width = 145
      Height = 21
      TabOrder = 7
      OnChange = ComboBoxAliasChange
    end
    object ButtonTestParent: TButton
      Left = 279
      Top = 582
      Width = 100
      Height = 25
      Caption = 'ButtonTestParent'
      TabOrder = 8
      Visible = False
      OnClick = ButtonTestParentClick
    end
    object CheckBoxOnlyActiv: TCheckBox
      Left = 133
      Top = 435
      Width = 220
      Height = 17
      Caption = #1050#1086#1087#1080#1088#1086#1074#1072#1090#1100' '#1090#1086#1083#1100#1082#1086' '#1040#1082#1090#1080#1074#1085#1099#1077' '#1076#1072#1085#1085#1099#1077
      Checked = True
      State = cbChecked
      TabOrder = 9
    end
  end
  object GroupBox4: TGroupBox
    Left = 0
    Top = 666
    Width = 1131
    Height = 46
    Align = alBottom
    TabOrder = 1
    object Label3: TLabel
      Left = 920
      Top = 6
      Width = 116
      Height = 13
      Caption = #1054#1073#1088#1072#1073#1086#1090#1072#1085#1072' '#1089#1090#1088#1086#1082#1072' '#8470
    end
    object LabelStrInd: TLabel
      Left = 1056
      Top = 6
      Width = 3
      Height = 13
    end
    object btnCreateTableFromTxt: TButton
      Left = 531
      Top = 3
      Width = 182
      Height = 25
      Caption = 'Create New SqLite Base From Txt'
      TabOrder = 0
      OnClick = btnCreateTableFromTxtClick
    end
    object btnCopyDataFromTxt: TButton
      Left = 719
      Top = 3
      Width = 182
      Height = 25
      Caption = 'Copy Data From Txt'
      TabOrder = 1
      OnClick = btnCopyDataFromTxtClick
    end
  end
  object GroupBox5: TGroupBox
    Left = 565
    Top = 0
    Width = 566
    Height = 663
    Align = alClient
    Caption = 'Base SQLite'
    TabOrder = 2
    object Splitter3: TSplitter
      Left = 2
      Top = 218
      Width = 562
      Height = 3
      Cursor = crVSplit
      Align = alTop
      ExplicitWidth = 393
    end
    object SpeedButton1: TSpeedButton
      Left = 522
      Top = 473
      Width = 23
      Height = 22
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Times New Roman'
      Font.Style = []
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00555555555555
        5555555555555555555555555555555555555555555555555555555555555555
        555555555555555555555555555555555555555FFFFFFFFFF555550000000000
        55555577777777775F55500B8B8B8B8B05555775F555555575F550F0B8B8B8B8
        B05557F75F555555575F50BF0B8B8B8B8B0557F575FFFFFFFF7F50FBF0000000
        000557F557777777777550BFBFBFBFB0555557F555555557F55550FBFBFBFBF0
        555557F555555FF7555550BFBFBF00055555575F555577755555550BFBF05555
        55555575FFF75555555555700007555555555557777555555555555555555555
        5555555555555555555555555555555555555555555555555555}
      NumGlyphs = 2
      ParentFont = False
      OnClick = SpeedButton1Click
    end
    object btnCopyData: TButton
      Left = 158
      Top = 501
      Width = 75
      Height = 25
      Caption = 'CopyData'
      TabOrder = 0
      OnClick = btnCopyDataClick
    end
    object CheckListBox2: TCheckListBox
      Left = 2
      Top = 15
      Width = 562
      Height = 203
      Align = alTop
      TabOrder = 1
      OnClick = CheckListBox2Click
    end
    object DBGridSql: TDBGrid
      Left = 2
      Top = 221
      Width = 562
      Height = 208
      Align = alTop
      DataSource = DataSourceSql
      TabOrder = 2
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
    end
    object ButtonTestBaseSql: TButton
      Left = 250
      Top = 501
      Width = 75
      Height = 25
      Caption = 'TestBaseSql'
      TabOrder = 3
      Visible = False
      OnClick = ButtonTestBaseSqlClick
    end
    object ButtonCheckAllTblSql: TButton
      Left = 6
      Top = 435
      Width = 124
      Height = 25
      Caption = 'Checked All Tables'
      TabOrder = 4
      OnClick = ButtonCheckAllTblSqlClick
    end
    object Edit1: TEdit
      Left = 3
      Top = 613
      Width = 487
      Height = 21
      TabOrder = 5
      Text = 'Edit1'
      Visible = False
    end
    object CheckBoxToAndroid: TCheckBox
      Left = 151
      Top = 435
      Width = 208
      Height = 17
      Caption = #1047#1072#1084#1077#1085#1072' '#1087#1086#1083#1103' Cod '#1085#1072' _id '#1076#1083#1103' Android'
      Checked = True
      State = cbChecked
      TabOrder = 6
    end
    object EditNameSqliteBase: TEdit
      Left = 15
      Top = 474
      Width = 487
      Height = 21
      TabOrder = 7
      Text = 'Edit1'
      OnChange = EditNameSqliteBaseChange
    end
  end
  object btnCreateTable: TButton
    Left = 574
    Top = 501
    Width = 124
    Height = 25
    Caption = 'Create New SqLite Base'
    TabOrder = 3
    OnClick = btnCreateSqliteBaseClick
  end
  object dbTrade: TDatabase
    AliasName = 'Trade'
    DatabaseName = 'Trade'
    LoginPrompt = False
    Params.Strings = (
      'PASSWORD=MasterTrade')
    ReadOnly = True
    SessionName = 'Default'
    Left = 18
    Top = 552
  end
  object qryTovar: TQuery
    DatabaseName = 'Trade'
    SQL.Strings = (
      'SELECT *'
      'FROM Tovar ')
    Left = 405
    Top = 328
  end
  object ds1: TDataSource
    DataSet = Query1
    Left = 513
    Top = 320
  end
  object conTradeSqlite: TSQLConnection
    ConnectionName = 'SQLITECONNECTION'
    DriverName = 'Sqlite'
    LoginPrompt = False
    Params.Strings = (
      'DriverUnit=Data.DbxSqlite'
      
        'DriverPackageLoader=TDBXSqliteDriverLoader,DBXSqliteDriver230.bp' +
        'l'
      
        'MetaDataPackageLoader=TDBXSqliteMetaDataCommandFactory,DbxSqlite' +
        'Driver230.bpl'
      'FailIfMissing=False'
      'Database=D:\Preobr\Android\BaseSQLite\Test.s3db')
    Left = 1073
    Top = 529
  end
  object qryEdIzmer: TQuery
    DatabaseName = 'Trade'
    SQL.Strings = (
      'select * from EdIzmer')
    Left = 72
    Top = 552
  end
  object tblEdIzmer: TTable
    DatabaseName = 'Trade'
    TableName = 'EdIzmer.DB'
    Left = 459
    Top = 328
  end
  object Query1: TQuery
    DatabaseName = 'Trade'
    SessionName = 'Default'
    SQL.Strings = (
      '')
    Left = 117
    Top = 552
  end
  object fdQry1: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      'select * from Agent')
    Left = 649
    Top = 568
  end
  object SQLQuery1: TSQLQuery
    MaxBlobSize = -1
    Params = <>
    SQLConnection = conTradeSqlite
    Left = 1048
    Top = 424
  end
  object SQLTable1: TSQLTable
    MaxBlobSize = -1
    SQLConnection = conTradeSqlite
    Left = 1048
    Top = 376
  end
  object FDConnection1: TFDConnection
    Params.Strings = (
      'Database=D:\Tel\BaseSQLite\Test.s3db'
      'DriverID=SQLite')
    Left = 580
    Top = 568
  end
  object DataSourceSql: TDataSource
    DataSet = fdQry1
    Left = 734
    Top = 568
  end
  object OpenDialog1: TOpenDialog
    Left = 922
    Top = 544
  end
  object TableParent: TTable
    DatabaseName = 'Trade'
    TableName = 'Parent.DB'
    Left = 351
    Top = 328
  end
end
