From: =?UTF-8?B?w4lyaWMgUGllbA==?= <E.A.B.Piel@tudelft.nl>
Subject: [PATCH 6/7] elantech: export pressure and width when supported
Date: Mon, 21 Jun 2010 23:05:45 +0200
Message-ID: <4C1FD429.1080409@tudelft.nl>
References: <4C1FD2B0.1080504@tudelft.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailservice.tudelft.nl ([130.161.131.5]:40711 "EHLO
	mailservice.tudelft.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758568Ab0FUVIF (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 21 Jun 2010 17:08:05 -0400
In-Reply-To: <4C1FD2B0.1080504@tudelft.nl>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>
Cc: Florian Ragwitz <rafl@debian.org>


Using the info of the Dell/Ubuntu driver, described in the protocol
document, report both width and pressure when pressing 1 and 3
fingers, for the versions of the touchpad which support it.

Signed-off-by: =C3=89ric Piel <eric.piel@tremplin-utc.net>
---
 drivers/input/mouse/elantech.c |   19 ++++++++++++++++++-
 drivers/input/mouse/elantech.h |    5 +++++
 2 files changed, 23 insertions(+), 1 deletions(-)

diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/elant=
ech.c
index 633f100..c84f741 100644
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
index b98c3c2..f6e3be5 100644
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
1.7.1


--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
