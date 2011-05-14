From: =?ISO-8859-1?Q?=C9ric_Piel?= <E.A.B.Piel@tudelft.nl>
Subject: [PATCH 2/6] elantech: distinguish various hardware/firmware versions
Date: Sat, 14 May 2011 08:46:06 +0200
Message-ID: <4DCE252E.2040403@tudelft.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailservice.tudelft.nl ([130.161.131.5]:55141 "EHLO
	mailservice.tudelft.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755951Ab1ENLIM (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 14 May 2011 07:08:12 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Henrik Rydberg <rydberg@euromail.se>, Chris Bagwell <chris@cnpbagwell.com>, Florian Ragwitz <rafl@debian.org>

According to the protocol document, there are a couple of different
versions of the hardware and firmware. Using the version number, it
should be possible to distinguish between them, at least for the
properties we care about.

Signed-off-by: =C9ric Piel <eric.piel@tremplin-utc.net>
---
 drivers/input/mouse/elantech.c |   34 +++++++++++++++++++++-----------=
--
 drivers/input/mouse/elantech.h |   10 +++++++++-
 2 files changed, 30 insertions(+), 14 deletions(-)

diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/elant=
ech.c
index 04d9bf3..badb2ea 100644
--- a/drivers/input/mouse/elantech.c
+++ b/drivers/input/mouse/elantech.c
@@ -719,15 +719,32 @@ int elantech_init(struct psmouse *psmouse)
 	 * Assume every version greater than this is new EeePC style
 	 * hardware with 6 byte packets
 	 */
-	if (etd->fw_version >=3D 0x020030) {
+	if (etd->fw_version >=3D 0x020800) {
 		etd->hw_version =3D 2;
 		/* For now show extra debug information */
 		etd->debug =3D 1;
-		/* Don't know how to do parity checking for version 2 */
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
@@ -741,15 +758,6 @@ int elantech_init(struct psmouse *psmouse)
 		param[0], param[1], param[2]);
 	etd->capabilities =3D param[0];
=20
-	/*
-	 * This firmware suffers from misreporting coordinates when
-	 * a touch action starts causing the mouse cursor or scrolled page
-	 * to jump. Enable a workaround.
-	 */
-	if (etd->fw_version =3D=3D 0x020022 || etd->fw_version =3D=3D 0x02060=
0) {
-		pr_info("firmware version 2.0.34/2.6.0 detected, enabling jumpy curs=
or workaround\n");
-		etd->jumpy_cursor =3D true;
-	}
=20
 	if (elantech_set_absolute_mode(psmouse)) {
 		pr_err("failed to put touchpad into absolute mode.\n");
diff --git a/drivers/input/mouse/elantech.h b/drivers/input/mouse/elant=
ech.h
index aa4aac5..257d419 100644
--- a/drivers/input/mouse/elantech.h
+++ b/drivers/input/mouse/elantech.h
@@ -100,14 +100,22 @@ struct elantech_data {
 	unsigned char reg_26;
 	unsigned char debug;
 	unsigned char capabilities;
-	bool paritycheck;
+	unsigned char paritycheck;
 	bool jumpy_cursor;
+	unsigned char reports_pres :1;
 	unsigned char hw_version;
 	unsigned int fw_version;
 	unsigned int single_finger_reports;
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
1.7.5.1

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
