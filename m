From: Kevin Cernekee <cernekee@gmail.com>
Subject: [PATCH V2 10/14] Input: ALPS - Move pixel and bitmap info into alps_data struct
Date: Sun,  3 Feb 2013 15:56:50 -0800
Message-ID: <1359935815-13507-11-git-send-email-cernekee@gmail.com>
References: <1359935815-13507-1-git-send-email-cernekee@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-da0-f43.google.com ([209.85.210.43]:52538 "EHLO
	mail-da0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753994Ab3BCX5g (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 3 Feb 2013 18:57:36 -0500
Received: by mail-da0-f43.google.com with SMTP id u36so2387744dak.2
        for <linux-input@vger.kernel.org>; Sun, 03 Feb 2013 15:57:35 -0800 (PST)
In-Reply-To: <1359935815-13507-1-git-send-email-cernekee@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: seth.forshee@canonical.com, emmanuel.thome@inria.fr, dturvene@dahetral.com, vincent.vanackere@gmail.com, bgamari@gmail.com, linux-input@vger.kernel.org

Newer touchpads use different constants, so make them runtime-
configurable.

Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
---
 drivers/input/mouse/alps.c |   47 +++++++++++++++++++++++---------------------
 drivers/input/mouse/alps.h |    8 ++++++++
 2 files changed, 33 insertions(+), 22 deletions(-)

diff --git a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c
index bea4a37..4729f89 100644
--- a/drivers/input/mouse/alps.c
+++ b/drivers/input/mouse/alps.c
@@ -27,12 +27,6 @@
 /*
  * Definitions for ALPS version 3 and 4 command mode protocol
  */
-#define ALPS_V3_X_MAX	2000
-#define ALPS_V3_Y_MAX	1400
-
-#define ALPS_BITMAP_X_BITS	15
-#define ALPS_BITMAP_Y_BITS	11
-
 #define ALPS_CMD_NIBBLE_10	0x01f2
 
 static const struct alps_nibble_commands alps_v3_nibble_commands[] = {
@@ -269,7 +263,8 @@ static void alps_process_packet_v1_v2(struct psmouse *psmouse)
  * These points are returned in x1, y1, x2, and y2 when the return value
  * is greater than 0.
  */
-static int alps_process_bitmap(unsigned int x_map, unsigned int y_map,
+static int alps_process_bitmap(struct alps_data *priv,
+			       unsigned int x_map, unsigned int y_map,
 			       int *x1, int *y1, int *x2, int *y2)
 {
 	struct alps_bitmap_point {
@@ -311,7 +306,7 @@ static int alps_process_bitmap(unsigned int x_map, unsigned int y_map,
 	 * y bitmap is reversed for what we need (lower positions are in
 	 * higher bits), so we process from the top end.
 	 */
-	y_map = y_map << (sizeof(y_map) * BITS_PER_BYTE - ALPS_BITMAP_Y_BITS);
+	y_map = y_map << (sizeof(y_map) * BITS_PER_BYTE - priv->y_bits);
 	prev_bit = 0;
 	point = &y_low;
 	for (i = 0; y_map != 0; i++, y_map <<= 1) {
@@ -357,16 +352,18 @@ static int alps_process_bitmap(unsigned int x_map, unsigned int y_map,
 		}
 	}
 
-	*x1 = (ALPS_V3_X_MAX * (2 * x_low.start_bit + x_low.num_bits - 1)) /
-	      (2 * (ALPS_BITMAP_X_BITS - 1));
-	*y1 = (ALPS_V3_Y_MAX * (2 * y_low.start_bit + y_low.num_bits - 1)) /
-	      (2 * (ALPS_BITMAP_Y_BITS - 1));
+	*x1 = (priv->x_max * (2 * x_low.start_bit + x_low.num_bits - 1)) /
+	      (2 * (priv->x_bits - 1));
+	*y1 = (priv->y_max * (2 * y_low.start_bit + y_low.num_bits - 1)) /
+	      (2 * (priv->y_bits - 1));
 
 	if (fingers > 1) {
-		*x2 = (ALPS_V3_X_MAX * (2 * x_high.start_bit + x_high.num_bits - 1)) /
-		      (2 * (ALPS_BITMAP_X_BITS - 1));
-		*y2 = (ALPS_V3_Y_MAX * (2 * y_high.start_bit + y_high.num_bits - 1)) /
-		      (2 * (ALPS_BITMAP_Y_BITS - 1));
+		*x2 = (priv->x_max *
+		       (2 * x_high.start_bit + x_high.num_bits - 1)) /
+		      (2 * (priv->x_bits - 1));
+		*y2 = (priv->y_max *
+		       (2 * y_high.start_bit + y_high.num_bits - 1)) /
+		      (2 * (priv->y_bits - 1));
 	}
 
 	return fingers;
@@ -484,7 +481,8 @@ static void alps_process_touchpad_packet_v3(struct psmouse *psmouse)
 				   ((packet[2] & 0x7f) << 1) |
 				   (packet[4] & 0x01);
 
-			bmap_fingers = alps_process_bitmap(x_bitmap, y_bitmap,
+			bmap_fingers = alps_process_bitmap(priv,
+							   x_bitmap, y_bitmap,
 							   &x1, &y1, &x2, &y2);
 
 			/*
@@ -641,7 +639,7 @@ static void alps_process_packet_v4(struct psmouse *psmouse)
 			   ((priv->multi_data[3] & 0x1f) << 5) |
 			    (priv->multi_data[1] & 0x1f);
 
-		fingers = alps_process_bitmap(x_bitmap, y_bitmap,
+		fingers = alps_process_bitmap(priv, x_bitmap, y_bitmap,
 					      &x1, &y1, &x2, &y2);
 
 		/* Store MT data.*/
@@ -1414,6 +1412,11 @@ static void alps_set_defaults(struct alps_data *priv)
 	priv->mask0 = 0x8f;
 	priv->flags = ALPS_DUALPOINT;
 
+	priv->x_max = 2000;
+	priv->y_max = 1400;
+	priv->x_bits = 15;
+	priv->y_bits = 11;
+
 	switch (priv->proto_version) {
 	case ALPS_PROTO_V1:
 	case ALPS_PROTO_V2:
@@ -1545,15 +1548,15 @@ static void alps_set_abs_params_mt(struct alps_data *priv,
 {
 	set_bit(INPUT_PROP_SEMI_MT, dev1->propbit);
 	input_mt_init_slots(dev1, 2, 0);
-	input_set_abs_params(dev1, ABS_MT_POSITION_X, 0, ALPS_V3_X_MAX, 0, 0);
-	input_set_abs_params(dev1, ABS_MT_POSITION_Y, 0, ALPS_V3_Y_MAX, 0, 0);
+	input_set_abs_params(dev1, ABS_MT_POSITION_X, 0, priv->x_max, 0, 0);
+	input_set_abs_params(dev1, ABS_MT_POSITION_Y, 0, priv->y_max, 0, 0);
 
 	set_bit(BTN_TOOL_DOUBLETAP, dev1->keybit);
 	set_bit(BTN_TOOL_TRIPLETAP, dev1->keybit);
 	set_bit(BTN_TOOL_QUADTAP, dev1->keybit);
 
-	input_set_abs_params(dev1, ABS_X, 0, ALPS_V3_X_MAX, 0, 0);
-	input_set_abs_params(dev1, ABS_Y, 0, ALPS_V3_Y_MAX, 0, 0);
+	input_set_abs_params(dev1, ABS_X, 0, priv->x_max, 0, 0);
+	input_set_abs_params(dev1, ABS_Y, 0, priv->y_max, 0, 0);
 }
 
 int alps_init(struct psmouse *psmouse)
diff --git a/drivers/input/mouse/alps.h b/drivers/input/mouse/alps.h
index 0934f8b..5e638be 100644
--- a/drivers/input/mouse/alps.h
+++ b/drivers/input/mouse/alps.h
@@ -72,6 +72,10 @@ struct alps_nibble_commands {
  *   mask0, should match byte0.
  * @mask0: The mask used to check the first byte of the report.
  * @flags: Additional device capabilities (passthrough port, trackstick, etc.).
+ * @x_max: Largest possible X position value.
+ * @y_max: Largest possible Y position value.
+ * @x_bits: Number of X bits in the MT bitmap.
+ * @y_bits: Number of Y bits in the MT bitmap.
  * @hw_init: Protocol-specific hardware init function.
  * @process_packet: Protocol-specific function to process a report packet.
  * @set_abs_params: Protocol-specific function to configure the input_dev.
@@ -96,6 +100,10 @@ struct alps_data {
 	unsigned char proto_version;
 	unsigned char byte0, mask0;
 	unsigned char flags;
+	int x_max;
+	int y_max;
+	int x_bits;
+	int y_bits;
 
 	int (*hw_init)(struct psmouse *psmouse);
 	void (*process_packet)(struct psmouse *psmouse);
-- 
1.7.10.4

