// Include-Datei mit Hilfsroutinen für HX3 Remote


function BoolToByte(my_bool: Boolean): byte;
begin
  if my_bool then
    result:= 255
  else
    result:= 0;
end;

procedure Delay(msecs: Longint);
var
  targettime: cardinal;
begin
  targettime := GetTickCount + msecs;
  while targettime > GetTickCount do
    Application.ProcessMessages;
end;

procedure CancelMsg;
begin
  Form1.TransferProgress.Position:= 0;
  Form1.Memo1.lines.Add('##### Warning: Process cancelled by user');
end;

procedure LEDstate(is_on: boolean);
// liefert vorherigen Zustand zurück
begin
  if is_on then
    Form1.LEDbusy.Color:=$000010FF
  else
    Form1.LEDbusy.Color:=$00000020;
end;

procedure LEDflash;
begin
  LEDstate(true);
  LEDtimer:=10;
  Application.ProcessMessages;
end;

procedure Form2HX3record;
var my_preset: Integer;  my_byte: byte;
begin
  HX3record.ImportOrgan  :=  Form1.ImportOrgan.Checked;
  HX3record.ImportLeslie :=  Form1.ImportLeslie.Checked;
  HX3record.ImportMidiCC :=  Form1.ImportMidiCC.Checked;
  HX3record.ImportUpper  :=  Form1.ImportUpper.Checked;
  HX3record.ImportLower  :=  Form1.ImportLower.Checked;

  HX3record.OrganParamFile := Form1.EditOrganDefaultsFile.Text;
  HX3record.LeslieParamFile:= Form1.EditLeslieDefaultsFile.Text;
  HX3record.MidiCCfile     := Form1.EditMidiCCFile.Text;
  HX3record.UpperPresetFile:= Form1.EditUpperPresetsFile.Text;
  HX3record.LowerPresetFile:= Form1.EditLowerPresetsFile.Text;

  HX3Record.Owner:= Form1.EditUserName.Text;
  HX3record.FPGAVersion:= Form1.FPGAversion.Text;
  HX3record.OrganLicence:= StrToIntDef(Form1.EditOrganLicence.Text,0);
  HX3record.LeslieLicence:= StrToIntDef(Form1.EditLeslieLicence.Text,0);
  HX3record.SerialNumber:= StrToIntDef(Form1.EditSerialNumber.Text,0);


  my_preset:= Form1.ComboboxUpperPreset.ItemIndex;
  UpperPresets[0+16*my_preset]:= Form1.TrackBarU0.Position;
  UpperPresets[1+16*my_preset]:= Form1.TrackBarU1.Position;
  UpperPresets[2+16*my_preset]:= Form1.TrackBarU2.Position;
  UpperPresets[3+16*my_preset]:= Form1.TrackBarU3.Position;
  UpperPresets[4+16*my_preset]:= Form1.TrackBarU4.Position;
  UpperPresets[5+16*my_preset]:= Form1.TrackBarU5.Position;
  UpperPresets[6+16*my_preset]:= Form1.TrackBarU6.Position;
  UpperPresets[7+16*my_preset]:= Form1.TrackBarU7.Position;
  UpperPresets[8+16*my_preset]:= Form1.TrackBarU8.Position;

  // Vibrato Upper Knob
  UpperPresets[9+16*my_preset]:= Form1.ComboBoxVibKnob.ItemIndex;

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
  UpperPresets[10+16*my_preset]:= my_byte;

  my_preset:= Form1.ComboboxLowerPreset.ItemIndex;
  LowerPresets[0+16*my_preset]:= Form1.TrackbarL0.Position;
  LowerPresets[1+16*my_preset]:= Form1.TrackbarL1.Position;
  LowerPresets[2+16*my_preset]:= Form1.TrackbarL2.Position;
  LowerPresets[3+16*my_preset]:= Form1.TrackbarL3.Position;
  LowerPresets[4+16*my_preset]:= Form1.TrackbarL4.Position;
  LowerPresets[5+16*my_preset]:= Form1.TrackbarL5.Position;
  LowerPresets[6+16*my_preset]:= Form1.TrackbarL6.Position;
  LowerPresets[7+16*my_preset]:= Form1.TrackbarL7.Position;
  LowerPresets[8+16*my_preset]:= Form1.TrackbarL8.Position;

  LowerPresets[ 9+16*my_preset]:= Form1.TrackbarB0.Position;
  LowerPresets[10+16*my_preset]:= Form1.TrackbarB1.Position;
  LowerPresets[11+16*my_preset]:= Form1.TrackbarB2.Position;
  LowerPresets[12+16*my_preset]:= Form1.TrackbarB3.Position;

  // Vibrato Lower
  my_byte:=0;
  if Form1.CheckBox5.Checked then
    my_byte:= 32;
  LowerPresets[13+16*my_preset]:= my_byte;

  // Reverb, Split, Jacks
  my_byte:=0;
  if Form1.CheckBox8.Checked then
    my_byte:= 1;
  if Form1.CheckBox9.Checked then
    my_byte:= my_byte or 2;
  HX3record.OrganBasicSettings[32]:= my_byte;

  my_byte:=0;
  if Form1.CheckBox10.Checked then
    my_byte:= 64;
  if Form1.CheckBox11.Checked then
    my_byte:= my_byte or 128;
  LowerPresets[14+16*my_preset]:= my_byte;
