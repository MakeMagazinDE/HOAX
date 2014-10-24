unit hx3_remote_main;

//##############################################################################
//
//    Remote/Update-Utility für HX3 mk3 Organ Module
//    Kommuniziert über FTDI D2XX-DLL für FT232R USB/Seriell-Wandler
//    Q&D RAD mit Delphi 2005 Personal Edition
//    (c) 5/2014 by Carsten Meyer, engineering@keyboardpartner.de
//
//    #1.20 Umbau auf Import-Dateien
//    #1.07 leicht geändertes XModem-Timing
//    #1.06 MIDI-CC und Preset-Editor eingebaut
//    #0.97 erste freigegebene Version, noch ohne MIDI-CC
//    #0.95 Übernahme aus FroschLoader D2XX
//
//##############################################################################


interface

uses SysUtils, StrUtils, Windows, Classes, Graphics, Forms, Controls, Menus,
  Dialogs, StdCtrls, Buttons, ColorButton, ExtCtrls, ComCtrls, ImgList, StdActns,
  ActnList, ToolWin, Spin, FileCtrl, Grids, Registry, ShellApi, XPMan, Gauges;

type

  TAnoPipe=record
    Input : THandle; // Handle to send data to the pipe
    Output: THandle; // Handle to read data from the pipe
  end;

  TForm1 = class(TForm)
    OpenDialog: TOpenDialog;
    SaveParamDialog: TSaveDialog;
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
    DeviceView: TEdit;
    ReadAll: TBitBtn;
    ComboBox1: TComboBox;
    UpdateFPGA: TBitBtn;
    UpdateAVR: TBitBtn;
    EditSerialNumber: TEdit;
    EditOrganLicence: TEdit;
    EditLeslieLicence: TEdit;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Bevel1: TBevel;
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
    BtnCancel: TSpeedButton;
    EditUserName: TEdit;
    Label2: TLabel;
    BtnRefreshInfo: TBitBtn;
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
    ComboBoxVibKnob: TComboBox;
    CheckBox4: TCheckBox;
    CheckBox3: TCheckBox;
    CheckBox2: TCheckBox;
    CheckBox1: TCheckBox;
    CheckBox0: TCheckBox;
    CheckBox5: TCheckBox;
    CheckBox6: TCheckBox;
    CheckBox7: TCheckBox;
    ComboBoxLowerPreset: TComboBox;
    ComboBoxUpperPreset: TComboBox;
    ComboBoxScancore: TComboBox;
    BtnDSP: TBitBtn;
    BasicScanMode: TComboBox;
    Bevel11: TBevel;
    Label10: TLabel;
    BasicExpanderMode: TCheckBox;
    BtnWriteBasics: TBitBtn;
    Label38: TLabel;
    BasicToneEna: TCheckBox;
    Label39: TLabel;
    LedOrganOk: TPanel;
    LedLeslieOk: TPanel;
    XPManifest1: TXPManifest;
    LEDbusy: TPanel;
    BtnUpdateFIR: TBitBtn;
    Panel1: TPanel;
    Bevel3: TBevel;
    StringGrid3: TStringGrid;
    StringGrid2: TStringGrid;
    MIDIccHint: TLabel;
    Label40: TLabel;
    EditMidiRec: TEdit;
    MidiCCListBox: TListBox;
    CheckboxEEwrite: TCheckBox;
    N10: TMenuItem;
    ImportOrganData1: TMenuItem;
    ImportLeslieData1: TMenuItem;
    ImportMIDICCData1: TMenuItem;
    N7: TMenuItem;
    ExportOrganData1: TMenuItem;
    ExportLeslieData1: TMenuItem;
    ExportMIDICCData1: TMenuItem;
    ImportUpperPresets1: TMenuItem;
    ImportLowerPresets1: TMenuItem;
    ExportUpperPresets1: TMenuItem;
    ExportLowerPresets1: TMenuItem;
    TabSheet6: TTabSheet;
    EditOrganDefaultsFile: TEdit;
    ImportOrgan: TCheckBox;
    ImportLeslie: TCheckBox;
    ImportMidiCC: TCheckBox;
    ImportUpper: TCheckBox;
    ImportLower: TCheckBox;
    EditLeslieDefaultsFile: TEdit;
    EditMidiCCFile: TEdit;
    EditUpperPresetsFile: TEdit;
    EditLowerPresetsFile: TEdit;
    New1: TMenuItem;
    Label41: TLabel;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    SpeedButton4: TSpeedButton;
    SpeedButton5: TSpeedButton;
    Label42: TLabel;
    Label43: TLabel;
    CheckBox8: TCheckBox;
    CheckBox9: TCheckBox;
    CheckBox10: TCheckBox;
    CheckBox11: TCheckBox;
    GaugeMIDIdata: TGauge;
    CheckBit7: TCheckBox;
    CheckBit6: TCheckBox;
    CheckBit5: TCheckBox;
    CheckBit4: TCheckBox;
    CheckBit3: TCheckBox;
    CheckBit2: TCheckBox;
    CheckBit1: TCheckBox;
    CheckBit0: TCheckBox;
    ScrollBar1: TScrollBar;
    ComboBoxScanDetected: TComboBox;
    procedure StringGrid1SelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure CheckBitClick(Sender: TObject);
    procedure StringGrid1SetEditText(Sender: TObject; ACol, ARow: Integer;
      const Value: string);
    procedure ImportUpperPresets1Click(Sender: TObject);
    procedure ImportLowerPresets1Click(Sender: TObject);
    procedure ExportLowerPresets1Click(Sender: TObject);
    procedure New1Click(Sender: TObject);
    procedure EditLowerPresetsFileChange(Sender: TObject);
    procedure EditUpperPresetsFileChange(Sender: TObject);
    procedure EditMidiCCFileChange(Sender: TObject);
    procedure EditLeslieDefaultsFileChange(Sender: TObject);
    procedure EditOrganDefaultsFileChange(Sender: TObject);
    procedure ExportUpperPresets1Click(Sender: TObject);
    procedure StringGrid1Click(Sender: TObject);
    procedure ImportOrganData1Click(Sender: TObject);
    procedure ImportLeslieData1Click(Sender: TObject);
    procedure ExportOrganData1Click(Sender: TObject);
    procedure ExportLeslieData1Click(Sender: TObject);
    procedure ImportMIDICCData1Click(Sender: TObject);
    procedure ExportMIDICCData1Click(Sender: TObject);
    procedure MidiCCListBoxClick(Sender: TObject);
    procedure MidiCCListBoxDrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
    procedure StringGrid3SetEditText(Sender: TObject; ACol, ARow: Integer;
      const Value: string);
    procedure StringGrid3Click(Sender: TObject);
    procedure StringGrid2TopLeftChanged(Sender: TObject);

    procedure Panel1Click(Sender: TObject);
    procedure StringGrid1TopLeftChanged(Sender: TObject);


    procedure BtnFIRClick(Sender: TObject);
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
    procedure StringGrid123DrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
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
    procedure UpdateScanCoresClick(Sender: TObject);
    procedure BtnResetClick(Sender: TObject);
    procedure BtnLicenceGenClick(Sender: TObject);
    procedure BtnScanCoreClick(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure BtnRefreshInfoClick(Sender: TObject);
    procedure EditLeslieLicenceChange(Sender: TObject);
    procedure EditOrganLicenceChange(Sender: TObject);
    procedure EditUserNameChange(Sender: TObject);
    procedure BtnCancelClick(Sender: TObject);

    procedure PageControl1Change(Sender: TObject);
    procedure BtnCloseClick(Sender: TObject);
    procedure BtnSetLicenceClick(Sender: TObject);
    procedure UpdateAVRClick(Sender: TObject);
    procedure UpdateFPGAClick(Sender: TObject);
    procedure Scrollbar1Change(Sender: TObject);
    procedure FileSaveExecute(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
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

type
  THX3Record = record
    OrganBasicSettings: array [0..127] of LongInt;
    Device: Integer;
    FirmwareVersion: Real;
    FPGAversion: String[10];
    SerialNumber: LongInt;
    OrganLicence: LongInt;
    LeslieLicence: LongInt;
    Owner: String[63];
    OrganParamFile: String[255];
    LeslieParamFile: String[255];
    MidiCCFile: String[255];
    UpperPresetFile: String[255];
    LowerPresetFile: String[255];
    ImportOrgan: Boolean;
    ImportLeslie: Boolean;
    ImportMidiCC: Boolean;
    ImportUpper: Boolean;
    ImportLower: Boolean;
  end;

const
//### Länge des Parameter-EEPROMs
  VersionInfo='Version 3.63';
  FroschDefaultDesc='FT232R USB UART';
  FroschDefDriveName='HOAX';
  FroschRegKeyName='HX3remote';

var
  HX3settingsPath: String; // Pfad zur Settings-Datei
  HX3record: THX3Record;
  Form1: TForm1;
  n, m:Integer;
  TimeOutValue,LEDtimer: Integer;  // Timer-Tick-Zähler
  TimeOut: Boolean;
  ComPortAvailableList: Array[0..31] of Integer;
  HasBootLoaderJump: Boolean;
  CancelProc: boolean;
  ComPortUsed: Integer;
  LastMidiCC, LastMidiVal: LongInt;
  ButtonDescList: TstringList;
  MidiCCList: TstringList;
  DropDownList: TstringList;
  LastControlName: String; // zuletzt verwendetes Control in StringGrids
  ClickedOnCell: Boolean;
  UpperPresets: array [0..255] of LongInt;
  LowerPresets: array [0..255] of LongInt;

implementation

uses about, deviceselect, hx3_com, hx3_MenuItems, FTDIchip;

{$R *.dfm}

//##############################################################################

{$I hx3_tools.inc}
{$I hx3_files.inc}
{$I hx3_stringgrids.inc}
{$I hx3_presets.inc}

//##############################################################################


procedure TForm1.BtnRefreshInfoClick(Sender: TObject);
// vorhandene Lizenznummern von HX3 holen
begin
  CancelProc:= false;
  Form1.Memo1.Lines.Clear;
  HX3_info;
end;

procedure TForm1.BtnSetLicenceClick(Sender: TObject);
// Lizenznummern senden
begin
  CancelProc:= false;
  HX3_resync;
  HX3_SetStr('wen=1');
  HX3_SetStr('9950='+trim(EditOrganLicence.Text)+'!');
  Form1.Memo1.lines.Add(HX3_ResponseWait(2000));
  HX3_SetStr('wen=1');
  HX3_SetStr('9951='+trim(EditLeslieLicence.Text)+'!');
  Form1.Memo1.lines.Add(HX3_ResponseWait(2000));
  HX3_SendStr('wen=1!',100);
  Form1.Memo1.lines.Add(HX3_SendStr('9990="'+trim(EditUserName.Text)+'"!',200));
  HX3_info;
end;

procedure TForm1.UpdateFPGAClick(Sender: TObject);
begin
  CancelProc:= false;
  if IsFPGAcorrupted then FPGAcorruptedMsg;
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
      exit;
    end;
    HX3_resync;
    Memo1.lines.Add(HX3_SendStr('DFS=1!', 100));
    HX3_info;
    Memo1.lines.Add('#--- Empty ScanCore and Reverb DSP Memory.');
    Memo1.lines.Add('#--- Please update ScanCore(s) and DSP!');
    if IsFPGAcorrupted then begin
      RemoveConfDisJpMsg;
      HX3_info;
    end;
  end;
end;

procedure TForm1.BtnScanCoreClick(Sender: TObject);
begin
  CancelProc:= false;
  OpenDialog.DefaultExt:='*.dat';
  OpenDialog.FilterIndex:= 3;
  if ComboBoxScanCore.ItemIndex = 8 then exit;

  if ComboBoxScanCore.ItemIndex = 9 then begin
    OpenDialog.Title:= 'Open any HX3 Scan Core in folder (DAT):';
    if not OpenDialog.Execute then exit;
    Memo1.lines.Add('#--- Reading all scan cores...');
    Application.ProcessMessages;
    CoreLoadAll(ExtractFilePath(OpenDialog.Filename));
    Memo1.lines.Add(HX3_SendStr('DFS=1!', 100));
  end else begin
    OpenDialog.Title:= 'Open HX3 Scan Core (DAT):';
    if not OpenDialog.Execute then exit;
    Memo1.lines.Add('#--- Reading single scan core...');
    CoreLoad(OpenDialog.Filename, ComboBoxScancore.ItemIndex);
    Form1.TransferProgress.Position:= 0;
    delay(200);
    Memo1.lines.Add(HX3_SendStr('DFS=1!', 100));
    HX3_send(476,ComboBoxScanCore.ItemIndex,true);
  end;
  Form1.Memo1.lines.Add(HX3_QueryStr(9900));   // Scan Core reload/info
end;

procedure TForm1.BtnDSPClick(Sender: TObject);
begin
  CancelProc:= false;
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

procedure TForm1.UpdateScanCoresClick(Sender: TObject);
begin
  CancelProc:= false;
  ComboBoxScanCore.ItemIndex := 9;
  BtnScanCoreClick(Sender);
end;

procedure TForm1.BtnFIRClick(Sender: TObject);
var
  my_ReadFile: TextFile;
  i, my_int: LongInt;
  my_str, my_resp: String;
begin
  CancelProc:= false;
  OpenDialog.DefaultExt:='*.pas';
  OpenDialog.FilterIndex:= 4;
  OpenDialog.Title:= 'Open FIR coeff file (PAS, COE):';
  if not OpenDialog.Execute then exit;
  Memo1.lines.Add('#--- Loading FIR filter coefficients...');
  Application.ProcessMessages;

  HX3_resync;
  FileMode := fmOpenRead;
  AssignFile(my_ReadFile, OpenDialog.FileName);
  Reset(my_ReadFile);
  Form1.TransferProgress.Max:= 511;
  i:=0;
  while not Eof(my_ReadFile) do begin
    my_str:=' ';
    Readln(my_ReadFile,my_str);
    if  not (my_str[1] in ['+','-','0'..'9']) then continue; // Leere Zeilen ignorieren
    Form1.TransferProgress.Position:= i;

    my_int:= pos(',', my_str);
    if my_int > 0 then
      my_str:= copy(my_str, 1, my_int-1);

    my_int:= pos(')',my_str);
    if my_int > 0 then
      my_str:= copy(my_str, 1, my_int-1);

    my_int:= StrToInt(trim(my_str));

    if ftdi_isopen then begin
      my_resp:= HX3_Send(2000+i, my_int, true);
      if pos('=0',my_resp) =0 then // Fehler!
        Form1.Memo1.lines.Add(my_resp);
    end else
      Form1.Memo1.lines.add(my_str);
    LEDflash;
    inc(i);
    if CancelProc then begin
      CancelMsg;
      break;
    end;
  end;
  CloseFile(my_ReadFile);
  Form1.TransferProgress.Position:= 0;
  HX3_resync;
end;

//##############################################################################

procedure TForm1.SendAllClick(Sender: TObject);
var i, my_val:integer;
begin
  CancelProc:= false;
  case PageControl1.TabIndex of
    0: begin
      TransferProgress.Max:= StringGrid1.RowCount-1;
      for i:= 0 to TransferProgress.Max do begin
        LEDflash;
        my_val:= IntFromStringGrid1(2,i+1);
        HX3_send(IntFromStringGrid1(0,i+1), my_val, true);
        TransferProgress.Position:= i;
        if CancelProc then begin
          CancelMsg;
          exit;
        end;
      end;
    end;
    1: begin
      TransferProgress.Max:= StringGrid2.RowCount-1;
      for i:= 0 to TransferProgress.Max do begin
        LEDflash;
        my_val:= IntFromStringGrid2(2,i+1);
        HX3_send(IntFromStringGrid2(0,i+1), my_val, true);
        TransferProgress.Position:= i;
        if CancelProc then begin
          CancelMsg;
          exit;
        end;
      end;
    end;
    2: begin
      TransferProgress.Max:= StringGrid3.RowCount-1;;
      for i:= 0 to TransferProgress.Max do begin
        LEDflash;
        my_val:= IntFromStringGrid3(2,i+1);
        HX3_send(IntFromStringGrid3(0,i+1), my_val, true);
        TransferProgress.Position:= i;
        if CancelProc then begin
          CancelMsg;
          exit;
        end;
      end;
    end;
    3: begin
      Form2HX3record;
      for i:= 0 to 255 do begin
        LEDflash;
        my_val:= UpperPresets[i];
        HX3_send(1000+i, my_val, true);
        TransferProgress.Position:= i;
        if CancelProc then begin
          CancelMsg;
          exit;
        end;
      end;
    end;
    4: begin
      Form2HX3record;
      for i:= 0 to 255 do begin
        LEDflash;
        my_val:= LowerPresets[i];
        HX3_send(1256+i, my_val, true);
        TransferProgress.Position:= i;
        if CancelProc then begin
          CancelMsg;
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
      TransferProgress.Max:= StringGrid1.RowCount-1;
      for i:= 0 to TransferProgress.Max do begin
        LEDflash;
        my_val:= HX3_query(IntFromStringGrid1(0,i+1));
        StringGrid1.Cells[2,i+1]:= IntToStr(my_val);
        TransferProgress.Position:= i;
        if CancelProc then begin
          CancelMsg;
          exit;
        end;
      end;
    end;
    1: begin
    if PageControl1.TabIndex = 1 then
      TransferProgress.Max:= StringGrid2.RowCount-1;
      for i:= 0 to TransferProgress.Max do begin
        LEDflash;
        my_val:= HX3_query(IntFromStringGrid2(0,i+1));
        StringGrid2.Cells[2,i+1]:= IntToStr(my_val);
        TransferProgress.Position:= i;
        if CancelProc then begin
          CancelMsg;
          exit;
        end;
      end;
    end;
    2: begin
      TransferProgress.Max:= StringGrid3.RowCount-1;
      for i:= 0 to TransferProgress.Max do begin
        LEDflash;
        my_val:= HX3_query(IntFromStringGrid3(0,i+1));
        StringGrid3.Cells[2,i+1]:= IntToStr(my_val);
        TransferProgress.Position:= i;
        if CancelProc then begin
          CancelMsg;
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
        UpperPresets[i]:= my_val;
        TransferProgress.Position:= i;
        if CancelProc then begin
          CancelMsg;
          exit;
        end;
      end;
      HX3record2Form;
    end;
    4: begin
      TransferProgress.Max:= 255;
      HX3_send(414,Form1.ComboboxLowerPreset.ItemIndex,false);
      delay(20);
      for i:= 0 to 255 do begin
        LEDflash;
        my_val:= HX3_query(1256+i);
        LowerPresets[i]:= my_val;
        TransferProgress.Position:= i;
        if CancelProc then begin
          CancelMsg;
          exit;
        end;
      end;
      HX3record2Form;
    end;
  end;
  TransferProgress.Position :=0;
end;

//##############################################################################

procedure TForm1.BtnRescanClick(Sender: TObject);
// Auswahl des Frosches unter FTDI-Devices
var i : Integer; LV : TListItem;
begin
// Alle verfügbaren COM-Ports prüfen, Ergebnisse in Array speichern
  CancelProc:= false;
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
  deviceselectbox.ListView1.Items.clear;
  SetUpFTDI;
  if ftdi_device_count > 0 then
    for i := 0 to ftdi_device_count - 1 do begin
      LV := deviceselectbox.ListView1.Items.Add;
      LV.Caption := 'Device '+IntToStr(I);
      LV.SubItems.Add(ftdi_sernum_arr[i]);
      LV.SubItems.Add(ftdi_desc_arr[i]);
    end
  else begin
    ShowMessage('No FTDI cable or HX3 USB extension found!');
    exit;
  end;
  ComPortUsed:=0;
  deviceselectbox.ListView1.Items[0].Selected := true;
  deviceselectbox.ShowModal;
  if (deviceselectbox.ModalResult=MrOK) and (ftdi_device_count > 0) then begin
    ftdi_selected_device:= deviceselectbox.ListView1.itemindex;
    InitFTDI(ftdi_selected_device);
    if ftdi_isopen then begin
      Form1.Memo1.lines.clear;
      HX3_info;
      DeviceView.Text:= ftdi_sernum_arr[ftdi_selected_device]
      + ' - ' + ftdi_desc_arr[ftdi_selected_device];
      LEDflash;
      if CancelProc then begin
        CancelProc:= false;
        if ftdi_isopen then
          ftdi.closeDevice;
        ftdi_isopen:= false;
        DisableButtons;
        DeviceView.Text:= '(not selected)';
        exit;
      end else
        EnableButtons;
      for i := 0 to 31 do begin
    // Erneut alle verfügbaren COM-Ports prüfen, Ergebnis mit Array vergleichen
    // Wenn Port jetzt gesperrt, ist er durch gewähltes ftdi-Device belegt
        if ComPortAvailableList[i] <> CheckCom(i) then begin
          ComPortUsed:=i;
          DeviceView.Text:= DeviceView.Text+ ' on COM'+IntToStr(ComPortUsed);
          exit;
        end;
      end;
    end;
  end;
end;

procedure TForm1.BtnCloseClick(Sender: TObject);
begin
  CancelProc:= false;
  if ftdi_isopen then
    ftdi.closeDevice;
  ftdi_isopen:= false;
  DisableButtons;
  DeviceView.Text:= '(not selected)';
end;


//##############################################################################
//########################### Formular Main  ###################################
//##############################################################################

procedure TForm1.HelpAbout1Execute(Sender: TObject);
begin
  AboutBox.Version.Caption:= VersionInfo;
  AboutBox.ShowModal;
end;

//##############################################################################

procedure TForm1.Timer1Timer(Sender: TObject);
// alle 10 ms aufgerufen: Schnittstelle abfragen und bei Telegramm-Ende
begin
  if LEDtimer = 0 then
    LEDstate(false)
  else
    dec(LEDtimer);

  if TimeOutValue = 0 then begin
    TimeOut:= true;
    TimeOutValue:= 10;
    MidiCheck;
  end else begin
    TimeOut:= false;
    dec(TimeOutValue);
  end;
end;

procedure TForm1.FormDestroy(Sender: TObject);
var  FroschIni:TRegistryIniFile;
begin
  CancelProc:= true;
  TransferProgress.Position:= 0;
  FroschIni:=TRegistryIniFile.Create(FroschRegKeyName);
  try
    FroschIni.WriteInteger('Form','Top',Top);
    FroschIni.WriteInteger('Form','Left',Left);
    FroschIni.WriteString('Settings','Path',HX3settingsPath);
    FroschIni.WriteInteger('Settings','Device', ftdi_selected_device);
    FroschIni.WriteBool('Settings','ImportOrgan', ImportOrgan.Checked);
    FroschIni.WriteBool('Settings','ImportLeslie', ImportLeslie.Checked);
    FroschIni.WriteBool('Settings','ImportMidiCC', ImportMidiCC.Checked);
    FroschIni.WriteBool('Settings','ImportUpper', ImportUpper.Checked);
    FroschIni.WriteBool('Settings','ImportLower', ImportLower.Checked);
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
  HX3settingsPath:=ExtractFilePath(Application.ExeName)+'HX3_default_setup.hx3';
  try
    Top:=FroschIni.ReadInteger('Form','Top',150);
    Left:= FroschIni.ReadInteger('Form','Left',150);
    HX3settingsPath:= FroschIni.ReadString('Settings','Path','');
    ftdi_selected_device:= FroschIni.ReadInteger('Settings','Device',0);
  finally
    FroschIni.Free;
  end;
  if FileExists(ExtractFilePath(Application.ExeName)+'decrypt56.exe') then
    BtnLicenceGen.Enabled:= true;

  ButtonDescList:= TStringList.Create;
  MidiCCList:= TStringList.Create;
  DropDownList:= TStringList.Create;
  InitHX3record;
  PageControl1Change(Sender);
  StringGrid3Click(Sender);
end;

procedure TForm1.PageControl1Change(Sender: TObject);
begin
//  PageControl1.Pages[PageControl1.TabIndex].Highlighted:= false;
  Scrollbar1.Visible:= false;
  Panel1.Visible:= false;
  ComboBox1.Visible:= false;
  CheckboxEEwrite.enabled:= true;
  Checkbox6.enabled:= true;
  Checkbox7.enabled:= true;
  Sendall.enabled:= ftdi_isopen;
  Readall.enabled:= ftdi_isopen;
  case PageControl1.TabIndex of
  0: with StringGrid1 do begin
      Col:= 2;
      Row:= 1;
      TopRow:= 1;
      Scrollbar1.Max:= IntFromStringGrid1(4,1);
      Scrollbar1.Position:= IntFromStringGrid1(2,1);
      TrackBarInStringGrid(CellRect(Col,Row));
    end;
  1: with StringGrid2 do begin
      Col:= 2;
      Row:= 1;
      TopRow:= 1;
      Scrollbar1.Max:= 255;
      Scrollbar1.Position:= IntFromStringGrid2(2,1);
      TrackBarInStringGrid(CellRect(Col,Row));
    end;
  3: begin
    if ftdi_isopen then
      HX3_send(413,ComboboxUpperPreset.ItemIndex,false);
    end;
  4:begin
    if ftdi_isopen then
      HX3_send(414,ComboboxUpperPreset.ItemIndex,false);
    end;
  5: begin
      Sendall.enabled:= false;
      Readall.enabled:= false;
      CheckboxEEwrite.enabled:= false;
      Checkbox6.enabled:= false;
      Checkbox7.enabled:= false;
    end;
  end;
  HX3record2Form;
end;

procedure TForm1.Panel1Click(Sender: TObject);
// Button für Organ, StrinGrid1
begin
  Panel1.Tag:= (not Panel1.Tag) and 255;
  with StringGrid1 do begin
    Cells[Col, Row] := IntToStr(Panel1.Tag);
    PanelInStringGrid(Panel1.BoundsRect);
  end;
  if ftdi_isopen then
    HX3_send(IntFromStringGrid1(0,StringGrid1.Row), Panel1.Tag, CheckboxEEwrite.checked);
end;

procedure TForm1.ComboBox1Change(Sender: TObject);
// Auswahl-Box für Organ, StrinGrid1
begin
// Comboboxinhalt wird in Zelle übertragen:
  with StringGrid1 do begin
    Cells[Col, Row] := IntToStr(ComboBox1.ItemIndex);
  end;
  if ftdi_isopen then
    HX3_send(IntFromStringGrid1(0,StringGrid1.Row),ComboBox1.ItemIndex, CheckboxEEwrite.checked);
end;

procedure TForm1.Scrollbar1Change(Sender: TObject);
// Trackbar für Organ und Leslie
begin
  case PageControl1.TabIndex of
    0: begin // Organ Params
      with StringGrid1 do
        Cells[Col, Row] := IntToStr(Scrollbar1.Position);
      if ftdi_isopen then
        HX3_send(IntFromStringGrid1(0,StringGrid1.Row), Scrollbar1.Position, CheckboxEEwrite.checked);
    end;
    1: begin // Leslie Params
      with StringGrid2 do
        Cells[Col, Row] := IntToStr(Scrollbar1.Position);
      if ftdi_isopen then
        HX3_send(IntFromStringGrid2(0,StringGrid2.Row), Scrollbar1.Position, CheckboxEEwrite.checked);
    end;
  end;
end;

procedure TForm1.CheckBitClick(Sender: TObject);
var my_val: Integer;
begin
  with StringGrid1 do begin
    my_val:= IntFromStringGrid1(Col, Row);
    if CheckBit0.Checked then
      my_val:= my_val or 1
    else
      my_val:= my_val and (not 1);
    if CheckBit1.Checked then
      my_val:= my_val or 2
    else
      my_val:= my_val and (not 2);
    if CheckBit2.Checked then
      my_val:= my_val or 4
    else
      my_val:= my_val and (not 4);
    if CheckBit3.Checked then
      my_val:= my_val or 8
    else
      my_val:= my_val and (not 8);
    if CheckBit4.Checked then
      my_val:= my_val or 16
    else
      my_val:= my_val and (not 16);
    if CheckBit5.Checked then
      my_val:= my_val or 32
    else
      my_val:= my_val and (not 32);
    if CheckBit6.Checked then
      my_val:= my_val or 64
    else
      my_val:= my_val and (not 64);
    if CheckBit7.Checked then
      my_val:= my_val or 128
    else
      my_val:= my_val and (not 128);
    Cells[Col, Row] := IntToStr(my_val);
  end;
  if ftdi_isopen then
    HX3_send(IntFromStringGrid1(0,StringGrid1.Row), my_val, CheckboxEEwrite.checked);
end;

//##############################################################################
//####################### Programming/Update Buttons ###########################
//##############################################################################

procedure TForm1.BtnResetClick(Sender: TObject);
begin
  CancelProc:= false;
  Form1.Memo1.Lines.Clear;
  ResetCheckboxes;
  HX3_reset;
  HX3_info;
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
  HX3record.OrganLicence:= StrToIntDef(EditOrganLicence.Text,0);
end;

procedure TForm1.EditLeslieLicenceChange(Sender: TObject);
begin
  HX3record.LeslieLicence:= StrToIntDef(EditLeslieLicence.Text,0);
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
      FloatToStr(HX3record.FirmwareVersion),#9,HX3record.OrganBasicSettings[76],#9,DateToStr(now),#9);
    WriteLn(my_File,HX3record.Owner);
    CloseFile(my_File);
  end else
    Form1.Memo1.lines.Add('##### Warning: DECRYPT56.EXE not found');
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
    HX3_info;
    DeviceView.Text:= ftdi_sernum_arr[ftdi_selected_device] + ', '
      + ftdi_desc_arr[ftdi_selected_device]+ ' on COM'+IntToStr(ComPortUsed);
    LEDflash;
    EnableButtons;
    UpdateFPGA.Enabled:=true;
  end;
end;

//##############################################################################
//####################### Basic Configuration Buttons ##########################
//##############################################################################

procedure TForm1.BtnWriteBasicsClick(Sender: TObject);
var i, j, p: Integer;
begin
  CancelProc:= false;
  if ftdi_isopen then begin
//    HX3_info;
//    BtnLicenceGenClick(Sender);
    LEDflash;

    p:= BasicScanMode.ItemIndex;
    Memo1.lines.Add('#--- Set HX3 Param 477 to ' + IntToSTr(p));
    HX3_send(477, p, true);

    p:= BoolToByte(BasicExpanderMode.Checked);
    Memo1.lines.Add('#--- Set HX3 Param 478 to ' + IntToSTr(p));
    HX3_send(478, p, true);

    p:= BoolToByte(BasicToneEna.Checked);  // Tone Pot Ena
    Memo1.lines.Add('#--- Set HX3 Param 481 to ' + IntToSTr(p));
    HX3_send(481, p, true);

    LEDflash;
//    BtnSetLicenceClick(Sender);
  end;
end;

procedure TForm1.BasicExpanderModeClick(Sender: TObject);
begin
  if BasicExpanderMode.Checked then begin
    BasicToneEna.Checked:= false;
    BasicScanMode.ItemIndex:= 1;
  end;
end;



end.

