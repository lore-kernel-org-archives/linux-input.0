From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 02/14] alps: Always report 2 fingers (or more) when receiving mt data on v3 models
Date: Wed,  9 Jul 2014 17:24:07 +0200
Message-ID: <1404919459-23561-3-git-send-email-hdegoede@redhat.com>
References: <1404919459-23561-1-git-send-email-hdegoede@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:40586 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932544AbaGIPYb (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 9 Jul 2014 11:24:31 -0400
In-Reply-To: <1404919459-23561-1-git-send-email-hdegoede@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Yunkang Tang <yunkang.tang@cn.alps.com>, linux-input@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>

V3 models only report mt bitmap data when there are 2 or more fingers on
the touchpad. So always generate 2 positions in alps_process_bitmap, and
for v3 models only fall back to st data when there was no mt data in a
mt packet (which should never happen).

This fixes 2 finger scrolling not working when using 2 fingers close to
each other.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/input/mouse/alps.c | 60 +++++++++++++++++++---------------------------
 1 file changed, 24 insertions(+), 36 deletions(-)

diff --git a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c
index 0448331..b69205e 100644
--- a/drivers/input/mouse/alps.c
+++ b/drivers/input/mouse/alps.c
@@ -407,23 +407,20 @@ static int alps_process_bitmap(struct alps_data *priv,
 	fingers = max(fingers_x, fingers_y);
 
 	/*
-	 * If total fingers is > 1 but either axis reports only a single
-	 * contact, we have overlapping or adjacent fingers. For the
-	 * purposes of creating a bounding box, divide the single contact
-	 * (roughly) equally between the two points.
+	 * If an axis reports only a single contact, we have overlapping or
+	 * adjacent fingers. Divide the single contact between the two points.
 	 */
-	if (fingers > 1) {
-		if (fingers_x == 1) {
-			i = x_low.num_bits / 2;
-			x_low.num_bits = x_low.num_bits - i;
-			x_high.start_bit = x_low.start_bit + i;
-			x_high.num_bits = max(i, 1);
-		} else if (fingers_y == 1) {
-			i = y_low.num_bits / 2;
-			y_low.num_bits = y_low.num_bits - i;
-			y_high.start_bit = y_low.start_bit + i;
-			y_high.num_bits = max(i, 1);
-		}
+	if (fingers_x == 1) {
+		i = x_low.num_bits / 2;
+		x_low.num_bits = x_low.num_bits - i;
+		x_high.start_bit = x_low.start_bit + i;
+		x_high.num_bits = max(i, 1);
+	}
+	if (fingers_y == 1) {
+		i = y_low.num_bits / 2;
+		y_low.num_bits = y_low.num_bits - i;
+		y_high.start_bit = y_low.start_bit + i;
+		y_high.num_bits = max(i, 1);
 	}
 
 	*x1 = (priv->x_max * (2 * x_low.start_bit + x_low.num_bits - 1)) /
@@ -431,14 +428,12 @@ static int alps_process_bitmap(struct alps_data *priv,
 	*y1 = (priv->y_max * (2 * y_low.start_bit + y_low.num_bits - 1)) /
 	      (2 * (priv->y_bits - 1));
 
-	if (fingers > 1) {
-		*x2 = (priv->x_max *
-		       (2 * x_high.start_bit + x_high.num_bits - 1)) /
-		      (2 * (priv->x_bits - 1));
-		*y2 = (priv->y_max *
-		       (2 * y_high.start_bit + y_high.num_bits - 1)) /
-		      (2 * (priv->y_bits - 1));
-	}
+	*x2 = (priv->x_max *
+	       (2 * x_high.start_bit + x_high.num_bits - 1)) /
+	      (2 * (priv->x_bits - 1));
+	*y2 = (priv->y_max *
+	       (2 * y_high.start_bit + y_high.num_bits - 1)) /
+	      (2 * (priv->y_bits - 1));
 
 	return fingers;
 }
@@ -607,8 +602,7 @@ static void alps_process_touchpad_packet_v3_v5(struct psmouse *psmouse)
 	unsigned char *packet = psmouse->packet;
 	struct input_dev *dev = psmouse->dev;
 	struct input_dev *dev2 = priv->dev2;
-	int x1 = 0, y1 = 0, x2 = 0, y2 = 0;
-	int fingers = 0, bmap_fn;
+	int x1 = 0, y1 = 0, x2 = 0, y2 = 0, fingers = 0;
 	struct alps_fields f = {0};
 
 	priv->decode_fields(&f, packet, psmouse);
@@ -629,16 +623,10 @@ static void alps_process_touchpad_packet_v3_v5(struct psmouse *psmouse)
 		if (f.is_mp) {
 			fingers = f.fingers;
 			if (priv->proto_version == ALPS_PROTO_V3) {
-				bmap_fn = alps_process_bitmap(priv, f.x_map,
-							      f.y_map, &x1, &y1,
-							      &x2, &y2);
-
-				/*
-				 * We shouldn't report more than one finger if
-				 * we don't have two coordinates.
-				 */
-				if (fingers > 1 && bmap_fn < 2)
-					fingers = bmap_fn;
+				if (alps_process_bitmap(priv, f.x_map,
+							f.y_map, &x1, &y1,
+							&x2, &y2) == 0)
+					fingers = 0; /* Use st data */
 
 				/* Now process position packet */
 				priv->decode_fields(&f, priv->multi_data,
-- 
2.0.0

