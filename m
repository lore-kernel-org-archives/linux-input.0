From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 1/7] Input: psmouse - create helper for reporting standard buttons/motion
Date: Fri, 19 Jan 2018 15:06:23 -0800
Message-ID: <20180119230629.49428-2-dmitry.torokhov@gmail.com>
References: <20180119230629.49428-1-dmitry.torokhov@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:39419 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753427AbeASXGe (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 19 Jan 2018 18:06:34 -0500
In-Reply-To: <20180119230629.49428-1-dmitry.torokhov@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Hans de Goede <hdegoede@redhat.com>, Lyude Paul <lyude@redhat.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Many protocol driver re-implement code to parse buttons or motion data from
the standard PS/2 protocol. Let's split the parsing into separate
functions and reuse them in protocol drivers.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/mouse/alps.c         | 30 +++++++-----------------------
 drivers/input/mouse/elantech.c     | 28 ++++++++++------------------
 drivers/input/mouse/lifebook.c     | 12 ++++--------
 drivers/input/mouse/logips2pp.c    | 10 ++++------
 drivers/input/mouse/psmouse-base.c | 26 ++++++++++++++++++++------
 drivers/input/mouse/psmouse.h      |  4 ++++
 drivers/input/mouse/sentelic.c     | 11 +----------
 7 files changed, 50 insertions(+), 71 deletions(-)

diff --git a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c
index dbe57da8c1a1b..f9c7f24522644 100644
--- a/drivers/input/mouse/alps.c
+++ b/drivers/input/mouse/alps.c
@@ -827,7 +827,7 @@ static void alps_process_packet_v6(struct psmouse *psmouse)
 	unsigned char *packet = psmouse->packet;
 	struct input_dev *dev = psmouse->dev;
 	struct input_dev *dev2 = priv->dev2;
-	int x, y, z, left, right, middle;
+	int x, y, z;
 
 	/*
 	 * We can use Byte5 to distinguish if the packet is from Touchpad
@@ -847,9 +847,6 @@ static void alps_process_packet_v6(struct psmouse *psmouse)
 		x = packet[1] | ((packet[3] & 0x20) << 2);
 		y = packet[2] | ((packet[3] & 0x40) << 1);
 		z = packet[4];
-		left = packet[3] & 0x01;
-		right = packet[3] & 0x02;
-		middle = packet[3] & 0x04;
 
 		/* To prevent the cursor jump when finger lifted */
 		if (x == 0x7F && y == 0x7F && z == 0x7F)
@@ -859,9 +856,7 @@ static void alps_process_packet_v6(struct psmouse *psmouse)
 		input_report_rel(dev2, REL_X, (char)x / 4);
 		input_report_rel(dev2, REL_Y, -((char)y / 4));
 
-		input_report_key(dev2, BTN_LEFT, left);
-		input_report_key(dev2, BTN_RIGHT, right);
-		input_report_key(dev2, BTN_MIDDLE, middle);
+		psmouse_report_standard_buttons(dev2, packet[3]);
 
 		input_sync(dev2);
 		return;
@@ -871,8 +866,6 @@ static void alps_process_packet_v6(struct psmouse *psmouse)
 	x = packet[1] | ((packet[3] & 0x78) << 4);
 	y = packet[2] | ((packet[4] & 0x78) << 4);
 	z = packet[5];
-	left = packet[3] & 0x01;
-	right = packet[3] & 0x02;
 
 	if (z > 30)
 		input_report_key(dev, BTN_TOUCH, 1);
@@ -888,8 +881,8 @@ static void alps_process_packet_v6(struct psmouse *psmouse)
 	input_report_key(dev, BTN_TOOL_FINGER, z > 0);
 
 	/* v6 touchpad does not have middle button */
-	input_report_key(dev, BTN_LEFT, left);
-	input_report_key(dev, BTN_RIGHT, right);
+	packet[3] &= ~BIT(2);
+	psmouse_report_standard_buttons(dev2, packet[3]);
 
 	input_sync(dev);
 }
@@ -1098,7 +1091,7 @@ static void alps_process_trackstick_packet_v7(struct psmouse *psmouse)
 	struct alps_data *priv = psmouse->private;
 	unsigned char *packet = psmouse->packet;
 	struct input_dev *dev2 = priv->dev2;
