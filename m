From: Alexander Ploumistos <alex.ploumistos@gmail.com>
Subject: Logitech M560 - Pt. 2
Date: Sat, 16 Nov 2013 13:32:59 +0200
Message-ID: <CAM86y2u4xSs6m7UijaUPoUznk5bTpUmsEAgiDpb5BqAqtyLR7Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-we0-f179.google.com ([74.125.82.179]:60194 "EHLO
	mail-we0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751481Ab3KPLdB (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 16 Nov 2013 06:33:01 -0500
Received: by mail-we0-f179.google.com with SMTP id q59so2414512wes.38
        for <linux-input@vger.kernel.org>; Sat, 16 Nov 2013 03:33:00 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

And here is the evtest output, I've removed mouse movements, to keep
it short. The keys are in the following order: Left click, right
click, wheel up, wheel down, left tilt, right tilt, forward button,
back button, small button behind the wheel (that last one twice).

Input driver version is 1.0.1
Input device ID: bus 0x3 vendor 0x46d product 0xc52b version 0x111
Input device name: "Logitech Unifying Device. Wireless PID:402d"
Supported events:
  Event type 0 (EV_SYN)
  Event type 1 (EV_KEY)
    Event code 1 (KEY_ESC)
    Event code 2 (KEY_1)
    Event code 3 (KEY_2)
    Event code 4 (KEY_3)
    Event code 5 (KEY_4)
    Event code 6 (KEY_5)
    Event code 7 (KEY_6)
    Event code 8 (KEY_7)
    Event code 9 (KEY_8)
    Event code 10 (KEY_9)
    Event code 11 (KEY_0)
    Event code 12 (KEY_MINUS)
    Event code 13 (KEY_EQUAL)
    Event code 14 (KEY_BACKSPACE)
    Event code 15 (KEY_TAB)
    Event code 16 (KEY_Q)
    Event code 17 (KEY_W)
    Event code 18 (KEY_E)
    Event code 19 (KEY_R)
    Event code 20 (KEY_T)
    Event code 21 (KEY_Y)
    Event code 22 (KEY_U)
    Event code 23 (KEY_I)
    Event code 24 (KEY_O)
    Event code 25 (KEY_P)
    Event code 26 (KEY_LEFTBRACE)
    Event code 27 (KEY_RIGHTBRACE)
    Event code 28 (KEY_ENTER)
    Event code 29 (KEY_LEFTCTRL)
    Event code 30 (KEY_A)
    Event code 31 (KEY_S)
    Event code 32 (KEY_D)
    Event code 33 (KEY_F)
    Event code 34 (KEY_G)
    Event code 35 (KEY_H)
    Event code 36 (KEY_J)
    Event code 37 (KEY_K)
    Event code 38 (KEY_L)
    Event code 39 (KEY_SEMICOLON)
    Event code 40 (KEY_APOSTROPHE)
    Event code 41 (KEY_GRAVE)
    Event code 42 (KEY_LEFTSHIFT)
    Event code 43 (KEY_BACKSLASH)
    Event code 44 (KEY_Z)
    Event code 45 (KEY_X)
    Event code 46 (KEY_C)
    Event code 47 (KEY_V)
    Event code 48 (KEY_B)
    Event code 49 (KEY_N)
    Event code 50 (KEY_M)
    Event code 51 (KEY_COMMA)
    Event code 52 (KEY_DOT)
    Event code 53 (KEY_SLASH)
    Event code 54 (KEY_RIGHTSHIFT)
    Event code 55 (KEY_KPASTERISK)
    Event code 56 (KEY_LEFTALT)
    Event code 57 (KEY_SPACE)
    Event code 58 (KEY_CAPSLOCK)
    Event code 59 (KEY_F1)
    Event code 60 (KEY_F2)
    Event code 61 (KEY_F3)
    Event code 62 (KEY_F4)
    Event code 63 (KEY_F5)
    Event code 64 (KEY_F6)
    Event code 65 (KEY_F7)
    Event code 66 (KEY_F8)
    Event code 67 (KEY_F9)
    Event code 68 (KEY_F10)
    Event code 69 (KEY_NUMLOCK)
    Event code 70 (KEY_SCROLLLOCK)
    Event code 71 (KEY_KP7)
    Event code 72 (KEY_KP8)
    Event code 73 (KEY_KP9)
    Event code 74 (KEY_KPMINUS)
    Event code 75 (KEY_KP4)
    Event code 76 (KEY_KP5)
    Event code 77 (KEY_KP6)
    Event code 78 (KEY_KPPLUS)
    Event code 79 (KEY_KP1)
    Event code 80 (KEY_KP2)
    Event code 81 (KEY_KP3)
    Event code 82 (KEY_KP0)
    Event code 83 (KEY_KPDOT)
    Event code 85 (KEY_ZENKAKUHANKAKU)
    Event code 86 (KEY_102ND)
    Event code 87 (KEY_F11)
    Event code 88 (KEY_F12)
    Event code 89 (KEY_RO)
    Event code 90 (KEY_KATAKANA)
    Event code 91 (KEY_HIRAGANA)
    Event code 92 (KEY_HENKAN)
    Event code 93 (KEY_KATAKANAHIRAGANA)
    Event code 94 (KEY_MUHENKAN)
    Event code 95 (KEY_KPJPCOMMA)
    Event code 96 (KEY_KPENTER)
    Event code 97 (KEY_RIGHTCTRL)
    Event code 98 (KEY_KPSLASH)
    Event code 99 (KEY_SYSRQ)
    Event code 100 (KEY_RIGHTALT)
    Event code 102 (KEY_HOME)
    Event code 103 (KEY_UP)
    Event code 104 (KEY_PAGEUP)
    Event code 105 (KEY_LEFT)
    Event code 106 (KEY_RIGHT)
    Event code 107 (KEY_END)
    Event code 108 (KEY_DOWN)
    Event code 109 (KEY_PAGEDOWN)
    Event code 110 (KEY_INSERT)
    Event code 111 (KEY_DELETE)
    Event code 113 (KEY_MUTE)
    Event code 114 (KEY_VOLUMEDOWN)
    Event code 115 (KEY_VOLUMEUP)
    Event code 116 (KEY_POWER)
    Event code 117 (KEY_KPEQUAL)
    Event code 119 (KEY_PAUSE)
    Event code 121 (KEY_KPCOMMA)
    Event code 122 (KEY_HANGUEL)
    Event code 123 (KEY_HANJA)
    Event code 124 (KEY_YEN)
    Event code 125 (KEY_LEFTMETA)
    Event code 126 (KEY_RIGHTMETA)
    Event code 127 (KEY_COMPOSE)
    Event code 128 (KEY_STOP)
    Event code 129 (KEY_AGAIN)
    Event code 130 (KEY_PROPS)
    Event code 131 (KEY_UNDO)
    Event code 132 (KEY_FRONT)
    Event code 133 (KEY_COPY)
    Event code 134 (KEY_OPEN)
    Event code 135 (KEY_PASTE)
    Event code 136 (KEY_FIND)
    Event code 137 (KEY_CUT)
    Event code 138 (KEY_HELP)
    Event code 140 (KEY_CALC)
    Event code 142 (KEY_SLEEP)
    Event code 150 (KEY_WWW)
    Event code 152 (KEY_SCREENLOCK)
    Event code 158 (KEY_BACK)
    Event code 159 (KEY_FORWARD)
    Event code 161 (KEY_EJECTCD)
    Event code 163 (KEY_NEXTSONG)
    Event code 164 (KEY_PLAYPAUSE)
    Event code 165 (KEY_PREVIOUSSONG)
    Event code 166 (KEY_STOPCD)
    Event code 173 (KEY_REFRESH)
    Event code 176 (KEY_EDIT)
    Event code 177 (KEY_SCROLLUP)
    Event code 178 (KEY_SCROLLDOWN)
    Event code 179 (KEY_KPLEFTPAREN)
    Event code 180 (KEY_KPRIGHTPAREN)
    Event code 183 (KEY_F13)
    Event code 184 (KEY_F14)
    Event code 185 (KEY_F15)
    Event code 186 (KEY_F16)
    Event code 187 (KEY_F17)
    Event code 188 (KEY_F18)
    Event code 189 (KEY_F19)
    Event code 190 (KEY_F20)
    Event code 191 (KEY_F21)
    Event code 192 (KEY_F22)
    Event code 193 (KEY_F23)
    Event code 194 (KEY_F24)
    Event code 240 (KEY_UNKNOWN)
    Event code 272 (BTN_LEFT)
    Event code 273 (BTN_RIGHT)
    Event code 274 (BTN_MIDDLE)
    Event code 275 (BTN_SIDE)
    Event code 276 (BTN_EXTRA)
    Event code 277 (BTN_FORWARD)
    Event code 278 (BTN_BACK)
    Event code 279 (BTN_TASK)
    Event code 280 (?)
    Event code 281 (?)
    Event code 282 (?)
    Event code 283 (?)
    Event code 284 (?)
    Event code 285 (?)
    Event code 286 (?)
    Event code 287 (?)
  Event type 2 (EV_REL)
    Event code 0 (REL_X)
    Event code 1 (REL_Y)
    Event code 6 (REL_HWHEEL)
    Event code 8 (REL_WHEEL)
  Event type 4 (EV_MSC)
    Event code 4 (MSC_SCAN)
  Event type 17 (EV_LED)
    Event code 0 (LED_NUML)
    Event code 1 (LED_CAPSL)
    Event code 2 (LED_SCROLLL)
    Event code 3 (LED_COMPOSE)
    Event code 4 (LED_KANA)
Properties:
  Property type 20 (EV_REP)
    Property code 0 (REP_DELAY)
      Value    250
    Property code 1 (REP_PERIOD)
      Value     33
Testing ... (interrupt to exit)
Event: time 1384596124.022800, type 4 (EV_MSC), code 4 (MSC_SCAN), value 90001
Event: time 1384596124.022800, type 1 (EV_KEY), code 272 (BTN_LEFT), value 1
Event: time 1384596124.022800, -------------- SYN_REPORT ------------
Event: time 1384596124.184807, type 4 (EV_MSC), code 4 (MSC_SCAN), value 90001
Event: time 1384596124.184807, type 1 (EV_KEY), code 272 (BTN_LEFT), value 0
Event: time 1384596124.184807, -------------- SYN_REPORT ------------
Event: time 1384596126.178789, type 4 (EV_MSC), code 4 (MSC_SCAN), value 90002
Event: time 1384596126.178789, type 1 (EV_KEY), code 273 (BTN_RIGHT), value 1
Event: time 1384596126.178789, -------------- SYN_REPORT ------------
Event: time 1384596126.356737, type 4 (EV_MSC), code 4 (MSC_SCAN), value 90002
Event: time 1384596126.356737, type 1 (EV_KEY), code 273 (BTN_RIGHT), value 0
Event: time 1384596126.356737, -------------- SYN_REPORT ------------
Event: time 1384596135.276730, type 2 (EV_REL), code 8 (REL_WHEEL), value 1
Event: time 1384596135.276730, -------------- SYN_REPORT ------------
Event: time 1384596140.958607, type 2 (EV_REL), code 8 (REL_WHEEL), value -1
Event: time 1384596140.958607, -------------- SYN_REPORT ------------
Event: time 1384596159.362527, type 4 (EV_MSC), code 4 (MSC_SCAN), value 90004
Event: time 1384596159.362527, type 1 (EV_KEY), code 275 (BTN_SIDE), value 1
Event: time 1384596159.362527, -------------- SYN_REPORT ------------
Event: time 1384596159.542501, type 4 (EV_MSC), code 4 (MSC_SCAN), value 90004
Event: time 1384596159.542501, type 1 (EV_KEY), code 275 (BTN_SIDE), value 0
Event: time 1384596163.550443, -------------- SYN_REPORT ------------
Event: time 1384596163.636455, type 4 (EV_MSC), code 4 (MSC_SCAN), value 90005
Event: time 1384596163.636455, type 1 (EV_KEY), code 276 (BTN_EXTRA), value 1
Event: time 1384596163.636455, -------------- SYN_REPORT ------------
Event: time 1384596163.870448, type 4 (EV_MSC), code 4 (MSC_SCAN), value 90005
Event: time 1384596163.870448, type 1 (EV_KEY), code 276 (BTN_EXTRA), value 0
Event: time 1384596168.990412, -------------- SYN_REPORT ------------
Event: time 1384596169.138456, type 4 (EV_MSC), code 4 (MSC_SCAN), value 700e7
Event: time 1384596169.138456, type 1 (EV_KEY), code 126
(KEY_RIGHTMETA), value 1
Event: time 1384596169.138456, -------------- SYN_REPORT ------------
Event: time 1384596169.356463, type 4 (EV_MSC), code 4 (MSC_SCAN), value 700e7
Event: time 1384596169.356463, type 1 (EV_KEY), code 126
(KEY_RIGHTMETA), value 0
Event: time 1384596169.356463, -------------- SYN_REPORT ------------
Event: time 1384596178.602405, type 4 (EV_MSC), code 4 (MSC_SCAN), value 700e3
Event: time 1384596178.602405, type 1 (EV_KEY), code 125 (KEY_LEFTMETA), value 1
Event: time 1384596178.602405, type 4 (EV_MSC), code 4 (MSC_SCAN), value 70007
Event: time 1384596178.602405, type 1 (EV_KEY), code 32 (KEY_D), value 1
Event: time 1384596178.602405, -------------- SYN_REPORT ------------
Event: time 1384596178.610395, type 4 (EV_MSC), code 4 (MSC_SCAN), value 70007
Event: time 1384596178.610395, type 1 (EV_KEY), code 32 (KEY_D), value 0
Event: time 1384596178.610395, -------------- SYN_REPORT ------------
Event: time 1384596178.618392, type 4 (EV_MSC), code 4 (MSC_SCAN), value 700e3
Event: time 1384596178.618392, type 1 (EV_KEY), code 125 (KEY_LEFTMETA), value 0
Event: time 1384596178.618392, -------------- SYN_REPORT ------------
Event: time 1384596181.964304, type 4 (EV_MSC), code 4 (MSC_SCAN), value 700e2
Event: time 1384596181.964304, type 1 (EV_KEY), code 56 (KEY_LEFTALT), value 1
Event: time 1384596181.964304, type 4 (EV_MSC), code 4 (MSC_SCAN), value 700e3
Event: time 1384596181.964304, type 1 (EV_KEY), code 125 (KEY_LEFTMETA), value 1
Event: time 1384596181.964304, type 4 (EV_MSC), code 4 (MSC_SCAN), value 70072
Event: time 1384596181.964304, type 1 (EV_KEY), code 193 (KEY_F23), value 1
Event: time 1384596181.964304, -------------- SYN_REPORT ------------
Event: time 1384596181.972327, type 4 (EV_MSC), code 4 (MSC_SCAN), value 700e2
Event: time 1384596181.972327, type 1 (EV_KEY), code 56 (KEY_LEFTALT), value 0
Event: time 1384596181.972327, type 4 (EV_MSC), code 4 (MSC_SCAN), value 700e3
Event: time 1384596181.972327, type 1 (EV_KEY), code 125 (KEY_LEFTMETA), value 0
Event: time 1384596181.972327, type 4 (EV_MSC), code 4 (MSC_SCAN), value 70072
Event: time 1384596181.972327, type 1 (EV_KEY), code 193 (KEY_F23), value 0
Event: time 1384596181.972327, -------------- SYN_REPORT ------------
Event: time 1384596184.976378, type 4 (EV_MSC), code 4 (MSC_SCAN), value 90001
Event: time 1384596184.976378, type 1 (EV_KEY), code 272 (BTN_LEFT), value 1
Event: time 1384596184.976378, -------------- SYN_REPORT ------------
Event: time 1384596184.984314, type 4 (EV_MSC), code 4 (MSC_SCAN), value 90001
Event: time 1384596184.984314, type 1 (EV_KEY), code 272 (BTN_LEFT), value 0
Event: time 1384596184.984314, -------------- SYN_REPORT ------------
