HX3 Latest Firmware
===================

Siehe https://github.com/heise/HOAX/LATEST

Was in diesem Ordner liegt, funktioniert, ist aber noch nicht offiziell freigegeben. Sie sollten wissen, was Sie tun!

Komplette Neuprogrammierung des ATmega644 mit FLASH und EEPROM sowie Hochladen der beigefügten FPGA-Konfiguration 
und SCan Cores erforderlich, ggf. auch Neueingabe der Lizenznummern. Beigefügtes Makro lädt diese Dateien, Pfad sollte
"C:\HOAX\LATEST\..." sein.

### Varianten:
<b>HOAX_main.hex</b>           Flash-Dastei zum Upload per AVRdude, Button Presets oder Preset16-Panel<br>
<b>HOAX_expander.hex</b> 	    Flash-Dastei zum Upload per AVRdude, Expander-Version<br>

<b>HOAX_main.eep</b>            EEPROM-Datei zum Upload mit AVRdude oder Programmierung über ISP<br>
<b>HOAX_expander.eep</b>        EEPROM-Datei zum Upload mit AVRdude oder Programmierung über ISP<br>

main_midi.bit           FPGA-Konfiguration 01052014, in Ordner FPGACORES zu kopieren für Upload mit Makro

Erfahrungen und Fehlermeldungen bitte an <info@keyboardpartner.de>
Bitte beachten Sie die ausführliche Anleitung auf http://wiki.keyboardpartner.de!

### Letztes Build

AVR:  #3.51       Neu: Vibrato, Stereo-Leslie, erweiterte Menüs, konfiogurierbare Ausgänge
FPGA: #01052014   Erforderlich für #3.51

## English

Not released yet, but working beta releases. You should know what you're doing!

Usually needs complete programming of ATmega644 FLASH and EEPROM, scan cores,
also reload of FPGA configuration and re-entry of licence numbers.
Please regard installation instructions on http://wiki.keyboardpartner.de!

Variants:
<b>HOAX_main.hex</b>           Flash file for serial upload via AVRdude, button presets or Preset16
<b>HOAX_main_latching.hex</b>	Flash file for serial upload via AVRdude, latching presets
<b>HOAX_boot_main.hex</b>      Flash file complete with Bootloader, for OEM programming by ISP programmer

<b>HOAX_main.eep</b>           EEPROM file for upload via AVRdude or ISP programming

<b>main_midi.bit</b>           FPGA configuration 01052014


Last Build
AVR:  #3.31       Event-based user interface, no more MIDI-Lockout
FPGA: #03042013   Reloadable FIR filter for Leslie horn emulation, better "throb"

AdaBoot by Adafruit, modified for ATmega644P(A)06/2012 by Carsten Meyer, cm@ct.de
