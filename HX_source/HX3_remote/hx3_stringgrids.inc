//##############################################################################
//######################### StringGrid1 ORGAN  #################################
//##############################################################################

function IntFromStringGrid1(my_column,my_row: Integer):Integer;
begin
  result:= StrToIntDef(Form1.StringGrid1.Cells[my_column,my_row],0);
end;


procedure TrackBarInStringGrid(rec: TRect);
var r: TRect;
begin
  with Form1.Scrollbar1 do begin
    CopyRect(r, rec); // rec => r (Eck-Koordinaten an Hilfsrechteck übergeben)
    // Umrechnung der Eck-Koordinaten des Hilfsrechtecks:
    r.BottomRight := Parent.ScreenToClient(Form1.StringGrid1.ClientToScreen(r.BottomRight));
    r.TopLeft := Parent.ScreenToClient(Form1.StringGrid1.ClientToScreen(r.TopLeft));
    // Positionierung der Combobox (Left, Top, Width und Height werden zugewiesen):
    SetBounds(r.Left+35, r.Top, r.Right-r.Left-35, r.Bottom-r.Top);
    Visible:= true;
    BringToFront; // ScrollBar in Vordergrund bringen
  end;
end;


// Positionierung der Combobox (muss als Methode von Form1 deklariert werden):
procedure ComboBoxInStringGrid(rec: TRect);
var r: TRect;
begin
  with Form1.ComboBox1 do begin
    CopyRect(r, rec); // rec => r (Eck-Koordinaten an Hilfsrechteck übergeben)
    // Umrechnung der Eck-Koordinaten des Hilfsrechtecks:
    r.BottomRight := Parent.ScreenToClient(Form1.StringGrid1.ClientToScreen(r.BottomRight));
    r.TopLeft := Parent.ScreenToClient(Form1.StringGrid1.ClientToScreen(r.TopLeft));
    // Positionierung der Combobox (Left, Top, Width und Height werden zugewiesen):
    SetBounds(r.Left+35, r.Top, r.Right-r.Left-36, r.Bottom-r.Top);
    Visible:= true;
    BringToFront; // Combobox in Vordergrund bringen
  end;
end;

procedure PanelInStringGrid(rec: TRect);
var r: TRect;
begin
  with Form1.Panel1 do begin
    CopyRect(r, rec); // rec => r (Eck-Koordinaten an Hilfsrechteck übergeben)
    // Umrechnung der Eck-Koordinaten des Hilfsrechtecks:
    r.BottomRight := Parent.ScreenToClient(Form1.StringGrid1.ClientToScreen(r.BottomRight));
    r.TopLeft := Parent.ScreenToClient(Form1.StringGrid1.ClientToScreen(r.TopLeft));
    // Positionierung des Panel-Buttons (Left, Top, Width und Height werden zugewiesen):
    SetBounds(r.Left+50, r.Top, r.Right-r.Left-100, r.Bottom-r.Top);
    if Tag <> 0 then begin
      Color:= cllime;
      Caption:= 'ON';
      Font.Color:= clwhite;
      BevelOuter:= bvLowered;
    end else begin
      Color:= clgreen;
      Caption:= 'OFF';
      Font.Color:= clblack;
      BevelOuter:= bvRaised;
    end;
    Visible:= true;
    BringToFront; // Panel-Button in Vordergrund bringen
  end;
end;

// Positionierung von 8 Bit-Checkboxen
procedure CheckBitsInStringGrid(rec: TRect; val: byte);
var r: TRect;
  my_offs_left, my_offs_top, my_height, my_width, my_spacing: Integer;
