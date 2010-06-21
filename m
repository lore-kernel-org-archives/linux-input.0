From: =?UTF-8?B?w4lyaWMgUGllbA==?= <E.A.B.Piel@tudelft.nl>
Subject: [PATCH 3/7] elantech: distinguish various hardware/firmware versions
Date: Mon, 21 Jun 2010 23:03:21 +0200
Message-ID: <4C1FD399.4000500@tudelft.nl>
References: <4C1FD2B0.1080504@tudelft.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailservice.tudelft.nl ([130.161.131.5]:40218 "EHLO
	mailservice.tudelft.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758439Ab0FUVIC (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 21 Jun 2010 17:08:02 -0400
In-Reply-To: <4C1FD2B0.1080504@tudelft.nl>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>
Cc: Florian Ragwitz <rafl@debian.org>

According to the protocol document, there are a couple of different
versions of the hardware and firmware. Using the version number, it
should be possible to distinguish between them, at least for the
properties we care about.

Signed-off-by: =C3=89ric Piel <eric.piel@tremplin-utc.net>
---
 drivers/input/mouse/elantech.c |   34 +++++++++++++++++++++-----------=
--
 drivers/input/mouse/elantech.h |   10 +++++++++-
 2 files changed, 30 insertions(+), 14 deletions(-)

diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/elant=
ech.c
index 1c1d065..f32ffda 100644
--- a/drivers/input/mouse/elantech.c
+++ b/drivers/input/mouse/elantech.c
@@ -709,15 +709,32 @@ int elantech_init(struct psmouse *psmouse)
 	 * Assume every version greater than this is new EeePC style
 	 * hardware with 6 byte packets
 	 */
-	if (etd->fw_version >=3D 0x020030) {
+	if (etd->fw_version >=3D 0x020800) {
 		etd->hw_version =3D 2;
 		/* For now show extra debug information */
 		etd->debug =3D 1;
-		/* Parity check is only for 4 byte protocol */
-		etd->paritycheck =3D 0;
+		etd->paritycheck =3D ETP_CONST_CHECK;
+		etd->reports_pres =3D 1;
+	} else if (etd->fw_version =3D=3D 0x020030) {
+		etd->hw_version =3D 2;
+		/* For now show extra debug information */
+		etd->debug =3D 1;
+		etd->paritycheck =3D ETP_EF113_CHECK;
+		etd->reports_pres =3D 0;
+	} else if ((etd->fw_version =3D=3D 0x020022) || (etd->fw_version =3D=3D=
 0x020600)) {
+		/*
+		 * This firmware suffers from misreporting coordinates when
+		 * a touch action starts causing the mouse cursor or scrolled page
+		 * to jump. Enable a workaround.
+		 */
+		pr_info("firmware version 2.0.34/2.6.0 detected, enabling jumpy curs=
or workaround\n");
+		etd->jumpy_cursor =3D 1;
+		etd->debug =3D 1;
+		etd->hw_version =3D 1;
+		etd->paritycheck =3D ETP_FULL_PC;
 	} else {
 		etd->hw_version =3D 1;
-		etd->paritycheck =3D 1;
+		etd->paritycheck =3D ETP_FULL_PC;
 	}
=20
 	pr_info("assuming hardware version %d, firmware version %d.%d.%d\n",
@@ -731,15 +748,6 @@ int elantech_init(struct psmouse *psmouse)
 		param[0], param[1], param[2]);
 	etd->capabilities =3D param[0];
=20
-	/*
-	 * This firmware suffers from misreporting coordinates when
-	 * a touch action starts causing the mouse cursor or scrolled page
-	 * to jump. Enable a workaround.
-	 */
-	if ((etd->fw_version =3D=3D 0x020022) || (etd->fw_version =3D=3D 0x02=
0600)) {
-		pr_info("firmware version 2.0.34/2.6.0 detected, enabling jumpy curs=
or workaround\n");
-		etd->jumpy_cursor =3D 1;
-	}
=20
 	if (elantech_set_absolute_mode(psmouse)) {
 		pr_err("failed to put touchpad into absolute mode.\n");
diff --git a/drivers/input/mouse/elantech.h b/drivers/input/mouse/elant=
ech.h
index ac57bde..b98c3c2 100644
--- a/drivers/input/mouse/elantech.h
+++ b/drivers/input/mouse/elantech.h
@@ -101,12 +101,20 @@ struct elantech_data {
 	unsigned char debug;
 	unsigned char capabilities;
 	unsigned char paritycheck;
-	unsigned char jumpy_cursor;
+	unsigned char jumpy_cursor :1;
+	unsigned char reports_pres :1;
 	unsigned char hw_version;
 	unsigned int  fw_version;
 	unsigned char parity[256];
 };
=20
+enum paritycheck_types {
+	ETP_NOT_CHECK =3D 0,
+	ETP_FULL_PC,	 /* used in 4-byte protocol */
+	ETP_EF113_CHECK, /* check used only on the EF113 */
+	ETP_CONST_CHECK, /* used in 6-byte protocol, only checking constant b=
its */
+};
+
 #ifdef CONFIG_MOUSE_PS2_ELANTECH
 int elantech_detect(struct psmouse *psmouse, bool set_properties);
 int elantech_init(struct psmouse *psmouse);
--=20
1.7.1


--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
