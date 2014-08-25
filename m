From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Lenovo T60 and X60: psmouse serio1: alps: Unknown ALPS touchpad:
 E7=10 00 64, EC=10 00 64
Date: Mon, 25 Aug 2014 11:23:32 -0700
Message-ID: <20140825182332.GB35881@core.coreip.homeip.net>
References: <1408788987.2724.25.camel@mattotaupa>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f173.google.com ([209.85.192.173]:35507 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755086AbaHYSXg (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 25 Aug 2014 14:23:36 -0400
Received: by mail-pd0-f173.google.com with SMTP id w10so20814681pde.32
        for <linux-input@vger.kernel.org>; Mon, 25 Aug 2014 11:23:36 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1408788987.2724.25.camel@mattotaupa>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Paul Menzel <paulepanter@users.sourceforge.net>
Cc: linux-input@vger.kernel.org, Yunkang Tang <yunkang.tang@cn.alps.com>

On Sat, Aug 23, 2014 at 12:16:27PM +0200, Paul Menzel wrote:
> Dear Linux developers,
>=20
>=20
> with at least Linux 3.12, 3.13 and 3.14 the Linux kernel log contains=
 a
> message about an unknown ALPS touchpad.
>=20
> [=E2=80=A6]
> [    8.793232] psmouse serio1: alps: Unknown ALPS touchpad: E7=3D10 0=
0 64, EC=3D10 00 64
> [    9.068102] Console: switching to colour frame buffer device 128x4=
8
> [    9.072053] i915 0000:00:02.0: fb0: inteldrmfb frame buffer device
> [    9.072056] i915 0000:00:02.0: registered panic notifier
> [    9.072075] [drm] Initialized i915 1.6.0 20080730 for 0000:00:02.0=
 on minor 0
> [    9.073703] hda_intel: probe_mask set to 0x1 for device 17aa:2010
> [    9.074158] snd_hda_intel 0000:00:1b.0: irq 47 for MSI/MSI-X
> [    9.104435] input: HDA Digital PCBeep as /devices/pci0000:00/0000:=
00:1b.0/input/input8
> [    9.107546] input: HDA Intel Front Headphone as /devices/pci0000:0=
0/0000:00:1b.0/sound/card0/input13
> [    9.107678] input: HDA Intel Line Out as /devices/pci0000:00/0000:=
00:1b.0/sound/card0/input12
> [    9.107793] input: HDA Intel Line as /devices/pci0000:00/0000:00:1=
b.0/sound/card0/input11
> [    9.107909] input: HDA Intel Front Mic as /devices/pci0000:00/0000=
:00:1b.0/sound/card0/input10
> [    9.108044] input: HDA Intel Rear Mic as /devices/pci0000:00/0000:=
00:1b.0/sound/card0/input9
> [    9.168843] psmouse serio1: trackpoint: IBM TrackPoint firmware: 0=
x0e, buttons: 3/3
> [    9.189695] input: TPPS/2 IBM TrackPoint as /devices/platform/i804=
2/serio1/input/input6
> [=E2=80=A6]
>=20
> The Lenovo T60 actually has a touchpad, a trackpoint and three button=
s,
> where the Lenovo X60 only has a trackpoint and three buttons.
>=20
> Searching the Web with this message, there are also hits for other
> laptop models.
>=20
> Looking at `drivers/input/mouse/alps.c` the values checked there for =
E7
> and EC are not related at all. It=E2=80=99s also interesting that E7 =
and EC
> contain the same values.
>=20
> Is that the trackpoint device detected later and should therefore be
> ignored?

Yes. I'll add a patch to suppress this message (or rather turn it to a
debug message) as it confuses users.

Thanks.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
