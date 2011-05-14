From: =?ISO-8859-1?Q?=C9ric_Piel?= <E.A.B.Piel@tudelft.nl>
Subject: [PATCH 4/6] elantech: export pressure and width when supported
Date: Sat, 14 May 2011 08:48:20 +0200
Message-ID: <4DCE25B4.9000500@tudelft.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailservice.tudelft.nl ([130.161.131.5]:48995 "EHLO
	mailservice.tudelft.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755593Ab1ENLIM (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 14 May 2011 07:08:12 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Henrik Rydberg <rydberg@euromail.se>, Chris Bagwell <chris@cnpbagwell.com>, Florian Ragwitz <rafl@debian.org>

Using the info of the Dell/Ubuntu driver, described in the protocol
document, report both width and pressure when pressing 1 and 3
fingers, for the versions of the touchpad which support it.

Signed-off-by: =C9ric Piel <eric.piel@tremplin-utc.net>
---
 drivers/input/mouse/elantech.c |   19 ++++++++++++++++++-
 drivers/input/mouse/elantech.h |    5 +++++
 2 files changed, 23 insertions(+), 1 deletions(-)

diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/elant=
ech.c
index 8f0a1ee..6817284 100644
--- a/drivers/input/mouse/elantech.c
+++ b/drivers/input/mouse/elantech.c
@@ -248,9 +248,10 @@ static void elantech_report_absolute_v1(struct psm=
ouse *psmouse)
  */
 static void elantech_report_absolute_v2(struct psmouse *psmouse)
 {
+	struct elantech_data *etd =3D psmouse->private;
 	struct input_dev *dev =3D psmouse->dev;
 	unsigned char *packet =3D psmouse->packet;
-	int fingers, x1, y1, x2, y2;
+	int fingers, x1, y1, x2, y2, width =3D 0, pres =3D 0;
=20
 	/* byte 0: n1  n0   .   .   .   .   R   L */
 	fingers =3D (packet[0] & 0xc0) >> 6;
@@ -278,6 +279,8 @@ static void elantech_report_absolute_v2(struct psmo=
use *psmouse)
 		 */
 		input_report_abs(dev, ABS_Y,
 			ETP_YMAX_V2 - (((packet[4] & 0x03) << 8) | packet[5]));
+		pres =3D (packet[1] & 0xf0) | ((packet[4] & 0xf0) >> 4);
+		width =3D ((packet[0] & 0x30) >> 2) | ((packet[3] & 0x30) >> 4);
 		break;
=20
 	case 2:
@@ -311,6 +314,10 @@ static void elantech_report_absolute_v2(struct psm=
ouse *psmouse)
 		input_report_abs(dev, ABS_HAT0Y, y1);
 		input_report_abs(dev, ABS_HAT1X, x2);
 		input_report_abs(dev, ABS_HAT1Y, y2);
+
+		/* Unknown so just report sensible values */
+		pres =3D 127;
+		width =3D 7;
 		break;
 	}
=20
@@ -320,6 +327,10 @@ static void elantech_report_absolute_v2(struct psm=
ouse *psmouse)
 	input_report_key(dev, BTN_TOOL_QUADTAP, fingers =3D=3D 4);
 	input_report_key(dev, BTN_LEFT, packet[0] & 0x01);
 	input_report_key(dev, BTN_RIGHT, packet[0] & 0x02);
+	if (etd->reports_pres) {
+		input_report_abs(dev, ABS_PRESSURE, pres);
+		input_report_abs(dev, ABS_TOOL_WIDTH, width);
+	}
=20
 	input_sync(dev);
 }
@@ -531,6 +542,12 @@ static void elantech_set_input_params(struct psmou=
se *psmouse)
 		__set_bit(BTN_TOOL_QUADTAP, dev->keybit);
 		input_set_abs_params(dev, ABS_X, ETP_XMIN_V2, ETP_XMAX_V2, 0, 0);
 		input_set_abs_params(dev, ABS_Y, ETP_YMIN_V2, ETP_YMAX_V2, 0, 0);
+		if (etd->reports_pres) {
+			input_set_abs_params(dev, ABS_PRESSURE, ETP_PMIN_V2,
+					     ETP_PMAX_V2, 0, 0);
+			input_set_abs_params(dev, ABS_TOOL_WIDTH, ETP_WMIN_V2,
+					     ETP_WMAX_V2, 0, 0);
+		}
 		input_set_abs_params(dev, ABS_HAT0X, ETP_2FT_XMIN, ETP_2FT_XMAX, 0, =
0);
 		input_set_abs_params(dev, ABS_HAT0Y, ETP_2FT_YMIN, ETP_2FT_YMAX, 0, =
0);
 		input_set_abs_params(dev, ABS_HAT1X, ETP_2FT_XMIN, ETP_2FT_XMAX, 0, =
0);
diff --git a/drivers/input/mouse/elantech.h b/drivers/input/mouse/elant=
ech.h
index 257d419..dcf9ad0 100644
--- a/drivers/input/mouse/elantech.h
+++ b/drivers/input/mouse/elantech.h
@@ -77,6 +77,11 @@
 #define ETP_YMIN_V2			(   0 + ETP_EDGE_FUZZ_V2)
 #define ETP_YMAX_V2			( 768 - ETP_EDGE_FUZZ_V2)
=20
+#define ETP_PMIN_V2			0
+#define ETP_PMAX_V2			255
+#define ETP_WMIN_V2			0
+#define ETP_WMAX_V2			15
+
 /*
  * For two finger touches the coordinate of each finger gets reported
  * separately but with reduced resolution.
--=20
1.7.5.1

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