-	int x, y, z, left, right, middle;
+	int x, y, z;
 
 	/* It should be a DualPoint when received trackstick packet */
 	if (!(priv->flags & ALPS_DUALPOINT)) {
@@ -1112,16 +1105,10 @@ static void alps_process_trackstick_packet_v7(struct psmouse *psmouse)
 	    ((packet[3] & 0x20) << 1);
 	z = (packet[5] & 0x3f) | ((packet[3] & 0x80) >> 1);
 
-	left = (packet[1] & 0x01);
-	right = (packet[1] & 0x02) >> 1;
-	middle = (packet[1] & 0x04) >> 2;
-
 	input_report_rel(dev2, REL_X, (char)x);
 	input_report_rel(dev2, REL_Y, -((char)y));
 
-	input_report_key(dev2, BTN_LEFT, left);
-	input_report_key(dev2, BTN_RIGHT, right);
-	input_report_key(dev2, BTN_MIDDLE, middle);
+	psmouse_report_standard_buttons(dev2, packet[1]);
 
 	input_sync(dev2);
 }
@@ -1503,10 +1490,7 @@ static void alps_report_bare_ps2_packet(struct psmouse *psmouse,
 		alps_report_buttons(dev, dev2,
 				packet[0] & 1, packet[0] & 2, packet[0] & 4);
 
-	input_report_rel(dev, REL_X,
-		packet[1] ? packet[1] - ((packet[0] << 4) & 0x100) : 0);
-	input_report_rel(dev, REL_Y,
-		packet[2] ? ((packet[0] << 3) & 0x100) - packet[2] : 0);
+	psmouse_report_standard_motion(dev, packet);
 
 	input_sync(dev);
 }
diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/elantech.c
index a4aaa748e987f..af7fc17c14d96 100644
--- a/drivers/input/mouse/elantech.c
+++ b/drivers/input/mouse/elantech.c
@@ -279,8 +279,8 @@ static void elantech_report_absolute_v1(struct psmouse *psmouse)
 	input_report_key(dev, BTN_TOOL_FINGER, fingers == 1);
 	input_report_key(dev, BTN_TOOL_DOUBLETAP, fingers == 2);
 	input_report_key(dev, BTN_TOOL_TRIPLETAP, fingers == 3);
