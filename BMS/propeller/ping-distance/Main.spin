{{
─────────────────────────────────────────────────
File: Main.spin
Version: 1.0
Copyright (c) 2012, Carl Edwards
See end of file for terms of use.
─────────────────────────────────────────────────
}}

{
  This example triggers a Ping Sensor on pin 25 and displays and LED bar graph
  of the distance being measured.
}

CON
  _clkmode = xtal1 + pll16x     
  _xinfreq = 5_000_000

  CLK_FREQ = ((_clkmode-xtal1)>>6)*_xinfreq
  MS_001 = CLK_FREQ / 1_000

VAR

OBJ
  Pst           : "Parallax Serial Terminal.spin"
  Ping          : "Ping"

PUB Main | pingRange
  dira[23..16]~~ 'set the LED pins to be output P23 - P16
  Pst.Start(115_200)

  REPEAT
    pingRange := Ping.Inches(25)
    Pst.Dec(pingRange)
    Pst.NewLine

    IF pingRange < 1
      OUTA[23..16] := %00000000
    ELSEIF pingRange < 3
      OUTA[23..16] := %00000001
    ELSEIF pingRange < 6
      OUTA[23..16] := %00000011
    ELSE
      OUTA[23..16] := %11111111

    Pause(200)

PUB Pause(ms) | t
  t := cnt - 1088
  repeat ms
    waitcnt(t += MS_001)

{{
┌──────────────────────────────────────────────────────────────────────────────────────┐
│                           TERMS OF USE: MIT License                                  │                                                            
├──────────────────────────────────────────────────────────────────────────────────────┤
│Permission is hereby granted, free of charge, to any person obtaining a copy of this  │
│software and associated documentation files (the "Software"), to deal in the Software │ 
│without restriction, including without limitation the rights to use, copy, modify,    │
│merge, publish, distribute, sublicense, and/or sell copies of the Software, and to    │
│permit persons to whom the Software is furnished to do so, subject to the following   │
│conditions:                                                                           │
│                                                                                      │
│The above copyright notice and this permission notice shall be included in all copies │
│or substantial portions of the Software.                                              │
│                                                                                      │
│THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED,   │
│INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A         │
│PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT    │
│HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION     │
│OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE        │
│SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.                                │
└──────────────────────────────────────────────────────────────────────────────────────┘
}}