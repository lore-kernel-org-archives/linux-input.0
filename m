From: Paul Menzel <paulepanter@users.sourceforge.net>
Subject: Lenovo T60 and X60: psmouse serio1: alps: Unknown ALPS touchpad:
 E7=10 00 64, EC=10 00 64
Date: Sat, 23 Aug 2014 12:16:27 +0200
Message-ID: <1408788987.2724.25.camel@mattotaupa>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-DmhWVQFnqzwu6MTuDg//"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.gw90.de ([188.40.100.199]:60518 "EHLO mail.gw90.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752336AbaHWKmm (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sat, 23 Aug 2014 06:42:42 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Yunkang Tang <yunkang.tang@cn.alps.com>


--=-DmhWVQFnqzwu6MTuDg//
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dear Linux developers,


with at least Linux 3.12, 3.13 and 3.14 the Linux kernel log contains a
message about an unknown ALPS touchpad.

[=E2=80=A6]
[    8.793232] psmouse serio1: alps: Unknown ALPS touchpad: E7=3D10 00 64, =
EC=3D10 00 64
[    9.068102] Console: switching to colour frame buffer device 128x48
[    9.072053] i915 0000:00:02.0: fb0: inteldrmfb frame buffer device
[    9.072056] i915 0000:00:02.0: registered panic notifier
[    9.072075] [drm] Initialized i915 1.6.0 20080730 for 0000:00:02.0 on mi=
nor 0
[    9.073703] hda_intel: probe_mask set to 0x1 for device 17aa:2010
[    9.074158] snd_hda_intel 0000:00:1b.0: irq 47 for MSI/MSI-X
[    9.104435] input: HDA Digital PCBeep as /devices/pci0000:00/0000:00:1b.=
0/input/input8
[    9.107546] input: HDA Intel Front Headphone as /devices/pci0000:00/0000=
:00:1b.0/sound/card0/input13
[    9.107678] input: HDA Intel Line Out as /devices/pci0000:00/0000:00:1b.=
0/sound/card0/input12
[    9.107793] input: HDA Intel Line as /devices/pci0000:00/0000:00:1b.0/so=
und/card0/input11
[    9.107909] input: HDA Intel Front Mic as /devices/pci0000:00/0000:00:1b=
.0/sound/card0/input10
[    9.108044] input: HDA Intel Rear Mic as /devices/pci0000:00/0000:00:1b.=
0/sound/card0/input9
[    9.168843] psmouse serio1: trackpoint: IBM TrackPoint firmware: 0x0e, b=
uttons: 3/3
[    9.189695] input: TPPS/2 IBM TrackPoint as /devices/platform/i8042/seri=
o1/input/input6
[=E2=80=A6]

The Lenovo T60 actually has a touchpad, a trackpoint and three buttons,
where the Lenovo X60 only has a trackpoint and three buttons.

Searching the Web with this message, there are also hits for other
laptop models.

Looking at `drivers/input/mouse/alps.c` the values checked there for E7
and EC are not related at all. It=E2=80=99s also interesting that E7 and EC
contain the same values.

Is that the trackpoint device detected later and should therefore be
ignored?


Thanks,

Paul

--=-DmhWVQFnqzwu6MTuDg//
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEABECAAYFAlP4ahYACgkQPX1aK2wOHVjlCgCgjEdoZPPBwNtl8ndGXXeIqCCH
pcAAnAmnyhJ2VI9Y8M3QarHxAWnHboVo
=eYjr
-----END PGP SIGNATURE-----

--=-DmhWVQFnqzwu6MTuDg//--

