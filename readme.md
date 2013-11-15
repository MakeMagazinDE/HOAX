HOAX-Firmware-Installation
==========================

Bitte beachten Sie die ausführliche Anleitung auf http://wiki.keyboardpartner.de!

HEX-Files zum Upload per AVRdude. Zu jedem HEX-File gehört eine EEPROM-Datei mit Endung .EEP!

<b>Flash-Dateien:</b>

HOAX_main.hex             HX3 Standard, ggf. mit Preset24 oder 1 bis 2 Preset16-Panel<br>
HOAX_main_latching.hex	  Latching Presets (einrastende Tasten) mit alter Preset12 MPX Platine<br>
HOAX_main_tabvib.hex      wie Standard, jedoch drei Schalter (V1,V2,CH - V3=V1+V2) statt Drehschalter an PL5<br>
HOAX_main_buttonvib.hex   wie Standard, jedoch Vibrato-Einstellung über die vier Common-Preset-Taster von Panel16 statt Drehschalter<br>
HOAX_main_xb2.hex         Spezialversion für XB2-Einbausatz, nutzt vorhandene Bedienelemente und Display<br>
HOAX_main_xb2_panel16.hex Spezialversion für alten XB2-Einbausatz mit Panel16<br>

<b>in FPGACORES:</b>
main_midi.bit             FPGA-Konfiguration zum Upload mit TeraTerm-Makro<br>
*.dat                     PicoBlaze Keyscan-Routinen, zum Upload mit TeraTerm-Makro<br>
*.bin                     SPIN-1 externe I2C Rerverb Programme, zum Upload mit TeraTerm-Makro<br>

hoaxflash.bat             Batch-Datei, ruft AVRdude mit allen Parametern zum Flashen des Controllers mit "HOAX_main.hex" auf.<br>
                          Parameter COM-Schnittstellennummer, z.B. "C:\HOAX>hoaxflash 14" for COM14 (für Windows)<br>
hoaxflasheeprom.bat       Batch-Datei, wie vor, programmier jedoch zusätzlich mit EEPROM-Datei "HOAX_main.eep" (für Windows)<br>
                          Batch-Dateien sind ggf. für das gewünschte Flash-File anzupassen!<br>

avrdude.exe               AVRdude-Programm zum Firmware-Update über serielle Schnittstelle (für Windows)<br>
libusb0.dll               Wird von manchen Windows-Systemen benötigt, um AVRdude auszuführen<br>
ATmegaBOOT_xx8.c          Nur für Neukompilierung des Bootloaders mit WinAVR nötig<br>
Makefile                  Nur für Neukompilierung des Bootloaders mit WinAVR nötig<br>

<b>Verzeichnisse:</b>
BETA                      enthält allerletzte Firmware und FPGA-Konfiguration<br>
DOCS_PDF                  Syntax-Tabelle zur Kommunikation und weitere Unterlagen<br>
FPGACORES                 FPGA-Konfiguration, Hallprogramme und Scan-Cores<br>
PLATINEN                  Schaltpläne, Bestückungspläne und weitere Unterlagen<br>
TERATERM_MACRO            Update-Makros für empfohlenes Terminal-Programm TeraTerm 4.7x (für Windows)<br>
giveio                    Wird benötigt, um AVRdude auszuführen<br>
FOR_OEM                   enthält alle dateien für AVR-Erstprogrammierung, wie oben, jedoch mit eingebautem Bootloader<br>
                          (Arduino/AVRdude-kompatibel) für Programmierung eines fabrikneuen AVR-Controllers<br>


HOAX-Firmware-Installation (english)
====================================

Please note installation instructions on http://wiki.keyboardpartner.de!

Flash files for serial upload via AVRdude. Please also program the appropiate EEPROM file (ending .EEP).

<b>Flash files:</b>

HOAX_main.hex             standard version with rotary vibrato switch, optional Preset24 or Preset16-Panel<br>
HOAX_main_latching.hex	  version for latching preset keys with old Preset12 MPX board<br>
HOAX_main_tabvib.hex      as standard, but 3 switches (V1,V2,CH - V3=V1+V2) instead of rotary vibrato switch at PL5<br>
HOAX_main_buttonvib.hex   as standard, but vibrato setting (V1..V3, CH) by four Common Preset buttons on Panel16<br>
HOAX_main_xb2.hex         special version for XB2 retrofit kit, uses XB2's buttons and display<br>
HOAX_main_xb2_panel16.hex special version for XB2 retrofit kit, uses installed Panel16<br>

<b>in FPGACORES:</b>

main_midi.bit             FPGA configuration, to be uploaded by TeraTerm macro<br>
*.dat                     PicoBlaze Key scanning routines, to be uploaded by TeraTerm macro<br>
*.bin                     SPIN-1 external I2C Rerverb programs, to be uploaded by TeraTerm macro<br>

hoaxflash.bat             Batch file, invokes AVRdude with all parameters to flah controllers with "HOAX_main.hex"<br>
                          Parameter COM interface number, for example "C:\HOAX>hoaxflash 14" for COM14<br>
hoaxflasheeprom.bat       Batch file, like above, but also with EEPROM-Datei "HOAX_main.eep"<br>

<b>Directories:</b>

BETA                      last firmware revisions and FPGA configurations, testing only<br>
DOCS_PDF                  Syntax table for HX3 COM port, MIDI tables etc. <br>
FPGACORES                 FPGA configuration, reverb firmware and keyboard scan cores for upload with TeraTerm macro<br>
PLATINEN                  schematics, mechanical drawings, board and componentlayouts<br>
TERATERM_MACRO            FPGA and scan core pdate macros for terminal emulator TeraTerm 4.7x (Windows)<br>
giveio                    used by AVRdude flash tool<br>
FOR_OEM                   contains all flash files as above, but with built-in bootloader (Arduino/AVRdude compatible)<br>

AdaBoot by Adafruit, modified for ATmega644P(A)06/2012 by Carsten Meyer, cm@ct.de

