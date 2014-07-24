unit hx3_MenuItems;

interface

type

MenuEntry = record
  ValueMin: Integer;
  ValueMax: Integer;
  StringIdx: Integer;
  DropDownIdx: Integer;
  DropDownLen: Integer;
end;

const

// #############################################################################
// ###             Tabellen aus AVR_menumap.xls übernommen                   ###
// ###              Maximale Werte für Drehgeber-Bedienung                   ###
// #############################################################################


// #############################################################################
// ###            Display-Überschriften obere Zeile                          ###
// #############################################################################


// #############################################################################
// ###                       Display untere Zeile                            ###
// #############################################################################

xMenuParamStrArr: array[0..40] of String[12] = (
  'NI B4'	,	// 0
  'Voce'	,	// 1
  'Hamichord'	,	// 2
  'Hammond XK'	,	// 3
  'Hammond SK'	,	// 4
  'Custom CC'	,	// 5
  'PedalToLower'	,	// 6
  'LowerToUpper'	,	// 7
  'PedalToUpper'	,	// 8
  'OrganScan61'	,	// 9
  'MIDI Input'	,	// 10
  'FatarScan'	,	// 11
  'Scan16/44'	,	// 12
  'Scan16/49'	,	// 13
  'Scan16/61'	,	// 14
  'HardwareTest'	,	// 15
  'OptoScan/XB2'	,	// 16
  'Clean'	,	// 17
  'NewOrgan'	,	// 18
  'OldOrgan'	,	// 19
  'SleazyOrgan'	,	// 20
  'ReceiveThru'	,	// 21 Opt 0
  'ReceiveSend'	,	// 22 Opt 1
  'RcvSendMerge'	,	// 23 Opt 2
  'RcvSndMgNoCC'	,	// 24 Opt 3
  'Config A'	,	// 25 Bass Ena = OFF
  'Config B'	,	// 26 Bass Ena = ON
  'RotaryStereo'	,	// 27
  'RotarySt+Ped'	,	// 28
  'Organ/Pedal'	,	// 29
  'Amp122/Pedal'	,	// 30
  'Foldback'	,	// 31
  'Full'	,	// 32
  'Foldb muted'	,	// 33
  'Full muted',		// 34
  'V1',		// 35
  'C1',
  'V2',		// 37
  'C2',
  'V3',		// 39
  'C3'
);



ButtonDescArr: array[0..17] of String[31] = (
  '900=Perc On/Off',      // 900
  '901=Perc Soft',
  '902=Perc Fast',
  '903=Perc 3rd',
  '904=Vib On Upper',
  '905=Vib On Lower',
  '906=Leslie Run',
  '907=Leslie Slow/Fast', // 907
  '908=(not assigned)',
  '909=(not assigned)',
  '910=(not assigned)',   // 910
  '911=(not assigned)',
  '912=(not assigned)',
  '913=(not assigned)',
  '914=Reverb I',         // 914
  '915=Reverb II',
  '916=Jack Config A/B',
  '917=Keyboard Split On/Off'
  );

implementation
end.
