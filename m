From: =?ISO-8859-1?Q?=C9ric_Piel?= <E.A.B.Piel@tudelft.nl>
Subject: [PATCH 10/10] elantech: don't take into account the border size in
 the calculations
Date: Mon, 09 Aug 2010 00:55:45 +0200
Message-ID: <4C5F35F1.5070104@tudelft.nl>
References: <4C567F27.7070900@tudelft.nl> <4C5697C4.1020801@euromail.se> <4C56A81E.3040703@tudelft.nl> <4C56AA67.8000902@euromail.se> <4C56AD12.1080106@tudelft.nl> <4C56B00B.50204@euromail.se> <4C56B686.60606@tudelft.nl> <4C56BA13.3030104@euromail.se> <4C56BE30.2070807@tudelft.nl> <4C56C213.2010605@euromail.se> <20100802163913.GB3276@core.coreip.homeip.net> <4C5F34F4.7030503@tudelft.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailservice.tudelft.nl ([130.161.131.5]:58378 "EHLO
	mailservice.tudelft.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754712Ab0HHWzy (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 8 Aug 2010 18:55:54 -0400
In-Reply-To: <4C5F34F4.7030503@tudelft.nl>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Henrik Rydberg <rydberg@euromail.se>, Chris Bagwell <chris@cnpbagwell.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Florian Ragwitz <rafl@debian.org>

The min and max of the reported ABS_X/Y are slightly smaller than the
theoretical maximum due to the physical border of the touchpad. However=
,
in the calculations, the maximum is the theoretical maximum. Otherwise
we can end up sending negative coordinates if the user manages to touch
the very borders. In addition, the incorrect number prevented to align
perfectly the coordinates between 1 and 2 touches.

Signed-off-by: =C9ric Piel <eric.piel@tremplin-utc.net>
---
 drivers/input/mouse/elantech.c |   20 ++++++++++++++------
 drivers/input/mouse/elantech.h |   26 ++++++++++++--------------
 2 files changed, 26 insertions(+), 20 deletions(-)

diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/elant=
ech.c
index ba1c3d8..bf95adf 100644
--- a/drivers/input/mouse/elantech.c
+++ b/drivers/input/mouse/elantech.c
@@ -584,22 +584,30 @@ static void elantech_set_input_params(struct psmo=
use *psmouse)
 			__set_bit(BTN_FORWARD, dev->keybit);
 			__set_bit(BTN_BACK, dev->keybit);
 		}
-		input_set_abs_params(dev, ABS_X, ETP_XMIN_V1, ETP_XMAX_V1, 0, 0);
-		input_set_abs_params(dev, ABS_Y, ETP_YMIN_V1, ETP_YMAX_V1, 0, 0);
+		input_set_abs_params(dev, ABS_X, ETP_XMIN_V1 + ETP_EDGE_FUZZ_V1,
+				     ETP_XMAX_V1 - ETP_EDGE_FUZZ_V1, 0, 0);
+		input_set_abs_params(dev, ABS_Y, ETP_YMIN_V1 + ETP_EDGE_FUZZ_V1,
+				     ETP_YMAX_V1 - ETP_EDGE_FUZZ_V1, 0, 0);
 		break;
=20
 	case 2:
 		__set_bit(BTN_TOOL_QUADTAP, dev->keybit);
-		input_set_abs_params(dev, ABS_X, ETP_XMIN_V2, ETP_XMAX_V2, 0, 0);
-		input_set_abs_params(dev, ABS_Y, ETP_YMIN_V2, ETP_YMAX_V2, 0, 0);
+		input_set_abs_params(dev, ABS_X, ETP_XMIN_V2 + ETP_EDGE_FUZZ_V2,
+				     ETP_XMAX_V2 - ETP_EDGE_FUZZ_V2, 0, 0);
+		input_set_abs_params(dev, ABS_Y, ETP_YMIN_V2 + ETP_EDGE_FUZZ_V2,
+				     ETP_YMAX_V2 - ETP_EDGE_FUZZ_V2, 0, 0);
 		if (etd->reports_pres) {
 			input_set_abs_params(dev, ABS_PRESSURE, ETP_PMIN_V2,
 					     ETP_PMAX_V2, 0, 0);
 			input_set_abs_params(dev, ABS_TOOL_WIDTH, ETP_WMIN_V2,
 					     ETP_WMAX_V2, 0, 0);
 		}
-		input_set_abs_params(dev, ABS_MT_POSITION_X, ETP_XMIN_V2, ETP_XMAX_V=
2, 0, 0);
-		input_set_abs_params(dev, ABS_MT_POSITION_Y, ETP_YMIN_V2, ETP_YMAX_V=
2, 0, 0);
+		input_set_abs_params(dev, ABS_MT_POSITION_X,
+				     ETP_XMIN_V2 + ETP_EDGE_FUZZ_V2,
+				     ETP_XMAX_V2 - ETP_EDGE_FUZZ_V2, 0, 0);
+		input_set_abs_params(dev, ABS_MT_POSITION_Y,
+				     ETP_YMIN_V2 + ETP_EDGE_FUZZ_V2,
+				     ETP_YMAX_V2 - ETP_EDGE_FUZZ_V2, 0, 0);
 		break;
 	}
 }
