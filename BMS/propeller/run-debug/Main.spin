
CON
  _clkmode = xtal1 + pll16x     
  _xinfreq = 5_000_000

  CLK_FREQ = ((_clkmode-xtal1)>>6)*_xinfreq
  MS_001 = CLK_FREQ / 1_000

VAR

OBJ
  Buttons       : "Touch Buttons.spin"
  Pst           : "Parallax Serial Terminal.spin"

PUB Main | buttonState, lastButtonState
  dira[23..16]~~ 'set the LED pins to be output P23 - P16

  Pst.Start(115200)
  Buttons.start(80_000_000 / 100)

  Pst.NewLine
  Pst.Str(string(" binary  - hex - decimal"))
  Pst.NewLine

  lastButtonState := 0
  buttonState := 0

  REPEAT
    ' get the buttons
    buttonState := Buttons.state & %11111111

    ' check if the buttons have changed since last time we checked
    if buttonState <> lastButtonState
      ' turn on/off the LEDs
      OUTA[23..16] := buttonState

      ' print out the binary
      Pst.Bin(buttonState, 8)
      Pst.Str(string(" - $"))
      ' print out the hex
      Pst.Hex(buttonState, 2)
      Pst.Str(string(" - "))
      ' print out the decimal
      Pst.Dec(buttonState)
      Pst.NewLine
      ' save the last button pressed
      lastButtonState := buttonState

      IF buttonState == %00000000
        'Pst.Str(string("bye"))
        'Pst.NewLine
      ELSEIF buttonState == %00000001
        'Pst.Str(string("hello number one"))
        'Pst.NewLine
      ELSEIF buttonState == %00000010
        'Pst.Str(string("hello number two"))
        'Pst.NewLine
      ELSEIF buttonState == %00000100
        'Pst.Str(string("hello number three"))
        'Pst.NewLine
      ELSEIF buttonState == %00001000
        'Pst.Str(string("hello number four"))
        'Pst.NewLine
      ELSEIF buttonState == %00010000
        'ADD code here
      ELSEIF buttonState == %00100000
        'ADD code here
      ELSEIF buttonState == %01000000
        'ADD code here
      ELSEIF buttonState == %10000000
        'ADD code here

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