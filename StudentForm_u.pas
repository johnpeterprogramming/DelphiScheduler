unit StudentForm_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, Vcl.StdCtrls, Vcl.Buttons,
  Data.DB, Vcl.DBGrids;

type
  TStudentForm = class(TForm)
    stLoadedGrid: TStringGrid;
    lblWelcome: TLabel;
    Label1: TLabel;
    btnLoadFromTextFile: TBitBtn;
    tblStudents: TDBGrid;
    BitBtn1: TBitBtn;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnLoadFromTextFileClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    sUsername : string;
  end;

var
  StudentForm: TStudentForm;

implementation

{$R *.dfm}

uses TimeTable_u, DataModuleSchedule_u, LoginForm_u;

procedure TStudentForm.btnLoadFromTextFileClick(Sender: TObject);
var loadTextFile : textfile;
idays, iblocks,iclasses, i, j, k : integer;
sLine : string;
loadedTimeTable : TimeTable;
begin
assignFile(loadTextFile, 'SavedSchedule.txt');
reset(loadTextFile);
readln(loadTextFile, sLine);

iDays := strtoint(sLine[1]);
iblocks := strtoint(sLine[2]);
iclasses := strtoint(sLine[3]);
delete(sLine, 1, 3);

loadedTimeTable := TimeTable.newEmpty(iDays, iblocks, iclasses);

for i := 0 to idays-1 do
for j := 0 to iblocks-1 do
begin
  for k := 0 to iclasses-1 do
  begin
    loadedTimeTable.arrTimeTable[i, j, k] := strtoint(sLine[1]);
    delete(sLine, 1, 2);
  end;
end;

closefile(loadTextFile);


stLoadedGrid.ColCount := idays + 1;
stLoadedGrid.RowCount := iblocks + 1;

stLoadedGrid.DefaultColWidth := stLoadedGrid.Width div stLoadedGrid.ColCount - 3;
stLoadedGrid.DefaultRowHeight := stLoadedGrid.Height div stLoadedGrid.RowCount - 3;

for i := 1 to idays do
  stLoadedGrid.Cells[i, 0] := 'Day ' + inttostr(i);

for i := 1 to iblocks do
  stLoadedGrid.Cells[0, i] := 'Block ' + inttostr(i);

loadedTimeTable.TimeTableToStringGrid(stLoadedGrid, sUsername, False);


end;


procedure TStudentForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
LoginForm.Show;
end;

procedure TStudentForm.FormShow(Sender: TObject);
begin
  lblWelcome.Caption := 'Welcome ' + sUsername;
  tblStudents.DataSource := dmSchedule.dsScheduleStudents;
end;

end.
