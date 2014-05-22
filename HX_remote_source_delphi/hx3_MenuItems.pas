unit hx3_MenuItems;

interface
const

// #############################################################################
// ###             Tabellen aus AVR_menumap.xls übernommen                   ###
// ###              Maximale Werte für Drehgeber-Bedienung                   ###
// #############################################################################

MenuMaxArr: array[0..81] of byte = (
0	,	// 0
127	,	// 1	Upper Drawbars
127	,	// 2	Upper Drawbars
127	,	// 3	Upper Drawbars
127	,	// 4	Upper Drawbars
127	,	// 5	Upper Drawbars
127	,	// 6	Upper Drawbars
127	,	// 7	Upper Drawbars
127	,	// 8	Upper Drawbars
127	,	// 9	Upper Drawbars
5	,	// 10	Vibknob
1	,	// 11	Vibrato ON upper
15	,	// 12	Percussion Mode 0..8
15	,	// 13	Drawbar Display Upper
15	,	// 14	Drawbar Display Lower
1	,	// 15	Vib Lower ON/OFF
127	,	// 16	Lower Drawbars
127	,	// 17	Lower Drawbars
127	,	// 18	Lower Drawbars
127	,	// 19	Lower Drawbars
127	,	// 20	Lower Drawbars
127	,	// 21	Lower Drawbars
127	,	// 22	Lower Drawbars
127	,	// 23	Lower Drawbars
127	,	// 24	Lower Drawbars
127	,	// 25	Pedal 16
127	,	// 26	Pedal 5
127	,	// 27	Pedal 8
100	,	// 28	Pedal Sustain
1	,	// 29	Output Mode
1	,	// 30	Split
250	,	// 31	Leslie Sim und Amp 122 Volume
3	,	// 32	Reverb Tabs 0..3
9	,	// 33	MIDI Channel
3	,	// 34	MIDI Opt, MIDIoptSubArr 0..2=THRU/SEND/SEND-MERGE, 3=DisableControllers
4	,	// 35	MIDI CC Interpreter, 0=NI, 1=Voce, 2=Hamichord 3=Hammond etc.
2	,	// 36	ScanOpt, Bedeutung von Scan-Routine abhängig, bei Fatar und MIDI: Split-Default
13	,	// 37	Transponierwert, -6 bis  +6!
3	,	// 38	Jack Config Standard
3	,	// 39	Jack Config Alternate
200	,	// 40	Vib1 AM   Vibrato AM-Anteil für V1 bis V3, 0..255!
200	,	// 41	Vib1 Dep  Vibrato FM-Modulation für V1 bis V3, 0..255!
200	,	// 42	Vib2 AM   0..255!
200	,	// 43	Vib2 Dep  0..255!
200	,	// 44	Vib3 AM   0..255!
200	,	// 45	Vib3 Dep  0..255!
200	,	// 46	ChDryMix  Chorus Dry-Anteil wenn Chorus ON, 0..255!
200	,	// 47	ChVibMix  Chorus Vibrato-Anteil wenn Chorus ON, 0..255!
250	,	// 48	PercNLvl  Percussion NORMAl Level, 0..255!
200	,	// 49	PercSLvl  Percussion SOFT Level, 0..255!
50	,	// 50	PercLong  Percussion LONG Timer
70	,	// 51	PercShrt  Percussion SHORT Timer
15	,	// 52	Flutter   "Eiern" und Asynchronität der Tonewheels, 0..15
3	,	// 53	Leakage   0=off, 1=minimal sporadisch, 2=kräftig sporadisch, 3=kräftig alle Noten
1	,	// 54	Vintage   Tapering, 0=neu, 1=alte Kondensatoren
1	,	// 55	Drawbar 1' off while Perc on (wie B3) wenn TRUE
3	,	// 56	Drawbar 16' Foldback Mode
120	,	// 57	Tone Equ if TonePot disabled
120	,	// 58	Bass Equ
50	,	// 59	Distortion Preamp
15	,	// 60	untere 4 Bits Noise-Frequenz
15	,	// 61	obere 4 Bits Noise-Länge
250	,	// 62	Amount Reverb 1
250	,	// 63	Amount Reverb 2
250	,	// 64	Amount Reverb 3
50	,	// 65	Horn Speed Slow
50	,	// 66	Rotor Speed Slow
150	,	// 67	Horn Speed Fast
150	,	// 68	Rotor Speed Fast
25	,	// 69	Horn Auslauf
25	,	// 70	Horn Anlauf
50	,	// 71	Rotor Auslauf
50	,	// 72	Rotor Anlauf
250	,	// 73	Leslie Throb
100	,	// 74	Leslie Spread
200	,	// 75	Leslie Balance
7	,	// 76	Scan PB Core Select
1	,	// 77	AnalogDisable
1	,	// 78	Volume Swell Enable, 255=ON
250	,	// 79	fixed Volume Swell value if disabled
1	,	// 80	Tone pot Enable, 0=OFF
1		// 81	Leslie Volume Pot Enable
	);

