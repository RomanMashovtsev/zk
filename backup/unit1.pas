unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, sqldb, db, sqlite3conn, Forms, Controls, Graphics, Dialogs,
  DBGrids, DBCtrls, StdCtrls;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    DataSource1: TDataSource;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    DBGrid1: TDBGrid;
    DBNavigator1: TDBNavigator;
    Edit1: TEdit;
    SQLite3Connection1: TSQLite3Connection;
    SQLQuery1: TSQLQuery;
    SQLTransaction1: TSQLTransaction;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure DataSource1DataChange(Sender: TObject; Field: TField);
    procedure DBGrid1ColumnSized(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure SQLQuery1AfterEdit(DataSet: TDataSet);
    procedure Update;
  private

  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }
procedure TForm1.Update;
begin
   SQLQuery1.Active:=false;
   SQLQuery1.SQL.Clear;
   SQLQuery1.SQL.Add('select id, cast(`name` as VARCHAR) as name, cast(`phone` as VARCHAR) as phone from `book` order by name;');
   SQLQuery1.Active:=true;
   DBGrid1.Columns.Items[0].Width:=200;
   DBGrid1.Columns.Items[1].Width:=200;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  DBGrid1.Columns.Items[0].Width:=200;
  DBGrid1.Columns.Items[1].Width:=200;
  Update;
end;

procedure TForm1.SQLQuery1AfterEdit(DataSet: TDataSet);
begin
  Update;
end;

procedure TForm1.DataSource1DataChange(Sender: TObject; Field: TField);
begin
  DBGrid1.Columns.Items[0].Width:=200;
  DBGrid1.Columns.Items[1].Width:=200;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  SQLQuery1.ApplyUpdates;
  SQLTransaction1.Commit;
  Update;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  if Edit1.Text <> '' then
  begin
     SQLQuery1.Active:=false;
     SQLQuery1.SQL.Clear;
     SQLQuery1.SQL.Add('select id, cast(`name` as VARCHAR) as name, cast(`phone` as VARCHAR) as phone from `book` where name like "%' + Edit1.Text + '%" or phone like "%' + Edit1.Text + '%" order by name;');
     SQLQuery1.Active:=true;
     DBGrid1.Columns.Items[0].Width:=200;
     DBGrid1.Columns.Items[1].Width:=200;
  end;
end;

procedure TForm1.DBGrid1ColumnSized(Sender: TObject);
begin
  DBGrid1.Columns.Items[0].Width:=200;
  DBGrid1.Columns.Items[1].Width:=200;
end;

procedure TForm1.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
end;

end.

