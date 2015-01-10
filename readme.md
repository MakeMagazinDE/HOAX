HX3 Hammond Clone
=================

(Scroll to bottom for english description) 

HX3/HOAX steht kurz f�r Hammond On A Xilinx FPGA und ist ein v�llig neuer Ansatz einer Tonewheel-Emulation als 
eigenst�ndiges Soundmodul auf einer Platine, erh�ltlich bei KeyboardPartner (http://shop.keyboardpartner.de). Hier 
finden Sie alle Schaltpl�ne, Zeichnungen und Firmware-Updates.

HX3-Firmware-Installation
=========================

Dateien k�nnen mit Anklicken von "View Raw" einzeln heruntergeladen werden. Es empfiehlt sich, das komplette Repo als 
ZIP downzuloaden (Download-Link: https://github.com/heise/HOAX/archive/master.zip) und auf einem Windows-PC zu entpacken, z.B. in 
E:\HX3\. Beachten Sie zum Update Ihrer HX3-Platine unser Wiki: http://wiki.keyboardpartner.de/index.php?title=HX3_Remote/Update_Application . 

Bitte beachten Sie die ausf�hrliche Anleitung auf http://wiki.keyboardpartner.de! Ge�nderte File-Struktur im Repository: Alle zusemmengeh�rigen Dateien sind jetzt f�r einfacheren Download in entsprechende ZIP-Dateien verpackt.

### Flash-Dateiformate

* <b>HX3mkX_xxx.hex</b>            Verschiedene Versionen f�r HX3 Mainboard, ggf. mit Preset24 oder 1 bis 2 Preset16-Panel<br>
* <b>Preset24.hex</b>              Firmware f�r ATmega8 auf Preset25-Platine<br>
* <b>fpga_DDMMYYYY.bit</b>         FPGA-Konfiguration zum Upload mit HX3 Remote<br>
* <b>*.dat</b>                     Keyscan-Routinen, zum Upload mit HX3 Remote<br>
* <b>*.bin</b>                     SPIN-1 externe I2C Rerverb Programme, zum Upload mit HX3 Remote<br>

### Verzeichnisse

* <b>LATEST</b>                      enth�lt allerletzte Firmware und FPGA-Konfiguration<br>
* <b>DOCS_PDF</b>                  Syntax-Tabelle zur Kommunikation und weitere Unterlagen<br>
* <b>FPGACORES</b>                 FPGA-Konfiguration, Hallprogramme und Scan-Cores<br>
* <b>PLATINEN</b>                  Schaltpl�ne, Best�ckungspl�ne und weitere Unterlagen<br>
* <b>FOR_OEM</b>                   enth�lt alle dateien f�r AVR-Erstprogrammierung, wie oben, jedoch mit eingebautem Bootloader 
(Arduino/AVRdude-kompatibel) f�r Programmierung eines fabrikneuen AVR-
Controllers. Au�erdem: <b>ATmegaBOOT_xx8.c</b> und <b>Makefile</b>, nur f�r Neukompilierung des Bootloaders mit WinAVR n�tig<br>


HX3 Firmware Installation (english)
===================================

HX3 is a full-featured Hammond clone module with physical modelled tone generation from KeyboardPartner 
(http://shop.keyboardpartner.de). Please find here all documentation, schematics, drawings and firmware/configuration updates.

Copy and unzip whole contents of this repo (full download link: https://github.com/heise/HOAX/archive/master.zip) to a new 
folder on your hard disk, for example E:\HX3\LATEST\. See 
http://wiki.keyboardpartner.de/index.php?title=HX3_Remote/Update_Application for details un update procedure. 

FPGA configuration and scan cores may be uploaded by provided HX3 Remote application. 

### directories

* <b>LATEST</b>                    last firmware revisions and FPGA configurations, testing only<br>
* <b>DOCS_PDF</b>                  Syntax table for HX3 COM port, MIDI tables etc. <br>
* <b>FPGACORES</b>                 FPGA configuration, reverb firmware and keyboard scan cores for upload with TeraTerm macro<br>
* <b>PLATINEN</b>                  schematics, mechanical drawings, board and componentlayouts<br>
* <b>TERATERM_MACRO</b>            FPGA and scan core pdate macros for terminal emulator TeraTerm 4.7x (Windows)<br>
* <b>FOR_OEM</b>                   contains all flash files as above, but with built-in bootloader (Arduino/AVRdude compatible). Contains also:
<b>ATmegaBOOT_xx8.c</b> and <b>Makefile</b>, only needed for re-compilation of bootloaders with WinAVR<br>

AdaBoot by Adafruit, modified for ATmega644P(A)06/2012 by Carsten Meyer, cm@ct.de

