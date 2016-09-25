From: Christophe TORDEUX <christophe@tordeux.net>
Subject: [PATCH 01/01] drivers:input:byd fix greedy detection of Sentelic FSP
 by the BYD touchpad driver
Date: Sun, 25 Sep 2016 11:31:19 +0800
Message-ID: <20160925033119.rvptljq3zs4hkmmf@sherka.pkbd.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="fvdcjldos3iyahuy"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx496502.smtp-engine.com ([212.227.20.70]:35225 "EHLO
        mx496502.smtp-engine.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965202AbcIYDjr (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Sat, 24 Sep 2016 23:39:47 -0400
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Rydberg <rydberg@bitmath.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Tai-hwa Liang <avatar@sentelic.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org


--fvdcjldos3iyahuy
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
Comments/discussion:
A Sentelic touchpad STL3888_C0 is available to the author of this patch.

No BYD touchpad device is available to the author of this patch for
testing purpose. The BYD website contains 5 data sheets documents for 5
touchpads. Unfortunately the handshake procedure description from the
BYD datasheets is either not fully consistent or not fully detailed.

This means that while the author is positive the bug of Sentelic greedy
detection is fixed by this patch, the effect on detection of BYD
touchpads is not tested on actual hardware. But, because this patch
codes the detection according to expected handshake answers based on BYD
datasheets, the approach taken by this patch is probably the best in the
author's opinion.
Nevertheless alternatives can be considered.

Alternative 1: move the detection of Sentelic touchpads above the
detection of BYD touchpads in psmouse_try_protocol function. However
based on the code comments, this could have adverse effects which I
don't really know about.

Alternative2: Sentelic STL3888_C0 answers E9 status request with a
standard PS/2 protocol answer, however I found out my Sentelic
STL3888_C0 answers E8/00/E8/00/E8/00/E8/00/E9 with 00/88/64, which looks
like a handshake answer. This could be used as a test to exit the
byd_detect function. Still effect on detection of a BYD device is not
known.

---
 drivers/input/mouse/byd.c | 76 ++++++++++++++++++++++++++++++++++++++-----=
----
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

--fvdcjldos3iyahuy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQEcBAEBAgAGBQJX50UHAAoJEE/hdwZK2YytrJEH/i09lSOWGLJux1HN96BT2CkR
sWBKUd07V6iz4ZCBrfRvwk2KhCuozSin0lU/zGx6tl1hSTOozqbHcDVJPJ2BKR91
L0WQz13cR9SF2RsV9mFy2Vsr5/cYbDkr1RpCrvNRaSJMPKfhlDNdKonyNw+9Wtnk
xoNTST4KcGIQsA39kf3gjR2HyCDxeM913g1tjQz6fPQalrCFkxHsOuLzK66GUbtw
gD0cLFg2uA59vEPveLPjBv+dIPAQwqeDx8AjOqCfGdc5v0hbYCJ8L4lFPTnC2Uvv
2P17TrErBxR/SAh7VeIW4jBeG7FPyxSRR1LBHYKKlrxOlsktbr50Har1CiYtbU4=
=UfzU
-----END PGP SIGNATURE-----

--fvdcjldos3iyahuy--