begin
  my_offs_left:= 36;
  my_offs_top:= 3;
  my_height:= 15;
  my_width:= 15;
  my_spacing:= 15;
  with Form1.CheckBit7 do begin
    Checked:= (val and 128) = 128;
    CopyRect(r, rec); // rec => r (Eck-Koordinaten an Hilfsrechteck übergeben)
    // Umrechnung der Eck-Koordinaten des Hilfsrechtecks:
    r.BottomRight := Parent.ScreenToClient(Form1.StringGrid1.ClientToScreen(r.BottomRight));
    r.TopLeft := Parent.ScreenToClient(Form1.StringGrid1.ClientToScreen(r.TopLeft));
    // Positionierung der Combobox (Left, Top, Width und Height werden zugewiesen):
    SetBounds(r.Left+my_offs_left, r.Top+my_offs_top, my_width, my_height);
    Visible:= true;
    BringToFront; // Combobox in Vordergrund bringen
  end;
  my_offs_left:= my_offs_left + my_spacing;
  with Form1.CheckBit6 do begin
    Checked:= (val and 64) = 64;
    CopyRect(r, rec); // rec => r (Eck-Koordinaten an Hilfsrechteck übergeben)
    // Umrechnung der Eck-Koordinaten des Hilfsrechtecks:
    r.BottomRight := Parent.ScreenToClient(Form1.StringGrid1.ClientToScreen(r.BottomRight));
    r.TopLeft := Parent.ScreenToClient(Form1.StringGrid1.ClientToScreen(r.TopLeft));
    // Positionierung der Combobox (Left, Top, Width und Height werden zugewiesen):
    SetBounds(r.Left+my_offs_left, r.Top+my_offs_top, my_width, my_height);
    Visible:= true;
    BringToFront; // Combobox in Vordergrund bringen
  end;
  my_offs_left:= my_offs_left + my_spacing;
  with Form1.CheckBit5 do begin
    Checked:= (val and 32) = 32;
    CopyRect(r, rec); // rec => r (Eck-Koordinaten an Hilfsrechteck übergeben)
    // Umrechnung der Eck-Koordinaten des Hilfsrechtecks:
    r.BottomRight := Parent.ScreenToClient(Form1.StringGrid1.ClientToScreen(r.BottomRight));
    r.TopLeft := Parent.ScreenToClient(Form1.StringGrid1.ClientToScreen(r.TopLeft));
    // Positionierung der Combobox (Left, Top, Width und Height werden zugewiesen):
    SetBounds(r.Left+my_offs_left, r.Top+my_offs_top, my_width, my_height);
    Visible:= true;
    BringToFront; // Combobox in Vordergrund bringen
  end;
  my_offs_left:= my_offs_left + my_spacing;
  with Form1.CheckBit4 do begin
    Checked:= (val and 16) = 16;
    CopyRect(r, rec); // rec => r (Eck-Koordinaten an Hilfsrechteck übergeben)
    // Umrechnung der Eck-Koordinaten des Hilfsrechtecks:
    r.BottomRight := Parent.ScreenToClient(Form1.StringGrid1.ClientToScreen(r.BottomRight));
    r.TopLeft := Parent.ScreenToClient(Form1.StringGrid1.ClientToScreen(r.TopLeft));
    // Positionierung der Combobox (Left, Top, Width und Height werden zugewiesen):
    SetBounds(r.Left+my_offs_left, r.Top+my_offs_top, my_width, my_height);
    Visible:= true;
    BringToFront; // Combobox in Vordergrund bringen
  end;
  my_offs_left:= my_offs_left + my_spacing;
  with Form1.CheckBit3 do begin
    Checked:= (val and 8) = 8;
    CopyRect(r, rec); // rec => r (Eck-Koordinaten an Hilfsrechteck übergeben)
    // Umrechnung der Eck-Koordinaten des Hilfsrechtecks:
    r.BottomRight := Parent.ScreenToClient(Form1.StringGrid1.ClientToScreen(r.BottomRight));
    r.TopLeft := Parent.ScreenToClient(Form1.StringGrid1.ClientToScreen(r.TopLeft));
    // Positionierung der Combobox (Left, Top, Width und Height werden zugewiesen):
    SetBounds(r.Left+my_offs_left, r.Top+my_offs_top, my_width, my_height);
    Visible:= true;
    BringToFront; // Combobox in Vordergrund bringen
  end;
  my_offs_left:= my_offs_left + my_spacing;
  with Form1.CheckBit2 do begin
    Checked:= (val and 4) = 4;
    CopyRect(r, rec); // rec => r (Eck-Koordinaten an Hilfsrechteck übergeben)
    // Umrechnung der Eck-Koordinaten des Hilfsrechtecks:
    r.BottomRight := Parent.ScreenToClient(Form1.StringGrid1.ClientToScreen(r.BottomRight));
    r.TopLeft := Parent.ScreenToClient(Form1.StringGrid1.ClientToScreen(r.TopLeft));
    // Positionierung der Combobox (Left, Top, Width und Height werden zugewiesen):
    SetBounds(r.Left+my_offs_left, r.Top+my_offs_top, my_width, my_height);
    Visible:= true;
    BringToFront; // Combobox in Vordergrund bringen
  end;
  my_offs_left:= my_offs_left + my_spacing;
  with Form1.CheckBit1 do begin
    Checked:= (val and 2) = 2;
    CopyRect(r, rec); // rec => r (Eck-Koordinaten an Hilfsrechteck übergeben)
    // Umrechnung der Eck-Koordinaten des Hilfsrechtecks:
    r.BottomRight := Parent.ScreenToClient(Form1.StringGrid1.ClientToScreen(r.BottomRight));
    r.TopLeft := Parent.ScreenToClient(Form1.StringGrid1.ClientToScreen(r.TopLeft));
    // Positionierung der Combobox (Left, Top, Width und Height werden zugewiesen):
    SetBounds(r.Left+my_offs_left, r.Top+my_offs_top, my_width, my_height);
    Visible:= true;
    BringToFront; // Combobox in Vordergrund bringen
  end;
  my_offs_left:= my_offs_left + my_spacing;
  with Form1.CheckBit0 do begin
    Checked:= (val and 1) = 1;
    CopyRect(r, rec); // rec => r (Eck-Koordinaten an Hilfsrechteck übergeben)
    // Umrechnung der Eck-Koordinaten des Hilfsrechtecks:
    r.BottomRight := Parent.ScreenToClient(Form1.StringGrid1.ClientToScreen(r.BottomRight));
    r.TopLeft := Parent.ScreenToClient(Form1.StringGrid1.ClientToScreen(r.TopLeft));
    // Positionierung der Combobox (Left, Top, Width und Height werden zugewiesen):
    SetBounds(r.Left+my_offs_left, r.Top+my_offs_top, my_width, my_height);
    Visible:= true;
    BringToFront; // Combobox in Vordergrund bringen
  end;
