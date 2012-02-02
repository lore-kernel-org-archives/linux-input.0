From: zitev <zitev@freemail.hu>
Subject: Re: not supported hardware: Gigabyte K8100 Aivia USB Gaming Keyboard
Date: Thu, 02 Feb 2012 21:16:48 +0100
Message-ID: <4F2AEF30.5080805@freemail.hu>
References: <4D55AE81.3030805@freemail.hu> <20120126002100.GA4495@burratino> <4F21C49D.2010906@freemail.hu> <20120126213939.GA5179@burratino> <4F230A1A.7080508@freemail.hu> <20120128071223.GA27331@burratino> <4F299010.5090009@freemail.hu> <alpine.LNX.2.00.1202012104030.18918@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail00k.mail.t-online.hu ([84.2.227.137]:53986 "EHLO
	mail00k.mail.t-online.hu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751176Ab2BBUQw (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 2 Feb 2012 15:16:52 -0500
In-Reply-To: <alpine.LNX.2.00.1202012104030.18918@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Jonathan Nieder <jrnieder@gmail.com>, linux-usb@vger.kernel.org, linux-input@vger.kernel.org

I check cat /dev/input/event6, and only the backspace-button working on=
=20
this keyboard...
I start pressing cat /sys/kernel/debug/hid/, and found the next subfold=
ers:

0003:060B:2270.0004/
0003:060B:2270.0005/
0003:1044:7A02.0001/
0003:1044:7A02.0002/
0003:1044:7A02.0003/

"player:/home/vitez# cat /sys/kernel/debug/hid/0003\:060B\:2270.0004/ev=
ents
(and pressing the backspace key):

report (size 8) (unnumbered) =3D  00 00 2a 00 00 00 00 00
Keyboard.00e0 =3D 0
Keyboard.00e1 =3D 0
Keyboard.00e2 =3D 0
Keyboard.00e3 =3D 0
Keyboard.00e4 =3D 0
Keyboard.00e5 =3D 0
Keyboard.00e6 =3D 0
Keyboard.00e7 =3D 0
Keyboard.002a =3D 1

report (size 8) (unnumbered) =3D  00 00 00 00 00 00 00 00
Keyboard.00e0 =3D 0
Keyboard.00e1 =3D 0
Keyboard.00e2 =3D 0
Keyboard.00e3 =3D 0
Keyboard.00e4 =3D 0
Keyboard.00e5 =3D 0
Keyboard.00e6 =3D 0
Keyboard.00e7 =3D 0
Keyboard.002a =3D 0

report (size 8) (unnumbered) =3D  00 00 2a 00 00 00 00 00
Keyboard.00e0 =3D 0
Keyboard.00e1 =3D 0
Keyboard.00e2 =3D 0
Keyboard.00e3 =3D 0
Keyboard.00e4 =3D 0
Keyboard.00e5 =3D 0
Keyboard.00e6 =3D 0
Keyboard.00e7 =3D 0
Keyboard.002a =3D 1

report (size 8) (unnumbered) =3D  00 00 00 00 00 00 00 00
Keyboard.00e0 =3D 0
Keyboard.00e1 =3D 0
Keyboard.00e2 =3D 0
Keyboard.00e3 =3D 0
Keyboard.00e4 =3D 0
Keyboard.00e5 =3D 0
Keyboard.00e6 =3D 0
Keyboard.00e7 =3D 0
Keyboard.002a =3D 0

report (size 8) (unnumbered) =3D  00 00 2a 00 00 00 00 00
Keyboard.00e0 =3D 0
Keyboard.00e1 =3D 0
Keyboard.00e2 =3D 0
Keyboard.00e3 =3D 0
Keyboard.00e4 =3D 0
Keyboard.00e5 =3D 0
Keyboard.00e6 =3D 0
Keyboard.00e7 =3D 0
Keyboard.002a =3D 1

report (size 8) (unnumbered) =3D  00 00 00 00 00 00 00 00
Keyboard.00e0 =3D 0
Keyboard.00e1 =3D 0
Keyboard.00e2 =3D 0
Keyboard.00e3 =3D 0
Keyboard.00e4 =3D 0
Keyboard.00e5 =3D 0
Keyboard.00e6 =3D 0
Keyboard.00e7 =3D 0
Keyboard.002a =3D 0"

"cat /sys/kernel/debug/hid/0003\:060B\:2270.0004/rdesc
05 01 09 06 a1 01 05 07 19 e0 29 e7 15 00 25 01 75 01 95 08 81 02 95 01=
=20
75 08 81 01 95 03 75 01 05 08 19 01 29 03 91 02 95 05 75 01 91 01 95 06=
=20
75 08 26 ff 00 05 07 19 00 29 91 81 00 09 00 15 00 26 ff 00 75 08 95 08=
=20
b1 00 c0

   INPUT[INPUT]
     Field(0)
       Application(GenericDesktop.Keyboard)
       Usage(8)
         Keyboard.00e0
         Keyboard.00e1
         Keyboard.00e2
         Keyboard.00e3
         Keyboard.00e4
         Keyboard.00e5
         Keyboard.00e6
         Keyboard.00e7
       Logical Minimum(0)
       Logical Maximum(1)
       Report Size(1)
       Report Count(8)
       Report Offset(0)
       Flags( Variable Absolute )
     Field(1)
       Application(GenericDesktop.Keyboard)
       Usage(146)
         Keyboard.0000
         Keyboard.0001
         Keyboard.0002
         Keyboard.0003
         Keyboard.0004
         Keyboard.0005
         Keyboard.0006
         Keyboard.0007
         Keyboard.0008
         Keyboard.0009
         Keyboard.000a
         Keyboard.000b
         Keyboard.000c
         Keyboard.000d
         Keyboard.000e
         Keyboard.000f
         Keyboard.0010
         Keyboard.0011
         Keyboard.0012
         Keyboard.0013
         Keyboard.0014
         Keyboard.0015
         Keyboard.0016
         Keyboard.0017
         Keyboard.0018
         Keyboard.0019
         Keyboard.001a
         Keyboard.001b
         Keyboard.001c
         Keyboard.001d
         Keyboard.001e
         Keyboard.001f
         Keyboard.0020
         Keyboard.0021
         Keyboard.0022
         Keyboard.0023
         Keyboard.0024
         Keyboard.0025
         Keyboard.0026
         Keyboard.0027
         Keyboard.0028
         Keyboard.0029
         Keyboard.002a
         Keyboard.002b
         Keyboard.002c
         Keyboard.002d
         Keyboard.002e
         Keyboard.002f
         Keyboard.0030
         Keyboard.0031
         Keyboard.0032
         Keyboard.0033
         Keyboard.0034
         Keyboard.0035
         Keyboard.0036
         Keyboard.0037
         Keyboard.0038
         Keyboard.0039
         Keyboard.003a
         Keyboard.003b
         Keyboard.003c
         Keyboard.003d
         Keyboard.003e
         Keyboard.003f
         Keyboard.0040
         Keyboard.0041
         Keyboard.0042
         Keyboard.0043
         Keyboard.0044
         Keyboard.0045
         Keyboard.0046
         Keyboard.0047
         Keyboard.0048
         Keyboard.0049
         Keyboard.004a
         Keyboard.004b
         Keyboard.004c
         Keyboard.004d
         Keyboard.004e
         Keyboard.004f
         Keyboard.0050
         Keyboard.0051
         Keyboard.0052
         Keyboard.0053
         Keyboard.0054
         Keyboard.0055
         Keyboard.0056
         Keyboard.0057
         Keyboard.0058
         Keyboard.0059
         Keyboard.005a
         Keyboard.005b
         Keyboard.005c
         Keyboard.005d
         Keyboard.005e
         Keyboard.005f
         Keyboard.0060
         Keyboard.0061
         Keyboard.0062
         Keyboard.0063
         Keyboard.0064
         Keyboard.0065
         Keyboard.0066
         Keyboard.0067
         Keyboard.0068
         Keyboard.0069
         Keyboard.006a
         Keyboard.006b
         Keyboard.006c
         Keyboard.006d
         Keyboard.006e
         Keyboard.006f
         Keyboard.0070
         Keyboard.0071
         Keyboard.0072
         Keyboard.0073
         Keyboard.0074
         Keyboard.0075
         Keyboard.0076
         Keyboard.0077
         Keyboard.0078
         Keyboard.0079
         Keyboard.007a
         Keyboard.007b
         Keyboard.007c
         Keyboard.007d
         Keyboard.007e
         Keyboard.007f
         Keyboard.0080
         Keyboard.0081
         Keyboard.0082
         Keyboard.0083
         Keyboard.0084
         Keyboard.0085
         Keyboard.0086
         Keyboard.0087
         Keyboard.0088
         Keyboard.0089
         Keyboard.008a
         Keyboard.008b
         Keyboard.008c
         Keyboard.008d
         Keyboard.008e
         Keyboard.008f
         Keyboard.0090
         Keyboard.0091
       Logical Minimum(0)
       Logical Maximum(255)
       Report Size(8)
       Report Count(6)
       Report Offset(16)
       Flags( Array Absolute )
   OUTPUT[OUTPUT]
     Field(0)
       Application(GenericDesktop.Keyboard)
       Usage(3)
         LED.NumLock
         LED.CapsLock
         LED.ScrollLock
       Logical Minimum(0)
       Logical Maximum(1)
       Report Size(1)
       Report Count(3)
       Report Offset(0)
       Flags( Variable Absolute )
   FEATURE[FEATURE]
     Field(0)
       Application(GenericDesktop.Keyboard)
       Usage(8)
         Keyboard.0000
         Keyboard.0000
         Keyboard.0000
         Keyboard.0000
         Keyboard.0000
         Keyboard.0000
         Keyboard.0000
         Keyboard.0000
       Logical Minimum(0)
       Logical Maximum(255)
       Report Size(8)
       Report Count(8)
       Report Offset(0)
       Flags( Array Absolute )

Keyboard.00e0 ---> Key.LeftControl
Keyboard.00e1 ---> Key.LeftShift
Keyboard.00e2 ---> Key.LeftAlt
Keyboard.00e3 ---> Key.LeftMeta
Keyboard.00e4 ---> Key.RightCtrl
Keyboard.00e5 ---> Key.RightShift
Keyboard.00e6 ---> Key.RightAlt
Keyboard.00e7 ---> Key.RightMeta
Keyboard.0000 ---> Sync.Report
Keyboard.0001 ---> Sync.Report
Keyboard.0002 ---> Sync.Report
Keyboard.0003 ---> Sync.Report
Keyboard.0004 ---> Key.A
Keyboard.0005 ---> Key.B
Keyboard.0006 ---> Key.C
Keyboard.0007 ---> Key.D
Keyboard.0008 ---> Key.E
Keyboard.0009 ---> Key.F
Keyboard.000a ---> Key.G
Keyboard.000b ---> Key.H
Keyboard.000c ---> Key.I
Keyboard.000d ---> Key.J
Keyboard.000e ---> Key.K
Keyboard.000f ---> Key.L
Keyboard.0010 ---> Key.M
Keyboard.0011 ---> Key.N
Keyboard.0012 ---> Key.O
Keyboard.0013 ---> Key.P
Keyboard.0014 ---> Key.Q
Keyboard.0015 ---> Key.R
Keyboard.0016 ---> Key.S
Keyboard.0017 ---> Key.T
Keyboard.0018 ---> Key.U
Keyboard.0019 ---> Key.V
Keyboard.001a ---> Key.W
Keyboard.001b ---> Key.X
Keyboard.001c ---> Key.Y
Keyboard.001d ---> Key.Z
Keyboard.001e ---> Key.1
Keyboard.001f ---> Key.2
Keyboard.0020 ---> Key.3
Keyboard.0021 ---> Key.4
Keyboard.0022 ---> Key.5
Keyboard.0023 ---> Key.6
Keyboard.0024 ---> Key.7
Keyboard.0025 ---> Key.8
Keyboard.0026 ---> Key.9
Keyboard.0027 ---> Key.0
Keyboard.0028 ---> Key.Enter
Keyboard.0029 ---> Key.Esc
Keyboard.002a ---> Key.Backspace
Keyboard.002b ---> Key.Tab
Keyboard.002c ---> Key.Space
Keyboard.002d ---> Key.Minus
Keyboard.002e ---> Key.Equal
Keyboard.002f ---> Key.LeftBrace
Keyboard.0030 ---> Key.RightBrace
Keyboard.0031 ---> Key.BackSlash
Keyboard.0032 ---> Key.BackSlash
Keyboard.0033 ---> Key.Semicolon
Keyboard.0034 ---> Key.Apostrophe
Keyboard.0035 ---> Key.Grave
Keyboard.0036 ---> Key.Comma
Keyboard.0037 ---> Key.Dot
Keyboard.0038 ---> Key.Slash
Keyboard.0039 ---> Key.CapsLock
Keyboard.003a ---> Key.F1
Keyboard.003b ---> Key.F2
Keyboard.003c ---> Key.F3
Keyboard.003d ---> Key.F4
Keyboard.003e ---> Key.F5
Keyboard.003f ---> Key.F6
Keyboard.0040 ---> Key.F7
Keyboard.0041 ---> Key.F8
Keyboard.0042 ---> Key.F9
Keyboard.0043 ---> Key.F10
Keyboard.0044 ---> Key.F11
Keyboard.0045 ---> Key.F12
Keyboard.0046 ---> Key.SysRq
Keyboard.0047 ---> Key.ScrollLock
Keyboard.0048 ---> Key.Pause
Keyboard.0049 ---> Key.Insert
Keyboard.004a ---> Key.Home
Keyboard.004b ---> Key.PageUp
Keyboard.004c ---> Key.Delete
Keyboard.004d ---> Key.End
Keyboard.004e ---> Key.PageDown
Keyboard.004f ---> Key.Right
Keyboard.0050 ---> Key.Left
Keyboard.0051 ---> Key.Down
Keyboard.0052 ---> Key.Up
Keyboard.0053 ---> Key.NumLock
Keyboard.0054 ---> Key.KPSlash
Keyboard.0055 ---> Key.KPAsterisk
Keyboard.0056 ---> Key.KPMinus
Keyboard.0057 ---> Key.KPPlus
Keyboard.0058 ---> Key.KPEnter
Keyboard.0059 ---> Key.KP1
Keyboard.005a ---> Key.KP2
Keyboard.005b ---> Key.KP3
Keyboard.005c ---> Key.KP4
Keyboard.005d ---> Key.KP5
Keyboard.005e ---> Key.KP6
Keyboard.005f ---> Key.KP7
Keyboard.0060 ---> Key.KP8
Keyboard.0061 ---> Key.KP9
Keyboard.0062 ---> Key.KP0
Keyboard.0063 ---> Key.KPDot
Keyboard.0064 ---> Key.102nd
Keyboard.0065 ---> Key.Compose
Keyboard.0066 ---> Key.Power
Keyboard.0067 ---> Key.KPEqual
Keyboard.0068 ---> Key.F13
Keyboard.0069 ---> Key.F14
Keyboard.006a ---> Key.F15
Keyboard.006b ---> Key.F16
Keyboard.006c ---> Key.F17
Keyboard.006d ---> Key.F18
Keyboard.006e ---> Key.F19
Keyboard.006f ---> Key.F20
Keyboard.0070 ---> Key.F21
Keyboard.0071 ---> Key.F22
Keyboard.0072 ---> Key.F23
Keyboard.0073 ---> Key.F24
Keyboard.0074 ---> Key.Open
Keyboard.0075 ---> Key.Help
Keyboard.0076 ---> Key.Props
Keyboard.0077 ---> Key.Front
Keyboard.0078 ---> Key.Stop
Keyboard.0079 ---> Key.Again
Keyboard.007a ---> Key.Undo
Keyboard.007b ---> Key.Cut
Keyboard.007c ---> Key.Copy
Keyboard.007d ---> Key.Paste
Keyboard.007e ---> Key.Find
Keyboard.007f ---> Key.Mute
Keyboard.0080 ---> Key.VolumeUp
Keyboard.0081 ---> Key.VolumeDown
Keyboard.0082 ---> Key.Unknown
Keyboard.0083 ---> Key.Unknown
Keyboard.0084 ---> Key.Unknown
Keyboard.0085 ---> Key.KPComma
Keyboard.0086 ---> Key.Unknown
Keyboard.0087 ---> Key.RO
Keyboard.0088 ---> Key.Katakana/Hiragana
Keyboard.0089 ---> Key.Yen
Keyboard.008a ---> Key.Henkan
Keyboard.008b ---> Key.Muhenkan
Keyboard.008c ---> Key.KPJpComma
Keyboard.008d ---> Key.Unknown
Keyboard.008e ---> Key.Unknown
Keyboard.008f ---> Key.Unknown
Keyboard.0090 ---> Key.Hangeul
Keyboard.0091 ---> Key.Hanja
LED.NumLock ---> LED.NumLock
LED.CapsLock ---> LED.CapsLock
LED.ScrollLock ---> LED.ScrollLock"

"cat /sys/kernel/debug/hid/0003\:060B\:2270.0005/rdesc
05 01 09 80 a1 01 85 01 19 81 29 83 15 00 25 01 95 03 75 01 81 02 95 01=
=20
75 05 81 01 c0 05 0c 09 01 a1 01 85 02 19 00 2a ff 7f 15 00 26 ff 7f 95=
=20
01 75 10 81 00 c0 05 01 09 06 a1 01 85 03 95 38 75 01 15 00 25 01 05 07=
=20
19 e0 29 e7 19 00 29 2f 81 02 c0 05 01 09 06 a1 01 85 04 95 38 75 01 15=
=20
00 25 01 05 07 19 30 29 67 81 02 c0

   INPUT(1)[INPUT]
     Field(0)
       Application(GenericDesktop.SystemControl)
       Usage(3)
         GenericDesktop.SystemPowerDown
         GenericDesktop.SystemSleep
         GenericDesktop.SystemWakeUp
       Logical Minimum(0)
       Logical Maximum(1)
       Report Size(1)
       Report Count(3)
       Report Offset(0)
       Flags( Variable Absolute )

GenericDesktop.SystemPowerDown ---> Sync.Report
GenericDesktop.SystemSleep ---> Sync.Report
GenericDesktop.SystemWakeUp ---> Sync.Report"

"cat /sys/kernel/debug/hid/0003\:1044\:7A02.0001/rdesc
05 01 09 06 a1 01 05 07 19 e0 29 e7 15 00 25 01 75 01 95 08 81 02 95 01=
=20
75 08 81 01 05 07 19 00 29 a4 16 a4 00 95 0e 81 00 c0

   INPUT[INPUT]
     Field(0)
       Application(GenericDesktop.Keyboard)
       Usage(8)
         Keyboard.00e0
         Keyboard.00e1
         Keyboard.00e2
         Keyboard.00e3
         Keyboard.00e4
         Keyboard.00e5
         Keyboard.00e6
         Keyboard.00e7
       Logical Minimum(0)
       Logical Maximum(1)
       Report Size(1)
       Report Count(8)
       Report Offset(0)
       Flags( Variable Absolute )

Keyboard.00e0 ---> Sync.Report
Keyboard.00e1 ---> Sync.Report
Keyboard.00e2 ---> Sync.Report
Keyboard.00e3 ---> Sync.Report
Keyboard.00e4 ---> Sync.Report
Keyboard.00e5 ---> Sync.Report
Keyboard.00e6 ---> Sync.Report
Keyboard.00e7 ---> Sync.Report"

"cat /sys/kernel/debug/hid/0003\:060B\:2270.0004/events
(with pressing backspace)

report (size 8) (unnumbered) =3D  00 00 2a 00 00 00 00 00
Keyboard.00e0 =3D 0
Keyboard.00e1 =3D 0
Keyboard.00e2 =3D 0
Keyboard.00e3 =3D 0
Keyboard.00e4 =3D 0
Keyboard.00e5 =3D 0
Keyboard.00e6 =3D 0
Keyboard.00e7 =3D 0
Keyboard.002a =3D 1

report (size 8) (unnumbered) =3D  00 00 00 00 00 00 00 00
Keyboard.00e0 =3D 0
Keyboard.00e1 =3D 0
Keyboard.00e2 =3D 0
Keyboard.00e3 =3D 0
Keyboard.00e4 =3D 0
Keyboard.00e5 =3D 0
Keyboard.00e6 =3D 0
Keyboard.00e7 =3D 0
Keyboard.002a =3D 0

report (size 8) (unnumbered) =3D  00 00 2a 00 00 00 00 00
Keyboard.00e0 =3D 0
Keyboard.00e1 =3D 0
Keyboard.00e2 =3D 0
Keyboard.00e3 =3D 0
Keyboard.00e4 =3D 0
Keyboard.00e5 =3D 0
Keyboard.00e6 =3D 0
Keyboard.00e7 =3D 0
Keyboard.002a =3D 1

report (size 8) (unnumbered) =3D  00 00 00 00 00 00 00 00
Keyboard.00e0 =3D 0
Keyboard.00e1 =3D 0
Keyboard.00e2 =3D 0
Keyboard.00e3 =3D 0
Keyboard.00e4 =3D 0
Keyboard.00e5 =3D 0
Keyboard.00e6 =3D 0
Keyboard.00e7 =3D 0
Keyboard.002a =3D 0"

2012-02-01 21:06 keltez=E9ssel, Jiri Kosina =EDrta:
> On Wed, 1 Feb 2012, zitev wrote:
>
>> I did every step of test, but after testing the /tmp/mon.out file is=
 0byte
>> (empty)
>>
>> next task?
> Does /dev/input/eventX get created? (I guess it does, as at least som=
e
> key(s) make it through).
>
> If so, please provide
>
> 	cat /sys/kernel/debug/hid/<device>/rdesc
>
> and
> 	cat /sys/kernel/debug/hid/<device>/events
>
> Please run the second command, then press some of the non-working key=
s
> (press "a" for starters), and provide the output.
>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
