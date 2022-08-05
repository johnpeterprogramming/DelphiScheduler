unit AdminForm_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Vcl.ComCtrls, Vcl.StdCtrls, Vcl.Buttons, DataModuleSchedule_u, GeneticAlgorithm_u;

type
  TAdminForm = class(TForm)
    tblAdmin: TDBGrid;
    sgSchedule: TStringGrid;
    AdminForm: TPageControl;
    tsAccounts: TTabSheet;
    tsScheduler: TTabSheet;
    btnAddNew: TBitBtn;
    cbAdmin: TCheckBox;
    btnRemoveAccount: TBitBtn;
    btnEditAccount: TBitBtn;
    edtAccountID: TEdit;
    edtUsername: TEdit;
    edtPassword: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    cbAdminEdit: TCheckBox;
    btnSetupValues: TBitBtn;
    btnRunGA: TBitBtn;
    redDisplay: TRichEdit;
    btnShowStudents: TBitBtn;
    Label7: TLabel;
    tblQueries: TDBGrid;
    cmbKeys: TComboBox;
    btnSortBySubject: TBitBtn;
    btnCountBySubject: TBitBtn;
    btnUnregistered: TBitBtn;
    lblCount: TLabel;
    lblNote: TLabel;
    btnSaveToTextFile: TBitBtn;
    BitBtn2: TBitBtn;
    edtDays: TEdit;
    edtBlocks: TEdit;
    Label5: TLabel;
    Label6: TLabel;
    procedure FormShow(Sender: TObject);
    procedure btnAddNewClick(Sender: TObject);
    procedure btnRemoveAccountClick(Sender: TObject);
    procedure resizeColumns(table : TDBGrid);
    procedure btnEditAccountClick(Sender: TObject);
    procedure btnSetupValuesClick(Sender: TObject);
    procedure btnRunGAClick(Sender: TObject);
    procedure btnShowStudentsClick(Sender: TObject);
    procedure btnSortBySubjectClick(Sender: TObject);
    procedure btnCountBySubjectClick(Sender: TObject);
    procedure btnUnregisteredClick(Sender: TObject);
    procedure btnAverageSubjectClick(Sender: TObject);
    procedure btnSaveToTextFileClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);

//    procedure TableToGrid;
  private
    { Private declarations }
  public
    { Public declarations }
      sAdminName : string;
  end;

var
  AdminForm: TAdminForm;
  gaClass : GeneticAlgoClass;


implementation

{$R *.dfm}

uses TimeTable_u, LoginForm_u;

procedure TAdminForm.btnSortBySubjectClick(Sender: TObject);
var sKey : string;
begin
sKey := cmbKeys.Text;
if not (sKey = 'Select a Key') then
begin
tblQueries.Visible := True;
with dmSchedule do
begin
  qrySchedule.Close;
  qrySchedule.SQL.Clear;
  qrySchedule.SQL.Add('select StudentName, SubjectName from Students, Subjects where Subjects.KeyID = Students.' + sKey) ;
  qrySchedule.Open;
end;
  resizeColumns(tblQueries);
end
else showmessage('No Subject Selected');

end;

procedure TAdminForm.btnUnregisteredClick(Sender: TObject);
begin
tblQueries.Visible := True;
with dmSchedule do
begin
  qrySchedule.Close;
  qrySchedule.SQL.Clear;
  qrySchedule.SQL.Add('select StudentName as UnregisteredUsers from Students where not (StudentName IN (Select Students.StudentName from Students, Accounts where Students.StudentName = Accounts.Username))');
  qrySchedule.Open;
end;
  resizeColumns(tblQueries);

end;

procedure TAdminForm.btnAddNewClick(Sender: TObject);
var
sUsername, sPassword: string;
begin
tblQueries.Visible := False;
sUsername := inputbox('Add User', 'Enter Username?', 'Bob');
sPassword := inputbox('Add User', 'Enter Password?', 'bobspassword');
with dmSchedule do
begin
tblScheduleAccounts.Insert;
tblScheduleAccounts['Username'] := sUsername;
tblScheduleAccounts['Password'] := sPassword;
tblScheduleAccounts['Admin'] := cbAdmin.Checked;
tblScheduleAccounts.Post;
end;
showmessage('New user successfully added');
end;

procedure TAdminForm.btnAverageSubjectClick(Sender: TObject);
var sSubject: string;
begin
sSubject := cmbKeys.Text;
if not (sSubject = 'Select a Subject') then
begin
  with dmSchedule do
  begin
    tblQueries.Visible := True;
    qrySchedule.Close;
    qrySchedule.SQL.Clear;
    qrySchedule.SQL.Add('select  as avgcount from Students where ' + sSubject + ' = True');
    qrySchedule.Open;

  end;
  resizeColumns(tblQueries);
end else showmessage('No Subject Selected');
end;

