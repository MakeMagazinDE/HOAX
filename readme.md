HX3 Hammond Clone
=================

<b>LATEST NEWS:</b> New update program for Windows available - makes fiddling with AVRdude and TeraTerm obsolete! See directory LATEST.

HX3/HOAX steht kurz f�r Hammond On A Xilinx FPGA und ist ein v�llig neuer Ansatz einer Tonewheel-Emulation als 
eigenst�ndiges Soundmodul auf einer Platine, erh�ltlich bei KeyboardPartner (http://shop.keyboardpartner.de). Hier 
finden Sie alle Schaltpl�ne, Zeichnungen und Firmware-Updates.

HX3 is a full-featured Hammond clone module with physical modelled tone generation from KeyboardPartner 
(http://shop.keyboardpartner.de). Please find here all documentation, schematics, drawings and firmware/configuration updates.

(Scroll to bottom for english description) 

HX3-Firmware-Installation
=========================

Bitte beachten Sie die ausf�hrliche Anleitung auf http://wiki.keyboardpartner.de! Wir empfehlen den Komplett-Download 
des Repositories mit Button "Download ZIP" (rechte Spalte) und Entpacken in Verzeichnis "C:\HOAX\", da die Batches und 
TeraTerm-Makros diesen Pfad voraussetzen. Bitte vorher ggf. selbst ge�nderte Batches/Makros sichern!

### Flash-Dateien

HEX-Files zum Upload per AVRdude. Zum Update HX3 in Hardware-Reset versetzen 
durch Jumper auf PL1 "R" (Pin 5/6). Unmittelbar vor Aufruf von AVRdude �ber
"hoaxflash.bat" (mit Angabe der COM-Port-Nummer, also z.B. "hoaxflash 3" f�r COM3) Jumper ziehen. 
Achtung: Update erfordert Neueingabe der Lizenznummern, siehe 
http://wiki.keyboardpartner.de/index.php?title=Lizenznummern_erwerben_und_eingeben f�r weitere Details. 
Zu jedem HEX-File geh�rt eine EEPROM-Datei mit Endung .EEP

* <b>HOAX_main.hex</b>             HX3 Standard, ggf. mit Preset24 oder 1 bis 2 Preset16-Panel<br>
* <b>HOAX_main_latching.hex</b>	   Latching Presets (einrastende Tasten) mit alter Preset12 MPX Platine<br>
* <b>HOAX_main_tabvib.hex</b>      wie Standard, jedoch drei Schalter (V1,V2,CH - V3=V1+V2) statt Drehschalter an PL5<br>
* <b>HOAX_main_buttonvib.hex</b>   wie Standard, jedoch Vibrato-Einstellung �ber die vier Common-Preset-Taster von Panel16 statt Drehschalter<br>
* <b>HOAX_main_xb2.hex</b>         Spezialversion f�r XB2-Einbausatz, nutzt vorhandene Bedienelemente und Display<br>
* <b>HOAX_main_xb2_panel16.hex</b> Spezialversion f�r alten XB2-Einbausatz mit Panel16<br>
* <b>Preset24.hex</b>              Firmware f�r ATmega8 auf Preset25-Platine<br>
* <b>HOAX_AVR_ALL.zip</b>          Enth�lt alle aufgef�hrten dateien, gepackt als ZIP

### im Verzeichnis FPGACORES

* <b>main_midi.bit</b>             FPGA-Konfiguration zum Upload mit TeraTerm-Makro<br>
* <b>*.dat</b>                     PicoBlaze Keyscan-Routinen, zum Upload mit TeraTerm-Makro<br>
* <b>*.bin</b>                     SPIN-1 externe I2C Rerverb Programme, zum Upload mit TeraTerm-Makro<br>

### Sonstige Dateien

* <b>hoaxflash.bat</b>             Batch-Datei, ruft AVRdude mit allen Parametern zum Flashen des Controllers mit 
"HOAX_main.hex" und EEPROM-Datei "HOAX_main.eep" auf (f�r Windows). Batch-Datei ist ggf. f�r das 
gew�nschte Flash-File anzupassen!<br>
* <b>avrdude.exe</b>               AVRdude-Programm zum Firmware-Update �ber serielle Schnittstelle (f�r Windows)<br>
* <b>libusb0.dll</b>               Wird von manchen Windows-Systemen ben�tigt, um AVRdude auszuf�hren<br>

### Verzeichnisse

* <b>BETA</b>                      enth�lt allerletzte Firmware und FPGA-Konfiguration<br>
* <b>DOCS_PDF</b>                  Syntax-Tabelle zur Kommunikation und weitere Unterlagen<br>
* <b>FPGACORES</b>                 FPGA-Konfiguration, Hallprogramme und Scan-Cores<br>
* <b>PLATINEN</b>                  Schaltpl�ne, Best�ckungspl�ne und weitere Unterlagen<br>
* <b>TERATERM_MACRO</b>            Update-Makros f�r empfohlenes Terminal-Programm TeraTerm 4.7x (f�r Windows)<br>
* <b>giveio</b>                    Wird ben�tigt, um AVRdude auszuf�hren<br>
* <b>FOR_OEM</b>                   enth�lt alle dateien f�r AVR-Erstprogrammierung, wie oben, jedoch mit eingebautem Bootloader 
(Arduino/AVRdude-kompatibel) f�r Programmierung eines fabrikneuen AVR-
Controllers. Au�erdem: <b>ATmegaBOOT_xx8.c</b> und <b>Makefile</b>, nur f�r Neukompilierung des Bootloaders mit WinAVR n�tig<br>


HX3 Firmware Installation (english)
===================================

Please note installation instructions on http://wiki.keyboardpartner.de! We recommend downloading the whole repository 
by button "Download ZIP" (right above) and unzipping to "C:\HOAX\" as the batch files and TeraTerm macros assume this 
path. Please backup your own batches/macros before!

### AVR flash files

Flash files for serial upload via AVRdude. HX3 must be in hardware reset by 
jumper on PL1 "R" (pin 5/6). Remove jumper immediately before running AVRdude or 
"hoaxflash.bat". Usage: "hoaxflash <COMPORTNUMBER>", i.e. hoaxflash 3" for COM3. 
Every .HEX file has a complimentary .EEP file. Note: Updating the firmware 
requires re-entry of serial numbers, see 
http://wiki.keyboardpartner.de/index.php?title=Lizenznummern_erwerben_und_eingeben for details.

* <b>HOAX_main.hex</b>             standard version with rotary vibrato switch, optional Preset24 or Preset16-Panel<br>
* <b>HOAX_main_latching.hex</b>	  version for latching preset keys with old Preset12 MPX board<br>
* <b>HOAX_main_tabvib.hex</b>      as standard, but 3 switches (V1,V2,CH - V3=V1+V2) instead of rotary vibrato switch at PL5<br>
* <b>HOAX_main_buttonvib.hex</b>   as standard, but vibrato setting (V1..V3, CH) by four Common Preset buttons on Panel16<br>
* <b>HOAX_main_xb2.hex</b>         special version for XB2 retrofit kit, uses XB2's buttons and display<br>
* <b>HOAX_main_xb2_panel16.hex</b> special version for XB2 retrofit kit, uses installed Panel16<br>

### in directory FPGACORES

* <b>main_midi.bit</b>             FPGA configuration, to be uploaded by TeraTerm macro<br>
* <b>*.dat</b>                     PicoBlaze Key scanning routines, to be uploaded by TeraTerm macro<br>
* <b>*.bin</b>                     SPIN-1 external I2C Rerverb programs, to be uploaded by TeraTerm macro<br>

### other files

* <b>hoaxflash.bat</b>             Batch file, invokes AVRdude with all parameters to flah controllers with "HOAX_main.hex" and EEPROM file "HOAX_main.eep". May be edited to fit your required HEX end EEP files.<br>
* <b>avrdude.exe</b>               AVRdude flash utility for firmware update by COM prt (eg. USB cable, for Windows)<br>
* <b>libusb0.dll</b>               used by AVRdude<br>

### directories

* <b>BETA</b>                      last firmware revisions and FPGA configurations, testing only<br>
* <b>DOCS_PDF</b>                  Syntax table for HX3 COM port, MIDI tables etc. <br>
* <b>FPGACORES</b>                 FPGA configuration, reverb firmware and keyboard scan cores for upload with TeraTerm macro<br>
* <b>PLATINEN</b>                  schematics, mechanical drawings, board and componentlayouts<br>
* <b>TERATERM_MACRO</b>            FPGA and scan core pdate macros for terminal emulator TeraTerm 4.7x (Windows)<br>
* <b>giveio</b>                    used by AVRdude flash tool<br>
* <b>FOR_OEM</b>                   contains all flash files as above, but with built-in bootloader (Arduino/AVRdude compatible). Contains also:
<b>ATmegaBOOT_xx8.c</b> and <b>Makefile</b>, only needed for re-compilation of bootloaders with WinAVR<br>

AdaBoot by Adafruit, modified for ATmega644P(A)06/2012 by Carsten Meyer, cm@ct.de