-	input_report_key(dev, BTN_LEFT, packet[0] & 0x01);
-	input_report_key(dev, BTN_RIGHT, packet[0] & 0x02);
+
+	psmouse_report_standard_buttons(dev, packet[0]);
 
 	if (etd->fw_version < 0x020000 &&
 	    (etd->capabilities[0] & ETP_CAP_HAS_ROCKER)) {
@@ -390,8 +390,7 @@ static void elantech_report_absolute_v2(struct psmouse *psmouse)
 	input_report_key(dev, BTN_TOOL_DOUBLETAP, fingers == 2);
 	input_report_key(dev, BTN_TOOL_TRIPLETAP, fingers == 3);
 	input_report_key(dev, BTN_TOOL_QUADTAP, fingers == 4);
-	input_report_key(dev, BTN_LEFT, packet[0] & 0x01);
-	input_report_key(dev, BTN_RIGHT, packet[0] & 0x02);
+	psmouse_report_standard_buttons(dev, packet[0]);
 	if (etd->reports_pressure) {
 		input_report_abs(dev, ABS_PRESSURE, pres);
 		input_report_abs(dev, ABS_TOOL_WIDTH, width);
@@ -434,9 +433,7 @@ static void elantech_report_trackpoint(struct psmouse *psmouse,
 		x = packet[4] - (int)((packet[1]^0x80) << 1);
 		y = (int)((packet[2]^0x80) << 1) - packet[5];
 
-		input_report_key(tp_dev, BTN_LEFT, packet[0] & 0x01);
-		input_report_key(tp_dev, BTN_RIGHT, packet[0] & 0x02);
-		input_report_key(tp_dev, BTN_MIDDLE, packet[0] & 0x04);
+		psmouse_report_standard_buttons(tp_dev, packet[0]);
 
 		input_report_rel(tp_dev, REL_X, x);
 		input_report_rel(tp_dev, REL_Y, y);
@@ -526,12 +523,10 @@ static void elantech_report_absolute_v3(struct psmouse *psmouse,
 	input_report_key(dev, BTN_TOOL_TRIPLETAP, fingers == 3);
 
 	/* For clickpads map both buttons to BTN_LEFT */
-	if (etd->fw_version & 0x001000) {
+	if (etd->fw_version & 0x001000)
 		input_report_key(dev, BTN_LEFT, packet[0] & 0x03);
-	} else {
-		input_report_key(dev, BTN_LEFT, packet[0] & 0x01);
-		input_report_key(dev, BTN_RIGHT, packet[0] & 0x02);
-	}
+	else
+		psmouse_report_standard_buttons(dev, packet[0]);
 
 	input_report_abs(dev, ABS_PRESSURE, pres);
 	input_report_abs(dev, ABS_TOOL_WIDTH, width);
@@ -546,13 +541,10 @@ static void elantech_input_sync_v4(struct psmouse *psmouse)
 	unsigned char *packet = psmouse->packet;
 
 	/* For clickpads map both buttons to BTN_LEFT */
-	if (etd->fw_version & 0x001000) {
+	if (etd->fw_version & 0x001000)
 		input_report_key(dev, BTN_LEFT, packet[0] & 0x03);
-	} else {
-		input_report_key(dev, BTN_LEFT, packet[0] & 0x01);
-		input_report_key(dev, BTN_RIGHT, packet[0] & 0x02);
-		input_report_key(dev, BTN_MIDDLE, packet[0] & 0x04);
-	}
+	else
+		psmouse_report_standard_buttons(dev, packet[0]);
 
 	input_mt_report_pointer_emulation(dev, true);
 	input_sync(dev);
diff --git a/drivers/input/mouse/lifebook.c b/drivers/input/mouse/lifebook.c
index 13d324cef7df5..65efaade0820d 100644
--- a/drivers/input/mouse/lifebook.c
+++ b/drivers/input/mouse/lifebook.c
@@ -188,14 +188,10 @@ static psmouse_ret_t lifebook_process_byte(struct psmouse *psmouse)
 	}
 
 	if (dev2) {
-		if (relative_packet) {
-			input_report_rel(dev2, REL_X,
-				((packet[0] & 0x10) ? packet[1] - 256 : packet[1]));
-			input_report_rel(dev2, REL_Y,
-				 -(int)((packet[0] & 0x20) ? packet[2] - 256 : packet[2]));
-		}
-		input_report_key(dev2, BTN_LEFT, packet[0] & 0x01);
-		input_report_key(dev2, BTN_RIGHT, packet[0] & 0x02);
+		if (relative_packet)
+			psmouse_report_standard_motion(dev2, packet);
+
+		psmouse_report_standard_buttons(dev2, packet[0]);
 		input_sync(dev2);
 	}
 
diff --git a/drivers/input/mouse/logips2pp.c b/drivers/input/mouse/logips2pp.c
index ef9c97f5e3d78..b7d17db632fc0 100644
--- a/drivers/input/mouse/logips2pp.c
+++ b/drivers/input/mouse/logips2pp.c
@@ -88,16 +88,14 @@ static psmouse_ret_t ps2pp_process_byte(struct psmouse *psmouse)
 				    (packet[1] >> 4) | (packet[0] & 0x30));
 			break;
 		}
+
+		psmouse_report_standard_buttons(dev, packet[0]);
+
 	} else {
 		/* Standard PS/2 motion data */
-		input_report_rel(dev, REL_X, packet[1] ? (int) packet[1] - (int) ((packet[0] << 4) & 0x100) : 0);
-		input_report_rel(dev, REL_Y, packet[2] ? (int) ((packet[0] << 3) & 0x100) - (int) packet[2] : 0);
+		psmouse_report_standard_packet(dev, packet);
 	}
 
-	input_report_key(dev, BTN_LEFT,    packet[0]       & 1);
-	input_report_key(dev, BTN_MIDDLE, (packet[0] >> 2) & 1);
-	input_report_key(dev, BTN_RIGHT,  (packet[0] >> 1) & 1);
-
 	input_sync(dev);
 
 	return PSMOUSE_FULL_PACKET;
diff --git a/drivers/input/mouse/psmouse-base.c b/drivers/input/mouse/psmouse-base.c
index 8ac9e03c05b45..19f7727555911 100644
--- a/drivers/input/mouse/psmouse-base.c
+++ b/drivers/input/mouse/psmouse-base.c
@@ -116,13 +116,30 @@ static DEFINE_MUTEX(psmouse_mutex);
 
 static struct workqueue_struct *kpsmoused_wq;
 
