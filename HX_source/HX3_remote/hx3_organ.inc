//##############################################################################
//######################### StringGrid1 ORGAN  #################################
//##############################################################################


procedure TrackBarInStringGrid(rec: TRect);
var r: TRect;
begin
  with Form1.TrackBar1 do begin
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
    SetBounds(r.Left+35, r.Top, r.Right-r.Left-35, r.Bottom-r.Top);
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

procedure TForm1.StringGrid123DrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
var
  i, my_val, my_max, my_type, my_idx: Integer;
  my_row: Integer;

begin
  my_row:= aRow-1;
  my_idx:= -1;
  my_max:= 255;
  case PageControl1.TabIndex of
    0: begin // Organ Params
      if ARow = 0 then
      // Tabelle erste Zeile fett und rot
        with StringGrid1, Canvas do begin
          Font.Style := [fsBold];
          Font.Color:= clred;
          TextRect(Rect, Rect.Left + 2, Rect.Top + 2, Cells[ACol, ARow]);
        end;
      my_max:= MenuControlsArr[my_row, 2];
      my_type:= MenuControlsArr[my_row, 0];
      my_idx:= MenuControlsArr[my_row, 1];
      my_val:= StrToIntDef(StringGrid1.Cells[aCol,aRow],0);
    end;
    1: begin // Leslie Params
      if ARow = 0 then
      // Tabelle erste Zeile fett und rot
        with StringGrid2, Canvas do begin
          Font.Style := [fsBold];
          Font.Color:= clred;
          TextRect(Rect, Rect.Left + 2, Rect.Top + 2, Cells[ACol, ARow]);
        end;
      my_type:= 3;
      my_val:= StrToIntDef(StringGrid2.Cells[aCol,aRow],0);
    end;
    2: begin // MIDI CC Params
      if ARow = 0 then
      // Tabelle erste Zeile fett und rot
        with StringGrid3, Canvas do begin
          Font.Style := [fsBold];
          Font.Color:= clred;
          TextRect(Rect, Rect.Left + 2, Rect.Top + 2, Cells[ACol, ARow]);
        end;
      my_type:= 0; // kein Control malen
    end;
  end;
  if not (gdFocused in State) then
    exit;

  if my_type = 1 then begin // LED-Button (Panel)
    Panel1.Tag:= my_val and 255;
    PanelInStringGrid(Rect)
  end else
    Panel1.Visible:=false;

  if my_type = 2 then begin // Combo-Box
    ComboBox1.Clear;
    for i:= 0 to my_max do begin // Länge DropDown-Einträge
      ComboBox1.Items.Add(MenuParamStrArr[my_idx+i])
    end;
    ComboBox1.ItemIndex:= my_val;
    ComboBoxInStringGrid(Rect);
  end else
    ComboBox1.Visible:=false;

  if my_type = 3 then begin // Trackbar/Scrollbar
    TrackBar1.Max:= my_max;
    TrackBar1.Position:= my_val;
    TrackBarInStringGrid(Rect)
  end else
    TrackBar1.Visible:=false;
end;


// Der folgende Eventhandler versteckt die Bedienelemente,
// wenn sie aus dem StringGrid herausgescrollt werden:
procedure TForm1.StringGrid1TopLeftChanged(Sender: TObject);
begin
  with StringGrid1 do begin
    case MenuControlsArr[Row-1, 0] of
      1:
        PanelInStringGrid(CellRect(Col,Row));
      2:
        ComboBoxInStringGrid(CellRect(Col,Row));
      3:
        TrackBarInStringGrid(CellRect(Col,Row));
    else
      ComboBox1.Visible:= false;
      TrackBar1.Visible:= false;
      Panel1.Visible:= false;
    end;
  end;
end;
