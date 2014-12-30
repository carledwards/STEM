
CON
  _clkmode = xtal1 + pll16x     
  _xinfreq = 5_000_000

  WHEEL_CENTER    = 1500

  CLK_FREQ = ((_clkmode-xtal1)>>6)*_xinfreq
  MS_001 = CLK_FREQ / 1_000

  PIN_SERVO_LEFT = 26
  PIN_SERVO_RIGHT = 27


VAR

OBJ
  PWM           : "PWM_32_v4.spin"
  Buttons       : "Touch Buttons"

PUB Main | buttonState, mode
  Buttons.start(80_000_000 / 100) ' Launch the touch buttons driver sampling 100 times a second
  dira[23..16]~~ 'set the LED pins to be output P23 - P16
  PWM.Start

  REPEAT
    OUTA[23..16] := %00000001
    RightWheelStop
    LeftWheelStop
    Pause(2000)
    OUTA[23..16] := %00000011
    RightWheelForward
    LeftWheelForward
    Pause(2000)
    OUTA[23..16] := %00000111
    RightWheelBackward
    LeftWheelBackward
    Pause(2000)

PUB RightWheelForward
    PWM.Servo(PIN_SERVO_RIGHT,1400)

PUB RightWheelBackward
    PWM.Servo(PIN_SERVO_RIGHT,1600)

PUB RightWheelStop
    PWM.Servo(PIN_SERVO_RIGHT,1500)

PUB LeftWheelForward
    PWM.Servo(PIN_SERVO_LEFT,1600)

PUB LeftWheelBackward
    PWM.Servo(PIN_SERVO_LEFT,1400)

PUB LeftWheelStop
    PWM.Servo(PIN_SERVO_LEFT,1500)

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