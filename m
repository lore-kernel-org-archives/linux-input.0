From: =?UTF-8?B?w4lyaWMgUGllbA==?= <E.A.B.Piel@tudelft.nl>
Subject: [PATCH 2/2 v2] elantech: Report multitouch with proper ABS_MT messages
Date: Sat, 08 May 2010 18:39:06 +0200
Message-ID: <4BE593AA.6040408@tudelft.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailservice.tudelft.nl ([130.161.131.5]:33917 "EHLO
	mailservice.tudelft.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753407Ab0EHQjZ (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sat, 8 May 2010 12:39:25 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Florian Ragwitz <rafl@debian.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Henrik Rydberg <rydberg@euromail.se>

Multitouch info was reported only via a old protocol used by the
proprietary X driver from elantech. Let's report the multitouch info
also following the official MT protocol.

This was done following the multi-touch-protocol.txt documentation, and
inspired by the bcm5974 implementation. Testing was light as there is
not many applications using this protocol yet, but the X synaptics
driver didn't complain and the X multitouch driver behaved correctly.

Signed-off-by: =C3=89ric Piel <eric.piel@tremplin-utc.net>
---
 drivers/input/mouse/elantech.c |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/elant=
ech.c
index 2708b22..fc3c98a 100644
--- a/drivers/input/mouse/elantech.c
+++ b/drivers/input/mouse/elantech.c
@@ -278,6 +278,10 @@ static void elantech_report_absolute_v2(struct psm=
ouse *psmouse)
 		 * byte 5: y7  y6  y5  y4  y3  y2  y1  y0
 		 */
 		y1 =3D ETP_YMAX_V2 - (((packet[4] & 0x03) << 8) | packet[5]);
+		input_report_abs(dev, ABS_MT_POSITION_X, x1);
+		input_report_abs(dev, ABS_MT_POSITION_Y, y1);
+		input_mt_sync(dev);
+
 		input_report_abs(dev, ABS_TOOL_WIDTH, width);
 		input_report_abs(dev, ABS_X, x1);
 		input_report_abs(dev, ABS_Y, y1);
@@ -300,6 +304,13 @@ static void elantech_report_absolute_v2(struct psm=
ouse *psmouse)
 		x2 =3D ((packet[3] & 0x10) << 4) | packet[4];
 		/* byte 5: by7 by6 by5 by4 by3 by2 by1 by0 */
 		y2 =3D ETP_2FT_YMAX - (((packet[3] & 0x20) << 3) | packet[5]);
+		/* Multitouch */
+		input_report_abs(dev, ABS_MT_POSITION_X, x1 << 2);
+		input_report_abs(dev, ABS_MT_POSITION_Y, y1 << 2);
+		input_mt_sync(dev);
+		input_report_abs(dev, ABS_MT_POSITION_X, x2 << 2);
+		input_report_abs(dev, ABS_MT_POSITION_Y, y2 << 2);
+		input_mt_sync(dev);
 		/*
 		 * For compatibility with the X Synaptics driver scale up
 		 * one coordinate and report as ordinary mouse movent
@@ -484,6 +495,8 @@ static void elantech_set_input_params(struct psmous=
e *psmouse)
 		input_set_abs_params(dev, ABS_TOOL_WIDTH, ETP_WMIN_V2, ETP_WMAX_V2, =
0, 0);
 		input_set_abs_params(dev, ABS_X, ETP_XMIN_V2, ETP_XMAX_V2, 0, 0);
 		input_set_abs_params(dev, ABS_Y, ETP_YMIN_V2, ETP_YMAX_V2, 0, 0);
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
1.7.1


--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
