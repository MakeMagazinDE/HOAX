//##############################################################################
//############################ Preset Change  ##################################
//##############################################################################


procedure TForm1.ComboBoxUpperPresetChange(Sender: TObject);
begin
  if ftdi_isopen then
    HX3_send(413,ComboboxUpperPreset.ItemIndex,false);
  HX3record2Form;
end;

procedure TForm1.ComboBoxLowerPresetChange(Sender: TObject);
begin
  if ftdi_isopen then
    HX3_send(414,Form1.ComboboxLowerPreset.ItemIndex,false);
  HX3record2Form;
end;

//##############################################################################

procedure TForm1.CheckBox0Click(Sender: TObject);
begin
  HX3_Send(900,BoolToByte(CheckBox0.Checked),false);
  Form2HX3record;
end;

procedure TForm1.CheckBox1Click(Sender: TObject);
begin
  HX3_Send(901,BoolToByte(CheckBox1.Checked),false);
  Form2HX3record;
end;

procedure TForm1.CheckBox2Click(Sender: TObject);
begin
  HX3_Send(902,BoolToByte(CheckBox2.Checked),false);
  Form2HX3record;
end;

procedure TForm1.CheckBox3Click(Sender: TObject);
begin
  HX3_Send(903,BoolToByte(CheckBox3.Checked),false);
  Form2HX3record;
end;

procedure TForm1.CheckBox4Click(Sender: TObject);
begin
  HX3_Send(904,BoolToByte(CheckBox4.Checked),false);
  Form2HX3record;
end;

procedure TForm1.CheckBox5Click(Sender: TObject);
begin
  HX3_Send(905,BoolToByte(CheckBox5.Checked),false);;
  Form2HX3record;
end;

procedure TForm1.CheckBox6Click(Sender: TObject);
begin
  HX3_Send(906,BoolToByte(CheckBox6.Checked),false);
  Form2HX3record;
end;

procedure TForm1.CheckBox7Click(Sender: TObject);
begin
  HX3_Send(907,BoolToByte(CheckBox7.Checked),false);
  Form2HX3record;
end;

procedure TForm1.CheckBox8Click(Sender: TObject);
begin
  HX3_Send(914,BoolToByte(CheckBox8.Checked),false);
  Form2HX3record;
end;

procedure TForm1.CheckBox9Click(Sender: TObject);
begin
  HX3_Send(915,BoolToByte(CheckBox9.Checked),false);
  Form2HX3record;
end;

procedure TForm1.CheckBox10Click(Sender: TObject);
begin
  HX3_Send(916,BoolToByte(CheckBox10.Checked),false);
  Form2HX3record;
end;

procedure TForm1.CheckBox11Click(Sender: TObject);
begin
  HX3_Send(917,BoolToByte(CheckBox11.Checked),false);
  Form2HX3record;
end;

procedure TForm1.TrackBarU0Change(Sender: TObject);
begin
  UpperPresets[0+16*Form1.ComboboxUpperPreset.ItemIndex]:= Form1.TrackBarU0.Position;
  if ftdi_isopen then
    HX3_send(401,Form1.TrackBarU0.Position,false);
end;

procedure TForm1.TrackBarU1Change(Sender: TObject);
begin
  UpperPresets[1+16*Form1.ComboboxUpperPreset.ItemIndex]:= Form1.TrackBarU1.Position;
  if ftdi_isopen then
    HX3_send(402,Form1.TrackBarU1.Position,false);
end;

procedure TForm1.TrackBarU2Change(Sender: TObject);
begin
  UpperPresets[2+16*Form1.ComboboxUpperPreset.ItemIndex]:= Form1.TrackBarU2.Position;
  if ftdi_isopen then
    HX3_send(403,Form1.TrackBarU2.Position,false);
end;

procedure TForm1.TrackBarU3Change(Sender: TObject);
begin
  UpperPresets[3+16*Form1.ComboboxUpperPreset.ItemIndex]:= Form1.TrackBarU3.Position;
  if ftdi_isopen then
    HX3_send(404,Form1.TrackBarU3.Position,false);
end;

procedure TForm1.TrackBarU4Change(Sender: TObject);
begin
  UpperPresets[4+16*Form1.ComboboxUpperPreset.ItemIndex]:= Form1.TrackBarU4.Position;
  if ftdi_isopen then
    HX3_send(405,Form1.TrackBarU4.Position,false);
end;

procedure TForm1.TrackBarU5Change(Sender: TObject);
begin
  UpperPresets[5+16*Form1.ComboboxUpperPreset.ItemIndex]:= Form1.TrackBarU5.Position;
  if ftdi_isopen then
    HX3_send(406,Form1.TrackBarU5.Position,false);
end;

procedure TForm1.TrackBarU6Change(Sender: TObject);
begin
  UpperPresets[6+16*Form1.ComboboxUpperPreset.ItemIndex]:= Form1.TrackBarU6.Position;
  if ftdi_isopen then
    HX3_send(407,Form1.TrackBarU6.Position,false);
end;

