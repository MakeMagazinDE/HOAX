HOAX-Firmware-Installation
==========================

Bitte beachten Sie die ausführliche Anleitung auf http://wiki.keyboardpartner.de!

Dateien:
HOAX_main.hex           Flash-Dastei zum Upload per AVRdude, Button Presets oder Preset16-Panel
HOAX_main_latching.hex	Flash-Dastei zum Upload per AVRdude, Latching Presets (einrastende Tasten)
HOAX_main.eep           EEPROM-Datei zum Upload mit AVRdude oder Programmierung über ISP

in FPGACORES:
main_midi.bit           FPGA-Konfiguration zum Upload mit TeraTerm-Makro
*.dat                   PicoBlaze Keyscan-Routinen, zum Upload mit TeraTerm-Makro
*.bin                   SPIN-1 externe I2C Rerverb Programme, zum Upload mit TeraTerm-Makro

hoaxflash.bat           Batch-Datei, ruft AVRdude mit allen Parametern zum Flashen des Controllers mit "HOAX_main.hex" auf.
                        Parameter COM-Schnittstellennummer, z.B. "C:\HOAX>hoaxflash 14" for COM14
hoaxflasheeprom.bat     Batch-Datei, wie vor, jedoch zusätzlich mit EEPROM-Datei "HOAX_main.eep"

avrdude.exe             AVRdude-Programm zum Firmware-Update über serielle Schnittstelle
libusb0.dll             Wird von manchen Windows-Systemen benötigt, um AVRdude auszuführen
ATmegaBOOT_xx8.c        Nur für Neukompilierung des Bootloaders mit WinAVR nötig
Makefile                Nur für Neukompilierung des Bootloaders mit WinAVR nötig

Verzeichnisse:
BETA                    enthält allerletzte Firmware und FPGA-Konfiguration
DOCS_PDF                Syntax-Tabelle zur Kommunikation und weitere Unterlagen
FPGACORES               FPGA-Konfiguration, Hallprogramme und Scan-Cores
PLATINEN                Schaltpläne, Bestückungspläne und weitere Unterlagen
TERATERM_MACRO          Update-Makros für Terminal-Programm TeraTerm
giveio                  Wird benötigt, um AVRdude auszuführen
FOR_OEM                 Alle dateien für AVR-Erstprogrammierung mit Boootloader


HOAX-Firmware-Installation (english)
====================================

Please note installation instructions onhttp://wiki.keyboardpartner.de!

File description:
HOAX_main.hex           Flash file for serial upload via AVRdude, button presets or Preset16
HOAX_main_latching.hex	Flash file for serial upload via AVRdude, latching presets
HOAX_boot_main.hex      Flash file complete with Bootloader, for OEM programming by ISP programmer
HOAX_main.eep           EEPROM file for upload via AVRdude or ISP programming

in FPGACORES:
main_midi.bit           FPGA configuration, to be uploaded by TeraTerm macro
*.dat                   PicoBlaze Key scanning routines, to be uploaded by TeraTerm macro
*.bin                   SPIN-1 external I2C Rerverb programs, to be uploaded by TeraTerm macro

hoaxflash.bat           Batch file, invokes AVRdude with all parameters to flah controllers with "HOAX_main.hex"
                        Parameter COM interface number, for example "C:\HOAX>hoaxflash 14" for COM14
hoaxflasheeprom.bat     Batch file, like above, but also with EEPROM-Datei "HOAX_main.eep"

AdaBoot by Adafruit, modified for ATmega644P(A)06/2012 by Carsten Meyer, cm@ct.de

