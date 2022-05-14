unit DMSqLiteUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Bde.DBTables, Vcl.Grids,
  Vcl.DBGrids, Vcl.StdCtrls, Data.DbxSqlite, Data.SqlExpr, Data.FMTBcd,
  Vcl.DBCtrls, Vcl.ExtCtrls, Vcl.ValEdit, Vcl.CheckLst, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, FireDAC.UI.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Phys, FireDAC.Phys.SQLite, FireDAC.Phys.SQLiteDef,
  FireDAC.Stan.ExprFuncs, FireDAC.VCLUI.Wait, Vcl.Samples.Calendar, Vcl.ComCtrls
  ,DateUtils, Vcl.Buttons
  ;

type
  TDMSqLiteForm = class(TForm)
    dbTrade: TDatabase;
    qryTovar: TQuery;
    ds1: TDataSource;
    conTradeSqlite: TSQLConnection;  // не используется
    SQLQuery1: TSQLQuery;   // не используется
    SQLTable1: TSQLTable;   // не используется
    GroupBox3: TGroupBox;
    dbgrdBde: TDBGrid;
    GroupBox4: TGroupBox;
    Splitter2: TSplitter;
    spl1: TSplitter;
    GroupBox5: TGroupBox;
    btnCreateTableFromTxt: TButton;
    btnCopyData: TButton;
    qryEdIzmer: TQuery;
    CheckListBox1: TCheckListBox;
    Splitter1: TSplitter;
    btnCreateTable: TButton;
    btnTestBaseBde: TButton;
    tblEdIzmer: TTable;
    Query1: TQuery;
    fdQry1: TFDQuery;
    FDConnection1: TFDConnection;
    MonthCalendar1: TMonthCalendar;
    ButtonCheckAllTblBde: TButton;
    CheckListBox2: TCheckListBox;
    Splitter3: TSplitter;
    DBGridSql: TDBGrid;
    ButtonTestBaseSql: TButton;
    ButtonCheckAllTblSql: TButton;
    DataSourceSql: TDataSource;
    Edit1: TEdit;
    Label2: TLabel;
    CheckBoxToAndroid: TCheckBox;
    EditNameSqliteBase: TEdit;
    ButtonCheckUsesTblBde: TButton;
    OpenDialog1: TOpenDialog;
    SpeedButton1: TSpeedButton;
    CheckBoxAfterDate: TCheckBox;
    ComboBoxAlias: TComboBox;
    Label1: TLabel;
    TableParent: TTable;
    ButtonTestParent: TButton;
    btnCopyDataFromTxt: TButton;
    Label3: TLabel;
    LabelStrInd: TLabel;
    CheckBoxOnlyActiv: TCheckBox;
    procedure btnCreateSqliteBaseClick(Sender: TObject);
    procedure btnCopyDataClick(Sender: TObject);
    procedure btnTestBaseBdeClick(Sender: TObject);
    procedure FormSqlCreateTable(DataSet: TDataSet; Name : string; var SqlStr: String);
    procedure CheckListBox1Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure ButtonCheckAllTblBdeClick(Sender: TObject);
    procedure ButtonTestBaseSqlClick(Sender: TObject);
    procedure ButtonCheckAllTblSqlClick(Sender: TObject);
    procedure CheckListBox2Click(Sender: TObject);
    procedure EditNameSqliteBaseChange(Sender: TObject);
    procedure ButtonCheckUsesTblBdeClick(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure ComboBoxAliasChange(Sender: TObject);
    procedure ButtonTestParentClick(Sender: TObject);
    procedure btnCreateTableFromTxtClick(Sender: TObject);
    procedure btnCopyDataFromTxtClick(Sender: TObject);
    procedure CopyDataFromLiter(Sender: TObject);
    procedure CopyDataFromTems(Sender: TObject);

  private
    { Private declarations }
    const toAndroid : Boolean = True;
        /// Имя файла базы Sqlite
    NameSqliteBase : string = 'D:\Tel\BaseSQLite\Test.s3db';
    AliasName      : string = 'Trade';

    {!Имя файла txt преобразуемогов базу Sqlite}
    NameFromLiterTxt : string = 'd:\Preobr\Web\PanovTatar\Files\КаталогВспомогательныефайлы\Liter.txt';
    NameFromTemsTxt  : string = 'd:\Preobr\Web\PanovTatar\Files\КаталогВспомогательныефайлы\Tems.txt';

    NameSqliteBaseFromTxt : string = 'd:\Preobr\Web\PanovTatar\Files\КаталогВспомогательныефайлы\Katalog.s3db';
    NameLng    : Integer =255;
    AvtorLng   : Integer =127;
    UrlLng     : Integer =127;
    TemNameLng : Integer =127;
  public
    { Public declarations }
  end;

var
  DMSqLiteForm: TDMSqLiteForm;

implementation

{$R *.dfm}

procedure TDMSqLiteForm.FormActivate(Sender: TObject);
begin

  Session.GetAliasNames(ComboBoxAlias.Items );

  //dbTrade.AddPassword('MasterTrade');      dbTrade.Params.Add('Password=MasterTrade');
  dbTrade.Close;
  dbTrade.Params.Add('Password=MasterTrade');
  dbTrade.Params.Add('USER NAME=AllUser');
  ComboBoxAlias.Text:= AliasName;
  dbTrade.AliasName :=  ComboBoxAlias.Text;
  dbTrade.Open;

  btnTestBaseBdeClick(Sender);
  OpenDialog1.FileName := NameSqliteBase;
  EditNameSqliteBase.Text := NameSqliteBase;
//  FDConnection1.Params[conTradeSqlite.Params.IndexOfName('Database')] := EditNameSqliteBase.Text;
  FDConnection1.Params.Database := EditNameSqliteBase.Text;

  ButtonTestBaseSqlClick(Sender);
  MonthCalendar1.Date:= Date-364;    // Копировать данные после даты
//  ButtonCheckAllTblBde.OnClick(Sender);  // Выбор всех таблиц базы
  ButtonCheckUsesTblBde.OnClick(Sender);  // Выбор используемых таблиц базы
  CheckBoxToAndroid.Checked := toAndroid;
end;

procedure TDMSqLiteForm.FormSqlCreateTable(DataSet: TDataSet; Name : string; var SqlStr: String);
var
    St  : string;
    I   : Integer;
    SaveCursor : TCursor;
    Closed : Boolean;

begin
//  IF DataSet.RecordCount>0 then  //
      try
        SaveCursor := Screen.Cursor;
        Screen.Cursor := crHourglass;    { Show hourglass cursor }

        If Not DataSet.Active then begin
          DataSet.Open;   //DataSet
          Closed := True; // Nead Close DataSet in Finish
        end;

        St:='CREATE TABLE ';     //
        St:=St+Name+' ( ';
        // St:=St+DataSet.Name+' ( ';
        // DataSet.Name for Query = Name of Query but no Table
        If DataSet.FieldCount>0 then
         for I:=0 to DataSet.FieldCount-1 do begin

           //if (Name = 'Parent') and (I=0) and  CheckBoxToAndroid.Checked
           //then St:=St+'_id' +' integer PRIMARY KEY NOT NULL, ';

           if (DataSet.FieldDefs[I].Name='Cod') and CheckBoxToAndroid.Checked
           then St:=St+'_id'
           else St:=St+DataSet.FieldDefs[I].Name+' ';

           case DataSet.FieldDefs[I].DataType of
             ftString : St:=St+'Char ('+IntToStr(DataSet.FieldDefs[I].Size)+')';
             ftAutoInc, ftSmallInt, ftInteger, ftWord : St:=St+' integer';
             ftBoolean : St:=St+' boolean';
             ftCurrency : St:=St+' real';
             ftDate : St:=St+' date';
             ftTime : St:=St+' time';
             ftBlob : St:=St+' blob';
             ftFloat: St:=St+' float';
              else St:=St+' Char(20)';
           end; //case
           if (I=0) and (DataSet.FieldDefs[I].Name='Cod') then st:=St+' PRIMARY KEY NOT NULL';
           // AUTOINCREMENT добавлять нельзя-нарушается соответствие ключей в исх. и таблице результата
           if I<> (DataSet.FieldCount-1) then St:=St+', ';

         end;  //for
       // удаление концевых пробела+,
//        If (St<>'') and (St[Length(St)]=' ') then Delete(St,Length(St),1);
//        If (St<>'') and (St[Length(St)]=',') then Delete(St,Length(St),1);
       St:=St+' );';
        SqlStr := St;
      finally

       If DataSet.Active and Closed then DataSet.Close;
       Screen.Cursor := SaveCursor;  { Always restore to normal }
      end;
end;


procedure TDMSqLiteForm.SpeedButton1Click(Sender: TObject);
begin
 if OpenDialog1.Execute then  begin
  EditNameSqliteBase.Text := OpenDialog1.FileName;
  FDConnection1.Params.Database := EditNameSqliteBase.Text;
  ButtonTestBaseSqlClick(Sender);
 end;
end;

procedure TDMSqLiteForm.btnCreateTableFromTxtClick(Sender: TObject);
// котвертирование из txt в sqlite
var SaveCursor : TCursor;
    St : string;
    Closed : Boolean;
    F: TextFile;
begin
 try
        SaveCursor := Screen.Cursor;
        Screen.Cursor := crHourglass;    { Show hourglass cursor }

// del base
  FDConnection1.Close;
  // del file of base
  if FileExists(NameSqliteBaseFromTxt) then DeleteFile(NameSqliteBaseFromTxt);


  FDConnection1.Params.Database :=  NameSqliteBaseFromTxt;
  FDConnection1.Open;

 // CREATE TABLE  Liter
    // подготовка строки запроса для создания таблицы в St
        St :='';
        St:='CREATE TABLE ';     //
        St:=St+'Liter'+' ( ';
        St:=St+'_id'+' integer';
        St:=St+' PRIMARY KEY AUTOINCREMENT'+', ';
        St:=St+'Avtor'+' Char ('+IntToStr(AvtorLng)+')'+', ';
        St:=St+'Name'+' Char ('+IntToStr(NameLng)+')'+', ';
        St:=St+'TemId'+' integer'+', ';
        St:=St+'Url'+' Char ('+IntToStr(UrlLng)+')';
        St:=St+' );';
       //  Edit1.Text:=St;
  FDConnection1.ExecSQL(St,True);

 // CREATE TABLE  Tems
    // подготовка строки запроса для создания таблицы в St
        St :='';
        St:='CREATE TABLE ';     //
        St:=St+'Tems'+' ( ';
        St:=St+'_id'+' integer'+', ';
        //St:=St+' PRIMARY KEY AUTOINCREMENT'+', ';
        St:=St+'Name'+' Char ('+IntToStr(TemNameLng)+')'+', ';
        St:=St+'Name1'+' Char ('+IntToStr(TemNameLng)+')';
        St:=St+' );';
       //  Edit1.Text:=St;
  FDConnection1.ExecSQL(St,True);

 finally
       Screen.Cursor := SaveCursor;  { Always restore to normal }
 end;

  ButtonTestBaseSqlClick(Sender);

end;


procedure TDMSqLiteForm.btnCopyDataClick(Sender: TObject);
var stQuery, Buf:string;
     I,LCount , MinCod  : Integer;
     SaveCursor : TCursor;
     Check : Boolean;

  procedure InsertRec;
  var J: Integer;
        begin
          fdQry1.Insert;
          for J:=0 to LCount-1 do
//          SQLQuery1.FieldByName(Query1.Fields[J].FieldName).Assign(Query1.FieldByName(Query1.Fields[J].FieldName));
            fdQry1.Fields[J].Assign(Query1.Fields[J]);
          fdQry1.POST;
        end;

begin
  SaveCursor     := Screen.Cursor;
  Screen.Cursor  := crHourglass;    { Show hourglass cursor }

  FDConnection1.Connected := False;
  FDConnection1.Connected := True;

//  stQuery:= 'Select   max(Cod) as MaxCod from Nakl N where N.DocDate < ''01.01.2015'' ';

//  stQuery:= 'Select   max(Cod) as MaxCod from Nakl N where N.DocDate < '''+
//       DateToStr(MonthCalendar1.Date)+''' ';
  if CheckBoxAfterDate.Checked then
  begin
     stQuery:= 'Select   min(Cod) as MinCod from    Nakl N where N.DocDate > '''+
       DateToStr(MonthCalendar1.Date)+''' ';
     Query1.SQL.Clear;
     Query1.SQL.Add(stQuery);
     Query1.Open;
     MinCod:= Query1.FieldByName('MinCod').AsInteger;   // 13730
   end;

// перебор таблиц базы
  for I := 0 to CheckListBox1.Items.Count-1 do
  begin
   CheckListBox1.ItemIndex:=I; // маркер на обрабатываемую таблицу
   if CheckListBox1.Checked[i] then
   begin
//     FDConnection1.ExecSQL('BEGIN TRANSACTION',True);
//     conTradeSqlite.ExecuteDirect('BEGIN TRANSACTION');
// удаление содержимого таблицы
//     conTradeSqlite.ExecuteDirect('DELETE * FROM '+CheckListBox1.Items[i]);

//     if (CheckListBox1.Items[i]='Sotrudn') then Query1.Params.Add('Password=MasterTrade');


     stQuery:= 'Select * From ' + CheckListBox1.Items[i]+';';

     // в свойство предварительно должно быть введена одна пустая строка
     Query1.SQL.Clear;
     Query1.SQL.Add(stQuery);
//     Query1.SQL[0]:= stQuery;

     Query1.Open;
     Query1.First;
     LCount := Query1.FieldCount; // count of fields

//     if fdQry1.SQL.Count=1 then fdQry1.SQL[0]:=stQuery else fdQry1.SQL.Add(stQuery);
//     fdQry1.SQL[0]:= stQuery;
     fdQry1.SQL.Clear;
     fdQry1.SQL.Add(stQuery);
     fdQry1.Open;


     repeat
       if CheckBoxAfterDate.Checked or CheckBoxOnlyActiv.Checked then
       begin

        if (CheckListBox1.Items[i]='Nakl') then
        begin
         Check :=  True;
         If CheckBoxAfterDate.Checked then
           If (DateOf(Query1.FieldByName('DocDate').AsDateTime) < MonthCalendar1.Date) then Check:=False;
         if Check and CheckBoxOnlyActiv.Checked then
           Check:= Query1.FieldByName('Activ').AsBoolean;
         if Check then InsertRec;
        end;

        if (CheckListBox1.Items[i]='Tovar') then
        begin
         Check :=  True;
         If CheckBoxAfterDate.Checked then
           If (DateOf(Query1.FieldByName('EditDate').AsDateTime) < MonthCalendar1.Date) then Check:=False;
         if Check and CheckBoxOnlyActiv.Checked then
           Check:= Query1.FieldByName('Activ').AsBoolean;
         if Check then InsertRec;
        end;

        if (CheckListBox1.Items[i]='RecNakl') then
        begin
         Check :=  True;
         If CheckBoxAfterDate.Checked then
           If (Query1.FieldByName('NaklCod').AsInteger < MinCod) then Check:=False;
         if Check then InsertRec;
        end;

        if (CheckListBox1.Items[i]='Parent') then
        begin
         Check :=  True;
         If CheckBoxAfterDate.Checked then
           If (Query1.FieldByName('ParentCod').AsInteger < MinCod) then Check:=False;
         if Check then InsertRec;
        end;

        if (CheckListBox1.Items[i]='Agent') then
        begin
         Check :=  True;
         if CheckBoxOnlyActiv.Checked then
           Check:= Query1.FieldByName('Activ').AsBoolean;
         if Check then InsertRec;
        end;

        if (CheckListBox1.Items[i]='EdIzmer') then
        begin
         Check :=  True;
         if CheckBoxOnlyActiv.Checked then
           Check:= Query1.FieldByName('Activ').AsBoolean;
         if Check then InsertRec;
        end;

        if (CheckListBox1.Items[i]='Proizv') then
        begin
         Check :=  True;
         if CheckBoxOnlyActiv.Checked then
           Check:= Query1.FieldByName('Activ').AsBoolean;
         if Check then InsertRec;
        end;

        if (CheckListBox1.Items[i]='Sotrudn') then
        begin
         Check :=  True;
         if CheckBoxOnlyActiv.Checked then
           Check:= Query1.FieldByName('Activ').AsBoolean;
         if Check then InsertRec;
        end;

        if (CheckListBox1.Items[i]='Unit') then
        begin
         Check :=  True;
         if CheckBoxOnlyActiv.Checked then
           Check:= Query1.FieldByName('Activ').AsBoolean;
         if Check then InsertRec;
        end;

        if (CheckListBox1.Items[i]='NaklName') then InsertRec;

        if (CheckListBox1.Items[i]='Grup') then
        begin
         Check :=  True;
         if CheckBoxOnlyActiv.Checked then
           Check:= Query1.FieldByName('Activ').AsBoolean;
         if Check then InsertRec;
        end;

        if (CheckListBox1.Items[i]='Kurs') then
        begin
         Check :=  True;
         if CheckBoxOnlyActiv.Checked then
           Check:= Query1.FieldByName('Activ').AsBoolean;
         if Check then InsertRec;
        end;

        if (CheckListBox1.Items[i]='Sklad') then
        begin
         Check :=  True;
         if CheckBoxOnlyActiv.Checked then
           Check:= Query1.FieldByName('Activ').AsBoolean;
         if Check then InsertRec;
        end;

        if (CheckListBox1.Items[i]='Zhurnal') then
        begin
         Check :=  True;
         If CheckBoxAfterDate.Checked then
           If (DateOf(Query1.FieldByName('DocDate').AsDateTime) < MonthCalendar1.Date) then Check:=False;
         if Check then InsertRec;
        end;

       end
       else InsertRec;
      Query1.Next;
    until Query1.Eof ;   //or (I=100)

//А теперь - ВНИМАНИЕ: этим же методом запоминаем изменения :-)
//    FDConnection1.ExecuteDirect('COMMIT TRANSACTION');
//     FDConnection1.ExecSQL('COMMIT TRANSACTION',True);
   end;
  end;
  Screen.Cursor := SaveCursor;  { Always restore to normal }
end;

procedure TDMSqLiteForm.btnCopyDataFromTxtClick(Sender: TObject);
begin
  CopyDataFromLiter(Sender);
  CopyDataFromTems(Sender);

end;


procedure TDMSqLiteForm.CopyDataFromLiter(Sender: TObject);
var  stQuery:string;
     SaveCursor : TCursor;
     St : string;
     F: TextFile;
     StInd : Integer;

  procedure InsertRec;
  var Ind : Integer;
  begin
          fdQry1.Insert;
          // index 0= _id
          Ind:= Pos(#9,St);
          if Ind=0 then Ind := Length(St)+1;
          if Ind<AvtorLng+1 then
            fdQry1.Fields[1].AsString := copy(St,1,Ind-1)  //AvtorLng
          else
            fdQry1.Fields[1].AsString := copy(St,1,AvtorLng);
          Delete (St,1,Ind);

          if (St<>'') and (St<>#9) then begin
            Ind:= Pos(#9,St);
            if Ind=0 then Ind := Length(St)+1;
            if Ind<NameLng+1 then
              fdQry1.Fields[2].AsString := copy(St,1,Ind-1)  //NameLng
            else
              fdQry1.Fields[2].AsString := copy(St,1,NameLng);
            Delete (St,1,Ind);
          end
          else fdQry1.Fields[2].AsString := '';

          if (St<>'') and (St<>#9) then begin
            Ind:= Pos(#9,St);
            if Ind=0 then Ind := Length(St)+1;
            try
              fdQry1.Fields[3].AsInteger := StrToInt(copy(St,1,Ind-1));  //TemId
            except
              fdQry1.Fields[3].AsInteger :=0;
            end;
            Delete (St,1,Ind);
          end
          else fdQry1.Fields[3].AsInteger :=0;

          if (St<>'') and (St<>#9) then begin
            if Length(St)<UrlLng then
              fdQry1.Fields[4].AsString := St  //UrlLng
            else
              fdQry1.Fields[4].AsString := copy(St,1,UrlLng);
            Delete (St,1,Ind);
          end
          else fdQry1.Fields[4].AsString := '';

          fdQry1.POST;
  end;

begin
  try
    SaveCursor := Screen.Cursor;
    Screen.Cursor := crHourglass;    { Show hourglass cursor }
    StInd:=0;

    FDConnection1.Connected := False;
    FDConnection1.Connected := True;

    stQuery:= 'Select * From Liter' +';';
     fdQry1.SQL.Clear;
     fdQry1.SQL.Add(stQuery);
     fdQry1.Open;

    AssignFile(F, NameFromLiterTxt);
    Reset(F);
    while not eof(F) do begin

      Readln(F, St);    // NameLng
      Inc(StInd);
      LabelStrInd.Caption := IntToStr(StInd);
      if (St<>'') and (St<>#9) then InsertRec;
    end;

  finally
       Screen.Cursor := SaveCursor;  { Always restore to normal }
       CloseFile(F);
  end;
end;

procedure TDMSqLiteForm.CopyDataFromTems(Sender: TObject);
var  stQuery:string;
     SaveCursor : TCursor;
     St : string;
     F: TextFile;
     StInd : Integer;

  procedure InsertRec;
  var Ind : Integer;
  begin
          fdQry1.Insert;

          if (St<>'') and (St<>#9) then begin   // index 0= _id
            Ind:= Pos(#9,St);
            if Ind=0 then Ind := Length(St)+1;
            try
              fdQry1.Fields[0].AsInteger := StrToInt(copy(St,1,Ind-1));  //_Id
            except
              fdQry1.Fields[0].AsInteger :=999;
            end;
            Delete (St,1,Ind);
          end
          else fdQry1.Fields[0].AsInteger :=999;

          if (St<>'') and (St<>#9) then begin
            Ind:= Pos(#9,St);
            if Ind=0 then Ind := Length(St)+1;
            if Ind<TemNameLng+1 then
              fdQry1.Fields[1].AsString := copy(St,1,Ind-1)  //NameLng
            else
              fdQry1.Fields[1].AsString := copy(St,1,TemNameLng);
            Delete (St,1,Ind);
          end
          else fdQry1.Fields[1].AsString := '';

          if (St<>'') and (St<>#9) then begin
            if Length(St)<TemNameLng then
              fdQry1.Fields[2].AsString := St  //NameLng
            else
              fdQry1.Fields[2].AsString := copy(St,1,TemNameLng);
            Delete (St,1,Ind);
          end
          else fdQry1.Fields[2].AsString := '';

          fdQry1.POST;
  end;

begin
  try
    SaveCursor := Screen.Cursor;
    Screen.Cursor := crHourglass;    { Show hourglass cursor }
    StInd:=0;

    FDConnection1.Connected := False;
    FDConnection1.Connected := True;

    stQuery:= 'Select * From Tems' +';';
     fdQry1.SQL.Clear;
     fdQry1.SQL.Add(stQuery);
     fdQry1.Open;

    AssignFile(F, NameFromTemsTxt);
    Reset(F);
    while not eof(F) do begin

      Readln(F, St);    // NameLng
      Inc(StInd);
      LabelStrInd.Caption := IntToStr(StInd);
      if (St<>'') and (St<>#9) then InsertRec;
    end;

  finally
       Screen.Cursor := SaveCursor;  { Always restore to normal }
       CloseFile(F);
  end;
end;


procedure TDMSqLiteForm.btnCreateSqliteBaseClick(Sender: TObject);
 var Script:String;
     I : Integer;
     SaveCursor : TCursor;
    parameter : TParam;
begin
  SaveCursor     := Screen.Cursor;
  Screen.Cursor  := crHourglass;    { Show hourglass cursor }

// del base
  FDConnection1.Close;
  // del file of base
  if FileExists(EditNameSqliteBase.Text) then DeleteFile(EditNameSqliteBase.Text);
  FDConnection1.Open;


  for I := 0 to CheckListBox1.Items.Count-1 do
   if CheckListBox1.Checked[i] then
   begin
    (*  чтобы не запрашивался пароль
    if (CheckListBox1.Items[I]='Sotrudn') then
    begin
     parameter := Query1.Params.AddParameter;
     parameter.Name := 'Password';
     parameter.Value := 'MasterTrade';
     Query1.Params.AddParam(parameter);
    end;
    *)
    Query1.SQL[0]:='Select * From ' + CheckListBox1.Items[i]+';';
    // подготовка строки запроса для создания таблицы в Script
    FormSqlCreateTable(Query1, CheckListBox1.Items[i], Script);
//  Edit1.Text:=Script;
//    conTradeSqlite.ExecuteDirect(Script);
    FDConnection1.ExecSQL(Script,True);
   end;
  Screen.Cursor := SaveCursor;  { Always restore to normal }
  ButtonTestBaseSqlClick(Sender);
end;

procedure TDMSqLiteForm.btnTestBaseBdeClick(Sender: TObject);
var    stQuery : string;
begin
   dbTrade.GetTableNames(CheckListBox1.Items,True);

   stQuery:= 'Select * From ' + CheckListBox1.Items[0]+';';
   Query1.SQL.Clear;
   Query1.SQL.Add(stQuery);

    Query1.Open;
   CheckListBox1.Selected[0]:=True;
end;


procedure TDMSqLiteForm.ButtonTestParentClick(Sender: TObject);
var i: Integer;
begin
TableParent.Open;
TableParent.First;
i:=0;
while not TableParent.eof do begin
   i:=i+1;
   TableParent.Edit;
   TableParent.FieldByName('Cod').AsInteger:= i;
   TableParent.Post;
   TableParent.Next;
end;
  TableParent.Close;
end;

procedure TDMSqLiteForm.ButtonCheckAllTblBdeClick(Sender: TObject);
var I : Integer;
begin
// select all str
    for I := 0 to CheckListBox1.Items.Count-1 do
      CheckListBox1.Checked[i]:=True;
//  CheckListBox1.SelectAll;
end;

procedure TDMSqLiteForm.ButtonCheckAllTblSqlClick(Sender: TObject);
var I : Integer;
begin
    for I := 0 to CheckListBox2.Items.Count-1 do
      CheckListBox2.Checked[i]:=True;
end;

procedure TDMSqLiteForm.ButtonCheckUsesTblBdeClick(Sender: TObject);
var I : Integer;
begin
// select uses str
    for I := 0 to CheckListBox1.Items.Count-1 do
      if (CheckListBox1.Items[I]<> 'Grup')  and
         (CheckListBox1.Items[I]<> 'Kurs')  and
         (CheckListBox1.Items[I]<> 'Sklad') and
         (CheckListBox1.Items[I]<> 'Zhurnal')
       then
        CheckListBox1.Checked[i]:=True;
//
end;

procedure TDMSqLiteForm.ButtonTestBaseSqlClick(Sender: TObject);
var    stQuery, Buf : string;
begin
//select RDB$RELATION_NAME from RDB$RELATIONS
//where (RDB$SYSTEM_FLAG = 0) AND (RDB$RELATION_TYPE = 0)
//order by RDB$RELATION_NAME

   FDConnection1.GetTableNames(Buf,Buf,Buf,CheckListBox2.Items);
   if CheckListBox2.Items.Count>0 then
   begin
     stQuery:= 'Select * From ' + CheckListBox2.Items[0]+';';
     fdQry1.SQL.Clear;
     fdQry1.SQL.Add(stQuery);

     fdQry1.Open;
     CheckListBox2.Selected[0]:=True;
   end;
end;

procedure TDMSqLiteForm.CheckListBox1Click(Sender: TObject);
var I : Integer;
    stQuery : string;
begin
   Query1.Close;
   stQuery:= 'Select * From ' + CheckListBox1.Items[CheckListBox1.ItemIndex]+';';
   Query1.SQL[0]:= stQuery;
   Query1.Open;

end;

procedure TDMSqLiteForm.CheckListBox2Click(Sender: TObject);
var I : Integer;
    stQuery : string;
begin
   fdQry1.Close;
   stQuery:= 'Select * From ' + CheckListBox2.Items[CheckListBox2.ItemIndex]+';';
   fdQry1.SQL[0]:= stQuery;
   fdQry1.Open;


end;

procedure TDMSqLiteForm.ComboBoxAliasChange(Sender: TObject);
begin
  dbTrade.Close;
  dbTrade.AliasName :=  ComboBoxAlias.Text;
  dbTrade.Open;
  btnTestBaseBdeClick(Sender);
end;

procedure TDMSqLiteForm.EditNameSqliteBaseChange(Sender: TObject);
begin
  FDConnection1.Close;
  FDConnection1.Params.Database := EditNameSqliteBase.Text;
  FDConnection1.Open;
  end;

end.