end;

procedure HX3record2Form;
var
  my_preset: Integer; my_byte: Byte;
begin
  Form1.ImportOrgan.Checked := HX3record.ImportOrgan;
  Form1.ImportLeslie.Checked:= HX3record.ImportLeslie;
  Form1.ImportMidiCC.Checked:= HX3record.ImportMidiCC;
  Form1.ImportUpper.Checked := HX3record.ImportUpper;
  Form1.ImportLower.Checked := HX3record.ImportLower;

  Form1.EditOrganDefaultsFile.Text := HX3record.OrganParamFile;
  Form1.EditLeslieDefaultsFile.Text:= HX3record.LeslieParamFile;
  Form1.EditMidiCCFile.Text        := HX3record.MidiCCfile;
  Form1.EditUpperPresetsFile.Text  := HX3record.UpperPresetFile;
  Form1.EditLowerPresetsFile.Text  := HX3record.LowerPresetFile;

  my_preset:= Form1.ComboboxUpperPreset.ItemIndex;
  Form1.TrackBarU0.Position:= UpperPresets[0+16*my_preset];
  Form1.TrackBarU1.Position:= UpperPresets[1+16*my_preset];
  Form1.TrackBarU2.Position:= UpperPresets[2+16*my_preset];
  Form1.TrackBarU3.Position:= UpperPresets[3+16*my_preset];
  Form1.TrackBarU4.Position:= UpperPresets[4+16*my_preset];
  Form1.TrackBarU5.Position:= UpperPresets[5+16*my_preset];
  Form1.TrackBarU6.Position:= UpperPresets[6+16*my_preset];
  Form1.TrackBarU7.Position:= UpperPresets[7+16*my_preset];
  Form1.TrackBarU8.Position:= UpperPresets[8+16*my_preset];
  // Vibrato Upper Knob
  Form1.ComboBoxVibKnob.ItemIndex:= UpperPresets[9+16*my_preset];

  // Percussion Upper
  my_byte:= UpperPresets[10+16*my_preset];
  Form1.CheckBox0.Checked:= (my_byte and 1) <> 0;
  Form1.CheckBox1.Checked:= (my_byte and 2) <> 0;
  Form1.CheckBox2.Checked:= (my_byte and 4) <> 0;
  Form1.CheckBox3.Checked:= (my_byte and 8) <> 0;

  // Vibrato Upper ON
  Form1.CheckBox4.Checked:= (my_byte and 16) <> 0;

  my_preset:= Form1.ComboboxLowerPreset.ItemIndex;
  Form1.TrackbarL0.Position:= LowerPresets[0+16*my_preset];
  Form1.TrackbarL1.Position:= LowerPresets[1+16*my_preset];
  Form1.TrackbarL2.Position:= LowerPresets[2+16*my_preset];
  Form1.TrackbarL3.Position:= LowerPresets[3+16*my_preset];
  Form1.TrackbarL4.Position:= LowerPresets[4+16*my_preset];
  Form1.TrackbarL5.Position:= LowerPresets[5+16*my_preset];
  Form1.TrackbarL6.Position:= LowerPresets[6+16*my_preset];
  Form1.TrackbarL7.Position:= LowerPresets[7+16*my_preset];
  Form1.TrackbarL8.Position:= LowerPresets[8+16*my_preset];


  Form1.TrackbarB0.Position:= LowerPresets[9+16*my_preset];
  Form1.TrackbarB1.Position:= LowerPresets[10+16*my_preset];
  Form1.TrackbarB2.Position:= LowerPresets[11+16*my_preset];
  Form1.TrackbarB3.Position:= LowerPresets[12+16*my_preset];

  // Vibrato Lower
  my_byte:= UpperPresets[13+16*my_preset];
  Form1.CheckBox0.Checked:= (my_byte and 32) <> 0;

  // Reverb, Split, Jacks; Reverb aus HX3record.OrganValues

  my_byte:= HX3record.OrganBasicSettings[32];
  Form1.CheckBox8.Checked:= (my_byte and 1) <> 0;
  Form1.CheckBox9.Checked:= (my_byte and 2) <> 0;

  my_byte:= LowerPresets[14+16*my_preset];
  Form1.CheckBox10.Checked:= (my_byte and 64) <> 0;
  Form1.CheckBox11.Checked:= (my_byte and 128) <> 0;

  Form1.EditUserName.Text:= HX3Record.Owner;
  Form1.FPGAversion.Text:= HX3record.FPGAVersion;
  DecimalSeparator:= '.';
  Form1.EditFirmwareVersion.Text  := FloatToStr(HX3record.FirmwareVersion);
  Form1.EditOrganLicence.Text     := IntToStr(HX3record.OrganLicence);
  Form1.EditLeslieLicence.Text    := IntToStr(HX3record.LeslieLicence);
  Form1.EditSerialNumber.Text     := IntToStr(HX3record.SerialNumber);

  Form1.BasicJackA.ItemIndex      := HX3record.OrganBasicSettings[38];
  Form1.BasicJackB.ItemIndex      := HX3record.OrganBasicSettings[39];
  Form1.BasicScanMode.ItemIndex   := HX3record.OrganBasicSettings[76];
  Form1.BasicExpanderMode.Checked := boolean(HX3record.OrganBasicSettings[77]);
  Form1.BasicToneEna.Checked      := boolean(HX3record.OrganBasicSettings[80]);
