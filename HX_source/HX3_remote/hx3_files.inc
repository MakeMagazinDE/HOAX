
//##############################################################################

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
    Form1.TransferProgress.Position:= 0;
    exit;
  end;
  if FileExists(my_name) then begin
    HX3_resync;
    Form1.Memo1.lines.Add('#--- Transfer File '+my_name);
    TxFileBufferSize:= FileToBuffer(my_name);
    XModemSendBuffer(my_core,TxFileBufferSize);
  end else
    Form1.Memo1.lines.Add('##### Warning: File '+my_name+' not found');
  Form1.TransferProgress.Position:= 0;
end;

procedure CoreLoadAll(my_str: String);
// Pfad ohne Dateiname in my_str
begin
  Form1.Memo1.lines.Add('#--- Reading all scan cores...');
  Application.ProcessMessages;
  if not CancelProc then
    CoreLoad(my_str+'hx_chain.dat', 0);
  if not CancelProc then
    CoreLoad(my_str+'hx_midi.dat', 1);
  if not CancelProc then
    CoreLoad(my_str+'hx_fatar.dat', 2);
  if not CancelProc then
    CoreLoad(my_str+'hx_sr44.dat', 3);
  if not CancelProc then
    CoreLoad(my_str+'hx_sr49.dat', 4);
  if not CancelProc then
    CoreLoad(my_str+'hx_sr61.dat', 5);
  if not CancelProc then
    CoreLoad(my_str+'hx_test.dat', 6);
  if not CancelProc then
    CoreLoad(my_str+'hx_xb2.dat', 7);
  if CancelProc then begin
    CancelMsg;
  end;
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

procedure TForm1.FileNew1Execute(Sender: TObject);
//Form löschen
begin
  Form1.Memo1.lines.Clear;
  Form1.Memo1.lines.Add('#--- Initializing HX3 Remote Panels');
  InitHX3record;
end;

procedure TForm1.New1Click(Sender: TObject);
begin
  FileNew1Execute(Sender);
end;


procedure TForm1.FileOpen1Execute(Sender: TObject);
var my_ReadFile: File of THX3record;
begin
  OpenParamDialog.Title:= 'HX3 Remote Setup File';
  OpenParamDialog.FilterIndex:= 1;
  if OpenParamDialog.Execute then begin
    HX3settingsPath := OpenParamDialog.Filename;
    FileMode := fmOpenRead;
    AssignFile(my_ReadFile, OpenParamDialog.Filename);
    Reset(my_ReadFile);
    Read(my_ReadFile,HX3record);
    CloseFile(my_ReadFile);
    HX3record2Form;
    Form1.Caption:= 'HX3 Remote  ['+ HX3settingsPath+']';
  end;
end;

//##############################################################################

procedure TForm1.FileSaveAs1Execute(Sender: TObject);
var mySaveFile: File of THX3record;
begin
  SaveParamDialog.Title:= 'HX3 Remote Setup File';
  SaveParamDialog.FilterIndex:= 1;
  if SaveParamDialog.Execute then begin
    Form2HX3record;
    HX3settingsPath := SaveParamDialog.Filename;
    AssignFile(mySaveFile, HX3settingsPath);
    ReWrite(mySaveFile);
    Write(mySaveFile,HX3record);
    CloseFile(mySaveFile);
    Form1.Caption:= 'HX3 Remote  ['+ HX3settingsPath+']';
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
  CancelProc:= true;
  TransferProgress.Position:= 0;
  Close;
end;

procedure TForm1.ExportOrganData1Click(Sender: TObject);
var
  F: TStringList;
  i: Integer;
begin
  SaveParamDialog.Title:= 'HX3 Export Organ Data File';
  SaveParamDialog.FilterIndex:= 2;
  if SaveParamDialog.Execute then begin
    HX3record.OrganParamFile:=SaveParamDialog.Filename;
    EditOrganDefaultsFile.Text := HX3record.OrganParamFile;
    F:= TStringList.Create;
    try
      for i := 0 to (StringGrid1.RowCount - 1) do
        F.Add(StringGrid1.Rows[i].CommaText);
      F.SaveToFile(SaveParamDialog.Filename);
    finally
      F.Free;
    end;
  end;
end;

procedure TForm1.ExportLeslieData1Click(Sender: TObject);
var
  F: TStringList;
  i: Integer;
begin
  SaveParamDialog.Title:= 'HX3 Export Leslie Data File';
  SaveParamDialog.FilterIndex:= 2;
  if SaveParamDialog.Execute then begin
    HX3record.LeslieParamFile:=SaveParamDialog.Filename;
    EditLeslieDefaultsFile.Text:= HX3record.LeslieParamFile;
    F:= TStringList.Create;
    try
      for i := 0 to (StringGrid2.RowCount - 1) do
        F.Add(StringGrid2.Rows[i].CommaText);
      F.SaveToFile(SaveParamDialog.Filename);
    finally
      F.Free;
    end;
  end;
end;

procedure TForm1.ExportMIDICCData1Click(Sender: TObject);
var
  F: TStringList;
  i: Integer;
begin
  SaveParamDialog.Title:= 'HX3 Export MIDI CC Data File';
  SaveParamDialog.FilterIndex:= 2;
  if SaveParamDialog.Execute then begin
    HX3record.MidiCCFile:=SaveParamDialog.Filename;
    EditMidiCCFile.Text:= HX3record.MidiCCfile;
    F:= TStringList.Create;
    try
      for i := 0 to (StringGrid3.RowCount - 1) do
        F.Add(StringGrid3.Rows[i].CommaText);
      F.SaveToFile(SaveParamDialog.Filename);
    finally
      F.Free;
    end;
  end;