end;

// Der folgende Eventhandler versteckt die Bedienelemente,
// wenn sie aus dem StringGrid herausgescrollt werden:
procedure TForm1.StringGrid1TopLeftChanged(Sender: TObject);
var
  i, my_val, my_max, my_idx: Integer;
  my_type : String;
  my_rect: TRect;
  my_finished: boolean;
begin
{
  if not ClickedOnCell then begin
    ComboBox1.Visible:=false;
    Scrollbar1.Visible:=false;
    Panel1.Visible:=false;
    exit;
  end;
}
  ClickedOnCell:= false;
  my_max:= 255;
  my_type:= 'None'; // Default: kein Control malen
  my_val:= 0;
  my_finished:= false;
  case PageControl1.TabIndex of
    0: begin // Organ Params
      my_val:=  IntFromStringGrid1(2,StringGrid1.Row);
      my_max:=  IntFromStringGrid1(4,StringGrid1.Row);
      my_rect:= StringGrid1.CellRect(2,StringGrid1.Row);
      if StringGrid1.Col < 3 then
        my_type:= StringGrid1.Cells[3,StringGrid1.Row];
    end;
    1: begin
      my_type:= 'TrackBar';
      my_val:= StrToIntDef(Form1.StringGrid2.Cells[2,StringGrid2.Row],0);
      my_rect:= StringGrid2.CellRect(2,StringGrid2.Row);
    end;
    2: begin // MIDI CC Params
      my_rect:= StringGrid3.CellRect(2,StringGrid3.Row);
    end;
  end;

  if my_type = 'TrackBar' then begin // Trackbar/Scrollbar
    ComboBox1.Visible:=false;
    Scrollbar1.Max:= my_max;
    Scrollbar1.Position:= my_val;
    TrackBarInStringGrid(my_rect);
    my_finished:= true;
  end else
    Scrollbar1.Visible:=false;

  if my_type = 'Button' then begin // LED-Button (Panel)
    ComboBox1.Visible:=false;
    Panel1.Tag:= my_val and 255;
    PanelInStringGrid(my_rect);
    my_finished:= true;
  end else
    Panel1.Visible:=false;

  if my_type = 'CheckBits' then begin // 8 Checkboxen
    ComboBox1.Visible:=false;
    CheckBitsInStringGrid(my_rect, my_val);
    my_finished:= true;
  end else begin
    CheckBit7.Visible:=false;
    CheckBit6.Visible:=false;
    CheckBit5.Visible:=false;
    CheckBit4.Visible:=false;
    CheckBit3.Visible:=false;
    CheckBit2.Visible:=false;
    CheckBit1.Visible:=false;
    CheckBit0.Visible:=false;
  end;

  if my_type = 'None' then begin// nur Zahlenwert
    ComboBox1.Visible:=false;
    exit;
  end;

