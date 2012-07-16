HOAX-Firmware-Installation
==========================

AdaBoot by Adafruit modified for ATmega644P(A)
06/2012 by Carsten Meyer, cm@ct.de

Die Installation der HOAX-Platine setzt einen Windows-PC (ab Win98) mit USB voraus.


Vorbereitung:
-------------

- Diesen gesamten Ordner auf Laufwerk C: kopieren und in "\HOAX" umbenennen
- Pfad dieser Datei also "C:\HOAX\README.TXT"


Vorbereiten des FTDI-Treibers:
------------------------------

Nur falls noch nicht installiert - wird aber für die folgenden Aktionen gebraucht!

- für das FTDI-Kabel TTL-232 5V:
  VCP-Treiber von http://www.ftdichip.com/Drivers/VCP.htm herunterladen,
  entpacken, Kabel an USB anschließen,
  VCP-Treiber für das neu erkannte USB-Device auswählen
- Geräte-Manager öffnen, zugewiesenen COM-Port des FTDI-Kabels notieren
  und mit Text-Editor in Batch-Datei "hoaxflash.bat"
  unter "-P COMx" mit x=COM-Port-Nummer eintragen (wichtig! - voreingestellt ist 6)



Inbetriebnahme
--------------

Setzt einen installierten FTDI VCP Treiber voraus

- Terminal-Programm TeraTerm von http://www.heise.de/download/teraterm-pro.html
  downloaden und istallieren (falls nicht schon vorhanden)
- TeraTerm starten
- Unter "Setup/Serial Port..." oben notierten COM-Port des FTDI-Kabels eintragen, sowie
  Baud rate 57600, Data 8 bit, Parity none, Stop 1 bit,
  Flow control none (falls nicht schon geschehen)
- Unter "Setup/Terminal..." einstellen: Receive CR, Transmit CRLF, Local echo
- ggf. mit ALT-N neue Verbindung, wenn DISCONNECTED
- Für spätere Updates Einstellungen unter "Setup/Save setup" Teraterm-Setup in TERATERM.INI sichern

Im Auslieferungszustand (oder nach dem Flashen des Controllers und Aufspielen der FPGA-Konfiguration
mit Scan-Core 6) liefert die Platine nach dem Einschalten auf dem Terminal die Meldung

#0:254=3.02 [HOAX 3 XC3S700 by CM 09/2010 SwitchTb]
#0:252=0 [HW check]
#0:252=1 [PCA9532 Btn/LED]
#0:252=4 [PCA9555 Switches]
#0:252=5 [PCA9554A VibChorus]
#0:252=7 [MIDI CtrlMap d3c/NI]
#0:9910=0 [FPGA_DONE OK Signature $21022012 found]
#0:9900=6 [Load PB Core ......... HW TEST core Rev $01 found]
#0:242=1234567 [Serial Number]

und an den Audio-Ausgängen einen Test-Akkord C-Dur, ein einzelnes C auf Bass
und Testimpulse ("Schieberegister") an den PL14 und PL15.
PL16 führt einige Digital-Audio-Signale (für zukünftige Erweiterungen).

Notieren Sie Ihre Seriennummer, falls Sie eine Lizenz für die Orgel-Vollversion
oder die Leslie-Simulation erwerben möchten.

Nach erfolgreichem Test den Scan-Core mit den Befehlen

WEN=1
519=x

auf den gewünschten Scan-Core "x" (0..7) umstellen:

	Core 0 = Chained OrganScan61 (alt, von Projekt Klangcomputer), mit ein bis drei Platinen in Reihe
	Core 1 = MIDI receive only
	Core 2 = ScanFatar2 mit ein oder zwei Manualen
	Core 3 = Scan4014-16/Bass parallel 2x 44 Tasten, 2x 3 Platinen
	Core 4 = Scan4014-16/Bass parallel 2x 49 Tasten, 2x 3 Platinen
	Core 5 = Scan4014-16/Bass parallel 2x 61 Tasten, 2x 4 Platinen
	         oder ein bis drei Scan4014-61 parallel
	Core 6 = Test-Routine (Auslieferungszustand)
	Core 7 = OptoScan von B.A.S.S.

Ein Reset kann jederzeit mit dem Befehl

9999

ausgeführt werden. <RETURN> am Zeilenende nicht vergessen!

Achtung: Das nicht lizensierte Leslie schaltet sich nach etwa zwei Minuten ab.




Leslie/Orgel-Lizenznummer eingeben
----------------------------------

Sie erhalten bei www.keyboardpartner.de gegen Gebühr Lizenznummern für Ihre Platine,
die die Leslie- und Orgel-Versionen dauerhaft freischalten.

- Nachdem Sie Ihre Lizenznummer(n) erhalten haben, stellen Sie wie oben beschrieben eine
  Verbindung mit TeraTerm her (Baud rate 57600, Data 8 bit, Parity none, Stop 1 bit).
- Führen Sie nun das Macro "HOAX_LICENSE.ttl" mit "Control/Macro..." aus und folgen den Anweisungen.
- Wird das Lizenznummer-Eingabefeld leer gelassen, erfolgt keine Änderung der jeweiligen Lizenz;
  es ist also möglich, die Lizenz für Orgel und Leslie getrennt zu erwerben und einzutragen.
- Das Macro zeigt eine erfolgreiche Eingabe an.




Flashen des Controllers per Bootloader:
---------------------------------------

Nur für Updates/Änderungen der Controller-Firmware!

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
----------------------------------

Nur für Updates/Änderungen der FPGA-Konfiguration (HOAX-Sound-Engine)!

- Ggf. aktuelle "main_midi.bit", "HX_*.dat" und "hoax3rev.bin" in Unterverzeichnis "FPGACORES" kopieren
- Terminal-Programm TeraTerm von http://www.heise.de/download/teraterm-pro.html
  downloaden und istallieren (falls nicht schon vorhanden)
- In der Makro-Datei "HOAX_UPLOAD.TTL" in "\TERATERM_MACRO"
  Pfade "mypath=..." konrollieren (mehrfach vorhanden, mit Texeditor zu öffnen)
  und ggf. auf aktuellen Pfad zu "<drive>:\HOAX\FPGACORES" setzen (Default C:\HOAX\FPGACORES)
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

Zum erstmaligen Flashen des Controllers bitte ReadMe in Verzeichnis "FOR_OEM" beachten.