end;

procedure TForm1.ImportOrganData1Click(Sender: TObject);
begin
  OpenParamDialog.Title:= 'HX3 Import Organ Data File';
  OpenParamDialog.FilterIndex:= 2;
  if OpenParamDialog.Execute then begin
    HX3record.OrganParamFile:=OpenParamDialog.Filename;
    EditOrganDefaultsFile.Text := HX3record.OrganParamFile;
    ImportStringGrid1(OpenParamDialog.Filename);
  end;
end;


procedure TForm1.ImportLeslieData1Click(Sender: TObject);
begin
  OpenParamDialog.Title:= 'HX3 Import Leslie Data File';
  OpenParamDialog.FilterIndex:= 2;
  if OpenParamDialog.Execute then begin
    HX3record.LeslieParamFile:=OpenParamDialog.Filename;
    EditLeslieDefaultsFile.Text:= HX3record.LeslieParamFile;
    ImportStringGrid2(OpenParamDialog.Filename);
  end;
end;

procedure TForm1.ImportMIDICCData1Click(Sender: TObject);
begin
  OpenParamDialog.Title:= 'HX3 Import MIDI CC Data File';
  OpenParamDialog.FilterIndex:= 2;
  if OpenParamDialog.Execute then begin
    HX3record.MidiCCFile:=OpenParamDialog.Filename;
    EditMidiCCFile.Text:= HX3record.MidiCCfile;
    ImportStringGrid3(OpenParamDialog.Filename);
  end;
end;

//##############################################################################
//########################## Preset File Handling  #############################
//##############################################################################

procedure TForm1.ExportUpperPresets1Click(Sender: TObject);
var
  F: TStringList;
  i,n: Integer;
begin
  SaveParamDialog.Title:= 'HX3 Export Upper Presets Data File';
  SaveParamDialog.FilterIndex:= 2;
  if SaveParamDialog.Execute then begin
    HX3record.UpperPresetFile:= SaveParamDialog.Filename;
    EditUpperPresetsFile.Text  := HX3record.UpperPresetFile;
    F:= TStringList.Create;
    try
      for n := 0 to 15 do begin
        for i := 0 to 8 do
          F.Add('Preset'+IntToStr(n)+'_Drawbar'+
            IntToStr(i)+'='+IntToStr(UpperPresets[n*16+i]));
        F.Add('Preset'+IntToStr(n)+'_VibKnob='+IntToStr(UpperPresets[n*16+9]));
        F.Add('Preset'+IntToStr(n)+'_Buttons='+IntToStr(UpperPresets[n*16+10]));
        for i := 11 to 15 do
          F.Add('Preset'+IntToStr(n)+'_Dummy='+IntToStr(UpperPresets[n*16+i]));
      end;
      F.SaveToFile(SaveParamDialog.Filename);
    finally
      F.Free;
    end;
  end;
end;

procedure TForm1.ExportLowerPresets1Click(Sender: TObject);
var
  F: TStringList;
  i,n: Integer;
begin
  SaveParamDialog.Title:= 'HX3 Export Lower Presets Data File';
  SaveParamDialog.FilterIndex:= 2;
  if SaveParamDialog.Execute then begin
    HX3record.LowerPresetFile:= SaveParamDialog.Filename;
    EditLowerPresetsFile.Text:= HX3record.LowerPresetFile;
    F:= TStringList.Create;
    try
      for n := 0 to 15 do begin
        for i := 0 to 12 do
          F.Add('Preset'+IntToStr(n)+'_Drawbar'+
            IntToStr(i)+'='+IntToStr(LowerPresets[n*16+i]));
        F.Add('Preset'+IntToStr(n)+'_Buttons1='+IntToStr(LowerPresets[n*16+13]));
        F.Add('Preset'+IntToStr(n)+'_Buttons2='+IntToStr(LowerPresets[n*16+14]));
        F.Add('Preset'+IntToStr(n)+'_Dummy='+IntToStr(LowerPresets[n*16+15]));
      end;
      F.SaveToFile(SaveParamDialog.Filename);
    finally
      F.Free;
    end;
  end;
end;

procedure TForm1.ImportUpperPresets1Click(Sender: TObject);
begin
  OpenParamDialog.Title:= 'HX3 Import Upper Presets Data File';
  OpenParamDialog.FilterIndex:= 2;
  if OpenParamDialog.Execute then begin
    HX3record.UpperPresetFile:=OpenParamDialog.Filename;
    EditUpperPresetsFile.Text:= HX3record.UpperPresetFile;
    ImportUpperPresets(OpenParamDialog.Filename);
  end;
end;

procedure TForm1.ImportLowerPresets1Click(Sender: TObject);
begin
  OpenParamDialog.Title:= 'HX3 Import Lower Presets Data File';
  OpenParamDialog.FilterIndex:= 2;
  if OpenParamDialog.Execute then begin
    HX3record.LowerPresetFile:=OpenParamDialog.Filename;
    EditLowerPresetsFile.Text:= HX3record.LowerPresetFile;
    ImportLowerPresets(OpenParamDialog.Filename);
  end;
end;