// my_type ist Menü-Eintrag für Combo-Box
  if (not my_finished) and (PageControl1.TabIndex = 0) then begin
    my_idx:= DropDownList.IndexOfName(my_type);
    if LastControlName <> my_type then begin
      LastControlName:= my_type;
      ComboBox1.Clear;
      for i:= 0 to my_max do begin
        ComboBox1.Items.Add(DropDownList.ValueFromIndex[my_idx+i]);
      end;
    end;
    ComboBox1.ItemIndex:= my_val;
    ComboBoxInStringGrid(my_rect);
  end;
end;

procedure TForm1.StringGrid123DrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
begin
  case PageControl1.TabIndex of
    0: if ARow = 0 then
  // Tabelle erste Zeile fett und rot
      with StringGrid1, Canvas do begin
        Font.Style := [fsBold];
        Font.Color:= clred;
        TextRect(Rect, Rect.Left + 2, Rect.Top + 2, Cells[ACol, ARow]);
      end;
  1: if ARow = 0 then
  // Tabelle erste Zeile fett und rot
      with StringGrid2, Canvas do begin
        Font.Style := [fsBold];
        Font.Color:= clred;
        TextRect(Rect, Rect.Left + 2, Rect.Top + 2, Cells[ACol, ARow]);
      end;
  2: if ARow = 0 then
  // Tabelle erste Zeile fett und rot
      with StringGrid3, Canvas do begin
        Font.Style := [fsBold];
        Font.Color:= clred;
        TextRect(Rect, Rect.Left + 2, Rect.Top + 2, Cells[ACol, ARow]);
      end;
  end;

  if not (gdFocused in State) then
    exit;
  if ACol = 2 then
    StringGrid1TopLeftChanged(Sender);
end;

procedure TForm1.StringGrid1Click(Sender: TObject);
begin
  ClickedOnCell:= true;
end;


procedure TForm1.StringGrid1SelectCell(Sender: TObject; ACol, ARow: Integer;
  var CanSelect: Boolean);
begin
  ClickedOnCell:= true;
end;

procedure TForm1.StringGrid1SetEditText(Sender: TObject; ACol, ARow: Integer;
  const Value: string);
begin
  ClickedOnCell:= true;
  if ftdi_isopen and (StringGrid1.Cells[3,ARow]='None') then
    HX3_send(IntFromStringGrid1(0,ARow), IntFromStringGrid1(2,ARow), CheckboxEEwrite.checked);
