From: =?ISO-8859-1?Q?=C9ric_Piel?= <E.A.B.Piel@tudelft.nl>
Subject: [PATCH 08/10] elantech: track finger to distinguish coordinates in
 2-finger report
Date: Mon, 09 Aug 2010 00:53:52 +0200
Message-ID: <4C5F3580.2090805@tudelft.nl>
References: <4C567F27.7070900@tudelft.nl> <4C5697C4.1020801@euromail.se> <4C56A81E.3040703@tudelft.nl> <4C56AA67.8000902@euromail.se> <4C56AD12.1080106@tudelft.nl> <4C56B00B.50204@euromail.se> <4C56B686.60606@tudelft.nl> <4C56BA13.3030104@euromail.se> <4C56BE30.2070807@tudelft.nl> <4C56C213.2010605@euromail.se> <20100802163913.GB3276@core.coreip.homeip.net> <4C5F34F4.7030503@tudelft.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailservice.tudelft.nl ([130.161.131.5]:38102 "EHLO
	mailservice.tudelft.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754705Ab0HHWzv (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 8 Aug 2010 18:55:51 -0400
In-Reply-To: <4C5F34F4.7030503@tudelft.nl>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Henrik Rydberg <rydberg@euromail.se>, Chris Bagwell <chris@cnpbagwell.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Florian Ragwitz <rafl@debian.org>

The elantech hardware is limited when reporting two fingers. It just
reports the minimum and maximum coordinates of the rectangle containing
the fingers.

As multitouch protocol requires at least to report the correct position
of each finger, we track the finger position when there is only one
finger to distinguish which corner of the rectangle corresponds to the
actual position of the fingers. When there are three fingers, only the
minimum position is reported, so we just don't track it and hope the
last tracked position has the most likelihood to be correct.

It works fine, at least as long as the two fingers don't get
horizontally or vertically aligned, after what it's back to random.
This also allows to avoid so "jumps" in the single-touch protocol.

Signed-off-by: =C9ric Piel <eric.piel@tremplin-utc.net>
---
 drivers/input/mouse/elantech.c |   75 ++++++++++++++++++++++++++++++++=
--------
 drivers/input/mouse/elantech.h |    2 +
 2 files changed, 62 insertions(+), 15 deletions(-)

diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/elant=
ech.c
index 7fa4f29..1dd7e7c 100644
--- a/drivers/input/mouse/elantech.c
+++ b/drivers/input/mouse/elantech.c
@@ -242,6 +242,45 @@ static void elantech_report_absolute_v1(struct psm=
ouse *psmouse)
 	input_sync(dev);
 }
=20
+/* Store the current position of the finger, for tracking when 2 finge=
rs */
+static void track_one_finger(struct elantech_data *etd, unsigned int x=
, unsigned int y)
+{
+	etd->prev_x =3D x;
+	etd->prev_y =3D y;
+}
+
+/* Ensure that argument a contains a value closest to ref than b */
+static void find_closest_and_swap(unsigned int *ref, unsigned int *a, =
unsigned int *b)
+{
+	int dist_a =3D abs(*ref - *a);
+	int dist_b =3D abs(*ref - *b);
+	int tmp;
+	if (dist_b < dist_a) {
+		tmp =3D *a;
+		*a =3D *b;
+		*b =3D tmp;
+	}
+	*ref =3D *a;
+}
+
+/*
+ * Track the coordinates reported and swap the values to improve the l=
ikelihood
+ * that the coordinates correspond to the real positions of the two fi=
ngers.
+ */
+static void
+track_two_fingers(struct elantech_data *etd,
+		  unsigned int *x1, unsigned int *y1, unsigned int *x2, unsigned int=
 *y2)
+{
+	/*
+	 * As the hardware can only report the coordinates without knowing wh=
ich one
+	 * corresponds to which finger, we try to guess according to the last=
 known
+	 * position, when using only one finger.
+	 */
+	find_closest_and_swap(&etd->prev_x, x1, x2);
+	find_closest_and_swap(&etd->prev_y, y1, y2);
+}
+
+
 /*
  * Interpret complete data packets and report absolute mode input even=
ts for
  * hardware version 2. (6 byte packets)
@@ -251,7 +290,7 @@ static void elantech_report_absolute_v2(struct psmo=
use *psmouse)
 	struct elantech_data *etd =3D psmouse->private;
 	struct input_dev *dev =3D psmouse->dev;
 	unsigned char *packet =3D psmouse->packet;
-	int fingers, x1, y1, x2, y2, width =3D 0, pres =3D 0;
+	unsigned int fingers, x1, y1, x2, y2, width =3D 0, pres =3D 0;
=20
 	/* byte 0: n1  n0   .   .   .   .   R   L */
 	fingers =3D (packet[0] & 0xc0) >> 6;
@@ -285,6 +324,10 @@ static void elantech_report_absolute_v2(struct psm=
ouse *psmouse)
 		input_report_abs(dev, ABS_X, x1);
 		input_report_abs(dev, ABS_Y, y1);
=20
+		/* Only track if we are sure it's real finger coodinates */
+		if (fingers =3D=3D 1)
+			track_one_finger(etd, x1, y1);
+
 		pres =3D (packet[1] & 0xf0) | ((packet[4] & 0xf0) >> 4);
 		width =3D ((packet[0] & 0x30) >> 2) | ((packet[3] & 0x30) >> 4);
 		break;
@@ -296,37 +339,39 @@ static void elantech_report_absolute_v2(struct ps=
mouse *psmouse)
 		 * byte 0:  .   .  ay8 ax8  .   .   .   .
 		 * byte 1: ax7 ax6 ax5 ax4 ax3 ax2 ax1 ax0
 		 */
-		x1 =3D ((packet[0] & 0x10) << 4) | packet[1];
+		x1 =3D (((packet[0] & 0x10) << 4) | packet[1]) << 2;
 		/* byte 2: ay7 ay6 ay5 ay4 ay3 ay2 ay1 ay0 */
-		y1 =3D ETP_2FT_YMAX - (((packet[0] & 0x20) << 3) | packet[2]);
+		y1 =3D (ETP_2FT_YMAX - (((packet[0] & 0x20) << 3) | packet[2])) << 2=
;
 		/*
 		 * byte 3:  .   .  by8 bx8  .   .   .   .
 		 * byte 4: bx7 bx6 bx5 bx4 bx3 bx2 bx1 bx0
 		 */
-		x2 =3D ((packet[3] & 0x10) << 4) | packet[4];
+		x2 =3D (((packet[3] & 0x10) << 4) | packet[4]) << 2;
 		/* byte 5: by7 by8 by5 by4 by3 by2 by1 by0 */
-		y2 =3D ETP_2FT_YMAX - (((packet[3] & 0x20) << 3) | packet[5]);
+		y2 =3D (ETP_2FT_YMAX - (((packet[3] & 0x20) << 3) | packet[5])) << 2=
;
+
+		track_two_fingers(etd, &x1, &y1, &x2, &y2);
 		/* Multitouch */
-		input_report_abs(dev, ABS_MT_POSITION_X, x1 << 2);
-		input_report_abs(dev, ABS_MT_POSITION_Y, y1 << 2);
+		input_report_abs(dev, ABS_MT_POSITION_X, x1);
+		input_report_abs(dev, ABS_MT_POSITION_Y, y1);
 		input_mt_sync(dev);
-		input_report_abs(dev, ABS_MT_POSITION_X, x2 << 2);
-		input_report_abs(dev, ABS_MT_POSITION_Y, y2 << 2);
+		input_report_abs(dev, ABS_MT_POSITION_X, x2);
+		input_report_abs(dev, ABS_MT_POSITION_Y, y2);
 		input_mt_sync(dev);
 		/*
 		 * For compatibility with the X Synaptics driver scale up
 		 * one coordinate and report as ordinary mouse movent
 		 */
-		input_report_abs(dev, ABS_X, x1 << 2);
-		input_report_abs(dev, ABS_Y, y1 << 2);
+		input_report_abs(dev, ABS_X, x1);
+		input_report_abs(dev, ABS_Y, y1);
 		/*
 		 * For compatibility with the proprietary X Elantech driver
 		 * report both coordinates as hat coordinates
 		 */
-		input_report_abs(dev, ABS_HAT0X, x1);
-		input_report_abs(dev, ABS_HAT0Y, y1);
-		input_report_abs(dev, ABS_HAT1X, x2);
-		input_report_abs(dev, ABS_HAT1Y, y2);
+		input_report_abs(dev, ABS_HAT0X, x1 >> 2);
+		input_report_abs(dev, ABS_HAT0Y, y1 >> 2);
+		input_report_abs(dev, ABS_HAT1X, x2 >> 2);
+		input_report_abs(dev, ABS_HAT1Y, y2 >> 2);
=20
 		/* Unknown so just report sensible values */
 		pres =3D 127;
diff --git a/drivers/input/mouse/elantech.h b/drivers/input/mouse/elant=
ech.h
index f6e3be5..fa9a6b4 100644
--- a/drivers/input/mouse/elantech.h
+++ b/drivers/input/mouse/elantech.h
@@ -111,6 +111,8 @@ struct elantech_data {
 	unsigned char hw_version;
 	unsigned int  fw_version;
 	unsigned char parity[256];
+	unsigned int prev_x;
+	unsigned int prev_y;
 };
=20
 enum paritycheck_types {
--=20
1.7.2.1


--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
