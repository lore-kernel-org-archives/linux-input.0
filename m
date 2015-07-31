From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Initialization of TPPS/2 IBM TrackPoint in too slow
Date: Fri, 31 Jul 2015 18:59:21 +0200
Message-ID: <201507311859.22045@pali>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1804530.P6yahemBsi";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Hans de Goede <hdegoede@redhat.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

--nextPart1804530.P6yahemBsi
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hello,

here is output from dmesg for psmouse.ko

[  266.378751] psmouse: calling psmouse_init()
[  267.167150] psmouse serio1: synaptics: queried max coordinates: x [..567=
6], y [..4758]
[  267.198416] psmouse serio1: synaptics: queried min coordinates: x [1266.=
=2E], y [1096..]
[  267.260402] psmouse serio1: synaptics: Touchpad model: 1, fw: 8.1, id: 0=
x1e2b1, caps: 0xf002a3/0x943300/0x12e800, board=20
id: 3072, fw id: 2560
[  267.260418] psmouse serio1: synaptics: serio: Synaptics pass-through por=
t at isa0060/serio1/input0
[  267.299629] input: SynPS/2 Synaptics TouchPad as /devices/platform/i8042=
/serio1/input/input39
[  268.697333] psmouse serio4: cypress_ps2: send extension cmd 0x00, [0 0 0=
 0]
[  269.259351] psmouse serio4: cypress_ps2: Command 0x00 response data (0x)=
: 00 00 14
[  269.562762] psmouse serio4: alps: E6 report: 00 00 64
[  269.825915] psmouse serio4: alps: E7 report: 10 00 64
[  270.086671] psmouse serio4: alps: EC report: 10 00 64
[  270.125866] psmouse serio4: alps: Likely not an ALPS touchpad: E7=3D10 0=
0 64, EC=3D10 00 64
[  270.388147] psmouse serio4: elantech: unexpected magic knock result 0x00=
, 0x02, 0x64.
[  271.390241] psmouse serio4: trackpoint: IBM TrackPoint firmware: 0x0e, b=
uttons: 3/3
[  271.586156] input: TPPS/2 IBM TrackPoint as /devices/platform/i8042/seri=
o1/serio4/input/input40

As you can see it takes about 5 seconds to initialize TrackPoint input
device. And about 3 seconds from stage after synaptics export serio
device. I think this is just because of trying to detect device type.
Is there any way how to speed it up? Maybe for synaptics serio devices
try to probe for TPPS/2 at first?

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart1804530.P6yahemBsi
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlW7qWoACgkQi/DJPQPkQ1L7GQCgiDirXiuW8CPyPCoNMeC6+I6v
gB4An2LwZ+AWMQLEh/snRqzdJZ5uIdgP
=A1mL
-----END PGP SIGNATURE-----

--nextPart1804530.P6yahemBsi--
