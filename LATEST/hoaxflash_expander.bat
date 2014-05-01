ECHO Please copy AVRdude.exe, AVRdude.conf and giveio directory to LATEST directory!
ECHO Flash AVR Controller and EEPROM for MIDI Expander
avrdude -C "avrdude.conf" -pm644p -cstk500v1 -P COM%1 -b57600 -D -U flash:w:"HOAX_expander.hex":i -U eeprom:w:"HOAX_expander.eep":i