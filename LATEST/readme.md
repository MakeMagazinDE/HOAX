HX3 Latest Firmware
===================

<b>Not released yet, but working beta releases for evaluation. You should know what you're doing!</b>

<b>LATEST NEWS:</b> New update program for Windows available - makes fiddling with AVRdude and TeraTerm obsolete!

### Using the new HX3 remote/update program

Copy whole contents of this directory to a new folder on your hard disk, for 
example E:\LATEST\. See 
http://wiki.keyboardpartner.de/index.php?title=HX3_Remote/Update_Application for 
details. Note: For operation with firmware 3.5 and up, remove jumpers JP7 and 
JP8 which may still sit on your board from factory programming. These jumpers 
are only required for updateing the reverb DSP.



### Last Build

* HX3 Remote: #1.10	hx3_remote.exe for Windows XP and up
* AVR:  #3.54       .hex and .eep files, Latest Firmware for AVR controller
* FPGA: #19052014   .bit file, Needed for #3.51
* SCAN: #$0D        .dat files, Needed for #3.51 and up; only FATAR and MIDI scan cores finished yet, others will follow 

### Changelog

06/04/2014 

* Fixed small bug in ScanCores which would have shown up later
* Added FIR Upload to HX Remote
* Added ScanCore for Scan16 Strip 61 Keys

05/28/2014

* HX3 Remote had a small bug in "Write Basics" function that transmitted "1" instead of "255" value with Booleans (Enables etc.) of value "true".  Fixed with version 1.09 (online).
* Fixed small bug in HX3 firmware that prevented saving of Amp122 resp. Leslie Volume Pot Enable by MenuPanel.

05/20/2014

* Bugfix on HX_remote.exe, organ param list, last parameter Amp122 Volume Enable was missing

05/19/2014

* Bugfix on HX_remote.exe, EEPROM programming was faulty
* Bugfix on FPGA configuration, fixed sporadic crackling noise on right Leslie channel
* Experimental custom MIDI CC set, editor added to HX3_remote

05/01/2014

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
