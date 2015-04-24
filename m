From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 7/7] alps: Use the generic process_bitmap function for dolphin (v5) touchpads too
Date: Fri, 24 Apr 2015 16:48:56 +0200
Message-ID: <1429886936-24587-8-git-send-email-hdegoede@redhat.com>
References: <1429886936-24587-1-git-send-email-hdegoede@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:57085 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757418AbbDXOtK (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 24 Apr 2015 10:49:10 -0400
In-Reply-To: <1429886936-24587-1-git-send-email-hdegoede@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Peter Hutterer <peter.hutterer@redhat.com>, Benjamin Tissoires <btissoir@redhat.com>, linux-input@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>

Now that the generic process_bitmap function has been improved to offer
accurate coordinates for the first touch we can use it for v5 (dolphin)
touchpads too.

Besides being a nice code cleanup this also fixes the saw tooth pattern
in the coordinates for the second touch the dolphin specific version had.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/input/mouse/alps.c | 74 ++++++++--------------------------------------
 1 file changed, 12 insertions(+), 62 deletions(-)

diff --git a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c
index 390a308..745921f 100644
--- a/drivers/input/mouse/alps.c
+++ b/drivers/input/mouse/alps.c
@@ -310,53 +310,6 @@ static void alps_process_packet_v1_v2(struct psmouse *psmouse)
 	input_sync(dev);
 }
 
-/*
- * Process bitmap data for V5 protocols. Return value is null.
- *
- * The bitmaps don't have enough data to track fingers, so this function
- * only generates points representing a bounding box of at most two contacts.
- * These two points are returned in fields->mt.
- */
-static void alps_process_bitmap_dolphin(struct alps_data *priv,
-					struct alps_fields *fields)
-{
-	int box_middle_x, box_middle_y;
-	unsigned int x_map, y_map;
-	unsigned char start_bit, end_bit;
-	unsigned char x_msb, x_lsb, y_msb, y_lsb;
-
-	x_map = fields->x_map;
-	y_map = fields->y_map;
-
-	if (!x_map || !y_map)
-		return;
-
-	/* Get Most-significant and Least-significant bit */
-	x_msb = fls(x_map);
-	x_lsb = ffs(x_map);
-	y_msb = fls(y_map);
-	y_lsb = ffs(y_map);
-
-	/* Most-significant bit should never exceed max sensor line number */
-	if (x_msb > priv->x_bits || y_msb > priv->y_bits)
-		return;
-
-	if (fields->fingers > 1) {
-		start_bit = priv->x_bits - x_msb;
-		end_bit = priv->x_bits - x_lsb;
-		box_middle_x = (priv->x_max * (start_bit + end_bit)) /
-				(2 * (priv->x_bits - 1));
-
-		start_bit = y_lsb - 1;
-		end_bit = y_msb - 1;
-		box_middle_y = (priv->y_max * (start_bit + end_bit)) /
-				(2 * (priv->y_bits - 1));
-		fields->mt[0] = fields->st;
-		fields->mt[1].x = 2 * box_middle_x - fields->mt[0].x;
-		fields->mt[1].y = 2 * box_middle_y - fields->mt[0].y;
-	}
-}
-
 static void alps_get_bitmap_points(unsigned int map,
 				   struct alps_bitmap_point *low,
 				   struct alps_bitmap_point *high,
@@ -384,7 +337,7 @@ static void alps_get_bitmap_points(unsigned int map,
 }
 
 /*
- * Process bitmap data from v3 and v4 protocols. Returns the number of
+ * Process bitmap data from semi-mt protocols. Returns the number of
  * fingers detected. A return value of 0 means at least one of the
  * bitmaps was empty.
  *
@@ -462,8 +415,15 @@ static int alps_process_bitmap(struct alps_data *priv,
 		(priv->y_max * (2 * y_high.start_bit + y_high.num_bits - 1)) /
 		(2 * (priv->y_bits - 1));
 
-	/* y-bitmap order is reversed, except on rushmore */
-	if (priv->proto_version != ALPS_PROTO_V3_RUSHMORE) {
+	/* x-bitmap order is reversed on v5 touchpads  */
+	if (priv->proto_version == ALPS_PROTO_V5) {
+		for (i = 0; i < 4; i++)
+			corner[i].x = priv->x_max - corner[i].x;
+	}
+
+	/* y-bitmap order is reversed on v3 and v4 touchpads  */
+	if (priv->proto_version == ALPS_PROTO_V3 ||
+	    priv->proto_version == ALPS_PROTO_V4) {
 		for (i = 0; i < 4; i++)
 			corner[i].y = priv->y_max - corner[i].y;
 	}
@@ -750,18 +710,8 @@ static void alps_process_touchpad_packet_v3_v5(struct psmouse *psmouse)
 			 * data, so we need to do decode it first.
 			 */
 			priv->decode_fields(f, priv->multi_data, psmouse);
-
-			if (priv->proto_version == ALPS_PROTO_V3 ||
-			    priv->proto_version == ALPS_PROTO_V3_RUSHMORE) {
-				if (alps_process_bitmap(priv, f) == 0)
-					fingers = 0; /* Use st data */
-			} else {
-				/*
-				 * Since Dolphin's finger number is reliable,
-				 * there is no need to compare with bmap_fn.
-				 */
-				alps_process_bitmap_dolphin(priv, f);
-			}
+			if (alps_process_bitmap(priv, f) == 0)
+				fingers = 0; /* Use st data */
 		} else {
 			priv->multi_packet = 0;
 		}
-- 
2.3.5

