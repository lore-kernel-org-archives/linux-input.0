From: =?ISO-8859-1?Q?=C9ric_Piel?= <E.A.B.Piel@tudelft.nl>
Subject: [PATCH 5/6] elantech: Report multitouch with proper ABS_MT messages
Date: Sat, 14 May 2011 08:49:44 +0200
Message-ID: <4DCE2608.6030003@tudelft.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailservice.tudelft.nl ([130.161.131.5]:52737 "EHLO
	mailservice.tudelft.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755045Ab1ENLIL (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 14 May 2011 07:08:11 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Henrik Rydberg <rydberg@euromail.se>, Chris Bagwell <chris@cnpbagwell.com>, Florian Ragwitz <rafl@debian.org>

Multitouch info was reported only via a old protocol used by the
proprietary X driver from elantech. Let's report the multitouch info
also following the official MT protocol. It's semi-mt because the devic=
e
only reports the lowest/highest coordinates.

This was done following the multi-touch-protocol.txt documentation, and
inspired by the bcm5974 and elantech implementations. Testing was light
as there is not many applications using this protocol yet, but the X
synaptics driver didn't complain and the X multitouch driver behaved
correctly.

Signed-off-by: =C9ric Piel <eric.piel@tremplin-utc.net>
---
 drivers/input/mouse/elantech.c |   36 +++++++++++++++++++++++++++++++-=
----
 1 files changed, 31 insertions(+), 5 deletions(-)

diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/elant=
ech.c
index 6817284..a05d092 100644
--- a/drivers/input/mouse/elantech.c
+++ b/drivers/input/mouse/elantech.c
@@ -16,6 +16,7 @@
 #include <linux/slab.h>
 #include <linux/module.h>
 #include <linux/input.h>
+#include <linux/input/mt.h>
 #include <linux/serio.h>
 #include <linux/libps2.h>
 #include "psmouse.h"
@@ -242,6 +243,24 @@ static void elantech_report_absolute_v1(struct psm=
ouse *psmouse)
 	input_sync(dev);
 }
=20
+static void set_slot(struct input_dev *dev, int slot, bool active, uns=
igned int x, unsigned int y)
+{
+	input_mt_slot(dev, slot);
+	input_mt_report_slot_state(dev, MT_TOOL_FINGER, active);
+	if (active) {
+		input_report_abs(dev, ABS_MT_POSITION_X, x);
+		input_report_abs(dev, ABS_MT_POSITION_Y, y);
+	}
+}
+
+/* x1 < x2 and y1 < y2 when two fingers, x =3D y =3D 0 when not presse=
d */
+static void elantech_report_semi_mt_data(struct input_dev *dev, int nu=
m_fingers,
+		  unsigned int x1, unsigned int y1, unsigned int x2, unsigned int y2=
)
+{
+	set_slot(dev, 0, (num_fingers > 0), x1, y1);
+	set_slot(dev, 1, (num_fingers =3D=3D 2), x2, y2);
+}
+
 /*
  * Interpret complete data packets and report absolute mode input even=
ts for
  * hardware version 2. (6 byte packets)
@@ -251,7 +270,7 @@ static void elantech_report_absolute_v2(struct psmo=
use *psmouse)
 	struct elantech_data *etd =3D psmouse->private;
 	struct input_dev *dev =3D psmouse->dev;
 	unsigned char *packet =3D psmouse->packet;
-	int fingers, x1, y1, x2, y2, width =3D 0, pres =3D 0;
+	unsigned int fingers, x1 =3D 0, y1 =3D 0, x2 =3D 0, y2 =3D 0, width =3D=
 0, pres =3D 0;
=20
 	/* byte 0: n1  n0   .   .   .   .   R   L */
 	fingers =3D (packet[0] & 0xc0) >> 6;
@@ -271,14 +290,16 @@ static void elantech_report_absolute_v2(struct ps=
mouse *psmouse)
 		 * byte 1:  .   .   .   .   .  x10 x9  x8
 		 * byte 2: x7  x6  x5  x4  x4  x2  x1  x0
 		 */
-		input_report_abs(dev, ABS_X,
-			((packet[1] & 0x07) << 8) | packet[2]);
+		x1 =3D ((packet[1] & 0x07) << 8) | packet[2];
 		/*
 		 * byte 4:  .   .   .   .   .   .  y9  y8
 		 * byte 5: y7  y6  y5  y4  y3  y2  y1  y0
 		 */
-		input_report_abs(dev, ABS_Y,
-			ETP_YMAX_V2 - (((packet[4] & 0x03) << 8) | packet[5]));
+		y1 =3D ETP_YMAX_V2 - (((packet[4] & 0x03) << 8) | packet[5]);
+
+		input_report_abs(dev, ABS_X, x1);
+		input_report_abs(dev, ABS_Y, y1);
+
 		pres =3D (packet[1] & 0xf0) | ((packet[4] & 0xf0) >> 4);
 		width =3D ((packet[0] & 0x30) >> 2) | ((packet[3] & 0x30) >> 4);
 		break;
@@ -321,6 +342,7 @@ static void elantech_report_absolute_v2(struct psmo=
use *psmouse)
 		break;
 	}
=20
+	elantech_report_semi_mt_data(dev, fingers, x1, y1, x2, y2);
 	input_report_key(dev, BTN_TOOL_FINGER, fingers =3D=3D 1);
 	input_report_key(dev, BTN_TOOL_DOUBLETAP, fingers =3D=3D 2);
 	input_report_key(dev, BTN_TOOL_TRIPLETAP, fingers =3D=3D 3);
@@ -548,6 +570,10 @@ static void elantech_set_input_params(struct psmou=
se *psmouse)
 			input_set_abs_params(dev, ABS_TOOL_WIDTH, ETP_WMIN_V2,
 					     ETP_WMAX_V2, 0, 0);
 		}
+		__set_bit(INPUT_PROP_SEMI_MT, dev->propbit);
+		input_mt_init_slots(dev, 2);
+		input_set_abs_params(dev, ABS_MT_POSITION_X, ETP_XMIN_V2, ETP_XMAX_V=
2, 0, 0);
+		input_set_abs_params(dev, ABS_MT_POSITION_Y, ETP_YMIN_V2, ETP_YMAX_V=
2, 0, 0);
 		input_set_abs_params(dev, ABS_HAT0X, ETP_2FT_XMIN, ETP_2FT_XMAX, 0, =
0);
 		input_set_abs_params(dev, ABS_HAT0Y, ETP_2FT_YMIN, ETP_2FT_YMAX, 0, =
0);
 		input_set_abs_params(dev, ABS_HAT1X, ETP_2FT_XMIN, ETP_2FT_XMAX, 0, =
0);
--=20
1.7.5.1

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
