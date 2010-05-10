From: =?UTF-8?B?w4lyaWMgUGllbA==?= <E.A.B.Piel@tudelft.nl>
Subject: Re: [PATCH 2/2 v3] elantech: Report multitouch with proper ABS_MT
 messages
Date: Mon, 10 May 2010 22:11:50 +0200
Message-ID: <4BE86886.2080909@tudelft.nl>
References: <4BE593AA.6040408@tudelft.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailservice.tudelft.nl ([130.161.131.5]:34429 "EHLO
	mailservice.tudelft.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756492Ab0EJULx (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 10 May 2010 16:11:53 -0400
In-Reply-To: <4BE593AA.6040408@tudelft.nl>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Florian Ragwitz <rafl@debian.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Henrik Rydberg <rydberg@euromail.se>

Here is an updated version of the patch. It is identical to the previou=
s
version but rediff'd against the lastest version of patch 1.

Eric

8<-------------------------------------------------------

Multitouch info was reported only via a old protocol used by the
proprietary X driver from elantech. Let's report the multitouch info
also following the official MT protocol.

This was done following the multi-touch-protocol.txt documentation, and
inspired by the bcm5974 implementation. Testing was light as there is
not many applications using this protocol yet, but the X synaptics
driver didn't complain and the X multitouch driver behaved correctly.

Signed-off-by: =C3=89ric Piel <eric.piel@tremplin-utc.net>
---
 drivers/input/mouse/elantech.c |   24 +++++++++++++++++++-----
 1 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/elant=
ech.c
index 3dceb0f..a226f21 100644
--- a/drivers/input/mouse/elantech.c
+++ b/drivers/input/mouse/elantech.c
@@ -271,15 +271,20 @@ static void elantech_report_absolute_v2(struct ps=
mouse *psmouse)
 		 * byte 3: .   .   w1  w0   .   .   .   .
 		 */
 		width =3D ((packet[1] & 0xf0) >> 2) | ((packet[3] & 0x30) >> 4);
-		input_report_abs(dev, ABS_TOOL_WIDTH, width);
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
+		/* Multitouch */
+		input_report_abs(dev, ABS_MT_POSITION_X, x1);
+		input_report_abs(dev, ABS_MT_POSITION_Y, y1);
+		input_mt_sync(dev);
+
+		input_report_abs(dev, ABS_TOOL_WIDTH, width);
+		input_report_abs(dev, ABS_X, x1);
+		input_report_abs(dev, ABS_Y, y1);
 		break;
=20
 	case 2:
@@ -299,6 +304,13 @@ static void elantech_report_absolute_v2(struct psm=
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
@@ -483,6 +495,8 @@ static void elantech_set_input_params(struct psmous=
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
