program SchedulerGA_p;

uses
  Vcl.Forms,
  TimeTable_u in 'TimeTable_u.pas',
  GeneticAlgorithm_u in 'GeneticAlgorithm_u.pas',
  DataModuleSchedule_u in 'DataModuleSchedule_u.pas' {dmSchedule: TDataModule},
  LoginForm_u in 'LoginForm_u.pas' {LoginForm: LoginForm},
  AdminForm_u in 'AdminForm_u.pas' {AdminForm},
  StudentForm_u in 'StudentForm_u.pas' {StudentForm};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TLoginForm, LoginForm);
  Application.CreateForm(TdmSchedule, dmSchedule);
  Application.CreateForm(TAdminForm, AdminForm);
  Application.CreateForm(TStudentForm, StudentForm);
  Application.Run;
end.