diff --git a/drivers/input/mouse/elantech.h b/drivers/input/mouse/elant=
ech.h
index fa9a6b4..75b0546 100644
--- a/drivers/input/mouse/elantech.h
+++ b/drivers/input/mouse/elantech.h
@@ -60,10 +60,10 @@
  */
 #define ETP_EDGE_FUZZ_V1		32
=20
-#define ETP_XMIN_V1			(  0 + ETP_EDGE_FUZZ_V1)
-#define ETP_XMAX_V1			(576 - ETP_EDGE_FUZZ_V1)
-#define ETP_YMIN_V1			(  0 + ETP_EDGE_FUZZ_V1)
-#define ETP_YMAX_V1			(384 - ETP_EDGE_FUZZ_V1)
+#define ETP_XMIN_V1			0
+#define ETP_XMAX_V1			576
+#define ETP_YMIN_V1			0
+#define ETP_YMAX_V1			384
=20
 /*
  * It seems the resolution for hardware version 2 doubled.
@@ -72,10 +72,10 @@
  */
 #define ETP_EDGE_FUZZ_V2		8
=20
-#define ETP_XMIN_V2			(   0 + ETP_EDGE_FUZZ_V2)
-#define ETP_XMAX_V2			(1152 - ETP_EDGE_FUZZ_V2)
-#define ETP_YMIN_V2			(   0 + ETP_EDGE_FUZZ_V2)
-#define ETP_YMAX_V2			( 768 - ETP_EDGE_FUZZ_V2)
+#define ETP_XMIN_V2			0
+#define ETP_XMAX_V2			1152
+#define ETP_YMIN_V2			0
+#define ETP_YMAX_V2			768
=20
 #define ETP_PMIN_V2			0
 #define ETP_PMAX_V2			255
@@ -86,12 +86,10 @@
  * For two finger touches the coordinate of each finger gets reported
  * separately but with reduced resolution.
  */
-#define ETP_2FT_FUZZ			4
-
-#define ETP_2FT_XMIN			(  0 + ETP_2FT_FUZZ)
-#define ETP_2FT_XMAX			(288 - ETP_2FT_FUZZ)
-#define ETP_2FT_YMIN			(  0 + ETP_2FT_FUZZ)
-#define ETP_2FT_YMAX			(192 - ETP_2FT_FUZZ)
+#define ETP_2FT_XMIN			0
+#define ETP_2FT_XMAX			288
+#define ETP_2FT_YMIN			0
+#define ETP_2FT_YMAX			192
=20
 struct elantech_data {
 	unsigned char reg_10;
--=20
1.7.2.1

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