procedure TAdminForm.btnCountBySubjectClick(Sender: TObject);
var sKey, sCount : string;
iSubjectID : integer;
begin
iSubjectId := strtoint(inputbox('Subject ID', 'ID', '1'));
sKey := cmbKeys.Text;
if not (sKey = 'Select a Key') then
begin
  with dmSchedule do
  begin
    qrySchedule.Close;
    qrySchedule.SQL.Clear;
    qrySchedule.SQL.Add('select count(*) as Amount from Students where ' + sKey + ' = ' + inttostr(iSUbjectId));
    qrySchedule.Open;

    sCount := qrySchedule.fieldbyname('Amount').asString;
  end;
  lblCount.Caption := 'Amount of Students with Subject of ID ' + inttostr(iSubjectID) +' in ' + sKey + ': ' + sCount;
  resizeColumns(tblQueries);
end else showmessage('No Subject Selected');
end;

procedure TAdminForm.btnEditAccountClick(Sender: TObject);
var iUserID : integer;
sUsernameEdit, sPasswordEdit : string;
begin

if not (edtAccountID.Text = '') and not (edtUsername.Text = '') and not (edtPassword.Text = '') then
begin
  tblQueries.Visible := False;
  iUserID := strtoint(edtAccountID.Text);
  sUsernameEdit := edtUsername.Text;
  sPasswordEdit := edtPassword.Text;
  with dmSchedule do
  begin
    if tblScheduleAccounts.Locate('ID', iUserID, []) then
    begin
      tblScheduleAccounts.Edit;
      tblScheduleAccounts['Username'] := sUsernameEdit;
      tblScheduleAccounts['Password'] := sPasswordEdit;
      tblScheduleAccounts['Admin'] := cbAdminEdit.Checked;
      tblScheduleAccounts.Post;
    end
    else
      showmessage('No User by that ID was found');

  end;
end
else showmessage('All fields should be filled');


end;

procedure TAdminForm.btnRemoveAccountClick(Sender: TObject);
var iUserID : integer;
begin
tblQueries.Visible := False;
iUserID := strtoint(inputbox('Remove User', 'Enter User ID', '1'));
with dmSchedule do
begin
  if tblScheduleAccounts.Locate('ID', iUserID, []) then
  begin
    if not tblScheduleAccounts['Admin'] then
      tblScheduleAccounts.Delete
    else
      showmessage('Cannot delete Admin');
  end
  else
    showmessage('No User by that ID was found');

end;
end;

procedure TAdminForm.btnRunGAClick(Sender: TObject);
begin
gaClass.run;
redDisplay.Lines.Clear;

if gaClass.bestIndividual.getFitness = 1 then
begin
  redDisplay.Lines.Add('A perfect solution was found within the generation limit');
  btnSaveToTextFile.Enabled := True;
end
else
  redDisplay.Lines.Add('Unfortunately a perfect solution wasnt found within the generation limit' + #13 + 'Try running again');

redDisplay.Lines.Add('Fitness: ' + floattostr(gaClass.bestIndividual.getFitness));

gaClass.bestIndividual.TimeTableToStringGrid(sgSchedule, sAdminName, True);
lblNote.Visible := True;
end;

procedure TAdminForm.btnSaveToTextFileClick(Sender: TObject);
var saveTextFile : TextFile;
begin
assignFile(saveTextFile, 'SavedSchedule.txt');
rewrite(saveTextFile);
writeln(saveTextFile, gaClass.bestIndividual.textFileOutput);

CloseFile(saveTextFile);

showmessage('Successfully written to text file');

end;

procedure TAdminForm.btnSetupValuesClick(Sender: TObject);
var i, days, blocks, classes : Integer;
begin
days := strtoint(edtDays.Text);
blocks := strtoint(edtBLocks.Text);

gaClass := GeneticAlgoClass.generateInitialPopulation(days, blocks, 3);

sgSchedule.ColCount := days + 1;
sgSchedule.RowCount := blocks + 1;

sgSchedule.DefaultColWidth := sgSchedule.Width div sgSchedule.ColCount - 3;
sgSchedule.DefaultRowHeight := sgSchedule.Height div sgSchedule.RowCount - 3;

for i := 1 to days do
  sgSchedule.Cells[i, 0] := 'Day ' + inttostr(i);

for i := 1 to blocks do
  sgSchedule.Cells[0, i] := 'Block ' + inttostr(i);

showmessage('Genetic Algorithm Class has been initialised!');
btnRunGa.Enabled := true;
end;

procedure TAdminForm.btnShowStudentsClick(Sender: TObject);
begin
tblQueries.Visible := True;
with dmSchedule do
begin
  qrySchedule.Close;
  qrySchedule.SQL.Clear;
  qrySchedule.SQL.Add('select * from Students order by StudentName asc');
  qrySchedule.Open;
end;
  resizeColumns(tblQueries);

end;

procedure TAdminForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
LoginForm.Show;
end;

procedure TAdminForm.FormShow(Sender: TObject);
begin
  tblQueries.DataSource := dmSchedule.dsScheduleQuery;
  tblAdmin.DataSource := dmSchedule.dsScheduleAccounts;
  resizeColumns(tblAdmin);

end;

procedure TAdminForm.resizeColumns(table: TDBGrid);
var iColumns, iWidth, iColumnWidth : integer;
  I: Integer;
begin
  iColumns := table.Columns.Count;
  iWidth := table.Width - 35;
  iColumnWidth := iWidth div iColumns;
  for I := 0 to iColumns-1 do
    table.Columns[I].Width := iColumnWidth;
end;


end.
