program TradeConv;

uses
  Vcl.Forms,
  DMSqLiteUnit in 'DMSqLiteUnit.pas' {DMSqLiteForm};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TDMSqLiteForm, DMSqLiteForm);
  Application.Run;
end.
