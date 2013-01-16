HX3 Beta Firmware
=================

Siehe https://github.com/heise/HOAX/BETA

Was in diesem Ordner liegt, funktioniert, ist aber noch nicht offiziell freigegeben. Sie sollten wissen, was Sie tun!

Komplette Neuprogrammierung des ATmega644 mit FLASH und EEPROM
sowie Hochladen der beigefügten FPGA-Konfiguration erforderlich,
ggf. auch Neueingabe der Lizenznummern.

Varianten:
HOAX_main.hex           Flash-Dastei zum Upload per AVRdude, Button Presets oder Preset16-Panel
HOAX_main_latching.hex	Flash-Dastei zum Upload per AVRdude, Latching Presets (einrastende Tasten)
HOAX_boot_main.hex      Flash-Dastei komplett mit Bootloader, für OEM-Programmierung über ISP-Programmer

HOAX_main.eep           EEPROM-Datei zum Upload mit AVRdude oder Programmierung über ISP

main_midi.bit           FPGA-Konfiguration 02012013, in Ordner FPGACORES zu kopieren für Upload mit Makro

Erfahrungen und Fehlermeldungen bitte an <info@keyboardpartner.de>
Bitte beachten Sie die ausführliche Anleitung auf http://wiki.keyboardpartner.de!

Letztes Build
Version AVR: #3.20   Version FPGA: 02012013	Reloadable FIR filter for Leslie horn emulation, better "throb"

English
=======

Not released yet, but working beta releases. You should know what you're doing!

Needs complete programming of ATmega644 FLASH and EEPROM,
also reload of FPGA configuration and re-entry of licence numbers.
Please regard installation instructions on http://wiki.keyboardpartner.de!

Variants:
HOAX_main.hex           Flash file for serial upload via AVRdude, button presets or Preset16
HOAX_main_latching.hex	Flash file for serial upload via AVRdude, latching presets
HOAX_boot_main.hex      Flash file complete with Bootloader, for OEM programming by ISP programmer

HOAX_main.eep           EEPROM file for upload via AVRdude or ISP programming

main_midi.bit           FPGA configuration 02012013, to be copied in dierctory FPGACORES


Last Build
Version AVR: #3.20   Version FPGA: 02012013	Reloadable FIR filter for Leslie horn emulation, better "throb"

AdaBoot by Adafruit, modified for ATmega644P(A)06/2012 by Carsten Meyer, cm@ct.de
