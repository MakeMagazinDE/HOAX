//##############################################################################
//######################### StringGrid2 LESLIE #################################
//##############################################################################

procedure TForm1.StringGrid2TopLeftChanged(Sender: TObject);
begin
  with StringGrid2 do begin
    TrackBarInStringGrid(CellRect(Col,Row));
  end;
end;


