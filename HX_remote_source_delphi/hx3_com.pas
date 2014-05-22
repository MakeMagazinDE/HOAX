unit hx3_com;
{
 <SOH>       = 01 hex
 <blk #>     = binary number, starts at 01 increments by 1, and
               wraps 0FFH to 00H (not to 01)
 <255-blk #> = blk # after going thru 8080 "CMA" instr.
               Formally, this is the "ones complement".
 <cksum>     = the sum of the data bytes only.  Toss any carry.

  SENDER                           RECEIVER
                                   Times out after 10 seconds,
                           <---    <nak>
  <soh> 01 FE -data- <xx>   --->
                           <---    <ack>
  <soh> 02 FD -data- <xx>   --->   (data gets line hit)
                           <---    <nak>
  <soh> 02 FD -data- <xx>   --->
                           <---    <ack>
  <soh> 03 FC -data- <xx>   --->
    (ack gets garbaged)    <---    <ack>
  <soh> 03 FC -data- <xx>   --->
                           <---    <ack>
  <eot>                     --->
                           <---    <ack>

}
interface

//uses SysUtils, FTDIdll, FTDIchip, FTDItypes;
uses SysUtils, StrUtils, Windows, Classes, Forms, Controls, Menus,
  Dialogs, StdCtrls, FTDIdll, FTDIchip, FTDItypes;

type
  TFileBuffer = Array of byte;

procedure HX3_Set(my_subch, my_val: Integer; my_getok, my_wen: boolean);
// Wert setzen, NICHT auf Antwort warten. OK-Antwort anfordern wenn my_getok=TRUE

procedure HX3_SetStr(my_str: String);
// sendet String an HX3, NICHT auf Antwort zu warten

function HX3_Send(my_subch, my_val: Integer; my_wen: boolean):string;
// Parameter (Integer) setzen und auf Antwort (OK) warten

function HX3_SendStr(my_str: String; my_wait: LongInt):String;
// sendet String an HX3 und wartet auf Antwort

function HX3_QueryStr(my_subch: Integer):String;
// Abfrage, liefert kompletten Antwort-String

function HX3_Query(my_subch: Integer):LongInt;
// Abfrage, liefert Parameter als LongInt-Wert

function HX3_ResponseWait(my_time: cardinal): String;
// sendet nichts, aber wartet my_time Millisekunden auf Antwort von HX3

function HX3_QueryFloat(my_subch: Integer):Real;
// Abfrage Float-Wert, z.B. für Seriennummer

function HX3_StrToInt(my_Str: String):LongInt;
// wandelt HX3-Antwortstring in LongInt-Wert

function HX3_StrToFloat(my_Str: String):Real;
// wandelt HX3-Antwortstring in Real-Wert


function SetupFTDI: String;
function InitFTDI(my_device:Integer): String;
function CheckCom(my_ComNumber: Integer): Integer;  // check if a COM port is available
Function TxPacket(PacketNbr:Word): String; // returns message
Function TxEOT:Boolean;     (* successfull *)

var
//FTDI-Device
  ftdi: Tftdichip;
  ftdi_isopen : Boolean;

  ftdi_selected_device: Integer;  // FTDI-Frosch-Device-Nummer
  ftdi_device_count: dword;
  ftdi_device_list: pftdiDeviceList;
  ftdi_sernum_arr, ftdi_desc_arr: Array[0..15] of ShortString;
  TxFileBuffer: TFileBuffer;
  TxFileBufferSize:LongInt;

implementation


const MAXTRY = 3;
      LIMIT = 20;

const SOH = $01;
      STX = $02;
      EOT = $04;
      ACK = $06;
      NAK = $15;
      CAN = $18;

function ExtComName(ComNr: DWORD): string;
begin
  if ComNr > 9 then
    Result := Format('\\.\COM%d', [ComNr])
  else
    Result := Format('COM%d', [ComNr]);
end;

function CheckCom(my_ComNumber: Integer): Integer;
// check if a COM port is available
var
  FHandle: THandle;
  my_str: String;
begin
  Result := 0;
  my_str:= ExtComName(my_ComNumber);
  FHandle := CreateFile(PChar(my_str),
    GENERIC_WRITE,
    0, {exclusive access}
    nil, {no security attrs}
    OPEN_EXISTING,
    FILE_ATTRIBUTE_NORMAL,
    0);
  if FHandle <> INVALID_HANDLE_VALUE then
    CloseHandle(FHandle)
  else
    Result := GetLastError;
end;

procedure Delay(msecs: Longint);
var
  targettime: cardinal;
begin
  targettime := GetTickCount + msecs;
  while targettime > GetTickCount do
    Application.ProcessMessages;
end;