// #############################################################################
// ###            Display-Überschriften obere Zeile                          ###
// #############################################################################

MenuHeaderArr: array[0..81] of String[31] = (
  '(Leslie)'	,	// 0
  'UpperDB 16   '	,	// 1	Upper Drawbars
  'UpperDB 5 1/3'	,	// 2	Upper Drawbars
  'UpperDB 8    '	,	// 3	Upper Drawbars
  'UpperDB 4    '	,	// 4	Upper Drawbars
  'UpperDB 2 2/3'	,	// 5	Upper Drawbars
  'UpperDB 2    '	,	// 6	Upper Drawbars
  'UpperDB 1 3/5'	,	// 7	Upper Drawbars
  'UpperDB 1 1/3'	,	// 8	Upper Drawbars
  'UpperDB 1    '	,	// 9	Upper Drawbars
  'Vib Knob'	,	// 10	Vibknob
  '(Vib Upper On)'	,	// 11	Vibrato ON upper
  '(Percussion)'	,	// 12	Percussion Mode 0..8
  '(UpperPreset)'	, 	// 13	Drawbar Display Upper
  '(LowerPreset)'	, 	// 14	Drawbar Display Lower
  '(Vib Lower On)'	,	// 15	Vib Lower ON/OFF
  'LowerDB 16   '	,	// 16	Lower Drawbars
  'LowerDB 5 1/3'	,	// 17	Lower Drawbars
  'LowerDB 8    '	,	// 18	Lower Drawbars
  'LowerDB 4    '	,	// 19	Lower Drawbars
  'LowerDB 2 2/3'	,	// 20	Lower Drawbars
  'LowerDB 2    '	,	// 21	Lower Drawbars
  'LowerDB 1 3/5'	,	// 22	Lower Drawbars
  'LowerDB 1 1/3'	,	// 23	Lower Drawbars
  'LowerDB 1    '	,	// 24	Lower Drawbars
  'PedalDB 16   '	,	// 25	Pedal 16
  'PedalDB 5 1/3'	,	// 26	Pedal 5
  'PedalDB 8    '	,	// 27	Pedal 8
  'PedalSustain '	, 	// 28	Pedal Sustain
  '(Audio Jacks A/B)'	, 	// 29	Output Mode
  '(KeyboardSplit)'	, 	// 30	Split
  'Amp122 Volume'	,	// 31	Leslie Sim und Amp 122 Volume
  '(Reverb Prgm)'	, 	// 32	Reverb Tabs 0..3
  'MIDI Channel '	,	// 33	MIDI Channel
  'MIDI Option  '	,	// 34	MIDI Opt, MIDIoptSubArr 0..2=THRU/SEND/SEND-MERGE, 3=DisableControllers
  'MIDI CC Set  ' 	,	// 35	MIDI CC Interpreter, 0=NI, 1=Voce, 2=Hamichord 3=Hammond etc.
  'SplitOption  '	,	// 36	ScanOpt, Bedeutung von Scan-Routine abhängig, bei Fatar und MIDI: Split-Default
  'Transpose    '	,	// 37	Transponierwert, -6 bis  +6!
  'AudioJack Conf A'	,	// 38	Jack Config Standard
  'AudioJack Conf B'	,	// 39	Jack Config Alternate
  'Vib1 LC Age  '	,	// 40	Vib1 AM   Vibrato AM-Anteil für V1 bis V3, 0..255!
  'Vib1 FreqMod '	,	// 41	Vib1 Dep  Vibrato FM-Modulation für V1 bis V3, 0..255!
  'Vib2 LC Age  '	,	// 42	Vib2 AM   0..255!
  'Vib2 FreqMod '	,	// 43	Vib2 Dep  0..255!
  'Vib3 LC Age  '	,	// 44	Vib3 AM   0..255!
  'Vib3 FreqMod'	,	// 45	Vib3 Dep  0..255!
  'ChorDryMix   '	,	// 46	ChDryMix  Chorus Dry-Anteil wenn Chorus ON, 0..255!
  'ChorVibMix   '	,	// 47	ChVibMix  Chorus Vibrato-Anteil wenn Chorus ON, 0..255!
  'PercNormLvl  '	,	// 48	PercNLvl  Percussion NORMAl Level, 0..255!
  'PercSoftLvl  '	,	// 49	PercSLvl  Percussion SOFT Level, 0..255!
  'PercLongTm   '	,	// 50	PercLong  Percussion LONG Timer
  'PercShortTm  '	,	// 51	PercShrt  Percussion SHORT Timer
  'TG Flutter   '	,	// 52	Flutter   "Eiern" und Asynchronität der Tonewheels, 0..15
  'TG Leakage   '	,	// 53	Leakage   0=off, 1=minimal sporadisch, 2=kräftig sporadisch, 3=kräftig alle Noten
  'TG OldCaps   '	,	// 54	Vintage   Tapering, 0=neu, 1=alte Kondensatoren
  'No DB1 @Perc '	,	// 55	Drawbar 1' off while Perc on (wie B3) wenn TRUE
  'DB16 1st Oct'	,	// 56	Drawbar 16' Foldback disable ("all way down") wenn TRUE
  'TrebleEqu    '	,	// 57	Tone Equ if TonePot disabled
  'BassEqu      '	,	// 58	Bass Equ
  'AO28 Tube k2 '	,	// 59	Distortion Preamp
  'ContSpringFlex'	,	// 60	untere 4 Bits Noise-Frequenz
  'ContSpringDamp'	,	// 61	obere 4 Bits Noise-Länge
  'Reverb 1 Lvl '	,	// 62	Amount Reverb 1
  'Reverb 2 Lvl '	,	// 63	Amount Reverb 2
  'Reverb 3 Lvl '	,	// 64	Amount Reverb 3
  'HornSlowTm   '	,	// 65	Horn Speed Slow
  'RotorSlowTm  '	,	// 66	Rotor Speed Slow
  'HornFastTm   '	,	// 67	Horn Speed Fast
  'RotorFastTm  '	,	// 68	Rotor Speed Fast
  'HornRampUp   '	,	// 69	Horn Auslauf
  'RotorRampUp  '	,	// 70	Horn Anlauf
  'HornRampDown '	,	// 71	Rotor Auslauf
  'RotorRampDown'	,	// 72	Rotor Anlauf
  'Rotary Throb '	,	// 73	Leslie Throb
  'Rotary Spread'	,	// 74	Leslie Spread
  'Rotary Balnce'	,	// 75	Leslie Balance
  'Scan Board   '	,	// 76	Scan PB Core Select
  'ExpanderMode '	,	// 77	AnalogDisable
  'SwellInEna   '	,	// 78	Volume Swell Enable, 255=ON
  'FixedSwell   '	,	// 79	fixed Volume Swell value if disabled
  'TonePotEna   '	,	// 80	Tone pot Enable, 0=OFF
  'LesVolPotEna '		// 81	Leslie Volume Pot Enable
);

