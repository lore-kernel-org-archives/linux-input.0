From: =?UTF-8?B?w4lyaWMgUGllbA==?= <E.A.B.Piel@tudelft.nl>
Subject: [PATCH 7/7] elantech: average the two coordinates when 2 fingers
Date: Mon, 21 Jun 2010 23:06:28 +0200
Message-ID: <4C1FD454.4050807@tudelft.nl>
References: <4C1FD2B0.1080504@tudelft.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailservice.tudelft.nl ([130.161.131.5]:44459 "EHLO
	mailservice.tudelft.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758439Ab0FUVIG (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 21 Jun 2010 17:08:06 -0400
In-Reply-To: <4C1FD2B0.1080504@tudelft.nl>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>
Cc: Florian Ragwitz <rafl@debian.org>

When 2 fingers are pressed, the low and high coordinates are given.
Instead of reporting just the low coordinate as the normal position,
report an average of both. This allow to have the cursor always move,
whichever finger moves. In practice, this improves the support of
two-fingers scolling with the synaptics X driver.

Signed-off-by: =C3=89ric Piel <eric.piel@tremplin-utc.net>
---
 drivers/input/mouse/elantech.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/elant=
ech.c
index c84f741..d1b505a 100644
--- a/drivers/input/mouse/elantech.c
+++ b/drivers/input/mouse/elantech.c
@@ -301,11 +301,11 @@ static void elantech_report_absolute_v2(struct ps=
mouse *psmouse)
 		/* byte 5: by7 by8 by5 by4 by3 by2 by1 by0 */
 		y2 =3D ETP_2FT_YMAX - (((packet[3] & 0x20) << 3) | packet[5]);
 		/*
-		 * For compatibility with the X Synaptics driver scale up
-		 * one coordinate and report as ordinary mouse movent
+		 * For compatibility with non-multitouch userspace apps
+		 * report the average of both coordinates and scale up.
 		 */
-		input_report_abs(dev, ABS_X, x1 << 2);
-		input_report_abs(dev, ABS_Y, y1 << 2);
+		input_report_abs(dev, ABS_X, (x1 + x2) << 1);
+		input_report_abs(dev, ABS_Y, (y1 + y2) << 1);
 		/*
 		 * For compatibility with the proprietary X Elantech driver
 		 * report both coordinates as hat coordinates
--=20
1.7.1


--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
