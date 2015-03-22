From: Gabriele Mazzotta <gabriele.mzt@gmail.com>
Subject: [PATCH v3 3/5] input: synaptics - setup devices depending on their capabilities
Date: Sun, 22 Mar 2015 15:43:54 +0100
Message-ID: <1427035436-2168-4-git-send-email-gabriele.mzt@gmail.com>
References: <1427035436-2168-1-git-send-email-gabriele.mzt@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-we0-f177.google.com ([74.125.82.177]:35887 "EHLO
	mail-we0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751776AbbCVOo2 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 22 Mar 2015 10:44:28 -0400
In-Reply-To: <1427035436-2168-1-git-send-email-gabriele.mzt@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, dmitry.torokhov@gmail.com, rydberg@bitmath.org, silverhammermba@gmail.com, peter.hutterer@who-t.net, hdegoede@redhat.com, benjamin.tissoires@gmail.com, grafi@grafi.jp, oneukum@suse.de, Gabriele Mazzotta <gabriele.mzt@gmail.com>

ABS_X, ABS_Y and ABS_PRESSURE were defined for all the devices, even
if not needed. Fix this by configuring each device depending on its
capabilities.

Signed-off-by: Gabriele Mazzotta <gabriele.mzt@gmail.com>
---
 drivers/input/mouse/synaptics.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
index a7a0e73..ff47084 100644
--- a/drivers/input/mouse/synaptics.c
+++ b/drivers/input/mouse/synaptics.c
@@ -1188,11 +1188,6 @@ static void set_input_params(struct psmouse *psmouse,
 
 	/* Absolute mode */
 	__set_bit(EV_ABS, dev->evbit);
-	set_abs_position_params(dev, priv, ABS_X, ABS_Y);
-	input_set_abs_params(dev, ABS_PRESSURE, 0, 255, 0, 0);
-
-	if (cr48_profile_sensor)
-		input_set_abs_params(dev, ABS_MT_PRESSURE, 0, 255, 0, 0);
 
 	if (SYN_CAP_IMAGE_SENSOR(priv->ext_cap_0c)) {
 		set_abs_position_params(dev, priv, ABS_MT_POSITION_X,
@@ -1200,26 +1195,32 @@ static void set_input_params(struct psmouse *psmouse,
 		/* Image sensors can report per-contact pressure */
 		input_set_abs_params(dev, ABS_MT_PRESSURE, 0, 255, 0, 0);
 		input_mt_init_slots(dev, 2, INPUT_MT_POINTER | INPUT_MT_TRACK);
-
 		/* Image sensors can signal 4 and 5 finger clicks */
 		__set_bit(BTN_TOOL_QUADTAP, dev->keybit);
 		__set_bit(BTN_TOOL_QUINTTAP, dev->keybit);
-	} else if (SYN_CAP_ADV_GESTURE(priv->ext_cap_0c)) {
+	} else if (cr48_profile_sensor) {
 		set_abs_position_params(dev, priv, ABS_MT_POSITION_X,
 					ABS_MT_POSITION_Y);
+		input_set_abs_params(dev, ABS_MT_PRESSURE, 0, 255, 0, 0);
 		/*
 		 * Profile sensor in CR-48 tracks contacts reasonably well,
 		 * other non-image sensors with AGM use semi-mt.
 		 */
+		input_mt_init_slots(dev, 2, INPUT_MT_POINTER | INPUT_MT_TRACK);
+	} else if (SYN_CAP_ADV_GESTURE(priv->ext_cap_0c)) {
+		set_abs_position_params(dev, priv, ABS_MT_POSITION_X,
+					ABS_MT_POSITION_Y);
+		input_set_abs_params(dev, ABS_PRESSURE, 0, 255, 0, 0);
+		input_set_abs_params(dev, ABS_TOOL_WIDTH, 0, 15, 0, 0);
 		input_mt_init_slots(dev, 2,
-				    INPUT_MT_POINTER |
-				    (cr48_profile_sensor ?
-					INPUT_MT_TRACK : INPUT_MT_SEMI_MT));
+				    INPUT_MT_POINTER | INPUT_MT_SEMI_MT);
+	} else {
+		set_abs_position_params(dev, priv, ABS_X, ABS_Y);
+		input_set_abs_params(dev, ABS_PRESSURE, 0, 255, 0, 0);
+		if (SYN_CAP_PALMDETECT(priv->capabilities))
+			input_set_abs_params(dev, ABS_TOOL_WIDTH, 0, 15, 0, 0);
 	}
 
-	if (SYN_CAP_PALMDETECT(priv->capabilities))
-		input_set_abs_params(dev, ABS_TOOL_WIDTH, 0, 15, 0, 0);
-
 	__set_bit(BTN_TOUCH, dev->keybit);
 	__set_bit(BTN_TOOL_FINGER, dev->keybit);
 
-- 
2.1.4

