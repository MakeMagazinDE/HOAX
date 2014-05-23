unit hx3_remote_main;

//##############################################################################
//
//    Remote/Update-Utility für HX3 mk3 Organ Module
//    Kommuniziert über FTDI D2XX-DLL für FT232R USB/Seriell-Wandler
//    Q&D RAD mit Delphi 2005 Personal Edition
//    (c) 5/2014 by Carsten Meyer, engineering@keyboardpartner.de
//
//    #1.07 leicht geändertes XModem-Timing
//    #1.06 MIDI-CC und Preset-Editor eingebaut
//    #0.97 erste freigegebene Version, noch ohne MIDI-CC
//    #0.95 Übernahme aus FroschLoader D2XX
//
//##############################################################################


interface

uses SysUtils, StrUtils, Windows, Classes, Graphics, Forms, Controls, Menus,
  Dialogs, StdCtrls, Buttons, ColorButton, ExtCtrls, ComCtrls, ImgList, StdActns,
  ActnList, ToolWin, Spin, FileCtrl, Grids, Registry, ShellApi,
  hx3_com, hx3_MenuItems;

type
  THX3Record = record
    OrganValues: array [0..127] of LongInt;
    LeslieValues: array [0..63] of LongInt;
    MIDIccValues: array [0..127] of LongInt;
    Device: Integer;
    FirmwareVersion: Real;
    FPGAversion: String[10];
    SerialNumber: LongInt;
    OrganLicence: LongInt;
    LeslieLicence: LongInt;
    Owner: String[63];
    UpperPresets: array [0..255] of LongInt;
    LowerPresets: array [0..255] of LongInt;
  end;

  TAnoPipe=record
    Input : THandle; // Handle to send data to the pipe
    Output: THandle; // Handle to read data from the pipe
  end;

  TForm1 = class(TForm)
    OpenDialog: TOpenDialog;
    SaveParamDialog: TSaveDialog;
    ToolBar1: TToolBar;
    ToolButton9: TToolButton;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    ToolButton6: TToolButton;
    ActionList1: TActionList;
    FileNew1: TAction;
    FileOpen1: TAction;
    FileSave1: TAction;
    FileSaveAs1: TAction;
    FileExit1: TAction;
    EditCut1: TEditCut;
    EditCopy1: TEditCopy;
    EditPaste1: TEditPaste;
    HelpAbout1: TAction;
    StatusBar: TStatusBar;
    ImageList1: TImageList;
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    FileNewItem: TMenuItem;
    FileOpenItem: TMenuItem;
    FileSaveItem: TMenuItem;
    FileSaveAsItem: TMenuItem;
    N1: TMenuItem;
    FileExitItem: TMenuItem;
    Edit1: TMenuItem;
    CutItem: TMenuItem;
    CopyItem: TMenuItem;
    PasteItem: TMenuItem;
    Help1: TMenuItem;
    HelpAboutItem: TMenuItem;
    TransferProgress: TProgressBar;
    OpenParamDialog: TOpenDialog;
    Bevel2: TBevel;
    Timer1: TTimer;
    BtnRescan: TButton;
    StringGrid1: TStringGrid;
    Image1: TImage;
    ToolButton8: TToolButton;
    DeviceView: TEdit;
    ReadAll: TBitBtn;
    TrackBar1: TTrackBar;
    LEDbtn: TColorButton;
    OnOffBtn1: TColorButton;
    OptionTextMenu: TComboBox;
    EditHint: TLabel;
    EditValue: TEdit;
    sendWEN: TCheckBox;
    UpdateFPGA: TBitBtn;
    UpdateAVR: TBitBtn;
    EditSerialNumber: TEdit;
    EditOrganLicence: TEdit;
    EditLeslieLicence: TEdit;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Bevel1: TBevel;
    Bevel3: TBevel;
    Memo1: TMemo;
    BtnSetLicence: TBitBtn;
    FPGAversion: TEdit;
    Label1: TLabel;
    EditFirmwareVersion: TEdit;
    Label6: TLabel;
    Label7: TLabel;
    Bevel4: TBevel;
    BtnClose: TButton;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    Bevel5: TBevel;
    BtnCancel: TSpeedButton;
    EditUserName: TEdit;
    Label2: TLabel;
    BtnRefreshInfo: TBitBtn;
    LedOrganOk: TColorButton;
    LedLeslieOk: TColorButton;
    Label8: TLabel;
    BtnScanCore: TBitBtn;
    Label9: TLabel;
    BtnLicenceGen: TBitBtn;
    BtnReset: TBitBtn;
    Actions1: TMenuItem;
    Connect1: TMenuItem;
    Disconnect1: TMenuItem;
    N2: TMenuItem;
    ReadParamstoPage: TMenuItem;
    SendParamsfromPage: TMenuItem;
    N3: TMenuItem;
    RefreshInfo1: TMenuItem;
    ResetHX31: TMenuItem;
    N4: TMenuItem;
    UpdateFPGAandScanCores1: TMenuItem;
    UpdateScanCoresonly1: TMenuItem;
    UpdateSingleScanCore1: TMenuItem;
    UpdateAVRFirmware1: TMenuItem;
    N5: TMenuItem;
    Send1: TMenuItem;
    N6: TMenuItem;
    TabSheet4: TTabSheet;
    TabSheet5: TTabSheet;
    StringGrid2: TStringGrid;
    StringGrid3: TStringGrid;
    SendAll: TBitBtn;
    Label11: TLabel;
    Label12: TLabel;
    TrackBarL0: TTrackBar;
    TrackBarL1: TTrackBar;
    TrackBarL2: TTrackBar;
    TrackBarL3: TTrackBar;
    TrackBarL4: TTrackBar;
    TrackBarL5: TTrackBar;
    TrackBarL6: TTrackBar;
    TrackBarL7: TTrackBar;
    TrackBarL8: TTrackBar;
    TrackBarU0: TTrackBar;
    TrackBarU1: TTrackBar;
    TrackBarU2: TTrackBar;
    TrackBarU3: TTrackBar;
    TrackBarU4: TTrackBar;
    TrackBarU5: TTrackBar;
    TrackBarU6: TTrackBar;
    TrackBarU7: TTrackBar;
    TrackBarU8: TTrackBar;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    Label30: TLabel;
    Label31: TLabel;
    Label32: TLabel;
    TrackBarB0: TTrackBar;
    Label33: TLabel;
    TrackBarB1: TTrackBar;
    Label34: TLabel;
    Label35: TLabel;
    TrackBarB2: TTrackBar;
    TrackBarB3: TTrackBar;
    Label36: TLabel;
    Label37: TLabel;
    Bevel7: TBevel;
    ComboBoxVibKnob: TComboBox;
    CheckBox4: TCheckBox;
    CheckBox3: TCheckBox;
    CheckBox2: TCheckBox;
    CheckBox1: TCheckBox;
    CheckBox0: TCheckBox;
    Bevel8: TBevel;
    CheckBox11: TCheckBox;
    CheckBox10: TCheckBox;
    CheckBox5: TCheckBox;
    Bevel9: TBevel;
    CheckBox8: TCheckBox;
    CheckBox9: TCheckBox;
    CheckBox6: TCheckBox;
    CheckBox7: TCheckBox;
    Bevel10: TBevel;
    ComboBoxLowerPreset: TComboBox;
    ComboBoxUpperPreset: TComboBox;
    ComboBoxScancore: TComboBox;
    BtnDSP: TBitBtn;
    BasicScanMode: TComboBox;
    Bevel11: TBevel;
    Label10: TLabel;
    BasicExpanderMode: TCheckBox;
    BasicJackA: TComboBox;
    BtnWriteBasics: TBitBtn;
    Label13: TLabel;
    Label14: TLabel;
    BasicJackB: TComboBox;
    Label38: TLabel;
    BasicToneEna: TCheckBox;
    Label39: TLabel;
    procedure BasicExpanderModeClick(Sender: TObject);
    procedure BtnWriteBasicsClick(Sender: TObject);
    procedure BtnDSPClick(Sender: TObject);
    procedure ComboBoxVibKnobChange(Sender: TObject);
    procedure TrackBarB3Change(Sender: TObject);
    procedure TrackBarB2Change(Sender: TObject);
    procedure TrackBarB1Change(Sender: TObject);
    procedure TrackBarB0Change(Sender: TObject);
    procedure ComboBoxUpperPresetChange(Sender: TObject);
    procedure ComboBoxLowerPresetChange(Sender: TObject);
    procedure TrackBarL8Change(Sender: TObject);
    procedure TrackBarL7Change(Sender: TObject);
    procedure TrackBarL6Change(Sender: TObject);
    procedure TrackBarL5Change(Sender: TObject);
    procedure TrackBarL4Change(Sender: TObject);
    procedure TrackBarL3Change(Sender: TObject);
    procedure TrackBarL2Change(Sender: TObject);
    procedure TrackBarL1Change(Sender: TObject);
    procedure TrackBarU8Change(Sender: TObject);
    procedure TrackBarU7Change(Sender: TObject);
    procedure TrackBarU6Change(Sender: TObject);
    procedure TrackBarU5Change(Sender: TObject);
    procedure TrackBarU4Change(Sender: TObject);
    procedure TrackBarU3Change(Sender: TObject);
    procedure TrackBarU2Change(Sender: TObject);
    procedure TrackBarU1Change(Sender: TObject);
    procedure TrackBarL0Change(Sender: TObject);
    procedure TrackBarU0Change(Sender: TObject);
    procedure StringGrid3DrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure StringGrid3SetEditText(Sender: TObject; ACol, ARow: Integer;
      const Value: string);
    procedure StringGrid3Click(Sender: TObject);
    procedure CheckBox11Click(Sender: TObject);
    procedure CheckBox10Click(Sender: TObject);
    procedure CheckBox9Click(Sender: TObject);
    procedure CheckBox8Click(Sender: TObject);
    procedure CheckBox7Click(Sender: TObject);
    procedure CheckBox6Click(Sender: TObject);
    procedure CheckBox5Click(Sender: TObject);
    procedure CheckBox4Click(Sender: TObject);
    procedure CheckBox3Click(Sender: TObject);
    procedure CheckBox2Click(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure CheckBox0Click(Sender: TObject);
    procedure UpdateScanCoresonly1Click(Sender: TObject);
    procedure BtnResetClick(Sender: TObject);
    procedure BtnLicenceGenClick(Sender: TObject);
    procedure StringGrid1DrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure StringGrid2DrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure BtnScanCoreClick(Sender: TObject);
    procedure OptionTextMenuChange(Sender: TObject);
    procedure BtnRefreshInfoClick(Sender: TObject);
    procedure StringGrid2Click(Sender: TObject);
    procedure StringGrid2SetEditText(Sender: TObject; ACol, ARow: Integer;
      const Value: string);
    procedure StringGrid1SetEditText(Sender: TObject; ACol, ARow: Integer;
      const Value: string);
    procedure EditLeslieLicenceChange(Sender: TObject);
    procedure EditOrganLicenceChange(Sender: TObject);
    procedure EditUserNameChange(Sender: TObject);
    procedure BtnCancelClick(Sender: TObject);

    procedure PageControl1Change(Sender: TObject);
    procedure BtnCloseClick(Sender: TObject);
    procedure BtnSetLicenceClick(Sender: TObject);
    procedure UpdateAVRClick(Sender: TObject);
    procedure UpdateFPGAClick(Sender: TObject);
    procedure TrackBar1Change(Sender: TObject);
    procedure OnOffBtn1Click(Sender: TObject);
    procedure FileSaveExecute(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure StringGrid1Click(Sender: TObject);
    procedure BtnRescanClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure ReadAllClick(Sender: TObject);
    procedure SendAllClick(Sender: TObject);
    procedure FileNew1Execute(Sender: TObject);
    procedure FileOpen1Execute(Sender: TObject);
    procedure FileSaveAs1Execute(Sender: TObject);
    procedure FileExit1Execute(Sender: TObject);
    procedure HelpAbout1Execute(Sender: TObject);
    procedure FormCreate(Sender: TObject);

  private
    { Private-Deklarationen }

  public
    { Public-Deklarationen }
  end;

const
//### Länge des Parameter-EEPROMs
  VersionInfo='Version 1.08';
  FroschScanTick=10; // alle  Timer1-ms*FroschScanTicks wird nach Frosch gesucht
  FroschDefaultDesc='FT232R USB UART';
  FroschDefDriveName='HOAX';
  FroschRegKeyName='HX3remote';
  c_num_of_organparams = 81;
  c_num_of_leslieparams = 63;
  c_num_of_midiparams = 127;

var
  Form1: TForm1;
  n, m:Integer;
  HX3settingsPath: String; // Pfad zur Settings-Datei
  HX3record: THX3Record;
  TimeOutValue,LEDtimer: Integer;  // Timer-Tick-Zähler
  TimeOut: Boolean;
  ComPortAvailableList: Array[0..31] of Integer;
  HasBootLoaderJump: Boolean;
  CancelProc: boolean;
  ComPortUsed: Integer;

implementation

uses about,deviceselect;

{$R *.dfm}

//##############################################################################
//##############################################################################
//##############################################################################

procedure LEDstate(is_on: boolean);
// liefert vorherigen Zustand zurück
begin
  if is_on then
    Form1.LEDbtn.Color:=$0000F000
  else
    Form1.LEDbtn.Color:=$00004000;
end;

procedure LEDtoggle;
// liefert vorherigen Zustand zurück
begin
  if Form1.LEDbtn.Color=$0000F000 then
    Form1.LEDbtn.Color:=$00004000
  else
    Form1.LEDbtn.Color:=$0000F000;
end;

procedure LEDflash;
begin
  LEDstate(true);
  LEDtimer:=10;
  Application.ProcessMessages;
end;

procedure SetTimeOut(my_val: Integer);
// alle 10 ms aufgerufen: Schnittstelle abfragen und bei Telegramm-Ende
begin
  TimeOutValue:= my_val;
  TimeOut:= false;
end;

procedure Delay(msecs: Longint);
var
  targettime: cardinal;
begin
  targettime := GetTickCount + msecs;
  while targettime > GetTickCount do
    Application.ProcessMessages;
end;

function TryStrToInt(my_str:String): LongInt;
begin
  result:= 0;
  if Length(my_str)>0 then try
    result:= StrToInt(trim(my_str));
  except Form1.Memo1.lines.Add('##### Error: Number format not valid');
  end;
end;

procedure CancelMsg;
begin
  Form1.TransferProgress.Position:= 0;
  Form1.Memo1.lines.Add('##### Warning: Process cancelled by user');
end;

//##############################################################################

procedure Form2HX3record;
var i, my_preset: Integer;  my_byte: byte;
begin
  for i := 0 to  c_num_of_organparams do
    HX3record.OrganValues[i]:=TrySTrToInt(Form1.StringGrid1.Rows[i+1].Strings[2]);
  for i := 0 to c_num_of_leslieparams do
    HX3record.LeslieValues[i]:=TrySTrToInt(Form1.StringGrid2.Rows[i+1].Strings[2]);
  for i := 0 to c_num_of_midiparams do
    HX3record.MIDIccValues[i]:=TrySTrToInt(Form1.StringGrid3.Rows[i+1].Strings[2]);
  // Reverb
  my_byte:= 0;
  if Form1.CheckBox8.Checked then
    my_byte:= 1;
  if Form1.CheckBox9.Checked then
    my_byte:= my_byte or 2;
  HX3record.OrganValues[32]:= my_byte;

  my_preset:= Form1.ComboboxUpperPreset.ItemIndex;
  HX3record.UpperPresets[0+16*my_preset]:= Form1.TrackBarU0.Position;
  HX3record.UpperPresets[1+16*my_preset]:= Form1.TrackBarU1.Position;
  HX3record.UpperPresets[2+16*my_preset]:= Form1.TrackBarU2.Position;
  HX3record.UpperPresets[3+16*my_preset]:= Form1.TrackBarU3.Position;
  HX3record.UpperPresets[4+16*my_preset]:= Form1.TrackBarU4.Position;
  HX3record.UpperPresets[5+16*my_preset]:= Form1.TrackBarU5.Position;
  HX3record.UpperPresets[6+16*my_preset]:= Form1.TrackBarU6.Position;
  HX3record.UpperPresets[7+16*my_preset]:= Form1.TrackBarU7.Position;
  HX3record.UpperPresets[8+16*my_preset]:= Form1.TrackBarU8.Position;

  // Vibrato Upper Knob
  HX3record.UpperPresets[9+16*my_preset]:= Form1.ComboBoxVibKnob.ItemIndex;

  // Percussion Upper
  my_byte:=0;
  if Form1.CheckBox0.Checked then
    my_byte:= my_byte or 1;
  if Form1.CheckBox1.Checked then
    my_byte:= my_byte or 2;
  if Form1.CheckBox2.Checked then
    my_byte:= my_byte or 4;
  if Form1.CheckBox3.Checked then
    my_byte:= my_byte or 8;
  // Vibrato Upper
  if Form1.CheckBox4.Checked then
    my_byte:= my_byte or 16;
  HX3record.UpperPresets[10+16*my_preset]:= my_byte;

  my_preset:= Form1.ComboboxLowerPreset.ItemIndex;
  HX3record.LowerPresets[0+16*my_preset]:= Form1.TrackbarL0.Position;
  HX3record.LowerPresets[1+16*my_preset]:= Form1.TrackbarL1.Position;
  HX3record.LowerPresets[2+16*my_preset]:= Form1.TrackbarL2.Position;
  HX3record.LowerPresets[3+16*my_preset]:= Form1.TrackbarL3.Position;
  HX3record.LowerPresets[4+16*my_preset]:= Form1.TrackbarL4.Position;
  HX3record.LowerPresets[5+16*my_preset]:= Form1.TrackbarL5.Position;
  HX3record.LowerPresets[6+16*my_preset]:= Form1.TrackbarL6.Position;
  HX3record.LowerPresets[7+16*my_preset]:= Form1.TrackbarL7.Position;
  HX3record.LowerPresets[8+16*my_preset]:= Form1.TrackbarL8.Position;

  HX3record.LowerPresets[9+16*my_preset]:= Form1.TrackbarB0.Position;
  HX3record.LowerPresets[10+16*my_preset]:= Form1.TrackbarB1.Position;
  HX3record.LowerPresets[11+16*my_preset]:= Form1.TrackbarB2.Position;
  HX3record.LowerPresets[12+16*my_preset]:= Form1.TrackbarB3.Position;

  // Vibrato Lower
  my_byte:=0;
  if Form1.CheckBox5.Checked then
    my_byte:= 32;
  HX3record.LowerPresets[13+16*my_preset]:= my_byte;

  // Reverb, Split, Jacks
  my_byte:=0;
  if Form1.CheckBox8.Checked then
    my_byte:= 1;
  if Form1.CheckBox9.Checked then
    my_byte:= my_byte or 2;
  HX3record.OrganValues[32]:= my_byte;

  my_byte:=0;
  if Form1.CheckBox10.Checked then
    my_byte:= 64;
  if Form1.CheckBox11.Checked then
    my_byte:= my_byte or 128;
  HX3record.LowerPresets[14+16*my_preset]:= my_byte;
  HX3Record.Owner:= Form1.EditUserName.Text;
  HX3record.FPGAVersion:= Form1.FPGAversion.Text;
  HX3record.OrganLicence:= TryStrToInt(Form1.EditOrganLicence.Text);
  HX3record.LeslieLicence:= TryStrToInt(Form1.EditLeslieLicence.Text);
  HX3record.SerialNumber:= TryStrToInt(Form1.EditSerialNumber.Text);
end;


procedure HX3record2Form;
var i, my_preset: Integer; my_byte: Byte;
begin
  for i := 0 to  c_num_of_organparams do begin
    Form1.StringGrid1.Rows[i+1].Strings[0]:= IntToStr(i+400);
    Form1.StringGrid1.Rows[i+1].Strings[1]:= MenuHeaderArr[i];
    Form1.StringGrid1.Rows[i+1].Strings[2]:= IntToStr(HX3record.OrganValues[i]);
  end;
  for i := 0 to c_num_of_leslieparams do begin
    Form1.StringGrid2.Rows[i+1].Strings[0]:= IntToStr(i+600);
    Form1.StringGrid2.Rows[i+1].Strings[1]:= LeslieDescArr[i];
    Form1.StringGrid2.Rows[i+1].Strings[2]:= IntToStr(HX3record.LeslieValues[i]);
  end;
  for i := 0 to c_num_of_midiparams do begin
    Form1.StringGrid3.Rows[i+1].Strings[0]:= IntToStr(i+3000);
    Form1.StringGrid3.Rows[i+1].Strings[1]:= MIDIdescArr[i];
    Form1.StringGrid3.Rows[i+1].Strings[2]:= IntToStr(HX3record.MIDIccValues[i]);
  end;

  my_preset:= Form1.ComboboxUpperPreset.ItemIndex;
  Form1.TrackBarU0.Position:= HX3record.UpperPresets[0+16*my_preset];
  Form1.TrackBarU1.Position:= HX3record.UpperPresets[1+16*my_preset];
  Form1.TrackBarU2.Position:= HX3record.UpperPresets[2+16*my_preset];
  Form1.TrackBarU3.Position:= HX3record.UpperPresets[3+16*my_preset];
  Form1.TrackBarU4.Position:= HX3record.UpperPresets[4+16*my_preset];
  Form1.TrackBarU5.Position:= HX3record.UpperPresets[5+16*my_preset];
  Form1.TrackBarU6.Position:= HX3record.UpperPresets[6+16*my_preset];
  Form1.TrackBarU7.Position:= HX3record.UpperPresets[7+16*my_preset];
  Form1.TrackBarU8.Position:= HX3record.UpperPresets[8+16*my_preset];
  // Vibrato Upper Knob
  Form1.ComboBoxVibKnob.ItemIndex:= HX3record.UpperPresets[9+16*my_preset];

  // Percussion Upper
  my_byte:= HX3record.UpperPresets[10+16*my_preset];
  Form1.CheckBox0.Checked:= (my_byte and 1) <> 0;
  Form1.CheckBox1.Checked:= (my_byte and 2) <> 0;
  Form1.CheckBox2.Checked:= (my_byte and 4) <> 0;
  Form1.CheckBox3.Checked:= (my_byte and 8) <> 0;

  // Vibrato Upper ON
  Form1.CheckBox4.Checked:= (my_byte and 16) <> 0;

  my_preset:= Form1.ComboboxLowerPreset.ItemIndex;
  Form1.TrackbarL0.Position:= HX3record.LowerPresets[0+16*my_preset];
  Form1.TrackbarL1.Position:= HX3record.LowerPresets[1+16*my_preset];
  Form1.TrackbarL2.Position:= HX3record.LowerPresets[2+16*my_preset];
  Form1.TrackbarL3.Position:= HX3record.LowerPresets[3+16*my_preset];
  Form1.TrackbarL4.Position:= HX3record.LowerPresets[4+16*my_preset];
  Form1.TrackbarL5.Position:= HX3record.LowerPresets[5+16*my_preset];
  Form1.TrackbarL6.Position:= HX3record.LowerPresets[6+16*my_preset];
  Form1.TrackbarL7.Position:= HX3record.LowerPresets[7+16*my_preset];
  Form1.TrackbarL8.Position:= HX3record.LowerPresets[8+16*my_preset];


  Form1.TrackbarB0.Position:= HX3record.LowerPresets[9+16*my_preset];
  Form1.TrackbarB1.Position:= HX3record.LowerPresets[10+16*my_preset];
  Form1.TrackbarB2.Position:= HX3record.LowerPresets[11+16*my_preset];
  Form1.TrackbarB3.Position:= HX3record.LowerPresets[12+16*my_preset];

  // Vibrato Lower
  my_byte:= HX3record.UpperPresets[13+16*my_preset];
  Form1.CheckBox0.Checked:= (my_byte and 32) <> 0;

  // Reverb, Split, Jacks; Reverb aus HX3record.OrganValues
  my_byte:= HX3record.OrganValues[32];
  Form1.CheckBox8.Checked:= (my_byte and 1) <> 0;
  Form1.CheckBox9.Checked:= (my_byte and 2) <> 0;

  my_byte:= HX3record.LowerPresets[14+16*my_preset];
  Form1.CheckBox10.Checked:= (my_byte and 64) <> 0;
  Form1.CheckBox11.Checked:= (my_byte and 128) <> 0;

  Form1.EditUserName.Text:= HX3Record.Owner;
  Form1.FPGAversion.Text:= HX3record.FPGAVersion;
  DecimalSeparator:= '.';
  Form1.EditFirmwareVersion.Text:= FloatToStr(HX3record.FirmwareVersion);
  Form1.EditOrganLicence.Text:= IntToStr(HX3record.OrganLicence);
  Form1.EditLeslieLicence.Text:= IntToStr(HX3record.LeslieLicence);
  Form1.EditSerialNumber.Text:= IntToStr(HX3record.SerialNumber);
end;

procedure NewHX3record;
var
  my_ReadFile: File of THX3record;

begin
  Form1.StringGrid1.Rows[0].Strings[0]:= '#';
  Form1.StringGrid1.Rows[0].Strings[1]:= 'Description';
  Form1.StringGrid1.Rows[0].Strings[2]:= 'Value';
  Form1.StringGrid2.Rows[0].Strings[0]:= '#';
  Form1.StringGrid2.Rows[0].Strings[1]:= 'Description';
  Form1.StringGrid2.Rows[0].Strings[2]:= 'Value';
  Form1.StringGrid3.Rows[0].Strings[0]:= '#';
  Form1.StringGrid3.Rows[0].Strings[1]:= 'MIDI-CC translated to';
  Form1.StringGrid3.Rows[0].Strings[2]:= 'HX3';

  if not fileexists(HX3settingsPath) then
    HX3settingsPath:=ExtractFilePath(Application.ExeName)+'HX3_factory_defaults.hx3';
    
  if FileExists(HX3settingsPath) then begin
    FileMode := fmOpenRead;
    AssignFile(my_ReadFile, HX3settingsPath);
    Reset(my_ReadFile);
    try
      Read(my_ReadFile,HX3record);
    except
      Form1.Memo1.lines.Add('##### Warning: Parameter file invalid/corrupted - Save to repair');
    end;
    CloseFile(my_ReadFile);
    Form1.Caption:= 'HX3 Remote  ['+ HX3settingsPath+']';
    Form1.Memo1.lines.Add('#--- Using parameter file: '+ ExtractFilename(HX3settingsPath));
  end else
    Form1.Memo1.lines.Add('##### Warning: Missing default parameter file HX3_factory_defaults.hx3');
  HX3record.Firmwareversion:=0;
  HX3record.LeslieLicence:=0;
  HX3record.OrganLicence:=0;
  HX3record.SerialNumber:=0;
  HX3record.Owner:='KeyboardPartner';
  HX3record.FPGAversion:='00000000';
  HX3record2Form;
  Form1.PageControl1.TabIndex := 0;
end;

function GetCCdesc(my_val: Integer):String;
begin
  case my_val of
    0:
      result:= '(not assigned)';
    400..(400+ c_num_of_organparams):
      result:= 'MIDI CC tanslated to '+ MenuHeaderArr[my_val-400];
    600..(600+ c_num_of_leslieparams):
      result:= 'MIDI CC tanslated to '+ LeslieDescArr[my_val-600];
    900..919:
      result:= 'MIDI CC tanslated to '+ ButtonDescArr[my_val-900];
  else
    result:= '(invalid number)';
  end;
end;

//##############################################################################
//##############################################################################
//##############################################################################

procedure TForm1.HelpAbout1Execute(Sender: TObject);
begin
  AboutBox.Version.Caption:= VersionInfo;
  AboutBox.ShowModal;
end;

procedure TForm1.FileNew1Execute(Sender: TObject);
//Form löschen
begin
  NewHX3record;
end;


procedure TForm1.FileOpen1Execute(Sender: TObject);
var my_ReadFile: File of THX3record;
begin
if OpenParamDialog.Execute then
  begin
    HX3settingsPath := OpenParamDialog.Filename;
    FileMode := fmOpenRead;
    AssignFile(my_ReadFile, OpenParamDialog.Filename);
    Reset(my_ReadFile);
    Read(my_ReadFile,HX3record);
    CloseFile(my_ReadFile);
    HX3record2Form;
    Form1.Caption:= 'HX3 Remote  ['+ HX3settingsPath+']';
    Form1.Memo1.lines.Add('#--- Using parameter file: '+ ExtractFilename(HX3settingsPath));
  end;
end;

//##############################################################################

procedure HX3_resync;
var
  my_str:String;
begin
  repeat begin
    LEDflash;
    my_str:= HX3_QueryStr(253);
    delay(500);
    if CancelProc then begin
      CancelMsg;
      CancelProc:= false;
      exit;
    end;
  end until pos('253',my_str) >0;
end;

procedure HX3_reset;
var
  my_str:String;
begin
  my_str:= HX3_QueryStr(9999);
  LEDflash;
  delay(500);
  HX3_resync;
end;

procedure XModemSendBuffer(my_core:Integer; my_size:LongInt);
// Bufferinhalt mit Länge TxFileBufferSize an FPGA
var
  my_packets, i: Integer;
  my_str: String;

begin
  HX3_SendStr('DFS=0!', 500);
  delay(100);
  LEDflash;
  if my_core= -1 then begin // FPGA configuration
    Form1.Memo1.lines.Add(HX3_SendStr('DFE 2=0!', 8000));
    HX3_resync;
    Form1.Memo1.lines.Add(HX3_SendStr('DFX 0=0!', 200));
  end else begin
    my_str:= IntToStr(my_core);
    Form1.Memo1.lines.Add(HX3_SendStr('DFE 1='+my_str+'!', 2000));
    HX3_resync;
    Form1.Memo1.lines.Add(HX3_SendStr('DFX 1='+my_str+'!', 200));
  end;
  my_packets:= (my_size-1) div 128;
  Form1.TransferProgress.Max:= my_packets;
  for i:= 0 to my_packets do begin
    my_str:= TxPacket(i);
    if my_str[1] <> 'P' then
      Form1.Memo1.lines.Add('##### Error: Xmodem '+ my_str);
    if (i mod 8 = 0) or (my_packets < 100) then begin
      LEDflash;
      Form1.TransferProgress.Position:= i;
{
      my_pos:= Pos(':', my_str);
      if my_pos > 0 then begin
        my_str:= copy(my_str, my_pos+2, 10);
        Form1.FPGAversion.Text:= my_str;
      end;
}
    end;
    if CancelProc then begin
      CancelMsg;
      exit;
    end;
  end;
  TxEOT;
  LEDflash;
  delay(100);
  Form1.Memo1.lines.Add('#--- Packets sent: '+ IntToStr(my_packets+1));
  Form1.Memo1.lines.Add(HX3_ResponseWait(2000));
  delay(500);
end;

function FileToBuffer(my_name:String):LongInt;
// Liest File in FileBuffer und liefert Länge zurück
var
  my_ReadFile: File of byte;
  i, my_len: LongInt;
begin
  FileMode := fmOpenRead;
  AssignFile(my_ReadFile, my_name);
  Reset(my_ReadFile);
  my_len:= FileSize(my_ReadFile);
  Form1.TransferProgress.Max:= my_len div 128;
  i:=0;
  while not Eof(my_ReadFile) do begin
    Read(my_ReadFile,TxFileBuffer[i]);
    if i mod 128 = 0 then begin
      Form1.TransferProgress.Position:= i div 128;
      LEDflash;
    end;
    inc(i);
  end;
  CloseFile(my_ReadFile);
  result:= i;
end;

function IsFPGAcorrupted: boolean;
begin
  if (HX3Record.FPGAversion='00000000')
  or (HX3Record.FPGAversion='FFFFFFFF')
  or (HX3Record.SerialNumber < 1) then result:= true
  else result:=false;
end;

procedure FPGAcorruptedMsg;
begin
  showmessage('FPGA configuration is corrupted. Please insert CONF_DIS jumper before continuing!');
end;

procedure RemoveConfDisJpMsg;
begin
  ShowMessage('Please remove CONF_DIS jumper and click OK when done!');
end;

procedure CoreLoad(my_name:String; my_core:Integer);
begin
  if CancelProc then begin
    exit;
  end;
  if FileExists(my_name) then begin
    Form1.Memo1.lines.Add('#--- Transfer File '+my_name);
    TxFileBufferSize:= FileToBuffer(my_name);
    XModemSendBuffer(my_core,TxFileBufferSize);
  end else begin
    Form1.Memo1.lines.Add('##### Warning: File '+my_name+' not found');
  end;
end;

procedure CoreLoadAll(my_str: String);
// Pfad ohne Dateiname in my_str
begin
  Form1.Memo1.lines.Add('#--- Reading all scan cores...');
  Application.ProcessMessages;
  CoreLoad(my_str+'hx_chain.dat', 0);
  CoreLoad(my_str+'hx_midi.dat', 1);
  CoreLoad(my_str+'hx_fatar.dat', 2);
  CoreLoad(my_str+'hx_sr44.dat', 3);
  CoreLoad(my_str+'hx_sr49.dat', 4);
  CoreLoad(my_str+'hx_sr61.dat', 5);
  CoreLoad(my_str+'hx_test.dat', 6);
  CoreLoad(my_str+'hx_xb2.dat', 7);
  CoreLoad(my_str+'hoax3rev.bin', 10);
  if CancelProc then begin
    CancelMsg;
    CancelProc:= false;
  end;
  Form1.TransferProgress.Position:= 0;
end;

//##############################################################################
//##############################################################################

procedure HX3_info;
// get system info and serial/licence numbers from HX3
var
  my_str:String;
  my_val, my_pos1, my_pos2: Integer;
begin
  my_str:=HX3_QueryStr(254);
  Form1.Memo1.lines.Add(my_str);

  my_str:= HX3_QueryStr(244); // Aktive Freischaltungen
  my_val:= HX3_StrToInt(my_str);
  if my_val and 1 = 1 then
    Form1.LedOrganOk.Color:=$0000F000
  else
    Form1.LedOrganOk.Color:=$00004000;
  if my_val and 2 = 2 then
    Form1.LedLeslieOk.Color:=$0000F000
  else
    Form1.LedLeslieOk.Color:=$00004000;

  my_str:=HX3_QueryStr(3);  // FPGA version
  Form1.Memo1.lines.Add(my_str);
  my_pos1:= Pos('[', my_str)+1;
  my_pos2:= Pos(']', my_str);
  if my_pos2 = 0 then my_pos2:= length(my_Str)-1 else dec(my_pos2);
  my_str:= copy(my_str, my_pos1+1, my_pos2-my_pos1);
  Form1.FPGAversion.Text:= my_str;
  HX3record.FPGAversion:= my_str;

  my_str:=HX3_QueryStr(9900);  // Scan Core reload/info
  Form1.Memo1.lines.Add(my_str);
  Form1.ComboBoxScancore.ItemIndex:= HX3_StrToInt(my_str);

  my_str:=HX3_QueryStr(9952);
  Form1.Memo1.lines.Add(my_str);
  HX3record.SerialNumber:= HX3_StrToInt(my_str);
  Form1.EditSerialNumber.Text:= IntToStr(HX3record.SerialNumber);;

  my_str:=HX3_QueryStr(9950);
  Form1.Memo1.lines.Add(my_str);
  HX3record.OrganLicence:= HX3_StrToInt(my_str);
  Form1.EditOrganLicence.Text:= IntToStr(HX3record.OrganLicence);

  my_str:=HX3_QueryStr(9951);
  Form1.Memo1.lines.Add(my_str);
  HX3record.LeslieLicence:= HX3_StrToInt(my_str);
  Form1.EditLeslieLicence.Text:= IntToStr(HX3record.LeslieLicence);

  my_str:=HX3_QueryStr(9990);
  Form1.Memo1.lines.Add(my_str);
  my_pos1:= Pos('[', my_str)+7;     // OWNER:  überspringen
  my_pos2:= Pos(']', my_str);
  if my_pos2 = 0 then my_pos2:= length(my_Str)-1 else dec(my_pos2);
  my_str:= copy(my_str, my_pos1+1, my_pos2-my_pos1);
  HX3record.Owner:= my_str;
  Form1.EditUserName.Text:= my_str;

  HX3record.FirmwareVersion:= HX3_QueryFloat(254);
  DecimalSeparator:= '.';
  my_str:= FloatToStr(HX3record.FirmwareVersion);
  Form1.EditFirmwareVersion.Text:= my_str;
  if HX3record.FirmwareVersion < 3.52 then begin
    Form1.Memo1.lines.Add('##### Warning: Firmware version below #3.6x, some functions may not work');
    HasBootLoaderJump:= false;
  end else
    HasBootLoaderJump:= true;
  if IsFPGAcorrupted then begin
    Form1.Memo1.lines.Add('##### Warning: FPGA config seems to be corrupted');
    Form1.Memo1.lines.Add('##### Warning: Update FPGA first and insert CONF_DIS JP when requested');
    Form1.BtnScanCore.Enabled:=false;
    Form1.BtnDSP.Enabled:=false;
  end else begin
    Form1.BtnScanCore.Enabled:=true;
    Form1.BtnDSP.Enabled:=true;
  end;
end;

procedure ResetCheckboxes;
begin
  with Form1 do begin
    CheckBox0.Checked:=false;
    CheckBox1.Checked:=false;
    CheckBox2.Checked:=false;
    CheckBox3.Checked:=false;
    CheckBox4.Checked:=false;
    CheckBox5.Checked:=false;
    CheckBox6.Checked:=false;
    CheckBox7.Checked:=false;
    CheckBox8.Checked:=false;
    CheckBox9.Checked:=false;
    CheckBox9.Checked:=false;
    CheckBox10.Checked:=false;
    CheckBox11.Checked:=false;
  end;
  if ftdi_isopen then begin
    HX3_Send(909,0,false);
    HX3_Send(919,0,false);
  end;
end;

procedure EnableButtons;
begin
  with Form1 do begin
    ReadAll.Enabled:=true;
    SendAll.Enabled:=true;
    UpdateFPGA.Enabled:=true;
    BtnSetLicence.Enabled:=true;
    BtnRefreshInfo.Enabled:=true;
    BtnScanCore.Enabled:=true;
    UpdateAVR.Enabled:=true;
    BtnCancel.Enabled:=true;
    BtnReset.Enabled:=true;
    BtnWriteBasics.Enabled:= true;

    Actions1.Enabled:= true;
    BtnClose.Visible:= true;
    BtnRescan.Visible:= false;
    BtnRescan.Enabled:= false;

    BtnScanCore.Enabled:=true;
    BtnDSP.Enabled:=true;

  end;
  ResetCheckBoxes;
end;

procedure DisableButtons;
begin
  with Form1 do begin
    ReadAll.Enabled:=false;
    SendAll.Enabled:=false;
    UpdateFPGA.Enabled:=false;
    BtnDSP.Enabled:=false;
    BtnSetLicence.Enabled:=false;
    BtnRefreshInfo.Enabled:=false;
    BtnScanCore.Enabled:=false;
    UpdateAVR.Enabled:=false;
    BtnCancel.Enabled:=false;
    BtnReset.Enabled:=false;
    Actions1.Enabled:= false;
    Connect1.Enabled:= true;
    BtnWriteBasics.Enabled:= false;

    BtnClose.Visible:= false;
    BtnRescan.Visible:= true;
    BtnRescan.Enabled:= true;

    Trackbar1.Visible:= false;
    OnOffBtn1.Visible:= false;
    OptionTextMenu.Visible:= false;
  end;
  ResetCheckboxes;
end;


procedure TForm1.BtnRefreshInfoClick(Sender: TObject);
// vorhandene Lizenznummern von HX3 holen
begin
  Form1.Memo1.Lines.Clear;
  HX3_resync;
  HX3_info;
end;

procedure TForm1.BtnSetLicenceClick(Sender: TObject);
// Lizenznummern senden
begin
  HX3_resync;
  HX3_SetStr('wen=1');
  HX3_SetStr('9950='+trim(EditOrganLicence.Text)+'!');
  Form1.Memo1.lines.Add(HX3_ResponseWait(2000));
  HX3_SetStr('wen=1');
  HX3_SetStr('9951='+trim(EditLeslieLicence.Text)+'!');
  Form1.Memo1.lines.Add(HX3_ResponseWait(2000));
  HX3_SendStr('wen=1!',100);
  Form1.Memo1.lines.Add(HX3_SendStr('9990="'+trim(EditUserName.Text)+'"!',200));
  HX3_resync;
  HX3_info;
end;


procedure TForm1.UpdateFPGAClick(Sender: TObject);
begin
  if IsFPGAcorrupted then FPGAcorruptedMsg;
  CancelProc:= false;
  OpenDialog.DefaultExt:='*.bit';
  OpenDialog.Title:= 'Open HX3 FPGA SoundEngine config (BIT):';
  OpenDialog.FilterIndex:= 1;
  if OpenDialog.Execute then begin
    Memo1.lines.Add('#--- Reading FPGA configuration...');
    Application.ProcessMessages;
    HX3_resync;
    CoreLoad(OpenDialog.Filename, -1);
    if CancelProc then begin
      CancelMsg;
      CancelProc:= false;
      exit;
    end;
  end else exit;
  if CancelProc then begin
    CancelMsg;
    CancelProc:= false;
    exit;
  end;
  CoreLoadAll(ExtractFilePath(OpenDialog.Filename));
  Memo1.lines.Add(HX3_SendStr('DFS=1!', 100));
  if IsFPGAcorrupted then RemoveConfDisJpMsg;
  Memo1.lines.Add(HX3_SendStr('9998', 1000));
  delay(1000);
  HX3_resync;
  HX3_info;
end;


procedure TForm1.BtnScanCoreClick(Sender: TObject);
begin
  OpenDialog.DefaultExt:='*.dat';
  OpenDialog.FilterIndex:= 3;
  if ComboBoxScanCore.ItemIndex = 8 then exit;

  if ComboBoxScanCore.ItemIndex = 9 then begin
    OpenDialog.Title:= 'Open any HX3 Scan Core in folder (DAT):';
    if not OpenDialog.Execute then exit;
    Memo1.lines.Add('#--- Reading all scan cores...');
    Application.ProcessMessages;
    CoreLoadAll(ExtractFilePath(OpenDialog.Filename));
  end else begin
    OpenDialog.Title:= 'Open HX3 Scan Core (DAT):';
    if not OpenDialog.Execute then exit;
    Memo1.lines.Add('#--- Reading single scan core...');
    CoreLoad(OpenDialog.Filename, ComboBoxScancore.ItemIndex);
    Form1.TransferProgress.Position:= 0;
    delay(200);
  end;
  Memo1.lines.Add(HX3_SendStr('DFS=1!', 100));
  Memo1.lines.Add(HX3_SendStr('9998', 1000));
  delay(1000);
end;


procedure TForm1.BtnDSPClick(Sender: TObject);
begin
  OpenDialog.DefaultExt:='*.bin';
  OpenDialog.FilterIndex:= 3;
  OpenDialog.Title:= 'Open FV-1 Reverb DSP binary file (BIN):';
  if not OpenDialog.Execute then exit;
  Memo1.lines.Add('#--- Reading FV-1 Reverb DSP binary...');
  Application.ProcessMessages;
  CoreLoad(OpenDialog.Filename, 10);
  Form1.TransferProgress.Position:= 0;
  Memo1.lines.Add(HX3_SendStr('DFS=1!', 100));
  showmessage('Insert JP7/JP8 I2C jumpers on HX3 board and click OK when done');
  delay(200);
  Memo1.lines.Add(HX3_SendStr('SFX=10!', 5000));
  Memo1.lines.Add(HX3_ResponseWait(500));
  delay(1000);
  showmessage('Remove JP7/JP8 I2C jumpers from HX3 board and click OK when done');
end;

procedure TForm1.UpdateScanCoresonly1Click(Sender: TObject);
begin
  ComboBoxScanCore.ItemIndex := 9;
  BtnScanCoreClick(Sender);
end;

//##############################################################################
//##############################################################################

procedure TForm1.FileSaveAs1Execute(Sender: TObject);
var mySaveFile: File of THX3record;
begin
  if SaveParamDialog.Execute then begin
    Form2HX3record;
    HX3settingsPath := SaveParamDialog.Filename;
    AssignFile(mySaveFile, HX3settingsPath);
    ReWrite(mySaveFile);
    Write(mySaveFile,HX3record);
    CloseFile(mySaveFile);
    Form1.Caption:= 'HX3 Remote  ['+ HX3settingsPath+']';
    Form1.Memo1.lines.Add('#--- Using parameter file: '+ ExtractFilename(HX3settingsPath));
  end;
end;

procedure TForm1.FileSaveExecute(Sender: TObject);
var mySaveFile: File of THX3record;
begin
  if FileExists(HX3settingsPath) then begin
    Form2HX3record;
    AssignFile(mySaveFile, HX3settingsPath);
    ReWrite(mySaveFile);
    Write(mySaveFile,HX3record);
    CloseFile(mySaveFile);
  end else
    Form1.FileSaveAs1Execute(nil);
end;

procedure TForm1.FileExit1Execute(Sender: TObject);
begin
  Close;
end;

//##############################################################################

procedure TForm1.SendAllClick(Sender: TObject);
var i, my_val:integer;
begin
  CancelProc:= false;
  Form2HX3record;
  case PageControl1.TabIndex of
    0: begin
      TransferProgress.Max:=  c_num_of_organparams;
      for i:= 0 to  c_num_of_organparams do begin
        LEDflash;
        my_val:= HX3record.OrganValues[i];
        HX3_send(400+i, my_val, sendWEN.Checked);
        TransferProgress.Position:= i;
        if CancelProc then begin
          CancelMsg;
          CancelProc:= false;
          exit;
        end;
      end;
    end;
    1: begin
      TransferProgress.Max:= c_num_of_leslieparams;
      for i:= 0 to c_num_of_leslieparams do begin
        LEDflash;
        my_val:= HX3record.LeslieValues[i];
        HX3_send(600+i, my_val, sendWEN.Checked);
        TransferProgress.Position:= i;
        if CancelProc then begin
          CancelMsg;
          CancelProc:= false;
          exit;
        end;
      end;
    end;
    2: begin
      TransferProgress.Max:= c_num_of_midiparams;
      for i:= 0 to c_num_of_midiparams do begin
        LEDflash;
        my_val:= HX3record.MidiCCValues[i];
        HX3_send(3000+i, my_val, sendWEN.Checked);
        TransferProgress.Position:= i;
        if CancelProc then begin
          CancelMsg;
          CancelProc:= false;
          exit;
        end;
      end;
    end;
    3: begin
      for i:= 0 to 255 do begin
        LEDflash;
        my_val:= HX3record.UpperPresets[i];
        HX3_send(1000+i, my_val, sendWEN.Checked);
        TransferProgress.Position:= i;
        if CancelProc then begin
          CancelMsg;
          CancelProc:= false;
          exit;
        end;
      end;
    end;
    4: begin
      for i:= 0 to 255 do begin
        LEDflash;
        my_val:= HX3record.LowerPresets[i];
        HX3_send(1256+i, my_val, sendWEN.Checked);
        TransferProgress.Position:= i;
        if CancelProc then begin
          CancelMsg;
          CancelProc:= false;
          exit;
        end;
      end;
    end;
  end;
  TransferProgress.Position :=0;
end;

procedure TForm1.ReadAllClick(Sender: TObject);
// Read all data to current tab from HX3
var my_val, i: LongInt;
begin
  CancelProc:= false;
  case PageControl1.TabIndex of
    0: begin
      TransferProgress.Max:=  c_num_of_organparams;
      for i:= 0 to  c_num_of_organparams do begin
        LEDflash;
        my_val:= HX3_query(i+400);
        HX3record.OrganValues[i]:= my_val;
        TransferProgress.Position:= i;
        if CancelProc then begin
          CancelMsg;
          CancelProc:= false;
          exit;
        end;
      end;
    end;
    1: begin
    if PageControl1.TabIndex = 1 then
      TransferProgress.Max:= c_num_of_leslieparams;
      for i:= 0 to c_num_of_leslieparams do begin
        LEDflash;
        my_val:= HX3_query(i+600);
        HX3record.LeslieValues[i]:= my_val;
        TransferProgress.Position:= i;
        if CancelProc then begin
          CancelMsg;
          CancelProc:= false;
          exit;
        end;
      end;
    end;
    2: begin
      TransferProgress.Max:= c_num_of_midiparams;
      for i:= 0 to c_num_of_midiparams do begin
        LEDflash;
        my_val:= HX3_query(i+3000);
        HX3record.MIDIccValues[i]:= my_val;
        TransferProgress.Position:= i;
        if CancelProc then begin
          CancelMsg;
          CancelProc:= false;
          exit;
        end;
      end;
    end;
    3: begin
      TransferProgress.Max:= 255;
      HX3_send(413,ComboboxUpperPreset.ItemIndex,false);
      delay(20);
      for i:= 0 to 255 do begin
        LEDflash;
        my_val:= HX3_query(1000+i);
        HX3record.UpperPresets[i]:= my_val;
        TransferProgress.Position:= i;
        if CancelProc then begin
          CancelMsg;
          CancelProc:= false;
          exit;
        end;
      end;
    end;
    4: begin
      TransferProgress.Max:= 255;
      HX3_send(414,Form1.ComboboxLowerPreset.ItemIndex,false);
      delay(20);
      for i:= 0 to 255 do begin
        LEDflash;
        my_val:= HX3_query(1256+i);
        HX3record.LowerPresets[i]:= my_val;
        TransferProgress.Position:= i;
        if CancelProc then begin
          CancelMsg;
          CancelProc:= false;
          exit;
        end;
      end;
    end;
  end;
  TransferProgress.Position :=0;
  HX3record2Form;
end;

//##############################################################################

procedure TForm1.BtnRescanClick(Sender: TObject);
// Auswahl des Frosches unter FTDI-Devices
var i : Integer; LV : TListItem;
begin
// Alle verfügbaren COM-Ports prüfen, Ergebnisse in Array speichern
  LEDflash;
  for i := 0 to 31 do begin
    ComPortAvailableList[i] := CheckCom(i);
{
    if (my_Err = 0) or (my_Err = ERROR_ACCESS_DENIED) then
// the Port exists, if  Err = ERROR_ACCESS_DENIED then the port is already open
    else if (my_Err = ERROR_FILE_NOT_FOUND) then
// the Port does not exist
    else
// another Error
}
  end;
  CancelProc:= false;
  deviceselectbox.ListView1.Items.clear;
  SetUpFTDI;
  if ftdi_device_count > 0 then
    for i := 0 to ftdi_device_count - 1 do begin
      LV := deviceselectbox.ListView1.Items.Add;
      LV.Caption := 'Device '+IntToStr(I);
      LV.SubItems.Add(ftdi_sernum_arr[i]);
      LV.SubItems.Add(ftdi_desc_arr[i]);
    end;

  deviceselectbox.ListView1.Items[0].Selected := true;
  deviceselectbox.ShowModal;
  if (deviceselectbox.ModalResult=MrOK) and (ftdi_device_count > 0) then begin
    ftdi_selected_device:= deviceselectbox.ListView1.itemindex;
    InitFTDI(ftdi_selected_device);
    if ftdi_isopen then begin
      EnableButtons;
      HX3_info;
      DeviceView.Text:= ftdi_sernum_arr[ftdi_selected_device]
      + ' - ' + ftdi_desc_arr[ftdi_selected_device];
      LEDflash;
      for i := 0 to 31 do begin
    // Erneut alle verfügbaren COM-Ports prüfen, Ergebnis mit Array vergleichen
    // Wenn Port jetzt gesperrt, ist er durch gewähltes ftdi-Device belegt
        if ComPortAvailableList[i] <> CheckCom(i) then begin
          ComPortUsed:=i;
          DeviceView.Text:= DeviceView.Text+ ' on COM'+IntToStr(ComPortUsed);
          exit;
        end;
      end;
      HX3_resync;
    end;
  end;

end;

procedure TForm1.BtnCloseClick(Sender: TObject);
begin
  if ftdi_isopen then
    ftdi.closeDevice;
  ftdi_isopen:= false;
  DisableButtons;
  DeviceView.Text:= '(not selected)';
end;

procedure TForm1.Timer1Timer(Sender: TObject);
// alle 10 ms aufgerufen: Schnittstelle abfragen und bei Telegramm-Ende
begin
  if LEDtimer = 0 then
    LEDstate(false)
  else
    dec(LEDtimer);

  if TimeOutValue = 0 then
    TimeOut:= true
  else begin
    TimeOut:= false;
    dec(TimeOutValue);
  end;
end;

procedure TForm1.FormDestroy(Sender: TObject);
var  FroschIni:TRegistryIniFile;
begin
  FroschIni:=TRegistryIniFile.Create(FroschRegKeyName);
  try
    FroschIni.WriteInteger('Form','Top',Top);
    FroschIni.WriteInteger('Form','Left',Left);
    FroschIni.WriteString('Settings','Path',HX3settingsPath);
    FroschIni.WriteInteger('Settings','Device', ftdi_selected_device);
  finally
    FroschIni.Free;
  end;
  if ftdi_isopen then
    ftdi.closeDevice;
  freeandnil(ftdi);
end;

procedure TForm1.FormCreate(Sender: TObject);
var
  FroschIni:TRegistryIniFile;

begin
  Form1.StringGrid1.RowCount:=  c_num_of_organparams+2;
  Form1.StringGrid2.RowCount:= c_num_of_leslieparams+2;
  Form1.StringGrid3.RowCount:= 129;
  ComPortUsed:=0;
  Form1.Memo1.lines.Clear;
  Form1.Memo1.lines.Add('#--- Welcome to HX3 Remote!');
  LEDflash;
  CancelProc:= false;
  setLength(TxFileBuffer,400000); // File-Buffer für FPGA-Konfiguration
  ftdi_selected_device:=0;
  TimeOutValue:=10;
  DisableButtons;
  FroschIni:=TRegistryIniFile.Create(FroschRegKeyName);
  HX3settingsPath:=ExtractFilePath(Application.ExeName)+'HX3_factory_defaults.hx3';
  try
    Top:=FroschIni.ReadInteger('Form','Top',150);
    Left:= FroschIni.ReadInteger('Form','Left',150);
    HX3settingsPath :=FroschIni.ReadString('Settings','Path','');
    ftdi_selected_device :=FroschIni.ReadInteger('Settings','Device',0);
  finally
    FroschIni.Free;
  end;
  NewHX3record;
  Stringgrid1.Row:=32;
  Stringgrid1.TopRow:=32;
end;

//##############################################################################
//##############################################################################
//##############################################################################

procedure TForm1.StringGrid1Click(Sender: TObject);
// Organ-Parameter
var
  i, my_row, my_hint, my_count, my_val: Integer;

begin
  SetTimeOut(10);
  my_row:= StringGrid1.Row-1;
  my_hint:= -1;
  my_count:= 0;
  EditValue.Text:= StringGrid1.Rows[my_row+1].Strings[2];
  if MenuHeaderArr[my_row][1]='(' then begin
    Trackbar1.Visible:= false;
    OnOffBtn1.Visible:= false;
    OptionTextMenu.Visible:= false;
    EditHint.Caption:= 'Non-Edit/Temp value';
    exit;
  end;
  EditHint.Caption:= StringGrid1.Rows[my_row+1].Strings[1];

  my_val:= TryStrToInt(StringGrid1.Rows[my_row+1].Strings[2]);
  if MenuMaxArr[my_row] > 1 then begin // enable Slider
    Trackbar1.Max:= MenuMaxArr[my_row];
    Trackbar1.Position:= my_val;
    Trackbar1.Visible:= true;
    OnOffBtn1.Visible:= false;
  end else begin
    Trackbar1.Visible:= false;
    OnOffBtn1.Visible:= true;
    if my_val > 0 then begin
      OnOffBtn1.Color:= clred;
      OnOffBtn1.Caption:= 'ON';
    end else begin
      OnOffBtn1.Color:= clMaroon;
      OnOffBtn1.Caption:= 'OFF';
    end;
  end;
  case my_row of
    10:
      begin
        my_hint:=35; // Vibknob
        my_count:=5;
      end;
    34:
      begin
        my_hint:=21; // MIDI option
        my_count:=3;
      end;
    35:
      begin
        my_hint:=0; // MIDI CC set
        my_count:=5;
      end;
    36:
      begin
        my_hint:=6; // MIDI CC set
        my_count:=2;
      end;
    38, 39:
      begin
        my_hint:=27; // Jack Config
        my_count:=3;
      end;
    53:
      begin
        my_hint:=17; // Leakage
        my_count:=3;
      end;
    56:
      begin
        my_hint:=31; // Foldback Mode
        my_count:=3;
      end;
    76:
      begin
        my_hint:=9; // Scan Core
        my_count:=7;
      end;
  end;
  // Wenn my_hint positiv, Drop-Down-Menü mit Einträgen aus MenuParamStrArr aktivieren
  if my_hint >= 0 then begin
    OptionTextMenu.Clear;
    for i:= 0 to my_count do begin
      OptionTextMenu.Items.Add(MenuParamStrArr[i+my_hint]);
    end;
    OptionTextMenu.Visible:= true;
    OptionTextMenu.ItemIndex:= HX3record.OrganValues[my_row];
    Trackbar1.Visible:= false;
    OnOffBtn1.Visible:= false;
  end else
    OptionTextMenu.Visible:= false;

  if ftdi_isopen then
    HX3_send(400+my_row, my_val, false);

end;

procedure TForm1.StringGrid2Click(Sender: TObject);
  // Leslie-Parameter
var
  my_row, my_val: Integer;

begin
  SetTimeOut(10);
  my_row:= StringGrid2.Row-1;
  my_val:= TryStrToInt(StringGrid2.Rows[my_row+1].Strings[2]);
  Trackbar1.Max:= 255;
  Trackbar1.Position:= my_val;
  Trackbar1.Visible:= true;
  OnOffBtn1.Visible:= false;
  EditHint.Caption:= StringGrid2.Rows[my_row+1].Strings[1];
  EditValue.Text:= StringGrid2.Rows[my_row+1].Strings[2];
  if ftdi_isopen then
    HX3_send(600+my_row, my_val, false);
end;

procedure TForm1.StringGrid3Click(Sender: TObject);
var
  my_row, my_val: Integer;
begin
  Trackbar1.Visible:= false;
  OnOffBtn1.Visible:= false;
  my_row:= StringGrid3.Row-1;
  my_val:= TryStrToInt(StringGrid3.Rows[my_row+1].Strings[2]);
  EditHint.Caption:=  GetCCdesc(my_Val);
  EditValue.Text:= '';
  if ftdi_isopen then
    HX3_send(3000+my_row, my_val, false);
end;



procedure TForm1.StringGrid1SetEditText(Sender: TObject; ACol, ARow: Integer;
  const Value: string);
var
  my_val: Integer;
  my_str: String;
begin
  if StringGrid1.EditorMode then exit;
  my_str:= trim(Value);
  my_val:= TryStrToInt(my_str);
  HX3record.OrganValues[ARow-1]:= my_val;
  EditValue.Text:= my_str;
  Trackbar1.Position:= my_val;
end;

procedure TForm1.StringGrid2SetEditText(Sender: TObject; ACol, ARow: Integer;
  const Value: string);
var
  my_val: Integer;
  my_str: String;
begin
  if StringGrid2.EditorMode then exit;
  my_str:= trim(Value);
  my_val:= TryStrToInt(my_str);
  HX3record.LeslieValues[ARow-1]:= my_val;
  EditValue.Text:= my_str;
  Trackbar1.Position:= my_val;
end;

procedure TForm1.StringGrid3SetEditText(Sender: TObject; ACol, ARow: Integer;
  const Value: string);
var
  my_val: Integer;
  my_str: String;
begin
  if StringGrid3.EditorMode then begin
    if length(Value) > 2 then begin
      my_str:= trim(Value);
      my_val:= TryStrToInt(my_str);
      EditHint.Caption:=  GetCCdesc(my_val);
      EditValue.Text:= '';
    end;
  end else begin
    my_str:= trim(Value);
    my_val:= TryStrToInt(my_str);
    HX3record.MIDIccValues[ARow-1]:= my_val;
  end;
end;

procedure TForm1.ComboBoxUpperPresetChange(Sender: TObject);
begin
  if ftdi_isopen then
    HX3_send(413,ComboboxUpperPreset.ItemIndex,false);
  HX3record2Form;
  EditHint.Caption:= 'Upper Drawbars';
end;

procedure TForm1.ComboBoxLowerPresetChange(Sender: TObject);
begin
  if ftdi_isopen then
    HX3_send(414,Form1.ComboboxLowerPreset.ItemIndex,false);
  HX3record2Form;
  EditHint.Caption:= 'Lower Drawbars';
end;


//##############################################################################
//##############################################################################
//##############################################################################

procedure TForm1.OptionTextMenuChange(Sender: TObject);
var
  my_row: Integer;
begin
  my_row:= StringGrid1.Row-1;
  if PageControl1.TabIndex = 0 then
    Form1.StringGrid1.Rows[my_row+1].Strings[2]:=IntToStr(OptionTextMenu.ItemIndex);
  EditValue.Text:= IntToStr(OptionTextMenu.ItemIndex);
  if ftdi_isopen then
    HX3_send(400+my_row, OptionTextMenu.ItemIndex, false);
end;

procedure TForm1.TrackBar1Change(Sender: TObject);
var
  my_row: Integer;
begin
  case PageControl1.TabIndex of
    0: begin // Organ Params
      my_row:= StringGrid1.Row-1;
      StringGrid1.Rows[my_row+1].Strings[2]:= IntToStr(Trackbar1.Position);
      HX3record.OrganValues[my_row]:= Trackbar1.Position;
      if ftdi_isopen then
        HX3_send(400+my_row, HX3record.OrganValues[my_row], false);
    end;
    1: begin // Leslie Params
      my_row:= StringGrid2.Row-1;
      StringGrid2.Rows[my_row+1].Strings[2]:= IntToStr(Trackbar1.Position);
      HX3record.LeslieValues[my_row]:= Trackbar1.Position;
      if ftdi_isopen then
        HX3_send(600+my_row, HX3record.LeslieValues[my_row], false);
    end;
  end;
  EditValue.Text:= IntToStr(Trackbar1.Position);
end;

procedure TForm1.OnOffBtn1Click(Sender: TObject);
var
  my_row: Integer;
begin
  if PageControl1.TabIndex = 0 then begin
    my_row:= StringGrid1.Row-1;
    if StringGrid1.Rows[my_row+1].Strings[2]= '0' then begin
      EditValue.Text:= '255';
      StringGrid1.Rows[my_row+1].Strings[2]:= '255';
      OnOffBtn1.Caption:= 'ON';
      OnOffBtn1.Color:= clRed;
      HX3record.OrganValues[my_row]:= 255;
    end else begin
      EditValue.Text:= '0';
      StringGrid1.Rows[my_row+1].Strings[2]:= '0';
      OnOffBtn1.Caption:= 'OFF';
      OnOffBtn1.Color:= clMaroon;
      HX3record.OrganValues[my_row]:= 0;
    end;
    if ftdi_isopen then
      HX3_send(400+my_row, HX3record.OrganValues[my_row], false);
  end;
end;


procedure TForm1.PageControl1Change(Sender: TObject);
begin
  Trackbar1.Visible:= false;
  OnOffBtn1.Visible:= false;
  OptionTextMenu.Visible:= false;
  if PageControl1.ActivePageIndex=3 then begin
    EditHint.Caption:= 'Drawbar change';
    if ftdi_isopen then
      HX3_send(413,ComboboxUpperPreset.ItemIndex,false);
  end;
  if PageControl1.ActivePageIndex=4 then begin
    EditHint.Caption:= 'Drawbar change';
    if ftdi_isopen then
      HX3_send(414,ComboboxUpperPreset.ItemIndex,false);
  end;
  HX3record2Form;
end;


//##############################################################################
//##############################################################################
//##############################################################################

procedure ExecuteFile(const AFilename: String;
                 AParameter, ACurrentDir: String; AWait: Boolean);
var
  si: TStartupInfo;
  pi: TProcessInformation;

begin
  if Length(ACurrentDir) = 0 then
    ACurrentDir := ExtractFilePath(AFilename)
  else if AnsiLastChar(ACurrentDir) = '\' then
    Delete(ACurrentDir, Length(ACurrentDir), 1);

  FillChar(si, SizeOf(si), 0);
  with si do begin
    cb := SizeOf(si);
    dwFlags := STARTF_USESHOWWINDOW;
    wShowWindow := SW_NORMAL;
  end;

  FillChar(pi, SizeOf(pi), 0);
  AParameter := Format('"%s" %s', [AFilename, TrimRight(AParameter)]);

  if CreateProcess(Nil, PChar(AParameter), Nil, Nil, False,
                   CREATE_DEFAULT_ERROR_MODE or CREATE_NEW_CONSOLE or
                   NORMAL_PRIORITY_CLASS, Nil, PChar(ACurrentDir), si, pi) then
  try
    if AWait then
      while WaitForSingleObject(pi.hProcess, 50) <> Wait_Object_0 do begin
        Application.ProcessMessages;
        LEDflash;
      end;
      TerminateProcess(pi.hProcess, Cardinal(-1));
  finally
    CloseHandle(pi.hProcess);
    CloseHandle(pi.hThread);
  end;
end;

function ExecuteAndResponse(DosApp:String):String;
// Shell-Programm ausführen und Antwort aufzeichnen
const
  ReadBuffer = 5000;
var
  Security : TSecurityAttributes;
  ReadPipe,WritePipe : THandle;
  start : TStartUpInfo;
  ProcessInfo : TProcessInformation;
  Buffer : Pchar;
  BytesRead : DWord;
  Apprunning : DWord;
  my_str: string;

begin
   my_str:='';
   With Security do begin
    nlength := SizeOf(TSecurityAttributes) ;
    binherithandle := true;
    lpsecuritydescriptor := nil;
   end;
   if Createpipe (ReadPipe, WritePipe,
                  @Security, 0) then begin
    Buffer := AllocMem(ReadBuffer + 1) ;
    FillChar(Start,Sizeof(Start),#0) ;
    start.cb := SizeOf(start) ;
    start.hStdOutput := WritePipe;
    start.hStdInput := ReadPipe;
    start.dwFlags := STARTF_USESTDHANDLES + STARTF_USESHOWWINDOW;
    start.wShowWindow := SW_HIDE;

    if CreateProcess(nil,
           PChar(DosApp),
           @Security,
           @Security,
           true,
           NORMAL_PRIORITY_CLASS,
           nil,
           nil,
           start,
           ProcessInfo)
    then
    begin
     repeat
      Apprunning := WaitForSingleObject(ProcessInfo.hProcess,100) ;
      Application.ProcessMessages;
     until (Apprunning <> WAIT_TIMEOUT) ;
      Repeat
        BytesRead := 0;
        ReadFile(ReadPipe,Buffer[0], ReadBuffer,BytesRead,nil) ;
        Buffer[BytesRead]:= #0;
        OemToAnsi(Buffer,Buffer) ;
        my_str := my_str+String(Buffer) ;
      until (BytesRead < ReadBuffer) ;
   end;
   FreeMem(Buffer) ;
   CloseHandle(ProcessInfo.hProcess) ;
   CloseHandle(ProcessInfo.hThread) ;
   CloseHandle(ReadPipe) ;
   CloseHandle(WritePipe) ;
  end;
  result:= my_str;
end;

procedure TForm1.UpdateAVRClick(Sender: TObject);
var
  my_hexfile, my_eepromfile: String;
begin

  CancelProc:= false;
  if not ftdi_isopen then exit;
  if IsFPGAcorrupted then FPGAcorruptedMsg;

  OpenDialog.Title:= 'Open HX3 controller firmware (HEX):';
  OpenDialog.FilterIndex:= 2;
  OpenDialog.DefaultExt:= '*.hex';
  if not OpenDialog.Execute then exit;
  my_hexfile:= OpenDialog.FileName;
  my_eepromfile:= ChangeFileExt(my_hexfile, '.eep');
  if not FileExists(my_eepromfile) then begin
    Form1.Memo1.lines.Add('##### Error: EEPROM file not found');
    exit;
  end;
  LEDflash;
  if HX3record.FirmwareVersion < 3.52 then
    showMessage('Insert RESET Jumper and pull same time when clicking OK')
  else
    HX3_setStr('9980=0');
  delay(50);
  ftdi.closeDevice;
  ftdi_isopen:= false;
  DisableButtons;
  DeviceView.Text:= '(in use by AVRdude)';
  Form1.Memo1.lines.Add('#--- Flash ´file: '+my_hexfile);
  Form1.Memo1.lines.Add('#--- EEPROM file: '+my_eepromfile);
  Application.ProcessMessages;

{  ExecuteShellCommand('avrdude.exe' + ' -C "avrdude.conf" -pm644p -cstk500v1 -P COM' + my_str +
    ' -b57600 -D -U flash:w:"HOAX_main.hex":i -U eeprom:w:"HOAX_main.eep":i', false);
}
  ExecuteFile(ExtractFilePath(Application.ExeName)+'avrdude.exe',
    ' -C "avrdude.conf" -pm644p -cstk500v1 -P COM' + IntToStr(ComPortUsed) +
    ' -b57600 -D -U flash:w:"'+my_hexfile+'":i -U eeprom:w:"'+my_eepromfile+'":i','', true);

  delay(1000);
  LEDflash;

  if IsFPGAcorrupted then RemoveConfDisJpMsg;

  InitFTDI(ftdi_selected_device);
  if ftdi_isopen then begin
    HX3_resync;
    HX3_info;
    DeviceView.Text:= ftdi_sernum_arr[ftdi_selected_device] + ', ' + ftdi_desc_arr[ftdi_selected_device];
    LEDflash;
    EnableButtons;
    UpdateFPGA.Enabled:=true;
  end;

end;


procedure TForm1.BtnCancelClick(Sender: TObject);
begin
  CancelProc:= true;
  TransferProgress.Position:= 0;
end;

procedure TForm1.EditUserNameChange(Sender: TObject);
begin
  HX3record.Owner:= trim(EditUserName.Text);
end;

procedure TForm1.EditOrganLicenceChange(Sender: TObject);
begin
  HX3record.OrganLicence:= TryStrToInt(EditOrganLicence.Text);
end;

procedure TForm1.EditLeslieLicenceChange(Sender: TObject);
begin
  HX3record.LeslieLicence:= TryStrToInt(EditLeslieLicence.Text);
end;


procedure TForm1.StringGrid1DrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
// Tabelle erste Zeile fett und rot
begin
  if ARow = 0 then
    with StringGrid1, Canvas do begin
      Font.Style := [fsBold];
      Font.Color:= clred;
      TextRect(Rect, Rect.Left + 2, Rect.Top + 2, Cells[ACol, ARow]);
    end;
end;

procedure TForm1.StringGrid2DrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
// Tabelle erste Zeile fett und rot
begin
  if ARow = 0 then
    with StringGrid2, Canvas do begin
      Font.Style := [fsBold];
      Font.Color:= clred;
      TextRect(Rect, Rect.Left + 2, Rect.Top + 2, Cells[ACol, ARow]);
    end;
end;

procedure TForm1.StringGrid3DrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
// Tabelle erste Zeile fett und rot
begin
  if ARow = 0 then
    with StringGrid3, Canvas do begin
      Font.Style := [fsBold];
      Font.Color:= clred;
      TextRect(Rect, Rect.Left + 2, Rect.Top + 2, Cells[ACol, ARow]);
    end;
end;

procedure TForm1.BtnLicenceGenClick(Sender: TObject);
var
  my_response, my_filename: String;
  my_pos1, my_pos2: cardinal;
  my_file: TextFile;

begin
  my_response:='';
  if FileExists(ExtractFilePath(Application.ExeName)+'decrypt56.exe') then begin
    my_response:=ExecuteAndResponse(ExtractFilePath(Application.ExeName)
      +'decrypt56.exe '+EditSerialNumber.Text);

    Memo1.lines.Add('#--- Licence Generation Result for: '+ EditUserName.Text);
    Memo1.lines.Add('#--- Serial Number: '+ EditSerialNumber.Text);
    my_response:=trim(my_response);
    Form1.Memo1.lines.Add('#--- Organ/Leslie Licences are '+my_response);
    my_pos1:= Pos('O:', my_response)+2;     // OWNER:  überspringen
    my_pos2:= Pos('L:', my_response)-1;
    EditOrganLicence.Text:= copy(my_response, my_pos1, my_pos2-my_pos1);
    my_pos1:= Pos('L:', my_response)+2;     // OWNER:  überspringen
    my_pos2:= length(my_response)+1;
    EditLeslieLicence.Text:= copy(my_response, my_pos1, my_pos2-my_pos1);
    my_filename:= ExtractFilePath(Application.ExeName)+'HX3_SERNUMS.txt';
    AssignFile(my_File, my_filename);
    if not FileExists(my_filename) then begin
      ReWrite(my_File);
      WriteLn(my_File,'Sernum ',#9,'OrganKey',#9,'LeslieKey',#9,
        'FPGA#   ',#9,'FW# ',#9,'ScanCore ',#9,'Date    ',#9,'Customer');
    end;
    Append(my_File);
    Write(my_File, HX3record.SerialNumber,#9,HX3record.OrganLicence,#9,
      HX3record.LeslieLicence,#9,HX3record.FPGAversion,#9,
      FloatToStr(HX3record.FirmwareVersion),#9,MenuParamStrArr[HX3record.OrganValues[76]+9],#9,DateToStr(now),#9);
    WriteLn(my_File,HX3record.Owner);
    CloseFile(my_File);
  end else
    Form1.Memo1.lines.Add('##### Error: DECRYPT56.EXE not found');
end;

procedure TForm1.BtnResetClick(Sender: TObject);
begin
  Form1.Memo1.Lines.Clear;
  ResetCheckboxes;
  HX3_reset;
  HX3_info;
end;

procedure TForm1.CheckBox0Click(Sender: TObject);
begin
  HX3_Send(900,byte(CheckBox0.Checked),false);
  Form2HX3record;
end;

procedure TForm1.CheckBox1Click(Sender: TObject);
begin
  HX3_Send(901,byte(CheckBox1.Checked),false);
  Form2HX3record;
end;

procedure TForm1.CheckBox2Click(Sender: TObject);
begin
  HX3_Send(902,byte(CheckBox2.Checked),false);
  Form2HX3record;
end;

procedure TForm1.CheckBox3Click(Sender: TObject);
begin
  HX3_Send(903,byte(CheckBox3.Checked),false);
  Form2HX3record;
end;

procedure TForm1.CheckBox4Click(Sender: TObject);
begin
  HX3_Send(904,byte(CheckBox4.Checked),false);
  Form2HX3record;
end;

procedure TForm1.CheckBox5Click(Sender: TObject);
begin
  HX3_Send(905,byte(CheckBox5.Checked),false);;
  Form2HX3record;
end;

procedure TForm1.CheckBox6Click(Sender: TObject);
begin
  HX3_Send(906,byte(CheckBox6.Checked),false);
  Form2HX3record;
end;

procedure TForm1.CheckBox7Click(Sender: TObject);
begin
  HX3_Send(907,byte(CheckBox7.Checked),false);
  Form2HX3record;
end;

procedure TForm1.CheckBox8Click(Sender: TObject);
var my_int: Integer;
begin
  HX3_Send(914,byte(CheckBox8.Checked),false);
  if Form1.CheckBox8.Checked then
    my_int:= 1 else my_int:= 0;
  if Form1.CheckBox9.Checked then
    my_int:= my_int or 2;
  Stringgrid1.Cells[2,32+1]:= IntToSTr(my_int);
  Form2HX3record;
end;

procedure TForm1.CheckBox9Click(Sender: TObject);
var my_int: Integer;
begin
  HX3_Send(915,byte(CheckBox9.Checked),false);
  if Form1.CheckBox8.Checked then
    my_int:= 1 else my_int:= 0;
  if Form1.CheckBox9.Checked then
    my_int:= my_int or 2;
  Stringgrid1.Cells[2,32+1]:= IntToSTr(my_int);
  Form2HX3record;
end;

procedure TForm1.CheckBox10Click(Sender: TObject);
begin
  HX3_Send(916,byte(CheckBox10.Checked),false);
  Form2HX3record;
end;

procedure TForm1.CheckBox11Click(Sender: TObject);
begin
  HX3_Send(917,byte(CheckBox11.Checked),false);
  Form2HX3record;
end;

procedure TForm1.TrackBarU0Change(Sender: TObject);
begin
  EditValue.Text:= IntToStr(TrackBarU0.Position);
  HX3record.UpperPresets[0+16*Form1.ComboboxUpperPreset.ItemIndex]:= Form1.TrackBarU0.Position;
  if ftdi_isopen then
    HX3_send(401,Form1.TrackBarU0.Position,false);
end;

procedure TForm1.TrackBarU1Change(Sender: TObject);
begin
  EditValue.Text:= IntToStr(TrackBarU1.Position);
  HX3record.UpperPresets[1+16*Form1.ComboboxUpperPreset.ItemIndex]:= Form1.TrackBarU1.Position;
  if ftdi_isopen then
    HX3_send(402,Form1.TrackBarU1.Position,false);
end;

procedure TForm1.TrackBarU2Change(Sender: TObject);
begin
  EditValue.Text:= IntToStr(TrackBarU2.Position);
  HX3record.UpperPresets[2+16*Form1.ComboboxUpperPreset.ItemIndex]:= Form1.TrackBarU2.Position;
  if ftdi_isopen then
    HX3_send(403,Form1.TrackBarU2.Position,false);
end;

procedure TForm1.TrackBarU3Change(Sender: TObject);
begin
  EditValue.Text:= IntToStr(TrackBarU3.Position);
  HX3record.UpperPresets[3+16*Form1.ComboboxUpperPreset.ItemIndex]:= Form1.TrackBarU3.Position;
  if ftdi_isopen then
    HX3_send(404,Form1.TrackBarU3.Position,false);
end;

procedure TForm1.TrackBarU4Change(Sender: TObject);
begin
  EditValue.Text:= IntToStr(TrackBarU4.Position);
  HX3record.UpperPresets[4+16*Form1.ComboboxUpperPreset.ItemIndex]:= Form1.TrackBarU4.Position;
  if ftdi_isopen then
    HX3_send(405,Form1.TrackBarU4.Position,false);
end;

procedure TForm1.TrackBarU5Change(Sender: TObject);
begin
  EditValue.Text:= IntToStr(TrackBarU5.Position);
  HX3record.UpperPresets[5+16*Form1.ComboboxUpperPreset.ItemIndex]:= Form1.TrackBarU5.Position;
  if ftdi_isopen then
    HX3_send(406,Form1.TrackBarU5.Position,false);
end;

procedure TForm1.TrackBarU6Change(Sender: TObject);
begin
  EditValue.Text:= IntToStr(TrackBarU5.Position);
  HX3record.UpperPresets[6+16*Form1.ComboboxUpperPreset.ItemIndex]:= Form1.TrackBarU6.Position;
  if ftdi_isopen then
    HX3_send(407,Form1.TrackBarU6.Position,false);
end;

procedure TForm1.TrackBarU7Change(Sender: TObject);
begin
  EditValue.Text:= IntToStr(TrackBarU7.Position);
  HX3record.UpperPresets[7+16*Form1.ComboboxUpperPreset.ItemIndex]:= Form1.TrackBarU7.Position;
  if ftdi_isopen then
    HX3_send(408,Form1.TrackBarU7.Position,false);
end;

procedure TForm1.TrackBarU8Change(Sender: TObject);
begin
  EditValue.Text:= IntToStr(TrackBarU8.Position);
  HX3record.UpperPresets[8+16*Form1.ComboboxUpperPreset.ItemIndex]:= Form1.TrackBarU8.Position;
  if ftdi_isopen then
    HX3_send(409,Form1.TrackBarU8.Position,false);
end;

procedure TForm1.TrackbarL0Change(Sender: TObject);
begin
  EditValue.Text:= IntToStr(TrackbarL0.Position);
  HX3record.LowerPresets[0+16*Form1.ComboboxLowerPreset.ItemIndex]:= Form1.TrackbarL0.Position;
  if ftdi_isopen then
    HX3_send(416,Form1.TrackbarL0.Position,false);
end;

procedure TForm1.TrackbarL1Change(Sender: TObject);
begin
  EditValue.Text:= IntToStr(TrackbarL1.Position);
  HX3record.LowerPresets[1+16*Form1.ComboboxLowerPreset.ItemIndex]:= Form1.TrackbarL1.Position;
  if ftdi_isopen then
    HX3_send(417,Form1.TrackbarL1.Position,false);
end;

procedure TForm1.TrackbarL2Change(Sender: TObject);
begin
  EditValue.Text:= IntToStr(TrackbarL2.Position);
  HX3record.LowerPresets[2+16*Form1.ComboboxLowerPreset.ItemIndex]:= Form1.TrackbarL2.Position;
  if ftdi_isopen then
    HX3_send(418,Form1.TrackbarL2.Position,false);
end;

procedure TForm1.TrackbarL3Change(Sender: TObject);
begin
  EditValue.Text:= IntToStr(TrackbarL3.Position);
  HX3record.LowerPresets[3+16*Form1.ComboboxLowerPreset.ItemIndex]:= Form1.TrackbarL3.Position;
  if ftdi_isopen then
    HX3_send(419,Form1.TrackbarL3.Position,false);
end;

procedure TForm1.TrackbarL4Change(Sender: TObject);
begin
  EditValue.Text:= IntToStr(TrackbarL4.Position);
  HX3record.LowerPresets[4+16*Form1.ComboboxLowerPreset.ItemIndex]:= Form1.TrackbarL4.Position;
  if ftdi_isopen then
    HX3_send(420,Form1.TrackbarL4.Position,false);
end;

procedure TForm1.TrackbarL5Change(Sender: TObject);
begin
  EditValue.Text:= IntToStr(TrackbarL5.Position);
  HX3record.LowerPresets[5+16*Form1.ComboboxLowerPreset.ItemIndex]:= Form1.TrackbarL5.Position;
  if ftdi_isopen then
    HX3_send(421,Form1.TrackbarL5.Position,false);
end;

procedure TForm1.TrackbarL6Change(Sender: TObject);
begin
  EditValue.Text:= IntToStr(TrackbarL5.Position);
  HX3record.LowerPresets[6+16*Form1.ComboboxLowerPreset.ItemIndex]:= Form1.TrackbarL6.Position;
  if ftdi_isopen then
    HX3_send(422,Form1.TrackbarL6.Position,false);
end;

procedure TForm1.TrackbarL7Change(Sender: TObject);
begin
  EditValue.Text:= IntToStr(TrackbarL7.Position);
  HX3record.LowerPresets[7+16*Form1.ComboboxLowerPreset.ItemIndex]:= Form1.TrackbarL7.Position;
  if ftdi_isopen then
    HX3_send(423,Form1.TrackbarL7.Position,false);
end;

procedure TForm1.TrackbarL8Change(Sender: TObject);
begin
  EditValue.Text:= IntToStr(TrackbarL8.Position);
  HX3record.LowerPresets[8+16*Form1.ComboboxLowerPreset.ItemIndex]:= Form1.TrackbarL8.Position;
  if ftdi_isopen then
    HX3_send(424,Form1.TrackbarL8.Position,false);
end;

procedure TForm1.TrackBarB0Change(Sender: TObject);
begin
  EditValue.Text:= IntToStr(TrackbarB0.Position);
  HX3record.LowerPresets[9+16*Form1.ComboboxLowerPreset.ItemIndex]:= Form1.TrackbarB0.Position;
  if ftdi_isopen then
    HX3_send(425,Form1.TrackbarB0.Position,false);
end;

procedure TForm1.TrackBarB1Change(Sender: TObject);
begin
  EditValue.Text:= IntToStr(TrackbarB1.Position);
  HX3record.LowerPresets[10+16*Form1.ComboboxLowerPreset.ItemIndex]:= Form1.TrackbarB1.Position;
  if ftdi_isopen then
    HX3_send(426,Form1.TrackbarB1.Position,false);
end;

procedure TForm1.TrackBarB2Change(Sender: TObject);
begin
  EditValue.Text:= IntToStr(TrackbarB2.Position);
  HX3record.LowerPresets[11+16*Form1.ComboboxLowerPreset.ItemIndex]:= Form1.TrackbarB2.Position;
  if ftdi_isopen then
    HX3_send(427,Form1.TrackbarB2.Position,false);
end;

procedure TForm1.TrackBarB3Change(Sender: TObject);
begin
  EditValue.Text:= IntToStr(TrackbarB3.Position);
  HX3record.LowerPresets[12+16*Form1.ComboboxLowerPreset.ItemIndex]:= Form1.TrackbarB3.Position;
  if ftdi_isopen then
    HX3_send(428,Form1.TrackbarB3.Position,false);
end;

procedure TForm1.ComboBoxVibKnobChange(Sender: TObject);
// Vibrato Knob
begin
  EditHint.Caption:= 'VibKnob Change';
  EditValue.Text:= IntToStr(Form1.ComboBoxVibKnob.ItemIndex);
  if ftdi_isopen then
    HX3_send(410,Form1.ComboBoxVibKnob.ItemIndex,false);
  HX3record.UpperPresets[9+16*Form1.ComboboxUpperPreset.ItemIndex]:= Form1.ComboBoxVibKnob.ItemIndex;
end;

procedure TForm1.BtnWriteBasicsClick(Sender: TObject);
begin
  HX3record.OrganValues[76]:= BasicScanMode.ItemIndex;
  HX3record.OrganValues[77]:= byte(BasicExpanderMode.Checked);
  HX3record.OrganValues[38]:= BasicJackA.ItemIndex;
  HX3record.OrganValues[39]:= BasicJackB.ItemIndex;
  HX3record.OrganValues[80]:= byte(BasicToneEna.Checked);
  HX3record.OrganValues[81]:= byte(not BasicExpanderMode.Checked);
  if ftdi_isopen then begin
    Form1.Memo1.Lines.Clear;
    HX3_info;
    BtnLicenceGenClick(Sender);
    LEDflash;
    HX3_send(438,HX3record.OrganValues[38],true);
    HX3_send(439,HX3record.OrganValues[39],true);
    HX3_send(476,HX3record.OrganValues[76],true);
    HX3_send(477,HX3record.OrganValues[77],true);
    HX3_send(480,HX3record.OrganValues[39],true); // Tone Pot Ena
    HX3_send(481,HX3record.OrganValues[81],true); // Amp122 Volume Pot Ena
    LEDflash;
    BtnSetLicenceClick(Sender);
    Memo1.lines.Add('#--- HX3 set to current Basic Setting controls');
  end;
  HX3record2Form;
end;

procedure TForm1.BasicExpanderModeClick(Sender: TObject);
begin
  if BasicExpanderMode.Checked then begin
    BasicToneEna.Checked:= false;
    BasicScanMode.ItemIndex:= 1;
  end;
end;

end.
