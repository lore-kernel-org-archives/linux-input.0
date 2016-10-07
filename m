From: Christophe Tordeux <christophe@tordeux.net>
Subject: [PATCH 01/01] drivers:input:byd fix greedy detection of Sentelic FSP
 by the BYD touchpad driver
Date: Fri, 7 Oct 2016 12:41:48 +0800
Message-ID: <20161007044148.ssgxygdvmiwjsb55@sherka.pkbd.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="kddslezx7txezxi3"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx496502.smtp-engine.com ([217.160.92.157]:50622 "EHLO
        mx496502.smtp-engine.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752643AbcJGEtD (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Fri, 7 Oct 2016 00:49:03 -0400
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: gregkh@linuxfoundation.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>


--kddslezx7txezxi3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

=46rom: Christophe TORDEUX <christophe@tordeux.net>

With kernel v4.6 and later, the Sentelic touchpad STL3888_C0 and
probably other Sentelic FSP touchpads are detected as a BYD touchpad and
lose multitouch features.

During the BYD handshake in the byd_detect function, the BYD driver
mistakenly interprets a standard PS/2 protocol status request answer
=66rom the Sentelic touchpad as a successful handshake with a BYD
touchpad. This is clearly a bug of the BYD driver.

Description of the patch: In byd_detect function, remove positive
detection result based on standard PS/2 protocol status request answer.
Replace it with positive detection based on handshake answers as they
can be inferred from the BYD touchpad datasheets found on BYD website.

Signed-off-by: Christophe TORDEUX <christophe@tordeux.net>

---
Resubmitting this patch because I got no feedback on my first=20
submission.
Fixes kernel bug 175421 which is impacting multiple users.

---
 drivers/input/mouse/byd.c | 76=20
 ++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 62 insertions(+), 14 deletions(-)

diff --git a/drivers/input/mouse/byd.c b/drivers/input/mouse/byd.c
index b27aa63..b5acca0 100644
--- a/drivers/input/mouse/byd.c
+++ b/drivers/input/mouse/byd.c
@@ -35,6 +35,18 @@
  * BYD pad constants
  */
=20
+/* Handshake answer of BTP6034 */
+#define BYD_MODEL_BTP6034	0x00E801
+/* Handshake answer of BTP6740 */
+#define BYD_MODEL_BTP6740	0x001155
+/* Handshake answers of BTP8644, BTP10463 and BTP11484 */
+#define BYD_MODEL_BTP8644	0x011155
+
+/* Handshake SETRES byte of BTP6034 and BTP6740 */
+#define BYD_SHAKE_BYTE_A	0x00
+/* Handshake SETRES byte of BTP8644, BTP10463 and BTP11484 */
+#define BYD_SHAKE_BYTE_B	0x03
+
 /*
  * True device resolution is unknown, however experiments show the
  * resolution is about 111 units/mm.
@@ -434,23 +446,59 @@ static void byd_disconnect(struct psmouse *psmouse)
 	}
 }
=20
+u32 byd_try_model(u32 model)
+{
+	size_t i;
+
+	u32 byd_model[] =3D {
+		BYD_MODEL_BTP6034,
+		BYD_MODEL_BTP6740,
+		BYD_MODEL_BTP8644
+	};
+
+	for (i=3D0; i < ARRAY_SIZE(byd_model); i++) {
+		if (model =3D=3D  byd_model[i])
+			return model;
+	}
+
+	return 0;
+}
+
 int byd_detect(struct psmouse *psmouse, bool set_properties)
 {
 	struct ps2dev *ps2dev =3D &psmouse->ps2dev;
-	u8 param[4] =3D {0x03, 0x00, 0x00, 0x00};
-
-	if (ps2_command(ps2dev, param, PSMOUSE_CMD_SETRES))
-		return -1;
-	if (ps2_command(ps2dev, param, PSMOUSE_CMD_SETRES))
-		return -1;
-	if (ps2_command(ps2dev, param, PSMOUSE_CMD_SETRES))
-		return -1;
-	if (ps2_command(ps2dev, param, PSMOUSE_CMD_SETRES))
-		return -1;
-	if (ps2_command(ps2dev, param, PSMOUSE_CMD_GETINFO))
-		return -1;
-
-	if (param[1] !=3D 0x03 || param[2] !=3D 0x64)
+	size_t i;
+
+	u8 byd_shbyte[] =3D {
+		BYD_SHAKE_BYTE_A,
+		BYD_SHAKE_BYTE_B
+	};
+
+	bool detect =3D false;
+	for (i=3D0; i < ARRAY_SIZE(byd_shbyte); i++) {
+		u32 model;
+		u8 param[4] =3D {byd_shbyte[i], 0x00, 0x00, 0x00};
+
+		if (ps2_command(ps2dev, param, PSMOUSE_CMD_SETRES))
+			return -1;
+		if (ps2_command(ps2dev, param, PSMOUSE_CMD_SETRES))
+			return -1;
+		if (ps2_command(ps2dev, param, PSMOUSE_CMD_SETRES))
+			return -1;
+		if (ps2_command(ps2dev, param, PSMOUSE_CMD_SETRES))
+			return -1;
+		if (ps2_command(ps2dev, param, PSMOUSE_CMD_GETINFO))
+			return -1;
+
+		model =3D param[2];
+		model +=3D param[1] << 8;
+		model +=3D param[0] << 16;
+		model =3D byd_try_model(model);
+		if (model)
+			detect =3D true;
+	}
+
+	if (!detect)
 		return -ENODEV;
=20
 	psmouse_dbg(psmouse, "BYD touchpad detected\n");

--kddslezx7txezxi3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJX9yeKAAoJEE/hdwZK2YytJQEIALZNTm3Aos4/mntsMs1GNBzO
IVPYs6Ds2UNrp+vEq1L47Xv0ga2jTBV7oCz2PPZn3HngZIsJArZj8n6WKFFfoV+F
RcpbLZXQ+Ks5p/qeI/SCbhrPDgpXNO8NTs2b1ELGH3Cb7WiSech2ROtB3gsreoRM
vdT2jBDXP+rPUpC3PdmMy1f+A+GxcL4oo4FrKWRR2Ls+TIkC5u/jnwH9cjxIr9M2
e7EJT98odxlQpleN7l45bwwmWSn3V7rVNwILtRk7//J7A/ThfqToXWr0IPmALZ0S
hyjFHLQey3KvFBh3OeN5FOkJGTy9H/RYB7kPcFSaIINapyEmHFALMtoyHF4beT8=
=ZC7L
-----END PGP SIGNATURE-----

--kddslezx7txezxi3--
