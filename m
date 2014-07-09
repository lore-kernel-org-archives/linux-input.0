From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 04/14] alps: process_bitmap: Add alps_get_bitmap_points() helper function
Date: Wed,  9 Jul 2014 17:24:09 +0200
Message-ID: <1404919459-23561-5-git-send-email-hdegoede@redhat.com>
References: <1404919459-23561-1-git-send-email-hdegoede@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:38700 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932544AbaGIPYc (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 9 Jul 2014 11:24:32 -0400
In-Reply-To: <1404919459-23561-1-git-send-email-hdegoede@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Yunkang Tang <yunkang.tang@cn.alps.com>, linux-input@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>

Factor out the identical code for getting the bitmap points for x and y into
a helper function.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/input/mouse/alps.c | 75 +++++++++++++++++++---------------------------
 drivers/input/mouse/alps.h |  5 ++++
 2 files changed, 35 insertions(+), 45 deletions(-)

diff --git a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c
index 5768fb6..00c735d 100644
--- a/drivers/input/mouse/alps.c
+++ b/drivers/input/mouse/alps.c
@@ -328,6 +328,33 @@ static void alps_process_bitmap_dolphin(struct alps_data *priv,
 	}
 }
 
+static void alps_get_bitmap_points(unsigned int map,
+				   struct alps_bitmap_point *low,
+				   struct alps_bitmap_point *high,
+				   int *fingers)
+{
+	struct alps_bitmap_point *point;
+	int i, bit, prev_bit = 0;
+
+	point = low;
+	for (i = 0; map != 0; i++, map >>= 1) {
+		bit = map & 1;
+		if (bit) {
+			if (!prev_bit) {
+				point->start_bit = i;
+				(*fingers)++;
+			}
+			point->num_bits++;
+		} else {
+			if (prev_bit)
+				point = high;
+			else
+				point->num_bits = 0;
+		}
+		prev_bit = bit;
+	}
+}
+
 /*
  * Process bitmap data from v3 and v4 protocols. Returns the number of
  * fingers detected. A return value of 0 means at least one of the
@@ -342,59 +369,17 @@ static int alps_process_bitmap(struct alps_data *priv,
 			       unsigned int x_map, unsigned int y_map,
 			       int *x1, int *y1, int *x2, int *y2)
 {
-	struct alps_bitmap_point {
-		int start_bit;
-		int num_bits;
-	};
-
-	int fingers_x = 0, fingers_y = 0, fingers;
-	int i, bit, prev_bit;
+	int i, fingers_x = 0, fingers_y = 0, fingers;
 	struct alps_bitmap_point x_low = {0,}, x_high = {0,};
 	struct alps_bitmap_point y_low = {0,}, y_high = {0,};
-	struct alps_bitmap_point *point;
 
 	if (!x_map || !y_map)
 		return 0;
 
 	*x1 = *y1 = *x2 = *y2 = 0;
 
-	prev_bit = 0;
-	point = &x_low;
-	for (i = 0; x_map != 0; i++, x_map >>= 1) {
-		bit = x_map & 1;
-		if (bit) {
-			if (!prev_bit) {
-				point->start_bit = i;
-				fingers_x++;
-			}
-			point->num_bits++;
-		} else {
-			if (prev_bit)
-				point = &x_high;
-			else
-				point->num_bits = 0;
-		}
-		prev_bit = bit;
-	}
-
-	prev_bit = 0;
-	point = &y_low;
-	for (i = 0; y_map != 0; i++, y_map >>= 1) {
-		bit = y_map & 1;
-		if (bit) {
-			if (!prev_bit) {
-				point->start_bit = i;
-				fingers_y++;
-			}
-			point->num_bits++;
-		} else {
-			if (prev_bit)
-				point = &y_high;
-			else
-				point->num_bits = 0;
-		}
-		prev_bit = bit;
-	}
+	alps_get_bitmap_points(x_map, &x_low, &x_high, &fingers_x);
+	alps_get_bitmap_points(y_map, &y_low, &y_high, &fingers_y);
 
 	/*
 	 * Fingers can overlap, so we use the maximum count of fingers
diff --git a/drivers/input/mouse/alps.h b/drivers/input/mouse/alps.h
index 6d2666c..e900a08 100644
--- a/drivers/input/mouse/alps.h
+++ b/drivers/input/mouse/alps.h
@@ -65,6 +65,11 @@ struct alps_nibble_commands {
 	unsigned char data;
 };
 
+struct alps_bitmap_point {
+	int start_bit;
+	int num_bits;
+};
+
 /**
  * struct alps_fields - decoded version of the report packet
  * @x_map: Bitmap of active X positions for MT.
-- 
2.0.0

