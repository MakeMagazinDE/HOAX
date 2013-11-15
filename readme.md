HOAX-Firmware-Installation
==========================

Bitte beachten Sie die ausführliche Anleitung auf http://wiki.keyboardpartner.de!

HEX-Files zum Upload per AVRdude. Zu jedem HEX-File gehört eine EEPROM-Datei mit Endung .EEP!

## <b>Flash-Dateien:</b>

* '<b>HOAX_main.hex</b>             HX3 Standard, ggf. mit Preset24 oder 1 bis 2 Preset16-Panel'<br>
* <b>HOAX_main_latching.hex</b>	  Latching Presets (einrastende Tasten) mit alter Preset12 MPX Platine<br>
* <b>HOAX_main_tabvib.hex</b>      wie Standard, jedoch drei Schalter (V1,V2,CH - V3=V1+V2) statt Drehschalter an PL5<br>
* <b>HOAX_main_buttonvib.hex</b>   wie Standard, jedoch Vibrato-Einstellung über die vier Common-Preset-Taster von Panel16 statt Drehschalter<br>
* <b>HOAX_main_xb2.hex</b>         Spezialversion für XB2-Einbausatz, nutzt vorhandene Bedienelemente und Display<br>
* <b>HOAX_main_xb2_panel16.hex</b> Spezialversion für alten XB2-Einbausatz mit Panel16<br>

## <b>in FPGACORES:</b>

* <b>main_midi.bit</b>             FPGA-Konfiguration zum Upload mit TeraTerm-Makro<br>
* <b>*.dat</b>                     PicoBlaze Keyscan-Routinen, zum Upload mit TeraTerm-Makro<br>
* <b>*.bin</b>                     SPIN-1 externe I2C Rerverb Programme, zum Upload mit TeraTerm-Makro<br>

* <b>hoaxflash.bat</b>             Batch-Datei, ruft AVRdude mit allen Parametern zum Flashen des Controllers mit "HOAX_main.hex" auf.<br>
                          Parameter COM-Schnittstellennummer, z.B. "C:\HOAX>hoaxflash 14" for COM14 (für Windows)<br>
* <b>hoaxflasheeprom.bat</b>       Batch-Datei, wie vor, programmier jedoch zusätzlich mit EEPROM-Datei "HOAX_main.eep" (für Windows)<br>
                          Batch-Dateien sind ggf. für das gewünschte Flash-File anzupassen!<br>

* <b>avrdude.exe</b>               AVRdude-Programm zum Firmware-Update über serielle Schnittstelle (für Windows)<br>
* <b>libusb0.dll</b>               Wird von manchen Windows-Systemen benötigt, um AVRdude auszuführen<br>
* <b>ATmegaBOOT_xx8.c</b>          Nur für Neukompilierung des Bootloaders mit WinAVR nötig<br>
* <b>Makefile</b>                  Nur für Neukompilierung des Bootloaders mit WinAVR nötig<br>

## <b>Verzeichnisse:</b>

* <b>BETA</b>                      enthält allerletzte Firmware und FPGA-Konfiguration<br>
* <b>DOCS_PDF</b>                  Syntax-Tabelle zur Kommunikation und weitere Unterlagen<br>
* <b>FPGACORES</b>                 FPGA-Konfiguration, Hallprogramme und Scan-Cores<br>
* <b>PLATINEN</b>                  Schaltpläne, Bestückungspläne und weitere Unterlagen<br>
* <b>TERATERM_MACRO</b>            Update-Makros für empfohlenes Terminal-Programm TeraTerm 4.7x (für Windows)<br>
* <b>giveio</b>                    Wird benötigt, um AVRdude auszuführen<br>
* <b>FOR_OEM</b>                   enthält alle dateien für AVR-Erstprogrammierung, wie oben, jedoch mit eingebautem Bootloader<br>
                          (Arduino/AVRdude-kompatibel) für Programmierung eines fabrikneuen AVR-Controllers<br>


HOAX-Firmware-Installation (english)
====================================

Please note installation instructions on http://wiki.keyboardpartner.de!

Flash files for serial upload via AVRdude. Please also program the appropiate EEPROM file (ending .EEP).

## <b>Flash files:</b>

* '<b>HOAX_main.hex</b>             standard version with rotary vibrato switch, optional Preset24 or Preset16-Panel<br>'
* <b>HOAX_main_latching.hex</b>	  version for latching preset keys with old Preset12 MPX board<br>
* <b>HOAX_main_tabvib.hex</b>      as standard, but 3 switches (V1,V2,CH - V3=V1+V2) instead of rotary vibrato switch at PL5<br>
* <b>HOAX_main_buttonvib.hex</b>   as standard, but vibrato setting (V1..V3, CH) by four Common Preset buttons on Panel16<br>
* <b>HOAX_main_xb2.hex</b>         special version for XB2 retrofit kit, uses XB2's buttons and display<br>
* <b>HOAX_main_xb2_panel16.hex</b> special version for XB2 retrofit kit, uses installed Panel16<br>

## <b>in FPGACORES:</b>

* <b>main_midi.bit</b>             FPGA configuration, to be uploaded by TeraTerm macro<br>
* <b>*.dat</b>                     PicoBlaze Key scanning routines, to be uploaded by TeraTerm macro<br>
* <b>*.bin</b>                     SPIN-1 external I2C Rerverb programs, to be uploaded by TeraTerm macro<br>

* <b>hoaxflash.bat</b>             Batch file, invokes AVRdude with all parameters to flah controllers with "HOAX_main.hex"<br>
                          Parameter COM interface number, for example "C:\HOAX>hoaxflash 14" for COM14<br>
* <b>hoaxflasheeprom.bat</b>       Batch file, like above, but also with EEPROM-Datei "HOAX_main.eep"<br>

## <b>Directories:</b>

* <b>BETA</b>                      last firmware revisions and FPGA configurations, testing only<br>
* <b>DOCS_PDF</b>                  Syntax table for HX3 COM port, MIDI tables etc. <br>
* <b>FPGACORES</b>                 FPGA configuration, reverb firmware and keyboard scan cores for upload with TeraTerm macro<br>
* <b>PLATINEN</b>                  schematics, mechanical drawings, board and componentlayouts<br>
* <b>TERATERM_MACRO</b>            FPGA and scan core pdate macros for terminal emulator TeraTerm 4.7x (Windows)<br>
* <b>giveio</b>                    used by AVRdude flash tool<br>
* <b>FOR_OEM</b>                   contains all flash files as above, but with built-in bootloader (Arduino/AVRdude compatible)<br>

AdaBoot by Adafruit, modified for ATmega644P(A)06/2012 by Carsten Meyer, cm@ct.de

