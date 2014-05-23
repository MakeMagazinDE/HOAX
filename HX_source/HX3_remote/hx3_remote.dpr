program hx3_remote;





uses
  Forms,
  hx3_remote_main in 'hx3_remote_main.pas' {Form1},
  ColorButton in 'ColorButton.pas',
  deviceselect in 'deviceselect.pas' {deviceselectbox},
  hx3_MenuItems in 'hx3_MenuItems.pas',
  ABOUT in 'ABOUT.PAS' {AboutBox},
  hx3_com in 'hx3_com.pas',
  blinklist in 'ftdiclass\blinklist.pas',
  bsearchtree in 'ftdiclass\bsearchtree.pas',
  FTDIchip in 'ftdiclass\FTDIchip.pas',
  FTDIdll in 'ftdiclass\FTDIdll.pas',
  FTDIthread in 'ftdiclass\FTDIthread.pas',
  FTDItypes in 'ftdiclass\FTDItypes.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'HX3 remote';
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(Tdeviceselectbox, deviceselectbox);
  Application.CreateForm(TAboutBox, AboutBox);
  Application.Run;
end.
