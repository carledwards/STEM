
CON
  _clkmode = xtal1 + pll16x
  _xinfreq = 5_000_000

  WHEEL_CENTER = 1500

  CLK_FREQ = ((_clkmode-xtal1)>>6)*_xinfreq
  MS_001 = CLK_FREQ / 1_000

  PIN_SERVO_LEFT = 26
  PIN_SERVO_RIGHT = 27

  LEFT_SERVO_CENTER = 1500
  LEFT_SERVO_FORWARD = 1700
  LEFT_SERVO_BACKWARD = 1300

  RIGHT_SERVO_CENTER = 1500
  RIGHT_SERVO_FORWARD = 1300
  RIGHT_SERVO_BACKWARD = 1700


VAR

OBJ
  PWM           : "PWM_32_v4.spin"
  Ping          : "Ping"

PUB Main | pingRange
  dira[23..16]~~ 'set the LED pins to be output P23 - P16
  PWM.Start
  RightWheelStop
  LeftWheelStop

  REPEAT
    pingRange := Ping.Inches(25)

    ' update motors
    IF pingRange < 3
      RightWheelForward
      LeftWheelBackward
    ELSE
      RightWheelBackward
      LeftWheelBackward

    ' update lights
    IF pingRange < 1
      OUTA[23..16] := %00000000
    ELSEIF pingRange < 3
      OUTA[23..16] := %00000001
    ELSEIF pingRange < 8
      OUTA[23..16] := %00000011
    ELSEIF pingRange < 13
      OUTA[23..16] := %00000111
    ELSEIF pingRange < 18
      OUTA[23..16] := %00001111
    ELSEIF pingRange < 23
      OUTA[23..16] := %00011111
    ELSEIF pingRange < 28
      OUTA[23..16] := %00111111
    ELSEIF pingRange < 33
      OUTA[23..16] := %01111111
    ELSE
      OUTA[23..16] := %11111111


PUB RightWheelForward
  RightWheelSpeed(RIGHT_SERVO_FORWARD)

PUB RightWheelBackward
  RightWheelSpeed(RIGHT_SERVO_BACKWARD)

PUB RightWheelStop
  RightWheelSpeed(RIGHT_SERVO_CENTER)

PUB LeftWheelForward
  LeftWheelSpeed(LEFT_SERVO_FORWARD)

PUB LeftWheelBackward
  LeftWheelSpeed(LEFT_SERVO_BACKWARD)

PUB LeftWheelStop
  LeftWheelSpeed(LEFT_SERVO_CENTER)

PUB RightWheelSpeed(speed)
  PWM.Servo(PIN_SERVO_RIGHT, speed)

PUB LeftWheelSpeed(speed)
  PWM.Servo(PIN_SERVO_LEFT, speed)


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