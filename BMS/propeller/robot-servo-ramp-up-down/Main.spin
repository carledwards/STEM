{{
─────────────────────────────────────────────────
File: Main.spin
Version: 1.0
Copyright (c) 2012, Carl Edwards
See end of file for terms of use.
─────────────────────────────────────────────────
}}

{
  This example shows how to gradually ramp up and down the servos to make the robot
  start and stop smoothly.
}

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
  long  ShowLightsStackSpace[20], RampServosStackSpace[50]
  long  TargetRightServo
  long  TargetLeftServo

OBJ
  PWM           : "PWM_32_v4.spin"

PUB Main | buttonState, mode
  PWM.Start
  CogNew(ShowLights, @ShowLightsStackSpace)
  CogNew(RampServos(@TargetLeftServo, @TargetRightServo), @RampServosStackSpace)

  REPEAT
    RightWheelStop
    LeftWheelStop
    Pause(2000)
    RightWheelForward
    LeftWheelForward
    Pause(4000)
    RightWheelBackward
    LeftWheelBackward
    Pause(4000)

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
  TargetRightServo := speed

PUB LeftWheelSpeed(speed)
  TargetLeftServo := speed


PUB RampServos(TargetLeftServoAddr, TargetRightServoAddr) | leftServoCurrentValue, rightServoCurrentValue

  leftServoCurrentValue := LEFT_SERVO_CENTER
  rightServoCurrentValue := RIGHT_SERVO_CENTER

  REPEAT
    IF leftServoCurrentValue < LONG[TargetLeftServoAddr]
      leftServoCurrentValue := leftServoCurrentValue + 2
      PWM.Servo(PIN_SERVO_LEFT, leftServoCurrentValue)

    IF leftServoCurrentValue > LONG[TargetLeftServoAddr]
      leftServoCurrentValue := leftServoCurrentValue - 2
      PWM.Servo(PIN_SERVO_LEFT, leftServoCurrentValue)

    IF rightServoCurrentValue < LONG[TargetRightServoAddr]
      rightServoCurrentValue := rightServoCurrentValue + 2
      PWM.Servo(PIN_SERVO_RIGHT, rightServoCurrentValue)

    IF rightServoCurrentValue > LONG[TargetRightServoAddr]
      rightServoCurrentValue := rightServoCurrentValue - 2
      PWM.Servo(PIN_SERVO_RIGHT, rightServoCurrentValue)

    Pause(10)


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