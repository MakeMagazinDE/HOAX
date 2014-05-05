HX3 Latest Firmware
===================

<b>Not released yet, but working beta releases for evaluation. You should know what you're doing!</b>

Usually needs complete programming of ATmega644 FLASH and EEPROM, scan cores, also reload of FPGA configuration and re-
entry of licence numbers. Note: Firmware 3.50 and up require new licence numbers which may be obtained free from 
"info@keyboardpartner.de" - regard "BETA TEST" and supply your <b>new serial number</b> issued by 3.5x firmware (you 
will have to update your board with new firmware and FPGA configuration first!).

FPGA configuration and scan cores may be uploaded by provided TTMACRO_LATEST_xxx.ttl TeraTerm macro and 
hoaxflash_main.bat/hoaxflash_expander.bat batch files. Please copy <b>AVRdude.exe, AVRdude.conf</b> and <b>giveio 
directory</b> from HOAX to LATEST directory!

For update, AVRdude Flash batches and TeraTerm macros should be started directly from LATEST dir, not HOAX main dir. Connect FTDI cable to your board and make shure connection works in TeraTerm (HX3 should respond to ENTER key with "#0:255=0 [OK]"). Remember the COM port number it uses (may be randomly assigned by Windows system from COM 3 up). Exit TeraTerm. Insert RESET Jumper on HX3 PL1 (R position, pin 5 to 6). Open Windows command window (run "cmd.exe") and start AVRdude batch by typing

* hoaxflash_main XX<br> 
or<br>
* hoaxflash_expander XX 

with XX = your COM port number, but don't press ENTER key. Remove RESET jumper in the very same moment you hit ENTER (!). AVRdude will start and flash the AVR controller. Try again when "out of sync" message issued. When finished, HX3 should reboot.

Start TeraTerm and "connect". Run macro TTMACRO_LATEST_MIDI or TTMACRO_LATEST_FATAR. depending of scan core required. Macro will update FPGA configuration and scan cores. New serial number will be issued while booting. Write down the serial number and send it to me to get a free update.

Many serial remote control parameters have been changed, see <b>HOAX3_mk3_Syntax.xls</b> for current values. Files on https://github.com/heise/HOAX/LATEST, please download/extract to C:/HOAX/LATEST on your hard disk or download whole repository as ZIP (use button in right column above).

For normal operation, set <b>jumper JP6 to STEREO position</b> (pointing towards edge of PCB) amd <b>remove I2C_REV jumpers JP7 and JP8</b>. Please note different operation of BASS To LESLIE tab/button (see http://wiki.keyboardpartner.de/index.php?title=HX3_MIDI_expander_module#Jack_Connections and http://wiki.keyboardpartner.de/index.php?title=HX3_MenuPanel#Menus_Lower for details). 

### Last Build

* AVR:  #3.51       .hex and .eep files, Latest Firmware for AVR controller
* FPGA: #01052014   .bit file, Needed for #3.51
* SCAN: #$0A        .dat files, Needed for #3.51; only FATAR and MIDI scan cores finished yet, others will follow 

### Changelog

* Stereo Leslie simulation with improved modulation
* New vibrato algorithm with delay line "aging" parameter
* Pedal is fully polyphonic with "dry" original sound or "Trek II string bass". Last note played fades out
* Output jacks are mono on new board, but configurable by menu parameter, i.e. you may get organ, amp122 sim, pedal or leslie L/R on any jack. Separate jack extension board (or plug "rings" on HX3 mk2) carries "other" signals
* Lower octave foldback is configurable by menu parameter: Foldback with full level, foldback with muted level, no foldback ("all way down") with full level or muted level
* Reverb amount may be adjusted for each of three tab settings separately
* Bass and Treble tone controls have wider range 
* Virtual key contacts have "mutual resistance" now which yields a more "decent" click response
* New remote parameters 400..481 directly access 81 params like menu selection by MenuPanel
* Deleted obsolete remote params 500..563 despite some for compatibility (519..524)

### Files

<b>HOAX_main.hex</b> Flash file for serial upload via AVRdude, button presets or Preset16<br>
<b>HOAX_expander.hex</b> Flash file for serial upload via AVRdude, MIDI expander version<br>
<b>HOAX_boot_main.hex</b> Flash file complete with Bootloader, for OEM programming by ISP programmer<br>
<b>HOAX_boot_main.hex</b> Flash file complete with Bootloader, for OEM programming by ISP programmer<br>

<b>HOAX_main.eep</b> EEPROM file for upload via AVRdude<br>
<b>HOAX_expander.eep</b> EEPROM file for upload via AVRdude, expander version<br>
<b>HOAX_boot_main.eep</b> EEPROM file for ISP programming<br>
<b>HOAX_boot_expander.eep</b> EEPROM file for ISP programming, expander version<br>

<b>HX_xxx.dat</b>  Scan cores for upload with TeraTerm macro<br>
<b>main.midi.bit</b>  FPGA configuration for upload with TeraTerm macro<br>
<b>hoax3rev.bin</b>  Reverb DSP program for upload with TeraTerm macro<br>

<b>HOAX3_mk3_Syntax.xls</b>  Excel Sheet with new remote syntax<br>

Please also regard installation instructions on http://wiki.keyboardpartner.de!

AdaBoot by Adafruit, modified for ATmega644P(A)06/2012 by Carsten Meyer, cm@ct.de
