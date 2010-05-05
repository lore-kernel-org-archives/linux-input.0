From: =?UTF-8?B?w4lyaWMgUGllbA==?= <E.A.B.Piel@tudelft.nl>
Subject: [PATCH 1/2] elantech: Report tool width when it is known
Date: Wed, 05 May 2010 14:14:25 +0200
Message-ID: <4BE16121.8040000@tudelft.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailservice.tudelft.nl ([130.161.131.5]:52628 "EHLO
	mailservice.tudelft.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934313Ab0EEMVf (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 5 May 2010 08:21:35 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Florian Ragwitz <rafl@debian.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

>From observation of the values sent from the hardware version 2, it
seems that the first four bits of byte 1 represents the width. So we ca=
n
report it as well. Observed values on my hardware were always between 1
and 12, so let's use this for min and max.

Signed-off-by: =C3=89ric Piel <eric.piel@tremplin-utc.net>
---
 drivers/input/mouse/elantech.c |   22 +++++++++++++---------
 drivers/input/mouse/elantech.h |    2 ++
 2 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/elant=
ech.c
index 0520c2e..6a99b30 100644
--- a/drivers/input/mouse/elantech.c
+++ b/drivers/input/mouse/elantech.c
@@ -249,7 +249,7 @@ static void elantech_report_absolute_v2(struct psmo=
use *psmouse)
 {
 	struct input_dev *dev =3D psmouse->dev;
 	unsigned char *packet =3D psmouse->packet;
-	int fingers, x1, y1, x2, y2;
+	int fingers, x1, y1, x2, y2, width;
=20
 	/* byte 0: n1  n0   .   .   .   .   R   L */
 	fingers =3D (packet[0] & 0xc0) >> 6;
@@ -258,17 +258,19 @@ static void elantech_report_absolute_v2(struct ps=
mouse *psmouse)
 	switch (fingers) {
 	case 1:
 		/*
-		 * byte 1:  .   .   .   .   .  x10 x9  x8
+		 * byte 1: w3  w2  w1  w0   .  x10 x9  x8
 		 * byte 2: x7  x6  x5  x4  x4  x2  x1  x0
 		 */
-		input_report_abs(dev, ABS_X,
-			((packet[1] & 0x07) << 8) | packet[2]);
+		width =3D ((packet[1] & 0xf0) >> 4);
+		x1 =3D ((packet[1] & 0x07) << 8) | packet[2];
 		/*
 		 * byte 4:  .   .   .   .   .   .  y9  y8
 		 * byte 5: y7  y6  y5  y4  y3  y2  y1  y0
 		 */
-		input_report_abs(dev, ABS_Y,
-			ETP_YMAX_V2 - (((packet[4] & 0x03) << 8) | packet[5]));
+		y1 =3D ETP_YMAX_V2 - (((packet[4] & 0x03) << 8) | packet[5]);
+		input_report_abs(dev, ABS_TOOL_WIDTH, width);
+		input_report_abs(dev, ABS_X, x1);
+		input_report_abs(dev, ABS_Y, y1);
 		break;
=20
 	case 2:
@@ -286,7 +288,7 @@ static void elantech_report_absolute_v2(struct psmo=
use *psmouse)
 		 * byte 4: bx7 bx6 bx5 bx4 bx3 bx2 bx1 bx0
 		 */
 		x2 =3D ((packet[3] & 0x10) << 4) | packet[4];
-		/* byte 5: by7 by8 by5 by4 by3 by2 by1 by0 */
+		/* byte 5: by7 by6 by5 by4 by3 by2 by1 by0 */
 		y2 =3D ETP_2FT_YMAX - (((packet[3] & 0x20) << 3) | packet[5]);
 		/*
 		 * For compatibility with the X Synaptics driver scale up
@@ -467,6 +469,7 @@ static void elantech_set_input_params(struct psmous=
e *psmouse)
 		break;
=20
 	case 2:
+		input_set_abs_params(dev, ABS_TOOL_WIDTH, ETP_WMIN_V2, ETP_WMAX_V2, =
0, 0);
 		input_set_abs_params(dev, ABS_X, ETP_XMIN_V2, ETP_XMAX_V2, 0, 0);
 		input_set_abs_params(dev, ABS_Y, ETP_YMIN_V2, ETP_YMAX_V2, 0, 0);
 		input_set_abs_params(dev, ABS_HAT0X, ETP_2FT_XMIN, ETP_2FT_XMAX, 0, =
0);
diff --git a/drivers/input/mouse/elantech.h b/drivers/input/mouse/elant=
ech.h
index feac5f7..2ce79c1 100644
--- a/drivers/input/mouse/elantech.h
+++ b/drivers/input/mouse/elantech.h
@@ -76,6 +76,8 @@
 #define ETP_XMAX_V2			(1152 - ETP_EDGE_FUZZ_V2)
 #define ETP_YMIN_V2			(   0 + ETP_EDGE_FUZZ_V2)
 #define ETP_YMAX_V2			( 768 - ETP_EDGE_FUZZ_V2)
+#define ETP_WMIN_V2			0
+#define ETP_WMAX_V2			12
=20
 /*
  * For two finger touches the coordinate of each finger gets reported
--=20
1.7.1


--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
