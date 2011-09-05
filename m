From: JJ Ding <jj_ding@emc.com.tw>
Subject: [PATCH v5 2/8] Input: elantech - get rid of ETP_2FT_* in elantech.h
Date: Mon,  5 Sep 2011 10:16:41 +0800
Message-ID: <1315189007-2179-3-git-send-email-jj_ding@emc.com.tw>
References: <1315189007-2179-1-git-send-email-jj_ding@emc.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from emcscan.emc.com.tw ([192.72.220.5]:4045 "EHLO
	emcscan.emc.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751379Ab1IECOi (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 4 Sep 2011 22:14:38 -0400
In-Reply-To: <1315189007-2179-1-git-send-email-jj_ding@emc.com.tw>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Seth Forshee <seth.forshee@canonical.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Aaron Huang <aaron_huang@emc.com.tw>, Tom Lin <tom_lin@emc.com.tw>, =?UTF-8?q?=C3=89ric=20Piel?= <E.A.B.Piel@tudelft.nl>, Daniel Kurtz <djkurtz@chromium.org>, Chase Douglas <chase.douglas@canonical.com>, Henrik Rydberg <rydberg@euromail.se>, Alessandro Rubini <rubini@cvml.unipv.it>, JJ Ding <jj_ding@emc.com.tw>

=46or two finger touches the coordinate of each finger gets reported
separately but with reduced resolution.

With this change, we now have the same range for ST and MT data and
scale MT data because it has lower resolution to match ST.

Suggested-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: JJ Ding <jj_ding@emc.com.tw>
Acked-by: Daniel Kurtz <djkurtz@chromium.org>
Acked-by: =C3=89ric Piel <eric.piel@tremplin-utc.net>
---
 drivers/input/mouse/elantech.c |   28 +++++++++++++---------------
 drivers/input/mouse/elantech.h |   11 -----------
 2 files changed, 13 insertions(+), 26 deletions(-)

diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/elant=
ech.c
index da161da..cd8e2e5 100644
--- a/drivers/input/mouse/elantech.c
+++ b/drivers/input/mouse/elantech.c
@@ -273,11 +273,11 @@ static void elantech_report_absolute_v2(struct ps=
mouse *psmouse)
 	struct elantech_data *etd =3D psmouse->private;
 	struct input_dev *dev =3D psmouse->dev;
 	unsigned char *packet =3D psmouse->packet;
-	unsigned int fingers, x1 =3D 0, y1 =3D 0, x2 =3D 0, y2 =3D 0, width =3D=
 0, pres =3D 0;
+	unsigned int fingers, x1 =3D 0, y1 =3D 0, x2 =3D 0, y2 =3D 0;
+	unsigned int width =3D 0, pres =3D 0;
=20
 	/* byte 0: n1  n0   .   .   .   .   R   L */
 	fingers =3D (packet[0] & 0xc0) >> 6;
-	input_report_key(dev, BTN_TOUCH, fingers !=3D 0);
=20
 	switch (fingers) {
 	case 3:
@@ -300,9 +300,6 @@ static void elantech_report_absolute_v2(struct psmo=
use *psmouse)
 		 */
 		y1 =3D ETP_YMAX_V2 - (((packet[4] & 0x0f) << 8) | packet[5]);
=20
-		input_report_abs(dev, ABS_X, x1);
-		input_report_abs(dev, ABS_Y, y1);
-
 		pres =3D (packet[1] & 0xf0) | ((packet[4] & 0xf0) >> 4);
 		width =3D ((packet[0] & 0x30) >> 2) | ((packet[3] & 0x30) >> 4);
 		break;
@@ -314,22 +311,18 @@ static void elantech_report_absolute_v2(struct ps=
mouse *psmouse)
 		 * byte 0:  .   .  ay8 ax8  .   .   .   .
 		 * byte 1: ax7 ax6 ax5 ax4 ax3 ax2 ax1 ax0
 		 */
-		x1 =3D ((packet[0] & 0x10) << 4) | packet[1];
+		x1 =3D (((packet[0] & 0x10) << 4) | packet[1]) << 2;
 		/* byte 2: ay7 ay6 ay5 ay4 ay3 ay2 ay1 ay0 */
-		y1 =3D ETP_2FT_YMAX - (((packet[0] & 0x20) << 3) | packet[2]);
+		y1 =3D ETP_YMAX_V2 -
+			((((packet[0] & 0x20) << 3) | packet[2]) << 2);
 		/*
 		 * byte 3:  .   .  by8 bx8  .   .   .   .
 		 * byte 4: bx7 bx6 bx5 bx4 bx3 bx2 bx1 bx0
 		 */
-		x2 =3D ((packet[3] & 0x10) << 4) | packet[4];
+		x2 =3D (((packet[3] & 0x10) << 4) | packet[4]) << 2;
 		/* byte 5: by7 by8 by5 by4 by3 by2 by1 by0 */
-		y2 =3D ETP_2FT_YMAX - (((packet[3] & 0x20) << 3) | packet[5]);
-		/*
-		 * For compatibility with the X Synaptics driver scale up
-		 * one coordinate and report as ordinary mouse movent
-		 */
-		input_report_abs(dev, ABS_X, x1 << 2);
-		input_report_abs(dev, ABS_Y, y1 << 2);
+		y2 =3D ETP_YMAX_V2 -
+			((((packet[3] & 0x20) << 3) | packet[5]) << 2);
=20
 		/* Unknown so just report sensible values */
 		pres =3D 127;
@@ -337,6 +330,11 @@ static void elantech_report_absolute_v2(struct psm=
ouse *psmouse)
 		break;
 	}
=20
+	input_report_key(dev, BTN_TOUCH, fingers !=3D 0);
+	if (fingers !=3D 0) {
+		input_report_abs(dev, ABS_X, x1);
+		input_report_abs(dev, ABS_Y, y1);
+	}
 	elantech_report_semi_mt_data(dev, fingers, x1, y1, x2, y2);
 	input_report_key(dev, BTN_TOOL_FINGER, fingers =3D=3D 1);
 	input_report_key(dev, BTN_TOOL_DOUBLETAP, fingers =3D=3D 2);
diff --git a/drivers/input/mouse/elantech.h b/drivers/input/mouse/elant=
ech.h
index fabb2b9..1c5894e 100644
--- a/drivers/input/mouse/elantech.h
+++ b/drivers/input/mouse/elantech.h
@@ -82,17 +82,6 @@
 #define ETP_WMIN_V2			0
 #define ETP_WMAX_V2			15
=20
-/*
- * For two finger touches the coordinate of each finger gets reported
- * separately but with reduced resolution.
- */
-#define ETP_2FT_FUZZ			4
-
-#define ETP_2FT_XMIN			(  0 + ETP_2FT_FUZZ)
-#define ETP_2FT_XMAX			(288 - ETP_2FT_FUZZ)
-#define ETP_2FT_YMIN			(  0 + ETP_2FT_FUZZ)
-#define ETP_2FT_YMAX			(192 - ETP_2FT_FUZZ)
-
 struct elantech_data {
 	unsigned char reg_10;
 	unsigned char reg_11;
--=20
1.7.4.1

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
