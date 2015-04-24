From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 4/7] alps: Use more accurate coordinates for first touch in semi-mt mode
Date: Fri, 24 Apr 2015 16:48:53 +0200
Message-ID: <1429886936-24587-5-git-send-email-hdegoede@redhat.com>
References: <1429886936-24587-1-git-send-email-hdegoede@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:53435 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756203AbbDXOtE (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 24 Apr 2015 10:49:04 -0400
In-Reply-To: <1429886936-24587-1-git-send-email-hdegoede@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Peter Hutterer <peter.hutterer@redhat.com>, Benjamin Tissoires <btissoir@redhat.com>, linux-input@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>

All alps semi-mt touchpads give us the following data when 2 (or more)
fingers are touching: 1 more or less accurate touch for the first finger
down, and a bitmap with columns and rows in which 1 or more fingers are
seen resulting in a crude (low res) bounding box.

So far for v3, rushmore and v4 touchpads we've been reporting the
coordinates of 2 opposite corners of the box when 2 fingers are touching.
Ignoring the much better resolution data given in the normal position
packet.

This commit actually uses this data for the first touch, figures out which
corner of the bounding box is closest to the first touch, and reports the
coordinates of the opposite corner for the second touch, resulting in
much better data for the first touch and for the single touch
pointer-emulation events.

This approach is similar to the one in alps_process_bitmap_dolphin, that
function takes the single accurate touch info, calculates the distance to
the center of the bounding box, and then puts the 2nd touch mirrored to
the center. The downside of that approach is that if both touches move
slowly in the same direction, the bounding box will stay the same for a
while (as it is low res) and the second touch will thus been seen moving
in the opposite direction until the bounding box actually changes, and
then the second touch snaps to its new position resulting in a saw tooth
pattern in the coordinates for the second touch, hence this new approach.

This commit fixes 2 finger scrolling being choppy / jumpy on these
touchpads.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/input/mouse/alps.c | 59 ++++++++++++++++++++++++++++++++++++++++------
 drivers/input/mouse/alps.h |  1 +
 2 files changed, 53 insertions(+), 7 deletions(-)

diff --git a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c
index 1cfee85..604dea3 100644
--- a/drivers/input/mouse/alps.c
+++ b/drivers/input/mouse/alps.c
@@ -396,9 +396,10 @@ static void alps_get_bitmap_points(unsigned int map,
 static int alps_process_bitmap(struct alps_data *priv,
 			       struct alps_fields *fields)
 {
-	int i, fingers_x = 0, fingers_y = 0, fingers;
+	int i, fingers_x = 0, fingers_y = 0, fingers, closest;
 	struct alps_bitmap_point x_low = {0,}, x_high = {0,};
 	struct alps_bitmap_point y_low = {0,}, y_high = {0,};
+	struct input_mt_pos corner[4];
 
 	if (!fields->x_map || !fields->y_map)
 		return 0;
@@ -429,26 +430,69 @@ static int alps_process_bitmap(struct alps_data *priv,
 		y_high.num_bits = max(i, 1);
 	}
 
-	fields->mt[0].x =
+	/* top-left corner */
+	corner[0].x =
 		(priv->x_max * (2 * x_low.start_bit + x_low.num_bits - 1)) /
 		(2 * (priv->x_bits - 1));
-	fields->mt[0].y =
+	corner[0].y =
 		(priv->y_max * (2 * y_low.start_bit + y_low.num_bits - 1)) /
 		(2 * (priv->y_bits - 1));
 
-	fields->mt[1].x =
+	/* top-right corner */
+	corner[1].x =
 		(priv->x_max * (2 * x_high.start_bit + x_high.num_bits - 1)) /
 		(2 * (priv->x_bits - 1));
-	fields->mt[1].y =
+	corner[1].y =
+		(priv->y_max * (2 * y_low.start_bit + y_low.num_bits - 1)) /
+		(2 * (priv->y_bits - 1));
+
+	/* bottom-right corner */
+	corner[2].x =
+		(priv->x_max * (2 * x_high.start_bit + x_high.num_bits - 1)) /
+		(2 * (priv->x_bits - 1));
+	corner[2].y =
+		(priv->y_max * (2 * y_high.start_bit + y_high.num_bits - 1)) /
+		(2 * (priv->y_bits - 1));
+
+	/* bottom-left corner */
+	corner[3].x =
+		(priv->x_max * (2 * x_low.start_bit + x_low.num_bits - 1)) /
+		(2 * (priv->x_bits - 1));
+	corner[3].y =
 		(priv->y_max * (2 * y_high.start_bit + y_high.num_bits - 1)) /
 		(2 * (priv->y_bits - 1));
 
 	/* y-bitmap order is reversed, except on rushmore */
 	if (priv->proto_version != ALPS_PROTO_V3_RUSHMORE) {
-		fields->mt[0].y = priv->y_max - fields->mt[0].y;
-		fields->mt[1].y = priv->y_max - fields->mt[1].y;
+		for (i = 0; i < 4; i++)
+			corner[i].y = priv->y_max - corner[i].y;
+	}
+
+	/*
+	 * We only select a corner for the second touch once per 2 finger
+	 * touch sequence to avoid the chosen corner (and thus the coordinates)
+	 * jumping around when the first touch is in the middle.
+	 */
+	if (priv->second_touch == -1) {
+		/* Find corner closest to our st coordinates */
+		closest = 0x7fffffff;
+		for (i = 0; i < 4; i++) {
+			int dx = fields->st.x - corner[i].x;
+			int dy = fields->st.y - corner[i].y;
+			int distance = dx * dx + dy * dy;
+
+			if (distance < closest) {
+				priv->second_touch = i;
+				closest = distance;
+			}
+		}
+		/* And select the opposite corner to use for the 2nd touch */
+		priv->second_touch = (priv->second_touch + 2) % 4;
 	}
 
+	fields->mt[0] = fields->st;
+	fields->mt[1] = corner[priv->second_touch];
+
 	return fingers;
 }
 
@@ -485,6 +529,7 @@ static void alps_report_semi_mt_data(struct psmouse *psmouse, int fingers)
 		f->mt[0].x = f->st.x;
 		f->mt[0].y = f->st.y;
 		fingers = f->pressure > 0 ? 1 : 0;
+		priv->second_touch = -1;
 	}
 
 	alps_report_mt_data(psmouse, (fingers <= 2) ? fingers : 2);
diff --git a/drivers/input/mouse/alps.h b/drivers/input/mouse/alps.h
index 6dfdccc..d37f814 100644
--- a/drivers/input/mouse/alps.h
+++ b/drivers/input/mouse/alps.h
@@ -278,6 +278,7 @@ struct alps_data {
 
 	int prev_fin;
 	int multi_packet;
+	int second_touch;
 	unsigned char multi_data[6];
 	struct alps_fields f;
 	u8 quirks;
-- 
2.3.5