-static void psmouse_report_standard_buttons(struct input_dev *dev, u8 buttons)
+void psmouse_report_standard_buttons(struct input_dev *dev, u8 buttons)
 {
 	input_report_key(dev, BTN_LEFT,   buttons & BIT(0));
 	input_report_key(dev, BTN_MIDDLE, buttons & BIT(2));
 	input_report_key(dev, BTN_RIGHT,  buttons & BIT(1));
 }
 
+void psmouse_report_standard_motion(struct input_dev *dev, u8 *packet)
+{
+	int x, y;
+
+	x = packet[1] ? packet[1] - ((packet[0] << 4) & 0x100) : 0;
+	y = packet[2] ? packet[2] - ((packet[0] << 3) & 0x100) : 0;
+
+	input_report_rel(dev, REL_X, x);
+	input_report_rel(dev, REL_Y, -y);
+}
+
+void psmouse_report_standard_packet(struct input_dev *dev, u8 *packet)
+{
+	psmouse_report_standard_buttons(dev, packet[0]);
+	psmouse_report_standard_motion(dev, packet);
+}
+
 /*
  * psmouse_process_byte() analyzes the PS/2 data stream and reports
  * relevant events to the input module once full packet has arrived.
@@ -195,11 +212,8 @@ psmouse_ret_t psmouse_process_byte(struct psmouse *psmouse)
 	}
 
 	/* Generic PS/2 Mouse */
-	psmouse_report_standard_buttons(dev,
-					packet[0] | psmouse->extra_buttons);
-
-	input_report_rel(dev, REL_X, packet[1] ? (int) packet[1] - (int) ((packet[0] << 4) & 0x100) : 0);
-	input_report_rel(dev, REL_Y, packet[2] ? (int) ((packet[0] << 3) & 0x100) - (int) packet[2] : 0);
+	packet[0] |= psmouse->extra_buttons;
+	psmouse_report_standard_packet(dev, packet);
 
 	input_sync(dev);
 
diff --git a/drivers/input/mouse/psmouse.h b/drivers/input/mouse/psmouse.h
index 8cd453808cc7d..8bc99691494e9 100644
--- a/drivers/input/mouse/psmouse.h
+++ b/drivers/input/mouse/psmouse.h
@@ -140,6 +140,10 @@ int psmouse_activate(struct psmouse *psmouse);
 int psmouse_deactivate(struct psmouse *psmouse);
 bool psmouse_matches_pnp_id(struct psmouse *psmouse, const char * const ids[]);
 
+void psmouse_report_standard_buttons(struct input_dev *, u8 buttons);
+void psmouse_report_standard_motion(struct input_dev *, u8 *packet);
+void psmouse_report_standard_packet(struct input_dev *, u8 *packet);
+
 struct psmouse_attribute {
 	struct device_attribute dattr;
 	void *data;
diff --git a/drivers/input/mouse/sentelic.c b/drivers/input/mouse/sentelic.c
index 11c32ac8234b2..1d6010d463e2c 100644
--- a/drivers/input/mouse/sentelic.c
+++ b/drivers/input/mouse/sentelic.c
@@ -710,7 +710,6 @@ static psmouse_ret_t fsp_process_byte(struct psmouse *psmouse)
 	unsigned char *packet = psmouse->packet;
 	unsigned char button_status = 0, lscroll = 0, rscroll = 0;
 	unsigned short abs_x, abs_y, fgrs = 0;
-	int rel_x, rel_y;
 
 	if (psmouse->pktcnt < 4)
 		return PSMOUSE_GOOD_DATA;
@@ -840,15 +839,7 @@ static psmouse_ret_t fsp_process_byte(struct psmouse *psmouse)
 		/*
 		 * Standard PS/2 Mouse
 		 */
-		input_report_key(dev, BTN_LEFT, packet[0] & 1);
-		input_report_key(dev, BTN_MIDDLE, (packet[0] >> 2) & 1);
-		input_report_key(dev, BTN_RIGHT, (packet[0] >> 1) & 1);
-
-		rel_x = packet[1] ? (int)packet[1] - (int)((packet[0] << 4) & 0x100) : 0;
-		rel_y = packet[2] ? (int)((packet[0] << 3) & 0x100) - (int)packet[2] : 0;
-
-		input_report_rel(dev, REL_X, rel_x);
-		input_report_rel(dev, REL_Y, rel_y);
+		psmouse_report_standard_packet(dev, packet);
 		break;
 	}
 
-- 
2.16.0.rc1.238.g530d649a79-goog

