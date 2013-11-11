From: David Herrmann <dh.herrmann@gmail.com>
Subject: Re: My "enable bluetooth" hotkey increase brightness instead
Date: Mon, 11 Nov 2013 08:50:37 +0100
Message-ID: <CANq1E4TfTMSkpVmhCojRpRPLHNPhARn1YPr5ME97AWo738NZcg@mail.gmail.com>
References: <1383035869.66885.YahooMailNeo@web171805.mail.ir2.yahoo.com>
	<1383036747.30147.YahooMailNeo@web171802.mail.ir2.yahoo.com>
	<CANq1E4TBHcCe6V7PhP_guhS3=nTd=hTq2jYYCzp+w7NjZiEpiQ@mail.gmail.com>
	<1383862514.1365.YahooMailNeo@web171806.mail.ir2.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-la0-f51.google.com ([209.85.215.51]:33481 "EHLO
	mail-la0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751256Ab3KKHuj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 11 Nov 2013 02:50:39 -0500
Received: by mail-la0-f51.google.com with SMTP id ec20so1206859lab.38
        for <linux-input@vger.kernel.org>; Sun, 10 Nov 2013 23:50:37 -0800 (PST)
In-Reply-To: <1383862514.1365.YahooMailNeo@web171806.mail.ir2.yahoo.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Gianfranco Costamagna <costamagnagianfranco@yahoo.it>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

Hi

On Thu, Nov 7, 2013 at 11:15 PM, Gianfranco Costamagna
<costamagnagianfranco@yahoo.it> wrote:
>
> ----- Messaggio originale -----
>
>> Da: David Herrmann <dh.herrmann@gmail.com>
>> A: Gianfranco Costamagna <costamagnagianfranco@yahoo.it>
>> Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>
>> Inviato: Gioved=EC 7 Novembre 2013 15:44
>> Oggetto: Re: My "enable bluetooth" hotkey increase brightness instea=
d
>>
>> Hi
>
> Hi David
>
>>
>> On Tue, Oct 29, 2013 at 9:52 AM, Gianfranco Costamagna
>> <costamagnagianfranco@yahoo.it> wrote:
>>>  Hi linux-input developers, I write here since suggested on my laun=
chpad
>> bug.
>>>
>>>  The problem is really simple, I have an acer aspire 6930G and when=
 I press
>> "enable bluetooth" on my keyboard I get the brightness of my screen
>> increased.
>>>  I reported on launchpad my configuration [1], and also opened a bu=
g here
>> [2].
>>>
>>>  the problem seems to be in the kernel so far, but I honestly don't=
 know
>> where to better report it and how to debug/check it.
>>>
>>>  I tested also kernel 3.12rc6 without any better outcome.
>>>
>>>  Can anybody please help me out with this problem?
>>>
>>>  Many thanks!
>>
>> Please use "evtest" to see which events are generated for your keys:
>>   http://cgit.freedesktop.org/evtest/
>> You need to run it on your keyboard-event chardev, something like:
>> /dev/input/eventX (just try each until you find your keyboard).
>>
>> Please append the information you get and press the key which is
>> incorrectly mapped.
>
> Wonderful hint! Now when I press the bluetooth key I see two differen=
t event fired from the keyboard
> ^Clocutus@Unimatrix02-Saucy:~ $ sudo evtest
> No device specified, trying to scan all of /dev/input/event*
> Available devices:
> /dev/input/event0:    Lid Switch
> /dev/input/event1:    Power Button
> /dev/input/event2:    Sleep Button
> /dev/input/event3:    Power Button
> /dev/input/event4:    AT Translated Set 2 keyboard
> /dev/input/event5:    Video Bus
> /dev/input/event6:    HDA Intel HDMI/DP,pcm=3D3 Phantom
> /dev/input/event7:    HDA Intel Headphone
> /dev/input/event8:    HDA Intel Line
> /dev/input/event9:    HDA Intel Mic
> /dev/input/event10:    SynPS/2 Synaptics TouchPad
> /dev/input/event11:    Acer Crystal Eye webcam
> Select the device event number [0-12]: 4
> Input driver version is 1.0.1
> Input device ID: bus 0x11 vendor 0x1 product 0x1 version 0xab41
> Input device name: "AT Translated Set 2 keyboard"
> Supported events:
>   Event type 0 (EV_SYN)
>   Event type 1 (EV_KEY)
>     Event code 1 (KEY_ESC)
>     Event code 2 (KEY_1)
>     Event code 3 (KEY_2)
>     Event code 4 (KEY_3)
>     Event code 5 (KEY_4)
>     Event code 6 (KEY_5)
>     Event code 7 (KEY_6)
>     Event code 8 (KEY_7)
>     Event code 9 (KEY_8)
>     Event code 10 (KEY_9)
>     Event code 11 (KEY_0)
>     Event code 12 (KEY_MINUS)
>     Event code 13 (KEY_EQUAL)
>     Event code 14 (KEY_BACKSPACE)
>     Event code 15 (KEY_TAB)
>     Event code 16 (KEY_Q)
>     Event code 17 (KEY_W)
>     Event code 18 (KEY_E)
>     Event code 19 (KEY_R)
>     Event code 20 (KEY_T)
>     Event code 21 (KEY_Y)
>     Event code 22 (KEY_U)
>     Event code 23 (KEY_I)
>     Event code 24 (KEY_O)
>     Event code 25 (KEY_P)
>     Event code 26 (KEY_LEFTBRACE)
>     Event code 27 (KEY_RIGHTBRACE)
>     Event code 28 (KEY_ENTER)
>     Event code 29 (KEY_LEFTCTRL)
>     Event code 30 (KEY_A)
>     Event code 31 (KEY_S)
>     Event code 32 (KEY_D)
>     Event code 33 (KEY_F)
>     Event code 34 (KEY_G)
>     Event code 35 (KEY_H)
>     Event code 36 (KEY_J)
>     Event code 37 (KEY_K)
>     Event code 38 (KEY_L)
>     Event code 39 (KEY_SEMICOLON)
>     Event code 40 (KEY_APOSTROPHE)
>     Event code 41 (KEY_GRAVE)
>     Event code 42 (KEY_LEFTSHIFT)
>     Event code 43 (KEY_BACKSLASH)
>     Event code 44 (KEY_Z)
>     Event code 45 (KEY_X)
>     Event code 46 (KEY_C)
>     Event code 47 (KEY_V)
>     Event code 48 (KEY_B)
>     Event code 49 (KEY_N)
>     Event code 50 (KEY_M)
>     Event code 51 (KEY_COMMA)
>     Event code 52 (KEY_DOT)
>     Event code 53 (KEY_SLASH)
>     Event code 54 (KEY_RIGHTSHIFT)
>     Event code 55 (KEY_KPASTERISK)
>     Event code 56 (KEY_LEFTALT)
>     Event code 57 (KEY_SPACE)
>     Event code 58 (KEY_CAPSLOCK)
>     Event code 59 (KEY_F1)
>     Event code 60 (KEY_F2)
>     Event code 61 (KEY_F3)
>     Event code 62 (KEY_F4)
>     Event code 63 (KEY_F5)
>     Event code 64 (KEY_F6)
>     Event code 65 (KEY_F7)
>     Event code 66 (KEY_F8)
>     Event code 67 (KEY_F9)
>     Event code 68 (KEY_F10)
>     Event code 69 (KEY_NUMLOCK)
>     Event code 70 (KEY_SCROLLLOCK)
>     Event code 71 (KEY_KP7)
>     Event code 72 (KEY_KP8)
>     Event code 73 (KEY_KP9)
>     Event code 74 (KEY_KPMINUS)
>     Event code 75 (KEY_KP4)
>     Event code 76 (KEY_KP5)
>     Event code 77 (KEY_KP6)
>     Event code 78 (KEY_KPPLUS)
>     Event code 79 (KEY_KP1)
>     Event code 80 (KEY_KP2)
>     Event code 81 (KEY_KP3)
>     Event code 82 (KEY_KP0)
>     Event code 83 (KEY_KPDOT)
>     Event code 85 (KEY_ZENKAKUHANKAKU)
>     Event code 86 (KEY_102ND)
>     Event code 87 (KEY_F11)
>     Event code 88 (KEY_F12)
>     Event code 89 (KEY_RO)
>     Event code 90 (KEY_KATAKANA)
>     Event code 91 (KEY_HIRAGANA)
>     Event code 92 (KEY_HENKAN)
>     Event code 93 (KEY_KATAKANAHIRAGANA)
>     Event code 94 (KEY_MUHENKAN)
>     Event code 95 (KEY_KPJPCOMMA)
>     Event code 96 (KEY_KPENTER)
>     Event code 97 (KEY_RIGHTCTRL)
>     Event code 98 (KEY_KPSLASH)
>     Event code 99 (KEY_SYSRQ)
>     Event code 100 (KEY_RIGHTALT)
>     Event code 102 (KEY_HOME)
>     Event code 103 (KEY_UP)
>     Event code 104 (KEY_PAGEUP)
>     Event code 105 (KEY_LEFT)
>     Event code 106 (KEY_RIGHT)
>     Event code 107 (KEY_END)
>     Event code 108 (KEY_DOWN)
>     Event code 109 (KEY_PAGEDOWN)
>     Event code 110 (KEY_INSERT)
>     Event code 111 (KEY_DELETE)
>     Event code 112 (KEY_MACRO)
>     Event code 113 (KEY_MUTE)
>     Event code 114 (KEY_VOLUMEDOWN)
>     Event code 115 (KEY_VOLUMEUP)
>     Event code 116 (KEY_POWER)
>     Event code 117 (KEY_KPEQUAL)
>     Event code 119 (KEY_PAUSE)
>     Event code 121 (KEY_KPCOMMA)
>     Event code 122 (KEY_HANGUEL)
>     Event code 123 (KEY_HANJA)
>     Event code 124 (KEY_YEN)
>     Event code 125 (KEY_LEFTMETA)
>     Event code 126 (KEY_RIGHTMETA)
>     Event code 127 (KEY_COMPOSE)
>     Event code 128 (KEY_STOP)
>     Event code 138 (KEY_HELP)
>     Event code 140 (KEY_CALC)
>     Event code 141 (KEY_SETUP)
>     Event code 142 (KEY_SLEEP)
>     Event code 143 (KEY_WAKEUP)
>     Event code 148 (KEY_PROG1)
>     Event code 149 (KEY_PROG2)
>     Event code 155 (KEY_MAIL)
>     Event code 156 (KEY_BOOKMARKS)
>     Event code 157 (KEY_COMPUTER)
>     Event code 158 (KEY_BACK)
>     Event code 159 (KEY_FORWARD)
>     Event code 163 (KEY_NEXTSONG)
>     Event code 164 (KEY_PLAYPAUSE)
>     Event code 165 (KEY_PREVIOUSSONG)
>     Event code 166 (KEY_STOPCD)
>     Event code 172 (KEY_HOMEPAGE)
>     Event code 173 (KEY_REFRESH)
>     Event code 183 (KEY_F13)
>     Event code 184 (KEY_F14)
>     Event code 185 (KEY_F15)
>     Event code 192 (KEY_F22)
>     Event code 193 (KEY_F23)
>     Event code 217 (KEY_SEARCH)
>     Event code 224 (KEY_BRIGHTNESSDOWN)
>     Event code 225 (KEY_BRIGHTNESSUP)
>     Event code 226 (KEY_MEDIA)
>     Event code 227 (KEY_SWITCHVIDEOMODE)
>     Event code 236 (KEY_BATTERY)
>     Event code 237 (KEY_BLUETOOTH)
>     Event code 238 (KEY_WLAN)
>     Event code 425 (KEY_PRESENTATION)
>     Event code 434 (KEY_DOLLAR)
>     Event code 435 (KEY_EURO)
>     Event code 464 (KEY_FN)
>   Event type 4 (EV_MSC)
>     Event code 4 (MSC_SCAN)
>   Event type 17 (EV_LED)
>     Event code 0 (LED_NUML)
>     Event code 1 (LED_CAPSL)
>     Event code 2 (LED_SCROLLL)
> Properties:
>   Property type 20 (EV_REP)
>     Property code 0 (REP_DELAY)
>       Value    250
>     Property code 1 (REP_PERIOD)
>       Value     33
> Testing ... (interrupt to exit)
> Event: time 1383862330.411016, type 4 (EV_MSC), code 4 (MSC_SCAN), va=
lue 1c
> Event: time 1383862330.411016, type 1 (EV_KEY), code 28 (KEY_ENTER), =
value 0
> Event: time 1383862330.411016, -------------- SYN_REPORT ------------
> Event: time 1383862331.588429, type 4 (EV_MSC), code 4 (MSC_SCAN), va=
lue d9
> Event: time 1383862331.588429, type 1 (EV_KEY), code 225 (KEY_BRIGHTN=
ESSUP), value 1
> Event: time 1383862331.588429, -------------- SYN_REPORT ------------
> Event: time 1383862331.810012, type 4 (EV_MSC), code 4 (MSC_SCAN), va=
lue d9
> Event: time 1383862331.810012, type 1 (EV_KEY), code 225 (KEY_BRIGHTN=
ESSUP), value 0
> Event: time 1383862331.810012, -------------- SYN_REPORT ------------
> Event: time 1383862332.498971, type 4 (EV_MSC), code 4 (MSC_SCAN), va=
lue d4
> Event: time 1383862332.498971, type 1 (EV_KEY), code 237 (KEY_BLUETOO=
TH), value 1
> Event: time 1383862332.498971, -------------- SYN_REPORT ------------
> Event: time 1383862332.720524, type 4 (EV_MSC), code 4 (MSC_SCAN), va=
lue d4
> Event: time 1383862332.720524, type 1 (EV_KEY), code 237 (KEY_BLUETOO=
TH), value 0
> Event: time 1383862332.720524, -------------- SYN_REPORT ------------
> Event: time 1383862333.631341, type 4 (EV_MSC), code 4 (MSC_SCAN), va=
lue d9
> Event: time 1383862333.631341, type 1 (EV_KEY), code 225 (KEY_BRIGHTN=
ESSUP), value 1
> Event: time 1383862333.631341, -------------- SYN_REPORT ------------
> Event: time 1383862333.832775, type 4 (EV_MSC), code 4 (MSC_SCAN), va=
lue d9
> Event: time 1383862333.832775, type 1 (EV_KEY), code 225 (KEY_BRIGHTN=
ESSUP), value 0
> Event: time 1383862333.832775, -------------- SYN_REPORT ------------
> Event: time 1383862334.682950, type 4 (EV_MSC), code 4 (MSC_SCAN), va=
lue d4
> Event: time 1383862334.682950, type 1 (EV_KEY), code 237 (KEY_BLUETOO=
TH), value 1
> Event: time 1383862334.682950, -------------- SYN_REPORT ------------
> Event: time 1383862334.844099, type 4 (EV_MSC), code 4 (MSC_SCAN), va=
lue d4
> Event: time 1383862334.844099, type 1 (EV_KEY), code 237 (KEY_BLUETOO=
TH), value 0
> Event: time 1383862334.844099, -------------- SYN_REPORT ------------
> Event: time 1383862338.144505, type 4 (EV_MSC), code 4 (MSC_SCAN), va=
lue d9
> Event: time 1383862338.144505, type 1 (EV_KEY), code 225 (KEY_BRIGHTN=
ESSUP), value 1
> Event: time 1383862338.144505, -------------- SYN_REPORT ------------
> Event: time 1383862338.386205, type 4 (EV_MSC), code 4 (MSC_SCAN), va=
lue d9
> Event: time 1383862338.386205, type 1 (EV_KEY), code 225 (KEY_BRIGHTN=
ESSUP), value 0
> Event: time 1383862338.386205, -------------- SYN_REPORT ------------
> Event: time 1383862339.167990, type 4 (EV_MSC), code 4 (MSC_SCAN), va=
lue 1d
> Event: time 1383862339.167990, type 1 (EV_KEY), code 29 (KEY_LEFTCTRL=
), value 1
> Event: time 1383862339.167990, -------------- SYN_REPORT ------------
> Event: time 1383862339.319043, type 4 (EV_MSC), code 4 (MSC_SCAN), va=
lue 2e
> Event: time 1383862339.319043, type 1 (EV_KEY), code 46 (KEY_C), valu=
e 1
> Event: time 1383862339.319043, -------------- SYN_REPORT ------------

Ok, it's not really clear to me which keys you actually pressed.
Judging from the timing-information, your Bluetooth key causes
brightness-up and your brightness-up key causes KEY_BLUETOOTH? Is that
correct?

Thanks
David
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