end;

procedure FileErrorMemo(my_name: String);
begin
    Form1.Memo1.lines.Add('##### Êrror: Missing file ' + my_name);
end;

//##############################################################################
//##############################################################################


function CountCharsInString(const my_char: char; my_text: string): integer;
var
  offset: integer;
begin
  result := 0;
  offset := Pos(my_char, my_text);
  while offset <> 0 do begin
    inc(result);
    offset := PosEx(my_char, my_text, offset + 1);
  end;
end;

procedure ImportStringGrid1(filename: String);
var
  F: TStringList;
  i: Integer;
begin
    F := TStringList.Create;
    try
      F.LoadFromFile(filename);
      Form1.StringGrid1.RowCount := F.Count;
      Form1.StringGrid1.ColCount := CountCharsInString(',',F[0])+1;
      for i := 0 to (Form1.StringGrid1.RowCount -1) do
        Form1.StringGrid1.Rows[i].CommaText := F[i];
    finally
      F.Free;
    end;
end;

procedure ImportStringGrid2(filename: String);
var
  F: TStringList;
  i: Integer;
begin
    F := TStringList.Create;
    try
      F.LoadFromFile(filename);
      Form1.StringGrid2.RowCount := F.Count;
      Form1.StringGrid2.ColCount := CountCharsInString(',',F[0])+1;
      for i := 0 to (Form1.StringGrid2.RowCount -1) do
        Form1.StringGrid2.Rows[i].CommaText := F[i];
    finally
      F.Free;
    end;
end;

procedure ImportStringGrid3(filename: String);
var
  F: TStringList;
  i: Integer;
begin
    F := TStringList.Create;
    try
      F.LoadFromFile(filename);
      Form1.StringGrid3.RowCount := F.Count;
      Form1.StringGrid3.ColCount := CountCharsInString(',',F[0])+1;
      for i := 0 to (Form1.StringGrid3.RowCount -1) do
        Form1.StringGrid3.Rows[i].CommaText := F[i];
    finally
      F.Free;
    end;
end;

procedure ImportUpperPresets(filename: String);
var
  F: TStringList;
  i, n: Integer;
begin
  F:= TStringList.Create;
  try
    F.LoadFromFile(filename);
    n := F.Count;
    for i := 0 to 255 do
      if i > n then
        break
      else
        UpperPresets[i] := StrToIntDef(F.ValueFromIndex[i],0);
  finally
    F.Free;
  end;
  HX3record2Form;
end;

procedure ImportLowerPresets(filename: String);
var
  F: TStringList;
  i, n: Integer;
begin
  F:= TStringList.Create;
  try
    F.LoadFromFile(filename);
    n := F.Count;
    for i := 0 to 255 do
      if i > n then
        break
      else
        LowerPresets[i] := StrToIntDef(F.ValueFromIndex[i],0);
  finally
    F.Free;
  end;
  HX3record2Form;
