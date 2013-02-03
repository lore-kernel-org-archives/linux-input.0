From: Kevin Cernekee <cernekee@gmail.com>
Subject: [PATCH V2 11/14] Input: ALPS - Make the V3 packet field decoder "pluggable"
Date: Sun,  3 Feb 2013 15:56:51 -0800
Message-ID: <1359935815-13507-12-git-send-email-cernekee@gmail.com>
References: <1359935815-13507-1-git-send-email-cernekee@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f48.google.com ([209.85.160.48]:49852 "EHLO
	mail-pb0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754066Ab3BCX5i (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 3 Feb 2013 18:57:38 -0500
Received: by mail-pb0-f48.google.com with SMTP id wy12so2878506pbc.21
        for <linux-input@vger.kernel.org>; Sun, 03 Feb 2013 15:57:37 -0800 (PST)
In-Reply-To: <1359935815-13507-1-git-send-email-cernekee@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: seth.forshee@canonical.com, emmanuel.thome@inria.fr, dturvene@dahetral.com, vincent.vanackere@gmail.com, bgamari@gmail.com, linux-input@vger.kernel.org

A number of different ALPS touchpad protocols can reuse
alps_process_touchpad_packet_v3() with small tweaks to the bitfield
decoding.  Create a new priv->decode_fields() callback that handles the
per-model differences.

Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
---
 drivers/input/mouse/alps.c |  101 +++++++++++++++++++++++++-------------------
 drivers/input/mouse/alps.h |   38 +++++++++++++++++
 2 files changed, 95 insertions(+), 44 deletions(-)

diff --git a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c
index 4729f89..92fe354 100644
--- a/drivers/input/mouse/alps.c
+++ b/drivers/input/mouse/alps.c
@@ -447,17 +447,49 @@ static void alps_process_trackstick_packet_v3(struct psmouse *psmouse)
 	return;
 }
 
+static void alps_decode_buttons_v3(struct alps_fields *f, unsigned char *p)
+{
+	f->left = !!(p[3] & 0x01);
+	f->right = !!(p[3] & 0x02);
+	f->middle = !!(p[3] & 0x04);
+
+	f->ts_left = !!(p[3] & 0x10);
+	f->ts_right = !!(p[3] & 0x20);
+	f->ts_middle = !!(p[3] & 0x40);
+}
+
+static void alps_decode_pinnacle(struct alps_fields *f, unsigned char *p)
+{
+	f->first_mp = !!(p[4] & 0x40);
+	f->is_mp = !!(p[0] & 0x40);
+
+	f->fingers = (p[5] & 0x3) + 1;
+	f->x_map = ((p[4] & 0x7e) << 8) |
+		   ((p[1] & 0x7f) << 2) |
+		   ((p[0] & 0x30) >> 4);
+	f->y_map = ((p[3] & 0x70) << 4) |
+		   ((p[2] & 0x7f) << 1) |
+		   (p[4] & 0x01);
+
+	f->x = ((p[1] & 0x7f) << 4) | ((p[4] & 0x30) >> 2) |
+	       ((p[0] & 0x30) >> 4);
+	f->y = ((p[2] & 0x7f) << 4) | (p[4] & 0x0f);
+	f->z = p[5] & 0x7f;
+
+	alps_decode_buttons_v3(f, p);
+}
+
 static void alps_process_touchpad_packet_v3(struct psmouse *psmouse)
 {
 	struct alps_data *priv = psmouse->private;
 	unsigned char *packet = psmouse->packet;
 	struct input_dev *dev = psmouse->dev;
 	struct input_dev *dev2 = priv->dev2;
-	int x, y, z;
-	int left, right, middle;
 	int x1 = 0, y1 = 0, x2 = 0, y2 = 0;
 	int fingers = 0, bmap_fingers;
-	unsigned int x_bitmap, y_bitmap;
+	struct alps_fields f;
+
+	priv->decode_fields(&f, packet);
 
 	/*
 	 * There's no single feature of touchpad position and bitmap packets
@@ -472,17 +504,10 @@ static void alps_process_touchpad_packet_v3(struct psmouse *psmouse)
 		 * packet. Check for this, and when it happens process the
 		 * position packet as usual.
 		 */
-		if (packet[0] & 0x40) {
-			fingers = (packet[5] & 0x3) + 1;
-			x_bitmap = ((packet[4] & 0x7e) << 8) |
-				   ((packet[1] & 0x7f) << 2) |
-				   ((packet[0] & 0x30) >> 4);
-			y_bitmap = ((packet[3] & 0x70) << 4) |
-				   ((packet[2] & 0x7f) << 1) |
-				   (packet[4] & 0x01);
-
+		if (f.is_mp) {
+			fingers = f.fingers;
 			bmap_fingers = alps_process_bitmap(priv,
-							   x_bitmap, y_bitmap,
+							   f.x_map, f.y_map,
 							   &x1, &y1, &x2, &y2);
 
 			/*
@@ -493,7 +518,7 @@ static void alps_process_touchpad_packet_v3(struct psmouse *psmouse)
 				fingers = bmap_fingers;
 
 			/* Now process position packet */
-			packet = priv->multi_data;
+			priv->decode_fields(&f, priv->multi_data);
 		} else {
 			priv->multi_packet = 0;
 		}
@@ -507,10 +532,10 @@ static void alps_process_touchpad_packet_v3(struct psmouse *psmouse)
 	 * out misidentified bitmap packets, we reject anything with this
 	 * bit set.
 	 */
-	if (packet[0] & 0x40)
+	if (f.is_mp)
 		return;
 
-	if (!priv->multi_packet && (packet[4] & 0x40)) {
+	if (!priv->multi_packet && f.first_mp) {
 		priv->multi_packet = 1;
 		memcpy(priv->multi_data, packet, sizeof(priv->multi_data));
 		return;
@@ -518,22 +543,13 @@ static void alps_process_touchpad_packet_v3(struct psmouse *psmouse)
 
 	priv->multi_packet = 0;
 
-	left = packet[3] & 0x01;
-	right = packet[3] & 0x02;
-	middle = packet[3] & 0x04;
-
-	x = ((packet[1] & 0x7f) << 4) | ((packet[4] & 0x30) >> 2) |
-	    ((packet[0] & 0x30) >> 4);
-	y = ((packet[2] & 0x7f) << 4) | (packet[4] & 0x0f);
-	z = packet[5] & 0x7f;
-
 	/*
 	 * Sometimes the hardware sends a single packet with z = 0
 	 * in the middle of a stream. Real releases generate packets
 	 * with x, y, and z all zero, so these seem to be flukes.
 	 * Ignore them.
 	 */
-	if (x && y && !z)
+	if (f.x && f.y && !f.z)
 		return;
 
 	/*
@@ -541,12 +557,12 @@ static void alps_process_touchpad_packet_v3(struct psmouse *psmouse)
 	 * to rely on ST data.
 	 */
 	if (!fingers) {
-		x1 = x;
-		y1 = y;
-		fingers = z > 0 ? 1 : 0;
+		x1 = f.x;
+		y1 = f.y;
+		fingers = f.z > 0 ? 1 : 0;
 	}
 
-	if (z >= 64)
+	if (f.z >= 64)
 		input_report_key(dev, BTN_TOUCH, 1);
 	else
 		input_report_key(dev, BTN_TOUCH, 0);
@@ -555,26 +571,22 @@ static void alps_process_touchpad_packet_v3(struct psmouse *psmouse)
 
 	input_mt_report_finger_count(dev, fingers);
 
-	input_report_key(dev, BTN_LEFT, left);
-	input_report_key(dev, BTN_RIGHT, right);
-	input_report_key(dev, BTN_MIDDLE, middle);
+	input_report_key(dev, BTN_LEFT, f.left);
+	input_report_key(dev, BTN_RIGHT, f.right);
+	input_report_key(dev, BTN_MIDDLE, f.middle);
 
-	if (z > 0) {
-		input_report_abs(dev, ABS_X, x);
-		input_report_abs(dev, ABS_Y, y);
+	if (f.z > 0) {
+		input_report_abs(dev, ABS_X, f.x);
+		input_report_abs(dev, ABS_Y, f.y);
 	}
-	input_report_abs(dev, ABS_PRESSURE, z);
+	input_report_abs(dev, ABS_PRESSURE, f.z);
 
 	input_sync(dev);
 
 	if (!(priv->quirks & ALPS_QUIRK_TRACKSTICK_BUTTONS)) {
-		left = packet[3] & 0x10;
-		right = packet[3] & 0x20;
-		middle = packet[3] & 0x40;
-
-		input_report_key(dev2, BTN_LEFT, left);
-		input_report_key(dev2, BTN_RIGHT, right);
-		input_report_key(dev2, BTN_MIDDLE, middle);
+		input_report_key(dev2, BTN_LEFT, f.ts_left);
+		input_report_key(dev2, BTN_RIGHT, f.ts_right);
+		input_report_key(dev2, BTN_MIDDLE, f.ts_middle);
 		input_sync(dev2);
 	}
 }
@@ -1428,6 +1440,7 @@ static void alps_set_defaults(struct alps_data *priv)
 		priv->hw_init = alps_hw_init_v3;
 		priv->process_packet = alps_process_packet_v3;
 		priv->set_abs_params = alps_set_abs_params_mt;
+		priv->decode_fields = alps_decode_pinnacle;
 		priv->nibble_commands = alps_v3_nibble_commands;
 		priv->addr_command = PSMOUSE_CMD_RESET_WRAP;
 		break;
diff --git a/drivers/input/mouse/alps.h b/drivers/input/mouse/alps.h
index 5e638be..9704805 100644
--- a/drivers/input/mouse/alps.h
+++ b/drivers/input/mouse/alps.h
@@ -60,6 +60,42 @@ struct alps_nibble_commands {
 };
 
 /**
+ * struct alps_fields - decoded version of the report packet
+ * @x_map: Bitmap of active X positions for MT.
+ * @y_map: Bitmap of active Y positions for MT.
+ * @fingers: Number of fingers for MT.
+ * @x: X position for ST.
+ * @y: Y position for ST.
+ * @z: Z position for ST.
+ * @first_mp: Packet is the first of a multi-packet report.
+ * @is_mp: Packet is part of a multi-packet report.
+ * @left: Left touchpad button is active.
+ * @right: Right touchpad button is active.
+ * @middle: Middle touchpad button is active.
+ * @ts_left: Left trackstick button is active.
+ * @ts_right: Right trackstick button is active.
+ * @ts_middle: Middle trackstick button is active.
+ */
+struct alps_fields {
+	unsigned int x_map;
+	unsigned int y_map;
+	unsigned int fingers;
+	unsigned int x;
+	unsigned int y;
+	unsigned int z;
+	unsigned int first_mp:1;
+	unsigned int is_mp:1;
+
+	unsigned int left:1;
+	unsigned int right:1;
+	unsigned int middle:1;
+
+	unsigned int ts_left:1;
+	unsigned int ts_right:1;
+	unsigned int ts_middle:1;
+};
+
+/**
  * struct alps_data - private data structure for the ALPS driver
  * @dev2: "Relative" device used to report trackstick or mouse activity.
  * @phys: Physical path for the relative device.
@@ -78,6 +114,7 @@ struct alps_nibble_commands {
  * @y_bits: Number of Y bits in the MT bitmap.
  * @hw_init: Protocol-specific hardware init function.
  * @process_packet: Protocol-specific function to process a report packet.
+ * @decode_fields: Protocol-specific function to read packet bitfields.
  * @set_abs_params: Protocol-specific function to configure the input_dev.
  * @prev_fin: Finger bit from previous packet.
  * @multi_packet: Multi-packet data in progress.
@@ -107,6 +144,7 @@ struct alps_data {
 
 	int (*hw_init)(struct psmouse *psmouse);
 	void (*process_packet)(struct psmouse *psmouse);
+	void (*decode_fields)(struct alps_fields *f, unsigned char *p);
 	void (*set_abs_params)(struct alps_data *priv, struct input_dev *dev1);
 
 	int prev_fin;
-- 
1.7.10.4

