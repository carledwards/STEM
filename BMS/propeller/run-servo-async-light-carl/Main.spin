
CON
  _clkmode = xtal1 + pll16x     
  _xinfreq = 5_000_000

  WHEEL_CENTER = 1500

  CLK_FREQ = ((_clkmode-xtal1)>>6)*_xinfreq
  MS_001 = CLK_FREQ / 1_000

  PIN_SERVO_LEFT = 26
  PIN_SERVO_RIGHT = 27


VAR
  long  StackSpace[20]

OBJ
  PWM           : "PWM_32_v4.spin"
  Buttons       : "Touch Buttons"

PUB Main | buttonState, mode | counter
  Buttons.start(80_000_000 / 100) ' Launch the touch buttons driver sampling 100 times a second
  PWM.Start
  CogNew(ShowLights, @StackSpace)

  REPEAT
    RightWheelForward
    REPEAT counter FROM 1600 TO 1400

    LeftWheelStop
    Pause(2000)
    RightWheelForward
    LeftWheelForward
    Pause(2000)
    RightWheelBackward
    LeftWheelBackward
    Pause(2000)

PRI ShowLights | counter
  dira[23..16]~~ 'set the LED pins to be output P23 - P16
  REPEAT
    REPEAT counter FROM 1 TO 5
      OUTA[23..16] := %00001111
      Pause(150)
      OUTA[23..16] := %11110000
      Pause(150)

    REPEAT counter FROM 1 to 5
      OUTA[23..16] := %10000001
      Pause(100)
      OUTA[23..16] := %01000010
      Pause(100)
      OUTA[23..16] := %00100100
      Pause(100)
      OUTA[23..16] := %00011000
      Pause(100)
      OUTA[23..16] := %00100100
      Pause(100)
      OUTA[23..16] := %01000010
      Pause(100)

    REPEAT counter FROM 1 to 5
      OUTA[23..16] := %10000000
      Pause(100)
      OUTA[23..16] := %01000000
      Pause(100)
      OUTA[23..16] := %00100000
      Pause(100)
      OUTA[23..16] := %00010000
      Pause(100)
      OUTA[23..16] := %00001000
      Pause(100)
      OUTA[23..16] := %00000100
      Pause(100)
      OUTA[23..16] := %00000010
      Pause(100)
      OUTA[23..16] := %00000001
      Pause(100)
      OUTA[23..16] := %00000010
      Pause(100)
      OUTA[23..16] := %00000100
      Pause(100)
      OUTA[23..16] := %00001000
      Pause(100)
      OUTA[23..16] := %00010000
      Pause(100)
      OUTA[23..16] := %00100000
      Pause(100)
      OUTA[23..16] := %01000000
      Pause(100)


PUB RightWheelForward
    PWM.Servo(PIN_SERVO_RIGHT,1000)

PUB RightWheelBackward
    PWM.Servo(PIN_SERVO_RIGHT,2000)

PUB RightWheelStop
    PWM.Servo(PIN_SERVO_RIGHT,1500)

PUB LeftWheelForward
    PWM.Servo(PIN_SERVO_LEFT,2000)

PUB LeftWheelBackward
    PWM.Servo(PIN_SERVO_LEFT,1000)

PUB LeftWheelStop
    PWM.Servo(PIN_SERVO_LEFT,1500)



PUB PauseUntilTimeOrButton(ms) | t
  t := cnt - 1088
  repeat ms
    waitcnt(t += MS_001)
    IF Buttons.State & %11111111 <> 0
      return Buttons.State & %11111111
  return 0

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