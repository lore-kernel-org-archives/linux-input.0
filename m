From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 10/14] alps: Add an alps_report_semi_mt_data function
Date: Wed,  9 Jul 2014 17:24:15 +0200
Message-ID: <1404919459-23561-11-git-send-email-hdegoede@redhat.com>
References: <1404919459-23561-1-git-send-email-hdegoede@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:7008 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932563AbaGIPYl (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 9 Jul 2014 11:24:41 -0400
In-Reply-To: <1404919459-23561-1-git-send-email-hdegoede@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Yunkang Tang <yunkang.tang@cn.alps.com>, linux-input@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>

Move all the semi-mt specific handling shared between the v3 and v4 handling
code to a common helper function.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/input/mouse/alps.c | 76 ++++++++++++++++++----------------------------
 1 file changed, 29 insertions(+), 47 deletions(-)

diff --git a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c
index c9991b4..adc90ab 100644
--- a/drivers/input/mouse/alps.c
+++ b/drivers/input/mouse/alps.c
@@ -441,6 +441,32 @@ static void alps_report_mt_data(struct psmouse *psmouse, int n)
 	input_mt_sync_frame(dev);
 }
 
+static void alps_report_semi_mt_data(struct psmouse *psmouse, int fingers)
+{
+	struct alps_data *priv = psmouse->private;
+	struct input_dev *dev = psmouse->dev;
+	struct alps_fields *f = &priv->f;
+
+	/* Use st data when we don't have mt data */
+	if (fingers < 2) {
+		f->mt[0].x = f->st.x;
+		f->mt[0].y = f->st.y;
+		fingers = f->pressure > 0 ? 1 : 0;
+	}
+
+	alps_report_mt_data(psmouse, (fingers <= 2) ? fingers : 1);
+
+	input_mt_report_finger_count(dev, fingers);
+
+	input_report_key(dev, BTN_LEFT, f->left);
+	input_report_key(dev, BTN_RIGHT, f->right);
+	input_report_key(dev, BTN_MIDDLE, f->middle);
+
+	input_report_abs(dev, ABS_PRESSURE, f->pressure);
+
+	input_sync(dev);
+}
+
 static void alps_process_trackstick_packet_v3(struct psmouse *psmouse)
 {
 	struct alps_data *priv = psmouse->private;
@@ -585,7 +611,6 @@ static void alps_process_touchpad_packet_v3_v5(struct psmouse *psmouse)
 {
 	struct alps_data *priv = psmouse->private;
 	unsigned char *packet = psmouse->packet;
-	struct input_dev *dev = psmouse->dev;
 	struct input_dev *dev2 = priv->dev2;
 	struct alps_fields *f = &priv->f;
 	int fingers = 0;
@@ -665,27 +690,7 @@ static void alps_process_touchpad_packet_v3_v5(struct psmouse *psmouse)
 	if (f->st.x && f->st.y && !f->pressure)
 		return;
 
-	/*
-	 * If we don't have MT data or the bitmaps were empty, we have
-	 * to rely on ST data.
-	 */
-	if (fingers < 2) {
-		f->mt[0].x = f->st.x;
-		f->mt[0].y = f->st.y;
-		fingers = f->pressure > 0 ? 1 : 0;
-	}
-
-	alps_report_mt_data(psmouse, (fingers <= 2) ? fingers : 1);
-
-	input_mt_report_finger_count(dev, fingers);
-
-	input_report_key(dev, BTN_LEFT, f->left);
-	input_report_key(dev, BTN_RIGHT, f->right);
-	input_report_key(dev, BTN_MIDDLE, f->middle);
-
-	input_report_abs(dev, ABS_PRESSURE, f->pressure);
-
-	input_sync(dev);
+	alps_report_semi_mt_data(psmouse, fingers);
 
 	if (!(priv->quirks & ALPS_QUIRK_TRACKSTICK_BUTTONS)) {
 		input_report_key(dev2, BTN_LEFT, f->ts_left);
@@ -789,9 +794,8 @@ static void alps_process_packet_v4(struct psmouse *psmouse)
 {
 	struct alps_data *priv = psmouse->private;
 	unsigned char *packet = psmouse->packet;
-	struct input_dev *dev = psmouse->dev;
 	struct alps_fields *f = &priv->f;
-	int offset, fingers = 0;
+	int offset;
 
 	/*
 	 * v4 has a 6-byte encoding for bitmap data, but this data is
@@ -832,29 +836,7 @@ static void alps_process_packet_v4(struct psmouse *psmouse)
 	f->st.y = ((packet[2] & 0x7f) << 4) | (packet[3] & 0x0f);
 	f->pressure = packet[5] & 0x7f;
 
-	/*
-	 * If there were no contacts in the bitmap, use ST
-	 * points in MT reports.
-	 * If there were two contacts or more, report MT data.
-	 */
-	if (f->fingers < 2) {
-		f->mt[0].x = f->st.x;
-		f->mt[0].y = f->st.y;
-		fingers = f->pressure > 0 ? 1 : 0;
-	} else {
-		fingers = f->fingers;
-	}
-
-	alps_report_mt_data(psmouse, (fingers <= 2) ? fingers : 1);
-
-	input_mt_report_finger_count(dev, fingers);
-
-	input_report_key(dev, BTN_LEFT, f->left);
-	input_report_key(dev, BTN_RIGHT, f->right);
-
-	input_report_abs(dev, ABS_PRESSURE, f->pressure);
-
-	input_sync(dev);
+	alps_report_semi_mt_data(psmouse, f->fingers);
 }
 
 static void alps_report_bare_ps2_packet(struct psmouse *psmouse,
-- 
2.0.0

