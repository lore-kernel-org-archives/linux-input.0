From: =?ISO-8859-1?Q?=C9ric_Piel?= <E.A.B.Piel@tudelft.nl>
Subject: [PATCH 6/6] elantech: remove support for proprietary X driver
Date: Sat, 14 May 2011 08:50:39 +0200
Message-ID: <4DCE263F.80905@tudelft.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailservice.tudelft.nl ([130.161.131.5]:43388 "EHLO
	mailservice.tudelft.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755409Ab1ENLIM (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 14 May 2011 07:08:12 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Henrik Rydberg <rydberg@euromail.se>, Chris Bagwell <chris@cnpbagwell.com>, Florian Ragwitz <rafl@debian.org>

Apparently somewhere someone had a proprietary X driver. To get the
multitouch info, it uses some hack on the normal API instead of using
the multitouch protocol. Now that the multitouch info is transmitted
correctly it makes not much sense to keep it. Especially because it's
impossible to find this proprietary X driver anywhere, so the number of
users must be very low.

Signed-off-by: =C9ric Piel <eric.piel@tremplin-utc.net>
---
 drivers/input/mouse/elantech.c |   12 ------------
 1 files changed, 0 insertions(+), 12 deletions(-)

diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/elant=
ech.c
index a05d092..5bfe508 100644
--- a/drivers/input/mouse/elantech.c
+++ b/drivers/input/mouse/elantech.c
@@ -327,14 +327,6 @@ static void elantech_report_absolute_v2(struct psm=
ouse *psmouse)
 		 */
 		input_report_abs(dev, ABS_X, x1 << 2);
 		input_report_abs(dev, ABS_Y, y1 << 2);
-		/*
-		 * For compatibility with the proprietary X Elantech driver
-		 * report both coordinates as hat coordinates
-		 */
-		input_report_abs(dev, ABS_HAT0X, x1);
-		input_report_abs(dev, ABS_HAT0Y, y1);
-		input_report_abs(dev, ABS_HAT1X, x2);
-		input_report_abs(dev, ABS_HAT1Y, y2);
=20
 		/* Unknown so just report sensible values */
 		pres =3D 127;
@@ -574,10 +566,6 @@ static void elantech_set_input_params(struct psmou=
se *psmouse)
 		input_mt_init_slots(dev, 2);
 		input_set_abs_params(dev, ABS_MT_POSITION_X, ETP_XMIN_V2, ETP_XMAX_V=
2, 0, 0);
 		input_set_abs_params(dev, ABS_MT_POSITION_Y, ETP_YMIN_V2, ETP_YMAX_V=
2, 0, 0);
-		input_set_abs_params(dev, ABS_HAT0X, ETP_2FT_XMIN, ETP_2FT_XMAX, 0, =
0);
-		input_set_abs_params(dev, ABS_HAT0Y, ETP_2FT_YMIN, ETP_2FT_YMAX, 0, =
0);
-		input_set_abs_params(dev, ABS_HAT1X, ETP_2FT_XMIN, ETP_2FT_XMAX, 0, =
0);
-		input_set_abs_params(dev, ABS_HAT1Y, ETP_2FT_YMIN, ETP_2FT_YMAX, 0, =
0);
 		break;
 	}
 }
--=20
1.7.5.1

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
