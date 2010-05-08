From: =?UTF-8?B?w4lyaWMgUGllbA==?= <E.A.B.Piel@tudelft.nl>
Subject: [PATCH 1/2] elantech: Improved protocol support for hardware 2
Date: Sat, 08 May 2010 18:37:38 +0200
Message-ID: <4BE59352.4070407@tudelft.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailservice.tudelft.nl ([130.161.131.5]:44940 "EHLO
	mailservice.tudelft.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753407Ab0EHQjX (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sat, 8 May 2010 12:39:23 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Florian Ragwitz <rafl@debian.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Henrik Rydberg <rydberg@euromail.se>

>From observation of the values sent from the hardware, it is possible =
to
determine also:
 * the width of the touch (coded on 6 bits)
 * the lowest coordinates of a three-finger touch
 * whether there is just three fingers or more
So report this information as well, and update the protocol description
document.

Signed-off-by: =C3=89ric Piel <eric.piel@tremplin-utc.net>
---
 Documentation/input/elantech.txt |   22 +++++++++++++++-------
 drivers/input/mouse/elantech.c   |   36 ++++++++++++++++++++++++++----=
------
 drivers/input/mouse/elantech.h   |    2 ++
 3 files changed, 43 insertions(+), 17 deletions(-)

diff --git a/Documentation/input/elantech.txt b/Documentation/input/ela=
ntech.txt
index 56941ae..cb8471b 100644
--- a/Documentation/input/elantech.txt
+++ b/Documentation/input/elantech.txt
@@ -319,7 +319,7 @@ For example:
 4.2 Native absolute mode 6 byte packet format
     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
=20
-4.2.1 One finger touch
+4.2.1 One/Three finger touch
       ~~~~~~~~~~~~~~~~
=20
 byte 0:
@@ -333,19 +333,22 @@ byte 0:
 byte 1:
=20
    bit   7   6   5   4   3   2   1   0
+         w5  w4  w3  w2  .  x10 x9  x8
          .   .   .   .   .  x10 x9  x8
=20
 byte 2:
=20
    bit   7   6   5   4   3   2   1   0
-        x7  x6  x5  x4  x4  x2  x1  x0
+        x7  x6  x5  x4  x3  x2  x1  x0
=20
          x10..x0 =3D absolute x value (horizontal)
=20
 byte 3:
=20
    bit   7   6   5   4   3   2   1   0
-         .   .   .   .   .   .   .   .
+        n4  .   w1  w0   .   .   .   .
+         w6..w0 =3D width of the finger touch
+         n4 =3D set if more than 3 fingers (only in 3 fingers mode)
=20
 byte 4:
=20
@@ -363,6 +366,11 @@ byte 5:
 4.2.2 Two finger touch
       ~~~~~~~~~~~~~~~~
=20
+Note that the two pairs of coordinates are not exactly the coordinates=
 of the=20
+two fingers, but only the pair of the lowest and highest coordinates. =
So the=20
+actual fingers might be situated on the other diagonal of the square d=
efined by
+these two points.
+
 byte 0:
=20
    bit   7   6   5   4   3   2   1   0
@@ -376,14 +384,14 @@ byte 1:
    bit   7   6   5   4   3   2   1   0
         ax7 ax6 ax5 ax4 ax3 ax2 ax1 ax0
=20
-         ax8..ax0 =3D first finger absolute x value
+         ax8..ax0 =3D lower finger absolute x value
=20
 byte 2:
=20
    bit   7   6   5   4   3   2   1   0
         ay7 ay6 ay5 ay4 ay3 ay2 ay1 ay0
=20
-         ay8..ay0 =3D first finger absolute y value
+         ay8..ay0 =3D lower finger absolute y value
=20
 byte 3:
=20
@@ -395,11 +403,11 @@ byte 4:
    bit   7   6   5   4   3   2   1   0
         bx7 bx6 bx5 bx4 bx3 bx2 bx1 bx0
=20
-         bx8..bx0 =3D second finger absolute x value
+         bx8..bx0 =3D higher finger absolute x value
=20
 byte 5:
=20
    bit   7   6   5   4   3   2   1   0
         by7 by8 by5 by4 by3 by2 by1 by0
=20
-         by8..by0 =3D second finger absolute y value
+         by8..by0 =3D higher finger absolute y value
diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/elant=
ech.c
index 0520c2e..2708b22 100644
--- a/drivers/input/mouse/elantech.c
+++ b/drivers/input/mouse/elantech.c
@@ -249,26 +249,38 @@ static void elantech_report_absolute_v2(struct ps=
mouse *psmouse)
 {
 	struct input_dev *dev =3D psmouse->dev;
 	unsigned char *packet =3D psmouse->packet;
-	int fingers, x1, y1, x2, y2;
+	int fingers, x1, y1, x2, y2, width;
=20
 	/* byte 0: n1  n0   .   .   .   .   R   L */
 	fingers =3D (packet[0] & 0xc0) >> 6;
 	input_report_key(dev, BTN_TOUCH, fingers !=3D 0);
=20
 	switch (fingers) {
+	case 3:
+		/*
+		 * Same as one finger excepted report of more than 3
+		 * fingers pressed:
+		 * byte 3:  n4  .   w1  w0   .   .   .   .
+		 */
+		if (packet[3] & 0x80)
+			fingers =3D 4;
+		/* pass through... */
 	case 1:
 		/*
-		 * byte 1:  .   .   .   .   .  x10 x9  x8
-		 * byte 2: x7  x6  x5  x4  x4  x2  x1  x0
+		 * byte 1: w5  w4  w3  w2   .  x10 x9  x8
+		 * byte 2: x7  x6  x5  x4  x3  x2  x1  x0
+		 * byte 3: .   .   w1  w0   .   .   .   .
 		 */
-		input_report_abs(dev, ABS_X,
-			((packet[1] & 0x07) << 8) | packet[2]);
+		width =3D ((packet[1] & 0xf0) >> 2) | ((packet[3] & 0x30) >> 4);
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
@@ -286,7 +298,7 @@ static void elantech_report_absolute_v2(struct psmo=
use *psmouse)
 		 * byte 4: bx7 bx6 bx5 bx4 bx3 bx2 bx1 bx0
 		 */
 		x2 =3D ((packet[3] & 0x10) << 4) | packet[4];
-		/* byte 5: by7 by8 by5 by4 by3 by2 by1 by0 */
+		/* byte 5: by7 by6 by5 by4 by3 by2 by1 by0 */
 		y2 =3D ETP_2FT_YMAX - (((packet[3] & 0x20) << 3) | packet[5]);
 		/*
 		 * For compatibility with the X Synaptics driver scale up
@@ -308,6 +320,7 @@ static void elantech_report_absolute_v2(struct psmo=
use *psmouse)
 	input_report_key(dev, BTN_TOOL_FINGER, fingers =3D=3D 1);
 	input_report_key(dev, BTN_TOOL_DOUBLETAP, fingers =3D=3D 2);
 	input_report_key(dev, BTN_TOOL_TRIPLETAP, fingers =3D=3D 3);
+	input_report_key(dev, BTN_TOOL_QUADTAP, fingers =3D=3D 4);
 	input_report_key(dev, BTN_LEFT, packet[0] & 0x01);
 	input_report_key(dev, BTN_RIGHT, packet[0] & 0x02);
=20
@@ -467,6 +480,8 @@ static void elantech_set_input_params(struct psmous=
e *psmouse)
 		break;
=20
 	case 2:
+		__set_bit(BTN_TOOL_QUADTAP, dev->keybit);
+		input_set_abs_params(dev, ABS_TOOL_WIDTH, ETP_WMIN_V2, ETP_WMAX_V2, =
0, 0);
 		input_set_abs_params(dev, ABS_X, ETP_XMIN_V2, ETP_XMAX_V2, 0, 0);
 		input_set_abs_params(dev, ABS_Y, ETP_YMIN_V2, ETP_YMAX_V2, 0, 0);
 		input_set_abs_params(dev, ABS_HAT0X, ETP_2FT_XMIN, ETP_2FT_XMAX, 0, =
0);
@@ -693,8 +708,9 @@ int elantech_init(struct psmouse *psmouse)
 	 * Assume every version greater than this is new EeePC style
 	 * hardware with 6 byte packets
 	 */
-	if ((etd->fw_version_maj =3D=3D 0x02 && etd->fw_version_min >=3D 0x30=
) ||
-	    etd->fw_version_maj > 0x02) {
+	//if ((etd->fw_version_maj =3D=3D 0x02 && etd->fw_version_min >=3D 0x=
30) ||
+	//    etd->fw_version_maj > 0x02) {
+	if (etd->fw_version_maj >=3D 0x02) {
 		etd->hw_version =3D 2;
 		/* For now show extra debug information */
 		etd->debug =3D 1;
diff --git a/drivers/input/mouse/elantech.h b/drivers/input/mouse/elant=
ech.h
index feac5f7..5093762 100644
--- a/drivers/input/mouse/elantech.h
+++ b/drivers/input/mouse/elantech.h
@@ -76,6 +76,8 @@
 #define ETP_XMAX_V2			(1152 - ETP_EDGE_FUZZ_V2)
 #define ETP_YMIN_V2			(   0 + ETP_EDGE_FUZZ_V2)
 #define ETP_YMAX_V2			( 768 - ETP_EDGE_FUZZ_V2)
+#define ETP_WMIN_V2			0
+#define ETP_WMAX_V2			(1 << 6)
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