// Bei Änderungen Konstante Adressen ebenfalls ändern!
// EEscancore[@EE_Organ_Init+76] usw.
// c_edit_ParamArrLen auf Array-Länge setzen!

// #############################################################################
// ###                       Display untere Zeile                            ###
// #############################################################################

MenuParamStrArr: array[0..40] of String[12] = (
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

LeslieDescArr: array[0..63] of String[31] = (
  '(Amp Volume)',
  '(Speed Horn)',
  '(Speed Rotor)',
  '(Config Sw)',
  'Lvl Tap Main',
  'Lvl Tap Near Cab 4x',
  'Lvl Tap Far',
  'Lvl Input',
  'Lvl Rotor',
  'Throb Frq Horn',
  'Throb Frq Rotor',
  'Crossover Frequ',
  'Allpass Horn Frequ',
  'Initial Room Dly Cab Near',
  'Initial Room Dly Far',
  'n.v.',
  'LFO Mod Horn Main Left',
  'LFO Mod Horn Main Left',
  'LFO Mod Horn Cab fx4',
  'LFO Mod Horn Refl L Near',
  'LFO Mod Horn Refl R Near',
  'LFO Mod Horn Refl L Far',
  'LFO Mod Horn Refl R Far',
  'LFO Mod Horn Throb L',
  'LFO Mod Horn Throb R',
  'LFO Mod Rotor Main',
  'LFO Mod Rotor Refl',
  'LFO Mod Rotor Throb',
  'n.v.',
  'n.v.',
  'n.v.',
  'n.v.',
  'LFO Add DlyOfs Horn Main Left',
  'LFO Add DlyOfs Horn Main Left',
  'LFO Add DlyOfs Horn Cab fx4',
  'LFO Add DlyOfs Horn Refl L Near',
  'LFO Add DlyOfs Horn Refl R Near',
  'LFO Add DlyOfs Horn Refl L Far',
  'LFO Add DlyOfs Horn Refl R Far',
  'LFO Add ValOfs Horn Throb L',
  'LFO Add ValOfs Horn Throb R',
  'LFO Add DlyOfs Rotor Main',
  'LFO Add DlyOfs Rotor Refl',
  'LFO Add ValOfs Rotor Throb',
  'n.v.',
  'n.v.',
  'n.v.',
  'n.v.',
  'LFO PhaseOfs Horn Main Left',
  'LFO PhaseOfs Horn Main Left',
  'LFO PhaseOfs Horn Cab fx4',
  'LFO PhaseOfs Horn Refl L  Near',
  'LFO PhaseOfs Horn Refl R Near',
  'LFO PhaseOfs Horn Refl L Far',
  'LFO PhaseOfs Horn Refl R Far',
  'LFO LevelOfs Horn Throb Left',
  'LFO LevelOfs Horn Throb Right',
  'LFO PhaseOfs Rotor Main',
  'LFO PhaseOfs Rotor Refl',
  'LFO LevelOfs Rotor Throb',
  'n.v.',
  'n.v.',
  'n.v.',
  'n.v.'
);

MIDIdescArr: array[0..127] of String[31] = (
  '$00   0 Bank Select',
  '$01   1 Modulation Wheel',
  '$02   2 Breath Control',
  '$03   3 CC #3',
  '$04   4 Foot Controller',
  '$05   5 Portamento Time',
  '$06   6 Data Entry Slider',
  '$07   7 Main Volume',
  '$08   8 Stereo Balance',
  '$09   9 CC #9',
  '$0A  10 Pan',
  '$0B  11 Expression',
  '$0C  12 Effect Control 1',
  '$0D  13 Effect Control 2',
  '$0E  14 CC #14',
  '$0F  15 CC #15',
  '$10  16 Slider 1',
  '$11  17 Slider 2',
  '$12  18 Slider 3',
  '$13  19 Slider 4',
  '$14  20 CC #20',
  '$15  21 CC #21',
  '$16  22 CC #22',
  '$17  23 CC #23',
  '$18  24 CC #24',
  '$19  25 CC #25',
  '$1A  26 CC #26',
  '$1B  27 CC #27',
  '$1C  28 CC #28',
  '$1D  29 CC #29',
  '$1E  30 CC #30',
  '$1F  31 CC #31',
  '$20  32 Bank Select',
  '$21  33 Modulation Wheel',
  '$22  34 Breath Control',
  '$23  35 CC #3',
  '$24  36 Foot Controller',
  '$25  37 Portamento Time',
  '$26  38 Data Entry Slider',
  '$27  39 Main Volume',
  '$28  40 Stereo Balance',
  '$29  41 CC #9',
  '$2A  42 Pan',
  '$2B  43 Expression (sub)',
  '$2C  44 Effect Control 1',
  '$2D  45 Effect Control 2',
  '$2E  46 CC #14',
  '$2F  47 CC #15',
  '$30  48 CC #16',
  '$31  49 CC #17',
  '$32  50 CC #18',
  '$33  51 CC #19',
  '$34  52 CC #20',
  '$35  53 CC #21',
  '$36  54 CC #22',
  '$37  55 CC #23',
  '$38  56 CC #24',
  '$39  57 CC #25',
  '$3A  58 CC #26',
  '$3B  59 CC #27',
  '$3C  60 CC #28',
  '$3D  61 CC #29',
  '$3E  62 CC #30',
  '$3F  63 CC #31',
  '$40  64 Hold on/off',
  '$41  65 Portamento on/off',
  '$42  66 Sustenuto on/off',
  '$43  67 Soft on/off',
  '$44  68 Legato on/off',
  '$45  69 Hold 2 on/off',
  '$46  70 Sound Variation',
  '$47  71 Sound Timbre',
  '$48  72 Sound Release Time',
  '$49  73 Sound Attack Time',
  '$4A  74 Sound Brighness',
  '$4B  75 Sound Control 6',
  '$4C  76 Sound Control 7',
  '$4D  77 Sound Control 8',
  '$4E  78 Sound Control 9',
  '$4F  79 Sound Control 10',
  '$50  80 General Purpose Btn',
  '$51  81 General Purpose Btn',
  '$52  82 General Purpose Btn',
  '$53  83 General Purpose Btn',
  '$54  84 Undefined on/off',
  '$55  85 Undefined on/off',
  '$56  86 Undefined on/off',
  '$57  87 Undefined on/off',
  '$58  88 Undefined on/off',
  '$59  89 Undefined on/off',
  '$5A  90 Undefined on/off',
  '$5B  91 Effects Level',
  '$5C  92 Tremulo Level',
  '$5D  93 Chorus Level',
  '$5E  94 Celeste Level',
  '$5F  95 Phaser Level',
  '$60  96 Data entry +1',
  '$61  97 Data entry -1',
  '$62  98 NRPN',
  '$63  99 NRPN',
  '$64 100 RPN',
  '$65 101 RPN',
  '$66 102 Undefined',
  '$67 103 Undefined',
  '$68 104 Undefined',
  '$69 105 Undefined',
  '$6A 106 Undefined',
  '$6B 107 Undefined',
  '$6C 108 Undefined',
  '$6D 109 Undefined',
  '$6E 110 Undefined',
  '$6F 111 Undefined',
  '$70 112 Undefined',
  '$71 113 Undefined',
  '$72 114 Undefined',
  '$73 115 Undefined',
  '$74 116 Undefined',
  '$75 117 Undefined',
  '$76 118 Undefined',
  '$77 119 Undefined',
  '$78 120 All Sound Off',
  '$79 121 All Controllers Off',
  '$7A 122 Local Keybd On/Off',
  '$7B 123 All Notes Off',
  '$7C 124 Omni Mode Off',
  '$7D 125 Omni Mode On',
  '$7E 126 Monophonic Mode On',
  '$7F 127 Polyphonic Mode On'
  );

ButtonDescArr: array[0..19] of String[31] = (
  'Perc On/Off',
  'Perc Soft',
  'Perc Fast',
  'Perc 3rd',
  'Vib On Upper',
  'Vib On Lower',
  'Leslie Run',
  'Leslie Slow/Fast',
  '(not assigned)',
  '(not assigned)',
  '(not assigned)',
  '(not assigned)',
  '(not assigned)',
  '(not assigned)',
  'Reverb I',
  'Reverb II',
  'Jack Config A/B',
  'Keyboard Split On/Off',
  '(not assigned)',
  '(not assigned)'
  );

implementation
end.