procedure PutChar(my_byte: byte);
var
  i: longint;
  my_char: char;
begin
  my_char:=char(my_byte);
  ftdi.write(@my_char, 1, i);
end;

function GetChar: byte;
var
  i: longint;
  my_char: char;
  targettime: cardinal;
begin
  targettime := GetTickCount + 500;
  repeat
    if ftdi.getReceiveQueueStatus(i) then
      if i>0 then
        ftdi.read(@my_char, 1, i);
  until (i>0) or (GetTickCount > targettime);
  result:= byte(my_char);
end;

procedure HX3_SetStr(my_str: String);
// sendet String an HX3, ohne auf Antwort zu warten
var
  i: longint;
begin
  if not ftdi_isopen then exit;
  my_str:= my_str+#13;
  ftdi.write(@my_str[1], length(my_str), i);
end;

function HX3_SendStr(my_str: String; my_wait: LongInt):String;
// sendet String an HX3 und wartet auf Antwort
var
  my_char: char;
  targettime: cardinal;
  i: longint;
begin
  ftdi.purgeQueue(fReceiveQueue);
  HX3_setstr(my_str);
  my_str:='';
  my_char:= #0;
  targettime := GetTickCount + my_wait;
  repeat
    if ftdi.getReceiveQueueStatus(i) then
      if i>0 then begin
        ftdi.read(@my_char, 1, i);
        my_str:= my_str + my_char;
      end;
  until (my_char = #13) or  (GetTickCount > targettime);
  if (GetTickCount > targettime) then
    result:= '-9999'
  else
    result:= my_str;
end;


function HX3_ResponseWait(my_time: cardinal): String;
// sendet nichts, aber wartet my_time Millisekunden auf Antwort von HX3
var
  my_str: String;
  my_char: char;
  targettime: cardinal;
  i: longint;
begin
  my_char:= ' ';
  my_str:= '';
  targettime := GetTickCount + my_time;
  repeat
    if ftdi.getReceiveQueueStatus(i) then
      if i>0 then begin
        ftdi.read(@my_char, 1, i);
        my_str:= my_str+my_char;
      end;
  until (my_char = #13) or  (GetTickCount > targettime);
  if (GetTickCount > targettime) then
    result:= '-9999'
  else
    result:= my_str;
end;

function HX3_QueryStr(my_subch: Integer):String;
// sendet SubCh-Abfrage an HX3 und wartet auf Antwort
var
  my_str: String;
  i: longint;
begin
  ftdi.purgeQueue(fReceiveQueue);
  my_str := IntToStr(my_subch) + '?' + #13;
  ftdi.write(@my_str[1], length(my_str), i);
  result:= HX3_ResponseWait(200);
end;

function HX3_StrToInt(my_Str: String):LongInt;
// wandelt HX3-Antwort in LongInt-Wert
var
  my_pos1, my_pos2: Integer;
begin
  my_pos1:= Pos('=', my_str);
  my_pos2:= Pos(' ', my_str);
  if my_pos2 = 0 then my_pos2:= length(my_Str)-1 else dec(my_pos2);
  my_str:= copy(my_str, my_pos1+1, my_pos2-my_pos1);
  result:= StrToInt(my_Str);
end;

function HX3_StrToFloat(my_Str: String):Real;
// wandelt HX3-Antwort in Real-Wert
var
  my_pos1, my_pos2: Integer;
  formatSettings : TFormatSettings;
begin
  my_pos1:= Pos('=', my_str);
  my_pos2:= Pos(' ', my_str);
  if my_pos2 = 0 then my_pos2:= length(my_Str)-1 else dec(my_pos2);
  my_str:= copy(my_str, my_pos1+1, my_pos2-my_pos1);
  formatSettings.DecimalSeparator:= '.';
  result:= StrToFloat(my_Str, formatSettings);
end;

function HX3_Query(my_subch: Integer):LongInt;
// Integer-Wert abfragen
begin
  result:= HX3_StrToInt(HX3_QueryStr(my_subch ));
end;

function HX3_QueryFloat(my_subch: Integer):Real;
// Float-Wert abfragen
begin
  result:= HX3_StrToFloat(HX3_QueryStr(my_subch ));
end;

procedure HX3_Set(my_subch, my_val: Integer; my_getok, my_wen: boolean);
// Wert setzen, NICHT auf Antwort warten. OK-Antwort anfordern wenn my_getok=TRUE
var
  my_str: String;
  i: longint;
begin
  if not ftdi_isopen then exit;
  if my_wen then begin
    my_str := 'wen=1' + #13;
    ftdi.write(@my_str[1], length(my_str), i);
  end;
  my_str := IntToStr(my_subch) + '=' + IntToStr(my_val);
  if my_getok then my_str := my_str + '!' + #13
    else my_str := my_str + #13;
  ftdi.purgeQueue(fReceiveQueue);
  ftdi.write(@my_str[1], length(my_str), i);
end;

function HX3_Send(my_subch, my_val: Integer; my_wen: boolean):string;
// Wert setzen und auf Antwort warten
var
  my_str: String;
  i: longint;
begin
  if not ftdi_isopen then exit;
  if my_wen then begin
    my_str := 'wen=1' + #13;
    ftdi.write(@my_str[1], length(my_str), i);
    delay(20);
  end;
  my_str := IntToStr(my_subch) + '=' + IntToStr(my_val) + '!' + #13;
  ftdi.purgeQueue(fReceiveQueue);
  ftdi.write(@my_str[1], length(my_str), i);
  result:= HX3_ResponseWait(200);
end;


function SetupFTDI: String;
var
  i: longint;

begin
  ftdi_isopen:= false;
  ftdi:= tftdichip.create;  { Create class instance }
  { Get the device list }
  if not ftdi.createDeviceInfoList(ftdi_device_count, ftdi_device_list) then begin
    result:= '### Failed to create device info list';
    freeandnil(ftdi);
    exit;
  end;
  { Iterate through the device list that was returned }
  for i := 0 to ftdi_device_count - 1 do begin
    ftdi_sernum_arr[i]:= strpas(ftdi_device_list^[i].serialNumber);
    ftdi_desc_arr[i]:= strpas(ftdi_device_list^[i].description);
  end;
end;

function InitFTDI(my_device:Integer):String;
begin
    { Check if device is present }
  if not ftdi.isPresentBySerial(ftdi_sernum_arr[my_device]) then begin
    result:= '### Device not present';
    ftdi.destroy;
    ftdi := nil;
    exit;
  end;

  if not ftdi.openDeviceBySerial(ftdi_sernum_arr[my_device]) then begin
    result:= '### Failed to open device';
    ftdi.destroy;
    ftdi := nil;
    exit;
  end;
  { Configure for 57600 baud, 8 bit, 1 stop bit, no parity, no flow control }
  if ftdi.resetDevice then begin
    ftdi_isopen:= true;
    ftdi.setBaudRate(fBaud57600);
    ftdi.setDataCharacteristics(fBits8, fStopBits1, fParityNone);
    ftdi.setFlowControl(fFlowNone, 0, 0);
    result:= 'USB connected';
  end else
    result:= '### Reset error';
end;

Function TxEOT:Boolean;
Var
  i    : Integer;
  Code : Integer;
Begin
  for I := 0 to 10 do
    begin
      PutChar(EOT);
      (* await response *)
      Code := GetChar;
      if Code = ACK then
        begin
          result := TRUE;
          exit;
        end
    end; (* end -- for I) *)
  result := FALSE;
end; (* end -- TxEOT *)

Function TxPacket(PacketNbr:Word): String;              (* successfull *)
// sendet ein Paket aus TxFileBuffer, Startadresse = PacketNbr * 128
Var
  I         : Integer;
  Code      : Integer;
  CheckSum  : Word;
  Attempt   : Word;
  my_PacketNbr: Word;

Begin
  ftdi.purgeQueue(fReceiveQueue);
  my_PacketNbr := PacketNbr and $00ff;
  (* make up to MAXTRY attempts to send this packet *)
  for Attempt := 1 to MAXTRY do
    begin
      (* send SOH/STX  *)
      PutChar(SOH);
      (* send packet # *)
      PutChar(my_PacketNbr);
      (* send 1's complement of packet *)
      PutChar(255-my_PacketNbr);
      (* send data *)
      CheckSum := 0;
      for i := 0 to 127 do begin
        //PutChar(TxFileBuffer[i+(128*PacketNbr)]);
        CheckSum := CheckSum + TxFileBuffer[i+(128*PacketNbr)]; // update checksum
      end;
      // kompletten Block senden, ist etwas schneller
      ftdi.write(@TxFileBuffer[128*PacketNbr], 128, i);
      PutChar($00ff AND CheckSum); // 1 Byte Checksum
      Code := GetChar; // warte auf ACK
      if Code = CAN then
         begin
            result:= 'Canceled by remote';
            exit;
          end;
      if Code = ACK then
          begin
            result:= 'Packet: ' + IntToStr(PacketNbr);
            exit;
          end;
      if Code <> NAK then
          begin
            result:= 'Out of sync at Packet ' + IntToStr(PacketNbr);
            exit;
          end;
    end; (* end for *)
  (* can't send packet ! *)
  result := 'Retry exceeded';
end; (* end -- TxPacket *)

end.
