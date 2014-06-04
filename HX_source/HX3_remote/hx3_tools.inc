// Include-Datei mit Hilfsroutinen für HX3 Remote

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

procedure SetTimeOut(my_val: Integer);
// alle 10 ms aufgerufen: Schnittstelle abfragen und bei Telegramm-Ende
begin
  TimeOutValue:= my_val;
  TimeOut:= false;
end;

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
  showmessage('FPGA configuration is corrupted. Please insert CONF_DIS jumper before continuing!');
end;

procedure RemoveConfDisJpMsg;
begin
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

function bool_byte(my_bool: Boolean): byte;
begin
  if my_bool then
    result:= 255
  else
    result:= 0;
end;

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


procedure CoreLoad(my_name:String; my_core:Integer);
begin
  if CancelProc then begin
    exit;
  end;
  if FileExists(my_name) then begin
    HX3_resync;
    Form1.Memo1.lines.Add('#--- Transfer File '+my_name);
    TxFileBufferSize:= FileToBuffer(my_name);
    XModemSendBuffer(my_core,TxFileBufferSize);
  end else
    Form1.Memo1.lines.Add('##### Warning: File '+my_name+' not found');
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
    OnOffBtn1.Visible:= false;
    OptionTextMenu.Visible:= false;
  end;
  ResetCheckboxes;
end;


