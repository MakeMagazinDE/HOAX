//##############################################################################
//######################### StringGrid3 MIDI CC ################################
//##############################################################################

procedure MidiCheck;
var
  my_long, my_cmd, my_cc, my_data: LongInt;
begin
  if ftdi_isopen and (HX3record.FirmwareVersion > 3.54) and (Form1.PageControl1.TabIndex = 2)
  then begin
    my_long:=HX3_Query(9000);
    my_data:= my_long and $FF;
    my_cc:= (my_long and $FF00) shr 8;
    my_cmd:= (my_long and $FF0000) shr 16;
    Form1.EditMidiRec.Text:= IntToStr(my_cmd)+':'+IntToStr(my_cc)+':'+IntToStr(my_data)+
      ' [$'+IntToHex(my_cmd,2)+':$'+IntToHex(my_cc,2)+':$'+IntToHex(my_data,2)+']';
    if (my_cmd and $F0) = 176 then begin
      if LastMidiCC <> my_cc then
        Form1.StringGrid3.Row:= my_cc +1;
      LastMidiCC:= my_cc;
    end;
  end;
end;

function GetCCdesc(my_val: Integer):String;
begin
  case my_val of
    0:
      result:= '(not assigned)';
    400..(400+ c_num_of_organparams):
      result:= MenuHeaderArr[my_val-400];
    600..(600+ c_num_of_leslieparams):
      result:= LeslieDescArr[my_val-600];
    900..919:
      result:= ButtonDescArr[my_val-900];
  else
    result:= '(invalid number)';
  end;
end;

procedure TForm1.ListBox1DrawItem(Control: TWinControl; Index: Integer;
  Rect: TRect; State: TOwnerDrawState);
const
  IsSelected : array[Boolean] of Integer = (DFCS_BUTTONRADIO, DFCS_BUTTONRADIO or DFCS_CHECKED) ;
var
  optionButtonRect: TRect;
  listBox : TListBox;
begin
  listBox := Control as TListBox;
  with listBox.Canvas do begin
    FillRect(rect);
    optionButtonRect.Left := rect.Left + 1;
    optionButtonRect.Right := Rect.Left + 13;
    optionButtonRect.Bottom := Rect.Bottom;
    optionButtonRect.Top := Rect.Top;
    DrawFrameControl(Handle, optionButtonRect, DFC_BUTTON, IsSelected[odSelected in State]) ;
    TextOut(17, rect.Top + 2, listBox.Items[Index]) ;
  end;
end;

procedure TForm1.StringGrid3Click(Sender: TObject);
var
  my_str: String;
  my_select: Integer;
begin
  my_select:= StrToIntDef(StringGrid3.Cells[2,StringGrid3.Row],0);
  LastMidiCC:= my_select;
  my_str:= GetCCdesc(my_select);
  MIDIccHint.Caption:= 'MIDI CC ' + IntToStr(StringGrid3.Row-1)
    + ' translated to ' + my_Str;
  if (my_select >= 400) and (my_select <= 400+c_num_of_organparams) then begin
    ListBox1.ItemIndex:= my_select-400;
  end else if (my_select >= 900) and (my_select <= 907) then begin
    ListBox1.ItemIndex:= c_num_of_organparams+my_select -900 +1;
  end else if (my_select >= 914) and (my_select <= 917) then begin
    ListBox1.ItemIndex:= c_num_of_organparams+my_select -905;
  end else
    ListBox1.ItemIndex:=0;
end;


procedure TForm1.ListBox1Click(Sender: TObject);
var
  my_str: String;
  my_select: Integer;
begin
  if (ListBox1.ItemIndex = 0) then
    StringGrid3.Cells[2,StringGrid3.Row]:= '0'
  else if (ListBox1.ItemIndex <= c_num_of_organparams) then
    StringGrid3.Cells[2,StringGrid3.Row]:= IntToStr(ListBox1.ItemIndex + 400)
  else if (ListBox1.ItemIndex <= c_num_of_organparams + 8) then
    StringGrid3.Cells[2,StringGrid3.Row]:= IntToStr(ListBox1.ItemIndex-c_num_of_organparams + 899)
  else if (ListBox1.ItemIndex <= c_num_of_organparams + 12) then
    StringGrid3.Cells[2,StringGrid3.Row]:= IntToStr(ListBox1.ItemIndex-c_num_of_organparams + 905);
  StringGrid3Click(Sender);
end;

procedure TForm1.StringGrid3SetEditText(Sender: TObject; ACol, ARow: Integer;
  const Value: string);
begin
  StringGrid3Click(Sender);
end;