procedure TForm1.TrackBarU7Change(Sender: TObject);
begin
  UpperPresets[7+16*Form1.ComboboxUpperPreset.ItemIndex]:= Form1.TrackBarU7.Position;
  if ftdi_isopen then
    HX3_send(408,Form1.TrackBarU7.Position,false);
end;

procedure TForm1.TrackBarU8Change(Sender: TObject);
begin
  UpperPresets[8+16*Form1.ComboboxUpperPreset.ItemIndex]:= Form1.TrackBarU8.Position;
  if ftdi_isopen then
    HX3_send(409,Form1.TrackBarU8.Position,false);
end;

procedure TForm1.TrackbarL0Change(Sender: TObject);
begin
  LowerPresets[0+16*Form1.ComboboxLowerPreset.ItemIndex]:= Form1.TrackbarL0.Position;
  if ftdi_isopen then
    HX3_send(416,Form1.TrackbarL0.Position,false);
end;

procedure TForm1.TrackbarL1Change(Sender: TObject);
begin
  LowerPresets[1+16*Form1.ComboboxLowerPreset.ItemIndex]:= Form1.TrackbarL1.Position;
  if ftdi_isopen then
    HX3_send(417,Form1.TrackbarL1.Position,false);
end;

procedure TForm1.TrackbarL2Change(Sender: TObject);
begin
  LowerPresets[2+16*Form1.ComboboxLowerPreset.ItemIndex]:= Form1.TrackbarL2.Position;
  if ftdi_isopen then
    HX3_send(418,Form1.TrackbarL2.Position,false);
end;

procedure TForm1.TrackbarL3Change(Sender: TObject);
begin
  LowerPresets[3+16*Form1.ComboboxLowerPreset.ItemIndex]:= Form1.TrackbarL3.Position;
  if ftdi_isopen then
    HX3_send(419,Form1.TrackbarL3.Position,false);
end;

procedure TForm1.TrackbarL4Change(Sender: TObject);
begin
  LowerPresets[4+16*Form1.ComboboxLowerPreset.ItemIndex]:= Form1.TrackbarL4.Position;
  if ftdi_isopen then
    HX3_send(420,Form1.TrackbarL4.Position,false);
end;

procedure TForm1.TrackbarL5Change(Sender: TObject);
begin
  LowerPresets[5+16*Form1.ComboboxLowerPreset.ItemIndex]:= Form1.TrackbarL5.Position;
  if ftdi_isopen then
    HX3_send(421,Form1.TrackbarL5.Position,false);
end;

procedure TForm1.TrackbarL6Change(Sender: TObject);
begin
  LowerPresets[6+16*Form1.ComboboxLowerPreset.ItemIndex]:= Form1.TrackbarL6.Position;
  if ftdi_isopen then
    HX3_send(422,Form1.TrackbarL6.Position,false);
end;

procedure TForm1.TrackbarL7Change(Sender: TObject);
begin
  LowerPresets[7+16*Form1.ComboboxLowerPreset.ItemIndex]:= Form1.TrackbarL7.Position;
  if ftdi_isopen then
    HX3_send(423,Form1.TrackbarL7.Position,false);
end;

procedure TForm1.TrackbarL8Change(Sender: TObject);
begin
  LowerPresets[8+16*Form1.ComboboxLowerPreset.ItemIndex]:= Form1.TrackbarL8.Position;
  if ftdi_isopen then
    HX3_send(424,Form1.TrackbarL8.Position,false);
end;

procedure TForm1.TrackBarB0Change(Sender: TObject);
begin
  LowerPresets[9+16*Form1.ComboboxLowerPreset.ItemIndex]:= Form1.TrackbarB0.Position;
  if ftdi_isopen then
    HX3_send(425,Form1.TrackbarB0.Position,false);
end;

procedure TForm1.TrackBarB1Change(Sender: TObject);
begin
  LowerPresets[10+16*Form1.ComboboxLowerPreset.ItemIndex]:= Form1.TrackbarB1.Position;
  if ftdi_isopen then
    HX3_send(426,Form1.TrackbarB1.Position,false);
end;

procedure TForm1.TrackBarB2Change(Sender: TObject);
begin
  LowerPresets[11+16*Form1.ComboboxLowerPreset.ItemIndex]:= Form1.TrackbarB2.Position;
  if ftdi_isopen then
    HX3_send(427,Form1.TrackbarB2.Position,false);
end;

procedure TForm1.TrackBarB3Change(Sender: TObject);
begin
  LowerPresets[12+16*Form1.ComboboxLowerPreset.ItemIndex]:= Form1.TrackbarB3.Position;
  if ftdi_isopen then
    HX3_send(428,Form1.TrackbarB3.Position,false);
end;

procedure TForm1.ComboBoxVibKnobChange(Sender: TObject);
// Vibrato Knob
begin
  UpperPresets[9+16*Form1.ComboboxUpperPreset.ItemIndex]:= Form1.ComboBoxVibKnob.ItemIndex;
  if ftdi_isopen then
    HX3_send(410,Form1.ComboBoxVibKnob.ItemIndex,false);
end;



