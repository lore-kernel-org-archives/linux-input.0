From: =?ISO-8859-1?Q?=C9ric_Piel?= <E.A.B.Piel@tudelft.nl>
Subject: [PATCH 09/10] elantech: remove support for proprietary X driver
Date: Mon, 09 Aug 2010 00:54:49 +0200
Message-ID: <4C5F35B9.6060006@tudelft.nl>
References: <4C567F27.7070900@tudelft.nl> <4C5697C4.1020801@euromail.se> <4C56A81E.3040703@tudelft.nl> <4C56AA67.8000902@euromail.se> <4C56AD12.1080106@tudelft.nl> <4C56B00B.50204@euromail.se> <4C56B686.60606@tudelft.nl> <4C56BA13.3030104@euromail.se> <4C56BE30.2070807@tudelft.nl> <4C56C213.2010605@euromail.se> <20100802163913.GB3276@core.coreip.homeip.net> <4C5F34F4.7030503@tudelft.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailservice.tudelft.nl ([130.161.131.5]:40073 "EHLO
	mailservice.tudelft.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754712Ab0HHWzw (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 8 Aug 2010 18:55:52 -0400
In-Reply-To: <4C5F34F4.7030503@tudelft.nl>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Henrik Rydberg <rydberg@euromail.se>, Chris Bagwell <chris@cnpbagwell.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Florian Ragwitz <rafl@debian.org>

Apparently somewhere someone had a proprietary X driver. To get the
multitouch info, it uses some hack on the normal API instead of using
the multitouch protocol. Now that the multitouch info is transmitted
correctly it makes not much sense to keep it. Especially because it's
impossible to find this proprietary X driver anywhere, so the number of
user must be pretty low.

Signed-off-by: =C9ric Piel <eric.piel@tremplin-utc.net>
---
 drivers/input/mouse/elantech.c |   12 ------------
 1 files changed, 0 insertions(+), 12 deletions(-)

diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/elant=
ech.c
index 1dd7e7c..ba1c3d8 100644
--- a/drivers/input/mouse/elantech.c
+++ b/drivers/input/mouse/elantech.c
@@ -364,14 +364,6 @@ static void elantech_report_absolute_v2(struct psm=
ouse *psmouse)
 		 */
 		input_report_abs(dev, ABS_X, x1);
 		input_report_abs(dev, ABS_Y, y1);
-		/*
-		 * For compatibility with the proprietary X Elantech driver
-		 * report both coordinates as hat coordinates
-		 */
-		input_report_abs(dev, ABS_HAT0X, x1 >> 2);
-		input_report_abs(dev, ABS_HAT0Y, y1 >> 2);
-		input_report_abs(dev, ABS_HAT1X, x2 >> 2);
-		input_report_abs(dev, ABS_HAT1Y, y2 >> 2);
=20
 		/* Unknown so just report sensible values */
 		pres =3D 127;
@@ -608,10 +600,6 @@ static void elantech_set_input_params(struct psmou=
se *psmouse)
 		}
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
1.7.2.1


--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