end;

//##############################################################################

procedure InitHX3record;
var
  my_ReadFile: File of THX3record;
  i, my_idx: integer;
  my_str, my_filename: String;

begin
  Form1.StringGrid1.ColWidths[1] := 200;
  Form1.StringGrid1.ColWidths[2] := 162;
  Form1.StringGrid2.ColWidths[1] := 200;
  Form1.StringGrid2.ColWidths[2] := 162;
//  StringGrid3.ColWidths[1] := 200;
//  StringGrid3.ColWidths[2] := 50;

  if not fileexists(HX3settingsPath) then
    HX3settingsPath:=ExtractFilePath(Application.ExeName)+'HX3_default_setup.hx3';

  if FileExists(HX3settingsPath) then begin
    FileMode := fmOpenRead;
    AssignFile(my_ReadFile, HX3settingsPath);
    Reset(my_ReadFile);
    try
      Read(my_ReadFile,HX3record);
    except
      Form1.Memo1.lines.Add('##### Warning: Setup file invalid/corrupted - Save to repair');
    end;
    CloseFile(my_ReadFile);
    Form1.Caption:= 'HX3 Remote  ['+ HX3settingsPath+']';
    Form1.Memo1.lines.Add('#--- Using HX3 Remote Setup file '+ ExtractFilename(HX3settingsPath));
  end else
    FileErrorMemo(ExtractFileName(HX3settingsPath));

  HX3record.Firmwareversion:=0;
  HX3record.LeslieLicence:=0;
  HX3record.OrganLicence:=0;
  HX3record.SerialNumber:=0;
  HX3record.Owner:='KeyboardPartner';
  HX3record.FPGAversion:='00000000';
  HX3record2Form;
  Form1.PageControl1.TabIndex := 0;

// Organ Defaults einlesen
  if Form1.ImportOrgan.Checked and FileExists(HX3record.OrganParamFile) then
    ImportStringGrid1(HX3record.OrganParamFile)
  else begin
    HX3record.OrganParamFile:= ExtractFilePath(Application.ExeName)+'hx3_organ_defaults.csv';
    if fileExists(HX3record.OrganParamFile) then
      ImportStringGrid1(HX3record.OrganParamFile)
    else
      FileErrorMemo('hx3_organ_defaults.csv');
  end;
  Form1.Memo1.lines.Add('#--- Using Organ Param file '+ ExtractFilename(HX3record.OrganParamFile));

 // Leslie Defaults einlesen
 if Form1.ImportLeslie.Checked and FileExists(HX3record.LeslieParamFile) then
    ImportStringGrid2(HX3record.LeslieParamFile)
  else begin
    HX3record.LeslieParamFile:= ExtractFilePath(Application.ExeName)+'hx3_leslie_defaults.csv';
    if fileExists(HX3record.LeslieParamFile) then
      ImportStringGrid2(HX3record.LeslieParamFile)
    else
      FileErrorMemo('hx3_leslie_defaults.csv');
  end;
  Form1.Memo1.lines.Add('#--- Using Leslie Param file '+ ExtractFilename(HX3record.LeslieParamFile));

// MIDI-Custom-CC File einlesen
  if Form1.ImportMidiCC.Checked and FileExists(HX3record.MidiCCFile) then
    ImportStringGrid3(HX3record.MidiCCFile)
  else begin
    HX3record.MidiCCFile:= ExtractFilePath(Application.ExeName)+'hx3_midi_cc_defaults.csv';
    if fileExists(HX3record.MidiCCFile) then
      ImportStringGrid3(HX3record.MidiCCFile)
    else
      FileErrorMemo('hx3_midi_cc_defaults.csv');
  end;
  Form1.Memo1.lines.Add('#--- Using MIDI CC file '+ ExtractFilename(HX3record.MidiCCFile));

// Upper Presets einlesen
  if Form1.ImportUpper.Checked and FileExists(HX3record.UpperPresetFile) then begin
    Form1.Memo1.lines.Add('#--- Using Upper Presets file '+ ExtractFilename(HX3record.UpperPresetFile));
    ImportUpperPresets(HX3record.UpperPresetFile)
  end;

// Lower Presets einlesen
  if Form1.ImportUpper.Checked and FileExists(HX3record.LowerPresetFile) then begin
    Form1.Memo1.lines.Add('#--- Using Upper Presets file '+ ExtractFilename(HX3record.LowerPresetFile));
    ImportLowerPresets(HX3record.LowerPresetFile)
  end;

