From: Vadim Fint <mocksoul@gmail.com>
Subject: Re: T440s Synaptics clickpad: lost sync / KBC bad data
Date: Mon, 20 Jan 2014 21:50:04 +0400
Message-ID: <2617481.nqZfKbekRf@t440s>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bk0-f50.google.com ([209.85.214.50]:43043 "EHLO
	mail-bk0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750787AbaATRtY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 20 Jan 2014 12:49:24 -0500
Received: by mail-bk0-f50.google.com with SMTP id w16so1995807bkz.37
        for <linux-input@vger.kernel.org>; Mon, 20 Jan 2014 09:49:22 -0800 (PST)
Received: from t440s.localnet ([2a02:6b8:0:40c:5e51:4fff:fe87:b478])
        by mx.google.com with ESMTPSA id sx5sm1603760bkb.0.2014.01.20.09.49.21
        for <linux-input@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Jan 2014 09:49:21 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Hello!

I was having exactly the same issues with brand new T440s from Lenovo. =
psmouse=20
get lost sync every time I did a physical click on clickpad.

But for me that was HW issue: after disassembling notebook I saw touchp=
ad=20
cable was not snapped into touchpad at all. Because latch (with cable) =
moves=20
2-3mm each click -- what was bad contact during that.

To deal with that issue I did removed only internal battery pack and lo=
cked a=20
cable on touchpad with a screwdriver :) (15-20 minutes for whole operat=
ion)

Dont know what Windows internaly do with synaptics protocol, but there =
was no=20
issues in Windows at all (but in recovery mode clickpad was not working=
 at=20
all).

Anyway, no problems in Gentoo with 3.12-3-pf kernel for me now! And no =
more=20
that weird =E2=80=9Cout of sync=E2=80=9D messages from psmouse at all.

Hope this helps!!

> Hello everyone,
>=20
> I hope I'm at the right address here with my problems. If not, please=
 do
> point me in the correct direction.
>=20
> I have a Lenovo Thinkpad T440s with a Synaptics clickpad and an IBM
> trackpoint in it:
>=20
> input: PS/2 Synaptics TouchPad as
> /devices/platform/i8042/serio1/input/input120 psmouse serio1: synapti=
cs:
> Touchpad model: 1, fw: 8.1, id: 0x1e2b1, caps: 0xd001a3/0x940300/0x12=
7c00,
> board id: 2668, fw id: 1293989 psmouse serio1: synaptics: serio: Syna=
ptics
> pass-through port at isa0060/serio1/input0 input: SynPS/2 Synaptics
> TouchPad as /devices/platform/i8042/serio1/input/input123 psmouse ser=
io34:
> alps: Unknown ALPS touchpad: E7=3D10 00 64, EC=3D10 00 64 psmouse ser=
io34:
> trackpoint: IBM TrackPoint firmware: 0x0e, buttons: 3/3 input: TPPS/2=
 IBM
> TrackPoint as /devices/platform/i8042/serio1/serio34/input/input124
>=20
> The problem is that the trackpoint behaves incredibly erratic, someti=
mes
> working correctly for minutes at a time, sometimes just jumping aroun=
d and
> many times just hanging. I need to remove and re-insert the psmouse m=
odule
> to solve that. Alongside this behaviour, my kernel log also is gettin=
g
> spammed with messages like:
>=20
> psmouse serio1: TouchPad at isa0060/serio1/input0 lost sync at byte 1
> psmouse serio1: TouchPad at isa0060/serio1/input0 lost sync at byte 1
> psmouse serio1: TouchPad at isa0060/serio1/input0 lost sync at byte 1
> psmouse serio1: TouchPad at isa0060/serio1/input0 - driver resynced.
> and psmouse serio1: bad data from KBC - timeout
>=20
> What I've tried:
> - Tried the kernel options i8042.nomux=3D1 and i8042.reset=3D1
> - Disable acpi by passing acpi=3Doff to the kernel
> - Disabled CPU frequency scaling
> - Trying other protocols, e.g. by doing modprobe psmouse proto=3Dimps=
 or
> proto=3Dbare - Switching from vanilla 3.12 kernel to both the latest&=
greatest
> kernel from Linus' Git and an antique 3.1.0 kernel - Turning on
> i8042.debug. To my untrained eye, it looks like bytes of PS/2 data ar=
e just
> disappearing when the 'lost sync' messages kick in. I can give an exa=
mple
> of that if needed.
>=20
> Strangely, the symptoms have been getting worse in the 10 days I've h=
ad this
> machine: from the first few days with no trouble to today with the mo=
use
> crapping out almost once every ten seconds or so. I would say it's a =
DOA
> and claim my warranty, if not frustratingly the machine works perfect=
ly
> fine in Windows 8, with no touchpad trouble at all.
>=20
> I'm willing to try things on this machine, run patches or take any hi=
nt in
> what I can change to get this working; if it helps I can even poke an
> oscilloscope at the PS2 lines. Not having a working touchpad or touch=
point
> is getting a bit frustrating...
>=20
> Cheers,
> Jeroen

--
Regards,
Vadim Fint,
Moscow, Ru.
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
