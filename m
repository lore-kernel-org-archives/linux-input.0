From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Dell ALPS patches for Dell Latitude E5250/5250, E5450/5450, E5550/5550
Date: Tue, 10 Feb 2015 10:29:31 +0100
Message-ID: <201502101029.31708@pali>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart33111634.YzIL0kMpzL";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Hans de Goede <hdegoede@redhat.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Vadim Klishko <vadim@cirque.com>
List-Id: linux-input@vger.kernel.org

--nextPart33111634.YzIL0kMpzL
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hello,

I want to let you know that Dell officially provides modified
psmouse/alps.c driver for Ubuntu 14.04 from Dell support webpage:
http://www.dell.com/support/home/ga/en/gadhs1/Drivers/DriversDetails?driver=
Id=3DCGC6T

I do not own any of E5250/5250, E5450/5450, E5550/5550 machines,
but at least you should know that Dell (or some subcontractor) is
modifying linux kernel drivers to work on Dell machines with
Ubuntu.

I generated diff against upstream linux v3.17-rc1 version. Maybe
it can be useful for other people (who do not use Ubuntu and
therefore cannot install Dell driver package).

Btw, same alps_probe_trackstick_v3() "hack" code is already for
rushmore devices in upstream kernel...=20


=2D-- linux-3.17-rc1/drivers/input/mouse/alps.c	2015-02-08 12:30:54.6685542=
21 +0100
+++ houston-15_A10.fish.tar.gz/debs/touchpad-alps-trusty-dkms_1.0_all.deb/u=
sr/src/touchpad-alps-trusty-1.0/alps.c	2014-09-15 11:49:10.000000000 +0200
@@ -24,12 +24,15 @@
 #include "psmouse.h"
 #include "alps.h"
=20
+#define ALPS_DRIVER_RELEASE_DATE	"2014/08/25"
+
 /*
  * Definitions for ALPS version 3 and 4 command mode protocol
  */
 #define ALPS_CMD_NIBBLE_10	0x01f2
=20
 #define ALPS_REG_BASE_RUSHMORE	0xc2c0
+#define ALPS_REG_BASE_V7	0xc2c0
 #define ALPS_REG_BASE_PINNACLE	0x0000
=20
 static const struct alps_nibble_commands alps_v3_nibble_commands[] =3D {
@@ -2208,6 +2211,12 @@ static int alps_identify(struct psmouse
 		priv->proto_version =3D ALPS_PROTO_V7;
 		alps_set_defaults(priv);
=20
+		/* hack to make addr_command, nibble_command available */
+		psmouse->private =3D priv;
+
+		if (alps_probe_trackstick_v3(psmouse, ALPS_REG_BASE_V7))
+			priv->flags &=3D ~ALPS_DUALPOINT;
+
 		return 0;
 	} else if (ec[0] =3D=3D 0x88 && ec[1] =3D=3D 0x08) {
 		priv->proto_version =3D ALPS_PROTO_V3;
@@ -2312,6 +2321,8 @@ int alps_init(struct psmouse *psmouse)
 	if (priv->hw_init(psmouse))
 		goto init_fail;
=20
+	printk("ALPS driver in use! %s, date:%s \n", __func__, ALPS_DRIVER_RELEAS=
E_DATE);
+
 	/*
 	 * Undo part of setup done for us by psmouse core since touchpad
 	 * is not a relative device.


=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart33111634.YzIL0kMpzL
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlTZz3sACgkQi/DJPQPkQ1JnUgCggqysvmknRXi0MiSSdN3LKmvT
cDkAoI1SezN5HINReupvefGYbpNJPS5j
=VodX
-----END PGP SIGNATURE-----

--nextPart33111634.YzIL0kMpzL--
