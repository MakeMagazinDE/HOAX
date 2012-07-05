HOAX_BOOT
=========

AdaBoot by Adafruit modified for ATmega644P(A)
by Carsten Meyer, cm@ct.de

Vorbereitung:
-------------

- Diesen gesamten Ordner \HOAX_BOOT auf Laufwerk C: kopieren
- Pfad C:\HOAX_BOOT\...

Vorbereiten des FTDI-Treibers:
------------------------------

Nur falls noch nicht installiert

- für das FTDI-Kabel TTL-232 5V:
  VCP-Treiber von http://www.ftdichip.com/Drivers/VCP.htm herunterladen,
  entpacken, Kabel an USB anschließen,
  VCP-Treiber für das neu erkannte USB-Device auswählen
- Geräte-Manager öffnen, zugewiesenen COM-Port des FTDI-Kabels notieren
  und mit Text-Editor in Batch-Datei "hoaxflash.bat"
  unter "-P COMx" mit x=COM-Port-Nummer eintragen (wichtig! - voreingestellt ist 6)


Flashen des Controllers per Bootloader:
---------------------------------------

Für Updates/Änderungen der Controller-Firmware

- Ggf. aktuelles "HOAX_main.hex" und "HOAX_main.eep" in dieses Verzeichnis kopieren
- Platine mit Strom versorgen (5V/250mA)
- JP5 setzen
- ISP-Kabel von PL1 abziehen, Jumper auf Position R quer auf PL1 setzen,
  das sind die beiden mittleren Pins 5 und 6 genau in der Mitte
- FTDI-Kabel an HOAX-Platine anschließen; GND = Pin1 = schwarzes Kabel!
- Jumper auf Position R abziehen, LED1 muss 5x aufblitzen.
  Sofort danach in Windows Command Prompt "hoaxflash.bat" aufrufen
- AVRdude programmiert Controller mit HEX- und EEP-Datei seriell
- Falls "out of sync" oder "verification error", Vorgang wiederholen



Aufspielen der FPGA-Konfiguration:
==================================

Für Updates/Änderungen der FPGA-Konfiguration (HOAX-Sound-Engine)

- Ggf. aktuelle "main_midi.bit", "HX_*.dat" und "hoax3rev.bin" in Unterverzeichnis "FPGACORES" kopieren
- Terminal-Programm TeraTerm von http://www.heise.de/download/teraterm-pro.html
  downloaden und istallieren (falls nicht schon vorhanden)
- In der Makro-Datei "HOAX_UPLOAD.TTL" in "\TERATERM_MACRO"
  Pfade "mypath=..." konrollieren (mehrfach vorhanden, mit Texeditor zu öffnen)
  und ggf. auf aktuellen Pfad zu "<drive>:\HOAX_BOOT\FPGACORES" setzen (Default C:\HOAX_BOOT\FPGACORES)
- TeraTerm starten
- Unter "Setup/Serial Port..." oben notierten COM-Port des FTDI-Kabels eintragen, sowie
  Baud rate 57600, Data 8 bit, Parity none, Stop 1 bit,
  Flow control none (falls nicht schon geschehen)
- Unter "Setup/Terminal..." einstellen: Receive CR, Transmit CRLF, Local echo (falls nicht schon geschehen)
- ggf. mit ALT-N neue Verbindung, wenn DISCONNECTED
- Für spätere Updates Einstellungen unter "Setup/Save setup" Teraterm-Setup in TERATERM.INI sichern
- Makro "HOAX_UPLOAD.TTL" mit "Control/Macro..." öffnen/ausführen, Anweisungen folgen
- Bei Frage nach Scan Core folgende Ziffern eingeben:
	Core 0 = Chained OrganScan61 (alt, von Projekt Klangcomputer), mit ein bis drei Platinen in Reihe
	Core 1 = MIDI receive only
	Core 2 = ScanFatar2 mit ein oder zwei Manualen
	Core 3 = Scan4014-16/Bass parallel 2x 44 Tasten, 2x 3 Platinen
	Core 4 = Scan4014-16/Bass parallel 2x 49 Tasten, 2x 3 Platinen
	Core 5 = Scan4014-16/Bass parallel 2x 61 Tasten, 2x 4 Platinen
	         oder ein bis drei Scan4014-61 parallel
	Core 6 = nicht benutzt
	Core 7 = OptoScan von B.A.S.S.
- Damit AVRdude wieder auf das FTDI-Kabel zugreifen kann, muss TeraTerm beendet
  oder Verbindung mit ALT-I unterbrochen werden!


nur für OEM:
============

Flashen des Bootloaders und des Main-Programms:
-----------------------------------------------

Dieser Vorgang programmiert Version 3.0 der Firmware als Basisversion in den
völlig neuen Controller

- JP5 setzen, Platine mit Strom versorgen (5V/250mA)
- ATmega644P per ISP-Programmer an PL1 mit HEX-Files "HOAX_boot_main.hex"
  "HOAX_main.eep" programmieren,
  Fuse Setting: SPIEN, BOOTSZ1, BOOTRST, CKSEL3, BODLEVEL0, BODLEVEL1, BOOTLOCK11 (BLB11)


Erstellen des Bootloaders:
--------------------------

Nur falls Bootloader selbst geändert wurde:
- ggf. WinAVR (open source) installieren
- Command Prompt aufrufen
- "make hoaxboot" ausführen


Flashen des Bootloaders:
------------------------

Bitte beachten: Der Controller wird vom Hersteller fertig programmiert ausgeliefert.
Nur bei neuem Controller (noch ohne Bootloader) ausführen:
- JP5 setzen, Platine mit Strom versorgen (5V/250mA)
- ATmega644P per ISP-Programmer an PL1 mit HEX-File "HOAX_boot.hex" programmieren,
  Fuse Setting: SPIEN, BOOTSZ1, BOOTRST, CKSEL3, BODLEVEL0, BODLEVEL1, BOOTLOCK11 (BLB11)