end;

//##############################################################################
//######################### StringGrid2 LESLIE #################################
//##############################################################################

function IntFromStringGrid2(my_column,my_row: Integer):Integer;
begin
  result:= StrToIntDef(Form1.StringGrid2.Cells[my_column,my_row],0);
end;

procedure TForm1.StringGrid2TopLeftChanged(Sender: TObject);
begin
  with StringGrid2 do begin
    Scrollbar1.Max:= 255;
    TrackBarInStringGrid(CellRect(Col,Row));
  end;
end;


//##############################################################################
//######################### StringGrid3 MIDI CC ################################
//##############################################################################

function IntFromStringGrid3(my_column,my_row: Integer):Integer;
begin
  result:= StrToIntDef(Form1.StringGrid3.Cells[my_column,my_row],0);
end;


procedure MidiCheck;
var
  my_long, my_cmd, my_cc, my_data: LongInt;
begin
  if ftdi_isopen and (HX3record.FirmwareVersion > 3.54) and (Form1.PageControl1.TabIndex = 2) then begin
    my_long:=HX3_Query(9000);
    my_data:= my_long and $7F;
    my_cc:= (my_long and $7F00) shr 8;
    my_cmd:= (my_long and $FF0000) shr 16;
    Form1.EditMidiRec.Text:= IntToStr(my_cmd)+':'+IntToStr(my_cc)+':'+IntToStr(my_data)+
      ' [$'+IntToHex(my_cmd,2)+':$'+IntToHex(my_cc,2)+':$'+IntToHex(my_data,2)+']';
    if (my_cmd and $F0) = 176 then begin
      if LastMidiVal <> my_data then begin
        Form1.StringGrid3.Row:= my_cc +1;
        LastMidiVal:= my_data;
        LastMidiCC:= my_cc;
        Form1.GaugeMIDIdata.Progress:= my_data;
      end;
    end;
  end;
end;

procedure TForm1.MidiCCListBoxDrawItem(Control: TWinControl; Index: Integer;
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
  my_str:= StringGrid3.Cells[2,StringGrid3.Row];
  my_select:=StrToIntDef(my_str,0);
  MidiCCListBox.ItemIndex:= MidiCCList.IndexOfName(my_str);
  my_str:= MidiCCList.Values[my_str];
  MIDIccHint.Caption:= 'MIDI CC ' + IntToStr(StringGrid3.Row-1)
    + ' translated to ' + my_Str;
  if ftdi_isopen then
    HX3_send(3000+StringGrid3.Row-1, my_select, CheckboxEEwrite.checked);
end;


procedure TForm1.MidiCCListBoxClick(Sender: TObject);
begin
  StringGrid3.Cells[2,StringGrid3.Row]:= MidiCCList.names[MidiCCListBox.ItemIndex];
  StringGrid3Click(Sender);
end;

procedure TForm1.StringGrid3SetEditText(Sender: TObject; ACol, ARow: Integer;
  const Value: string);
begin
  StringGrid3Click(Sender);
end;

procedure TForm1.EditOrganDefaultsFileChange(Sender: TObject);
begin
  HX3record.OrganParamFile:= EditOrganDefaultsFile.Text;
end;

procedure TForm1.EditLeslieDefaultsFileChange(Sender: TObject);
begin
  HX3record.LeslieParamFile:= EditLeslieDefaultsFile.Text;
end;

procedure TForm1.EditMidiCCFileChange(Sender: TObject);
begin
  HX3record.MidiCCfile:= EditMidiCCFile.Text;
end;

procedure TForm1.EditUpperPresetsFileChange(Sender: TObject);
begin
  HX3record.UpperPresetFile:= EditUpperPresetsFile.Text;
end;

procedure TForm1.EditLowerPresetsFileChange(Sender: TObject);
begin
  HX3record.LowerPresetFile:= EditLowerPresetsFile.Text;
end;

