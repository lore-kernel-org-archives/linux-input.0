From: Andrey Rahmatullin <wrar@wrar.name>
Subject: Re: Quick note about the elantech driver
Date: Fri, 17 Jun 2011 01:40:01 +0600
Message-ID: <20110616194001.GE7253@belkar.wrar.name>
References: <4DFA1682.2090403@tudelft.nl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="n+lFg1Zro7sl44OB"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from wrar.name ([109.74.195.39]:43242 "EHLO haley.wrar.name"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755483Ab1FPUBN (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 16 Jun 2011 16:01:13 -0400
Content-Disposition: inline
In-Reply-To: <4DFA1682.2090403@tudelft.nl>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?iso-8859-1?Q?=C9ric?= Piel <E.A.B.Piel@tudelft.nl>
Cc: linux-input@vger.kernel.org


--n+lFg1Zro7sl44OB
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 16, 2011 at 04:43:14PM +0200, =C9ric Piel wrote:
> I've just found out that there is a patch written by Elantech
> themselves for getting more versions of their touchpads working with
> the latest kernels:
> https://launchpadlibrarian.net/71387234/01elantech_2.6.38.patch
>=20
> So if anyone has problem with a new elantech touchpad she/he can try
> this patch :-)
I've tested this on 2.6.39.1 (applies cleanly) with ASUS K53E and it
works.
On the module load I get this:

[   62.958694] 2.6.2X-Elan-touchpad-2011-04-12
[   63.365850] elantech.c: PSMOUSE_CMD_RESET_BAT  param[0]=3Daa param[1]=3D=
0 param[2]=3D0
[   63.415274] elantech.c: Elantech version query result 0x45, 0x0f, 0x01.
[   63.440436] param[0] =3D 45 param[1] =3D f param[2] =3D 1=20
[   63.441287] elantech.c: assuming hardware version 9, firmware version 0x=
45.0x0f.0x01
[   63.477535] val =3D 0x0f=20
[   63.504554] input: ETPS/2 Elantech ETF1059 Click-Pad as /devices/platfor=
m/i8042/serio4/input/input10

In the X log:

[    63.247] (II) config/udev: Adding input device ETPS/2 Elantech ETF1059 =
Click-Pad (/dev/input/event10)
[    63.247] (**) ETPS/2 Elantech ETF1059 Click-Pad: Applying InputClass "e=
vdev pointer catchall"
[    63.247] (**) ETPS/2 Elantech ETF1059 Click-Pad: Applying InputClass "e=
vdev touchpad catchall"
[    63.247] (**) ETPS/2 Elantech ETF1059 Click-Pad: Applying InputClass "t=
ouchpad catchall"
[    63.247] (II) Using input driver 'synaptics' for 'ETPS/2 Elantech ETF10=
59 Click-Pad'
[    63.247] (II) Loading /usr/lib/xorg/modules/input/synaptics_drv.so
[    63.247] (**) ETPS/2 Elantech ETF1059 Click-Pad: always reports core ev=
ents
[    63.247] (**) Option "Device" "/dev/input/event10"
[    63.295] (--) ETPS/2 Elantech ETF1059 Click-Pad: x-axis range 0 - 2508
[    63.295] (--) ETPS/2 Elantech ETF1059 Click-Pad: y-axis range 0 - 1320
[    63.295] (--) ETPS/2 Elantech ETF1059 Click-Pad: pressure range 0 - 255
[    63.295] (--) ETPS/2 Elantech ETF1059 Click-Pad: finger width range 0 -=
 16
[    63.295] (--) ETPS/2 Elantech ETF1059 Click-Pad: buttons: left right mi=
ddle double triple scroll-buttons
[    63.331] (--) ETPS/2 Elantech ETF1059 Click-Pad: touchpad found
[    63.331] (**) ETPS/2 Elantech ETF1059 Click-Pad: always reports core ev=
ents
[    63.347] (**) Option "config_info" "udev:/sys/devices/platform/i8042/se=
rio4/input/input10/event10"
[    63.347] (II) XINPUT: Adding extended input device "ETPS/2 Elantech ETF=
1059 Click-Pad" (type: TOUCHPAD)
[    63.347] (**) ETPS/2 Elantech ETF1059 Click-Pad: (accel) MinSpeed is no=
w constant deceleration 2.5
[    63.347] (**) ETPS/2 Elantech ETF1059 Click-Pad: MaxSpeed is now 1.75
[    63.347] (**) ETPS/2 Elantech ETF1059 Click-Pad: AccelFactor is now 0.0=
71
[    63.347] (**) ETPS/2 Elantech ETF1059 Click-Pad: (accel) keeping accele=
ration scheme 1
[    63.347] (**) ETPS/2 Elantech ETF1059 Click-Pad: (accel) acceleration p=
rofile 1
[    63.347] (**) ETPS/2 Elantech ETF1059 Click-Pad: (accel) acceleration f=
actor: 2.000
[    63.347] (**) ETPS/2 Elantech ETF1059 Click-Pad: (accel) acceleration t=
hreshold: 4

Multitouch now works.


--=20
WBR, wRAR

--n+lFg1Zro7sl44OB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBCAAGBQJN+lwRAAoJEDNi9wMaSZLhDq4P/2VXjZQlFoFeNyBL5aqKLWri
C5oDokbbxZF540tYjGzWOxA2oIku+dZheh4HcFGwLwqv5u5DeleX0Fne8v1hXIiT
bYbLtxbsjgOFQTU1diftoICkTNGxFzjXD+/3BisntPSyMePSxAwB6KXaekaufQMy
IfDvJZtZbCT7VoaqW1OVTNpFY5ERdjhKx+DTrKSfeA7e0b9MVa83xOiuitGlqL4m
d1ePrw/VzQkfZyA9bxUZkND9MkN6qcQriWfb3xK380FZlvA3WRps2z39kwnWA97a
wIKJaElTSEoE6Vk4Ge3tsDCIYZOpgkiuomST2+D8JxmcH0waw3RcZgfVLDt7Sdqz
wIZWvL5DrONzhxdZclBL/8nzpN5Ey7vlqILmZk6aroowrrX6QFH+u9o7cfVpQEI+
rQ8QH+kzEDJQfLdcdFh04PdnIjWG4WCFuH43BgYLeMg6dc7TnIxQacahScdc6ZiI
3buvVcF1/6gppXexU5Ty8dc+AtelXgjzvkEoOcEp/D/w6pmiUZkCWEaxj+Cc9JGp
XWyXAqGcZSzD4NF0AyhVju/LnKRNkuljtIV4K3Yw5jQeCoOZdnpUPFniG2nsIY/g
k/n2S9EczKswtUeaK9rS07x9BgLcXYifL66KQJksLHpohJXV1wdwumZ83gCkd4Eb
dMoOUaNztN8fXZkMICxo
=rAKA
-----END PGP SIGNATURE-----

--n+lFg1Zro7sl44OB--
