From: Gianfranco Costamagna <costamagnagianfranco@yahoo.it>
Subject: Re: My "enable bluetooth" hotkey increase brightness instead
Date: Thu, 7 Nov 2013 22:15:14 +0000 (GMT)
Message-ID: <1383862514.1365.YahooMailNeo@web171806.mail.ir2.yahoo.com>
References: <1383035869.66885.YahooMailNeo@web171805.mail.ir2.yahoo.com> <1383036747.30147.YahooMailNeo@web171802.mail.ir2.yahoo.com> <CANq1E4TBHcCe6V7PhP_guhS3=nTd=hTq2jYYCzp+w7NjZiEpiQ@mail.gmail.com>
Reply-To: Gianfranco Costamagna <costamagnagianfranco@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from nm6-vm7.bullet.mail.ir2.yahoo.com ([212.82.96.123]:31602 "EHLO
	nm6-vm7.bullet.mail.ir2.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755694Ab3KGWPS convert rfc822-to-8bit
	(ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 7 Nov 2013 17:15:18 -0500
In-Reply-To: <CANq1E4TBHcCe6V7PhP_guhS3=nTd=hTq2jYYCzp+w7NjZiEpiQ@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Herrmann <dh.herrmann@gmail.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>


----- Messaggio originale -----

> Da: David Herrmann <dh.herrmann@gmail.com>
> A: Gianfranco Costamagna <costamagnagianfranco@yahoo.it>
> Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>
> Inviato: Gioved=EC 7 Novembre 2013 15:44
> Oggetto: Re: My "enable bluetooth" hotkey increase brightness instead
>=20
> Hi

Hi David

>=20
> On Tue, Oct 29, 2013 at 9:52 AM, Gianfranco Costamagna
> <costamagnagianfranco@yahoo.it> wrote:
>>  Hi linux-input developers, I write here since suggested on my launc=
hpad=20
> bug.
>>=20
>>  The problem is really simple, I have an acer aspire 6930G and when =
I press=20
> "enable bluetooth" on my keyboard I get the brightness of my screen=20
> increased.
>>  I reported on launchpad my configuration [1], and also opened a bug=
 here=20
> [2].
>>=20
>>  the problem seems to be in the kernel so far, but I honestly don't =
know=20
> where to better report it and how to debug/check it.
>>=20
>>  I tested also kernel 3.12rc6 without any better outcome.
>>=20
>>  Can anybody please help me out with this problem?
>>=20
>>  Many thanks!
>=20
> Please use "evtest" to see which events are generated for your keys:
> =A0 http://cgit.freedesktop.org/evtest/
> You need to run it on your keyboard-event chardev, something like:
> /dev/input/eventX (just try each until you find your keyboard).
>=20
> Please append the information you get and press the key which is
> incorrectly mapped.

Wonderful hint! Now when I press the bluetooth key I see two different =
event fired from the keyboard
^Clocutus@Unimatrix02-Saucy:~ $ sudo evtest=20
No device specified, trying to scan all of /dev/input/event*
Available devices:
/dev/input/event0:=A0=A0=A0 Lid Switch
/dev/input/event1:=A0=A0=A0 Power Button
/dev/input/event2:=A0=A0=A0 Sleep Button
/dev/input/event3:=A0=A0=A0 Power Button
/dev/input/event4:=A0=A0=A0 AT Translated Set 2 keyboard
/dev/input/event5:=A0=A0=A0 Video Bus
/dev/input/event6:=A0=A0=A0 HDA Intel HDMI/DP,pcm=3D3 Phantom
/dev/input/event7:=A0=A0=A0 HDA Intel Headphone
/dev/input/event8:=A0=A0=A0 HDA Intel Line
/dev/input/event9:=A0=A0=A0 HDA Intel Mic
/dev/input/event10:=A0=A0=A0 SynPS/2 Synaptics TouchPad
/dev/input/event11:=A0=A0=A0 Acer Crystal Eye webcam
Select the device event number [0-12]: 4
Input driver version is 1.0.1
Input device ID: bus 0x11 vendor 0x1 product 0x1 version 0xab41
Input device name: "AT Translated Set 2 keyboard"
Supported events:
=A0 Event type 0 (EV_SYN)
=A0 Event type 1 (EV_KEY)
=A0=A0=A0 Event code 1 (KEY_ESC)
=A0=A0=A0 Event code 2 (KEY_1)
=A0=A0=A0 Event code 3 (KEY_2)
=A0=A0=A0 Event code 4 (KEY_3)
=A0=A0=A0 Event code 5 (KEY_4)
=A0=A0=A0 Event code 6 (KEY_5)
=A0=A0=A0 Event code 7 (KEY_6)
=A0=A0=A0 Event code 8 (KEY_7)
=A0=A0=A0 Event code 9 (KEY_8)
=A0=A0=A0 Event code 10 (KEY_9)
=A0=A0=A0 Event code 11 (KEY_0)
=A0=A0=A0 Event code 12 (KEY_MINUS)
=A0=A0=A0 Event code 13 (KEY_EQUAL)
=A0=A0=A0 Event code 14 (KEY_BACKSPACE)
=A0=A0=A0 Event code 15 (KEY_TAB)
=A0=A0=A0 Event code 16 (KEY_Q)
=A0=A0=A0 Event code 17 (KEY_W)
=A0=A0=A0 Event code 18 (KEY_E)
=A0=A0=A0 Event code 19 (KEY_R)
=A0=A0=A0 Event code 20 (KEY_T)
=A0=A0=A0 Event code 21 (KEY_Y)
=A0=A0=A0 Event code 22 (KEY_U)
=A0=A0=A0 Event code 23 (KEY_I)
=A0=A0=A0 Event code 24 (KEY_O)
=A0=A0=A0 Event code 25 (KEY_P)
=A0=A0=A0 Event code 26 (KEY_LEFTBRACE)
=A0=A0=A0 Event code 27 (KEY_RIGHTBRACE)
=A0=A0=A0 Event code 28 (KEY_ENTER)
=A0=A0=A0 Event code 29 (KEY_LEFTCTRL)
=A0=A0=A0 Event code 30 (KEY_A)
=A0=A0=A0 Event code 31 (KEY_S)
=A0=A0=A0 Event code 32 (KEY_D)
=A0=A0=A0 Event code 33 (KEY_F)
=A0=A0=A0 Event code 34 (KEY_G)
=A0=A0=A0 Event code 35 (KEY_H)
=A0=A0=A0 Event code 36 (KEY_J)
=A0=A0=A0 Event code 37 (KEY_K)
=A0=A0=A0 Event code 38 (KEY_L)
=A0=A0=A0 Event code 39 (KEY_SEMICOLON)
=A0=A0=A0 Event code 40 (KEY_APOSTROPHE)
=A0=A0=A0 Event code 41 (KEY_GRAVE)
=A0=A0=A0 Event code 42 (KEY_LEFTSHIFT)
=A0=A0=A0 Event code 43 (KEY_BACKSLASH)
=A0=A0=A0 Event code 44 (KEY_Z)
=A0=A0=A0 Event code 45 (KEY_X)
=A0=A0=A0 Event code 46 (KEY_C)
=A0=A0=A0 Event code 47 (KEY_V)
=A0=A0=A0 Event code 48 (KEY_B)
=A0=A0=A0 Event code 49 (KEY_N)
=A0=A0=A0 Event code 50 (KEY_M)
=A0=A0=A0 Event code 51 (KEY_COMMA)
=A0=A0=A0 Event code 52 (KEY_DOT)
=A0=A0=A0 Event code 53 (KEY_SLASH)
=A0=A0=A0 Event code 54 (KEY_RIGHTSHIFT)
=A0=A0=A0 Event code 55 (KEY_KPASTERISK)
=A0=A0=A0 Event code 56 (KEY_LEFTALT)
=A0=A0=A0 Event code 57 (KEY_SPACE)
=A0=A0=A0 Event code 58 (KEY_CAPSLOCK)
=A0=A0=A0 Event code 59 (KEY_F1)
=A0=A0=A0 Event code 60 (KEY_F2)
=A0=A0=A0 Event code 61 (KEY_F3)
=A0=A0=A0 Event code 62 (KEY_F4)
=A0=A0=A0 Event code 63 (KEY_F5)
=A0=A0=A0 Event code 64 (KEY_F6)
=A0=A0=A0 Event code 65 (KEY_F7)
=A0=A0=A0 Event code 66 (KEY_F8)
=A0=A0=A0 Event code 67 (KEY_F9)
=A0=A0=A0 Event code 68 (KEY_F10)
=A0=A0=A0 Event code 69 (KEY_NUMLOCK)
=A0=A0=A0 Event code 70 (KEY_SCROLLLOCK)
=A0=A0=A0 Event code 71 (KEY_KP7)
=A0=A0=A0 Event code 72 (KEY_KP8)
=A0=A0=A0 Event code 73 (KEY_KP9)
=A0=A0=A0 Event code 74 (KEY_KPMINUS)
=A0=A0=A0 Event code 75 (KEY_KP4)
=A0=A0=A0 Event code 76 (KEY_KP5)
=A0=A0=A0 Event code 77 (KEY_KP6)
=A0=A0=A0 Event code 78 (KEY_KPPLUS)
=A0=A0=A0 Event code 79 (KEY_KP1)
=A0=A0=A0 Event code 80 (KEY_KP2)
=A0=A0=A0 Event code 81 (KEY_KP3)
=A0=A0=A0 Event code 82 (KEY_KP0)
=A0=A0=A0 Event code 83 (KEY_KPDOT)
=A0=A0=A0 Event code 85 (KEY_ZENKAKUHANKAKU)
=A0=A0=A0 Event code 86 (KEY_102ND)
=A0=A0=A0 Event code 87 (KEY_F11)
=A0=A0=A0 Event code 88 (KEY_F12)
=A0=A0=A0 Event code 89 (KEY_RO)
=A0=A0=A0 Event code 90 (KEY_KATAKANA)
=A0=A0=A0 Event code 91 (KEY_HIRAGANA)
=A0=A0=A0 Event code 92 (KEY_HENKAN)
=A0=A0=A0 Event code 93 (KEY_KATAKANAHIRAGANA)
=A0=A0=A0 Event code 94 (KEY_MUHENKAN)
=A0=A0=A0 Event code 95 (KEY_KPJPCOMMA)
=A0=A0=A0 Event code 96 (KEY_KPENTER)
=A0=A0=A0 Event code 97 (KEY_RIGHTCTRL)
=A0=A0=A0 Event code 98 (KEY_KPSLASH)
=A0=A0=A0 Event code 99 (KEY_SYSRQ)
=A0=A0=A0 Event code 100 (KEY_RIGHTALT)
=A0=A0=A0 Event code 102 (KEY_HOME)
=A0=A0=A0 Event code 103 (KEY_UP)
=A0=A0=A0 Event code 104 (KEY_PAGEUP)
=A0=A0=A0 Event code 105 (KEY_LEFT)
=A0=A0=A0 Event code 106 (KEY_RIGHT)
=A0=A0=A0 Event code 107 (KEY_END)
=A0=A0=A0 Event code 108 (KEY_DOWN)
=A0=A0=A0 Event code 109 (KEY_PAGEDOWN)
=A0=A0=A0 Event code 110 (KEY_INSERT)
=A0=A0=A0 Event code 111 (KEY_DELETE)
=A0=A0=A0 Event code 112 (KEY_MACRO)
=A0=A0=A0 Event code 113 (KEY_MUTE)
=A0=A0=A0 Event code 114 (KEY_VOLUMEDOWN)
=A0=A0=A0 Event code 115 (KEY_VOLUMEUP)
=A0=A0=A0 Event code 116 (KEY_POWER)
=A0=A0=A0 Event code 117 (KEY_KPEQUAL)
=A0=A0=A0 Event code 119 (KEY_PAUSE)
=A0=A0=A0 Event code 121 (KEY_KPCOMMA)
=A0=A0=A0 Event code 122 (KEY_HANGUEL)
=A0=A0=A0 Event code 123 (KEY_HANJA)
=A0=A0=A0 Event code 124 (KEY_YEN)
=A0=A0=A0 Event code 125 (KEY_LEFTMETA)
=A0=A0=A0 Event code 126 (KEY_RIGHTMETA)
=A0=A0=A0 Event code 127 (KEY_COMPOSE)
=A0=A0=A0 Event code 128 (KEY_STOP)
=A0=A0=A0 Event code 138 (KEY_HELP)
=A0=A0=A0 Event code 140 (KEY_CALC)
=A0=A0=A0 Event code 141 (KEY_SETUP)
=A0=A0=A0 Event code 142 (KEY_SLEEP)
=A0=A0=A0 Event code 143 (KEY_WAKEUP)
=A0=A0=A0 Event code 148 (KEY_PROG1)
=A0=A0=A0 Event code 149 (KEY_PROG2)
=A0=A0=A0 Event code 155 (KEY_MAIL)
=A0=A0=A0 Event code 156 (KEY_BOOKMARKS)
=A0=A0=A0 Event code 157 (KEY_COMPUTER)
=A0=A0=A0 Event code 158 (KEY_BACK)
=A0=A0=A0 Event code 159 (KEY_FORWARD)
=A0=A0=A0 Event code 163 (KEY_NEXTSONG)
=A0=A0=A0 Event code 164 (KEY_PLAYPAUSE)
=A0=A0=A0 Event code 165 (KEY_PREVIOUSSONG)
=A0=A0=A0 Event code 166 (KEY_STOPCD)
=A0=A0=A0 Event code 172 (KEY_HOMEPAGE)
=A0=A0=A0 Event code 173 (KEY_REFRESH)
=A0=A0=A0 Event code 183 (KEY_F13)
=A0=A0=A0 Event code 184 (KEY_F14)
=A0=A0=A0 Event code 185 (KEY_F15)
=A0=A0=A0 Event code 192 (KEY_F22)
=A0=A0=A0 Event code 193 (KEY_F23)
=A0=A0=A0 Event code 217 (KEY_SEARCH)
=A0=A0=A0 Event code 224 (KEY_BRIGHTNESSDOWN)
=A0=A0=A0 Event code 225 (KEY_BRIGHTNESSUP)
=A0=A0=A0 Event code 226 (KEY_MEDIA)
=A0=A0=A0 Event code 227 (KEY_SWITCHVIDEOMODE)
=A0=A0=A0 Event code 236 (KEY_BATTERY)
=A0=A0=A0 Event code 237 (KEY_BLUETOOTH)
=A0=A0=A0 Event code 238 (KEY_WLAN)
=A0=A0=A0 Event code 425 (KEY_PRESENTATION)
=A0=A0=A0 Event code 434 (KEY_DOLLAR)
=A0=A0=A0 Event code 435 (KEY_EURO)
=A0=A0=A0 Event code 464 (KEY_FN)
=A0 Event type 4 (EV_MSC)
=A0=A0=A0 Event code 4 (MSC_SCAN)
=A0 Event type 17 (EV_LED)
=A0=A0=A0 Event code 0 (LED_NUML)
=A0=A0=A0 Event code 1 (LED_CAPSL)
=A0=A0=A0 Event code 2 (LED_SCROLLL)
Properties:
=A0 Property type 20 (EV_REP)
=A0=A0=A0 Property code 0 (REP_DELAY)
=A0=A0=A0=A0=A0 Value=A0=A0=A0 250
=A0=A0=A0 Property code 1 (REP_PERIOD)
=A0=A0=A0=A0=A0 Value=A0=A0=A0=A0 33
Testing ... (interrupt to exit)
Event: time 1383862330.411016, type 4 (EV_MSC), code 4 (MSC_SCAN), valu=
e 1c
Event: time 1383862330.411016, type 1 (EV_KEY), code 28 (KEY_ENTER), va=
lue 0
Event: time 1383862330.411016, -------------- SYN_REPORT ------------
Event: time 1383862331.588429, type 4 (EV_MSC), code 4 (MSC_SCAN), valu=
e d9
Event: time 1383862331.588429, type 1 (EV_KEY), code 225 (KEY_BRIGHTNES=
SUP), value 1
Event: time 1383862331.588429, -------------- SYN_REPORT ------------
Event: time 1383862331.810012, type 4 (EV_MSC), code 4 (MSC_SCAN), valu=
e d9
Event: time 1383862331.810012, type 1 (EV_KEY), code 225 (KEY_BRIGHTNES=
SUP), value 0
Event: time 1383862331.810012, -------------- SYN_REPORT ------------
Event: time 1383862332.498971, type 4 (EV_MSC), code 4 (MSC_SCAN), valu=
e d4
Event: time 1383862332.498971, type 1 (EV_KEY), code 237 (KEY_BLUETOOTH=
), value 1
Event: time 1383862332.498971, -------------- SYN_REPORT ------------
Event: time 1383862332.720524, type 4 (EV_MSC), code 4 (MSC_SCAN), valu=
e d4
Event: time 1383862332.720524, type 1 (EV_KEY), code 237 (KEY_BLUETOOTH=
), value 0
Event: time 1383862332.720524, -------------- SYN_REPORT ------------
Event: time 1383862333.631341, type 4 (EV_MSC), code 4 (MSC_SCAN), valu=
e d9
Event: time 1383862333.631341, type 1 (EV_KEY), code 225 (KEY_BRIGHTNES=
SUP), value 1
Event: time 1383862333.631341, -------------- SYN_REPORT ------------
Event: time 1383862333.832775, type 4 (EV_MSC), code 4 (MSC_SCAN), valu=
e d9
Event: time 1383862333.832775, type 1 (EV_KEY), code 225 (KEY_BRIGHTNES=
SUP), value 0
Event: time 1383862333.832775, -------------- SYN_REPORT ------------
Event: time 1383862334.682950, type 4 (EV_MSC), code 4 (MSC_SCAN), valu=
e d4
Event: time 1383862334.682950, type 1 (EV_KEY), code 237 (KEY_BLUETOOTH=
), value 1
Event: time 1383862334.682950, -------------- SYN_REPORT ------------
Event: time 1383862334.844099, type 4 (EV_MSC), code 4 (MSC_SCAN), valu=
e d4
Event: time 1383862334.844099, type 1 (EV_KEY), code 237 (KEY_BLUETOOTH=
), value 0
Event: time 1383862334.844099, -------------- SYN_REPORT ------------
Event: time 1383862338.144505, type 4 (EV_MSC), code 4 (MSC_SCAN), valu=
e d9
Event: time 1383862338.144505, type 1 (EV_KEY), code 225 (KEY_BRIGHTNES=
SUP), value 1
Event: time 1383862338.144505, -------------- SYN_REPORT ------------
Event: time 1383862338.386205, type 4 (EV_MSC), code 4 (MSC_SCAN), valu=
e d9
Event: time 1383862338.386205, type 1 (EV_KEY), code 225 (KEY_BRIGHTNES=
SUP), value 0
Event: time 1383862338.386205, -------------- SYN_REPORT ------------
Event: time 1383862339.167990, type 4 (EV_MSC), code 4 (MSC_SCAN), valu=
e 1d
Event: time 1383862339.167990, type 1 (EV_KEY), code 29 (KEY_LEFTCTRL),=
 value 1
Event: time 1383862339.167990, -------------- SYN_REPORT ------------
Event: time 1383862339.319043, type 4 (EV_MSC), code 4 (MSC_SCAN), valu=
e 2e
Event: time 1383862339.319043, type 1 (EV_KEY), code 46 (KEY_C), value =
1
Event: time 1383862339.319043, -------------- SYN_REPORT ------------


Thanks to you, you were really useful, but I don't know how to fix this=
 properly :)

Cheers,

Gianfranco

>=20
> Thanks
> David
>=20
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