// Listbox und Liste für MIDI-CC-Assignment erstellen
  Form1.MidiCCListBox.Clear;
  MidiCCList.Clear;
  MidiCCList.Add('0=(not assigned)');
  Form1.MidiCCListBox.Items.Add('(not assigned)');
  for i := 1 to Form1.StringGrid1.RowCount-1 do begin
    my_str:= Form1.StringGrid1.Cells[1,i];
    Form1.MidiCCListBox.Items.Add(my_str);
    my_str:= Form1.StringGrid1.Cells[0,i]+'='+my_str;
    MidiCCList.Add(my_str);
  end;
  my_filename:= ExtractFilePath(Application.ExeName)+'hx3_buttons.csv';
  if FileExists(my_filename) then begin
    ButtonDescList.LoadFromFile(my_filename);
    for i:= 0 to ButtonDescList.Count -1 do begin
      Form1.MidiCCListBox.Items.Add(ButtonDescList.ValueFromIndex[i]);
      MidiCCList.Add(ButtonDescList[i]);
    end;
  end else
    FileErrorMemo('hx3_buttons.csv');

// DropDown-Menüs einlesen
  DropDownList.Clear;
  my_filename:= ExtractFilePath(Application.ExeName)+'hx3_dropdown_menus.csv';
  if FileExists(my_filename) then begin
    DropDownList.LoadFromFile(my_filename);
    my_idx:= DropDownList.IndexOfName('OutConfig');
    for i:= 0 to 31 do begin
      Form1.BasicJackA.Items.Add(DropDownList.ValueFromIndex[my_idx+i]);
      Form1.BasicJackB.Items.Add(DropDownList.ValueFromIndex[my_idx+i]);
    end;
  end else
    FileErrorMemo('hx3_dropdown_menus.csv');

  Form2HX3record;
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

function IsFPGAcorrupted: boolean;
begin
  if (HX3Record.FPGAversion='00000000')
  or (HX3Record.FPGAversion='FFFFFFFF')
  or (HX3Record.SerialNumber < 1) then result:= true
  else result:=false;
end;

procedure FPGAcorruptedMsg;
begin
  if HX3record.FirmwareVersion < 3.56 then
    showmessage('FPGA configuration is corrupted. Please insert CONF_DIS jumper before continuing!');
end;

procedure RemoveConfDisJpMsg;
begin
  if HX3record.FirmwareVersion < 3.56 then
    ShowMessage('Please remove CONF_DIS jumper and click OK when done!');
end;

procedure HX3_info;
// get system info and serial/licence numbers from HX3
var
  my_str:String;
  my_val, my_pos1, my_pos2: Integer;
begin
  HX3_resync;
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

  my_str:=HX3_QueryStr(9910);  // FPGA Info
  Form1.Memo1.lines.Add(my_str);
  my_val:= HX3_StrToInt(my_str);
  if my_val < 0 then
    Form1.Memo1.lines.Add('##### Warning: FPGA version too old, does not match firmware');
  HX3_resync;

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
  if HX3record.FirmwareVersion < 3.56 then begin
    Form1.Memo1.lines.Add('##### Warning: Firmware version below #3.6x, some functions may not work');
    HasBootLoaderJump:= false;
  end else
    HasBootLoaderJump:= true;
  if IsFPGAcorrupted then begin
    Form1.Memo1.lines.Add('##### Warning: FPGA config seems to be corrupted');
    Form1.Memo1.lines.Add('##### Warning: Update FPGA first and insert CONF_DIS JP if requested');
    Form1.BtnScanCore.Enabled:=false;
    Form1.BtnDSP.Enabled:=false;
  end else begin
    Form1.BtnScanCore.Enabled:=true;
    Form1.BtnDSP.Enabled:=true;
  end;


  my_str:=HX3_QueryStr(9900);  // Scan Core reload/info
  Form1.Memo1.lines.Add(my_str);
  Form1.ComboBoxScancore.ItemIndex:= HX3_StrToInt(my_str);

end;

//##############################################################################

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


//##############################################################################


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
    BtnUpdateFIR.Enabled:= true;

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
    BtnUpdateFIR.Enabled:= false;
    BtnClose.Visible:= false;
    BtnRescan.Visible:= true;
    BtnRescan.Enabled:= true;

    Trackbar1.Visible:= false;
    Panel1.Visible:= false;
    ComboBox1.Visible:= false;
  end;
  ResetCheckboxes;
end;


