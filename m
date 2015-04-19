From: Dmitry Tunin <hanipouspilot@gmail.com>
Subject: [PATCH v3] psmouse - focaltech pass finger width to userspace
Date: Sun, 19 Apr 2015 15:00:45 +0300
Message-ID: <1429444845-10511-1-git-send-email-hanipouspilot@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-la0-f43.google.com ([209.85.215.43]:35384 "EHLO
	mail-la0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751158AbbDSMA4 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 19 Apr 2015 08:00:56 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Mathias Gottschlag <mgottschlag@gmail.com>, linux-kernel@vger.kernel.org, Dmitry Tunin <hanipouspilot@gmail.com>

Focaltech touchpads report finger width in packet[5] of absolute packet.
Range for width in raw format is 0x10 - 0x70. Second half-byte is always 0.
0xff is reported, when a large contact area is detected.
This can be handled in userspace.

Signed-off-by: Dmitry Tunin <hanipouspilot@gmail.com>
---
 drivers/input/mouse/focaltech.c | 53 +++++++++++++++++++++++++----------------
 1 file changed, 32 insertions(+), 21 deletions(-)

diff --git a/drivers/input/mouse/focaltech.c b/drivers/input/mouse/focaltech.c
index 23d2594..1ef9d2b 100644
--- a/drivers/input/mouse/focaltech.c
+++ b/drivers/input/mouse/focaltech.c
@@ -55,8 +55,6 @@ static void focaltech_reset(struct psmouse *psmouse)
 	psmouse_reset(psmouse);
 }
 
-#ifdef CONFIG_MOUSE_PS2_FOCALTECH
-
 /*
  * Packet types - the numbers are not consecutive, so we might be missing
  * something here.
@@ -105,6 +103,16 @@ struct focaltech_hw_state {
 
 	/* True if the clickpad has been pressed. */
 	bool pressed;
+
+	/*
+	* Finger width 0-7 and 15 for 'latching'
+	* 15 value stays until the finger is released
+	* Width is reported only when 1 finger is active
+	*/
+	unsigned int width;
+
+	/* Finger count */
+	unsigned int count;
 };
 
 struct focaltech_data {
@@ -118,7 +126,7 @@ static void focaltech_report_state(struct psmouse *psmouse)
 	struct focaltech_hw_state *state = &priv->state;
 	struct input_dev *dev = psmouse->dev;
 	int i;
-
+	
 	for (i = 0; i < FOC_MAX_FINGERS; i++) {
 		struct focaltech_finger_state *finger = &state->fingers[i];
 		bool active = finger->active && finger->valid;
@@ -126,21 +134,23 @@ static void focaltech_report_state(struct psmouse *psmouse)
 		input_mt_slot(dev, i);
 		input_mt_report_slot_state(dev, MT_TOOL_FINGER, active);
 		if (active) {
-			unsigned int clamped_x, clamped_y;
+			int clamped_x, clamped_y;
 			/*
 			 * The touchpad might report invalid data, so we clamp
 			 * the resulting values so that we do not confuse
 			 * userspace.
 			 */
-			clamped_x = clamp(finger->x, 0U, priv->x_max);
-			clamped_y = clamp(finger->y, 0U, priv->y_max);
+			clamped_x = clamp((int)finger->x, 0, (int)priv->x_max);
+			clamped_y = clamp((int)finger->y, 0, (int)priv->y_max);
 			input_report_abs(dev, ABS_MT_POSITION_X, clamped_x);
 			input_report_abs(dev, ABS_MT_POSITION_Y,
 					 priv->y_max - clamped_y);
+			if (state->count == 1)
+				input_report_abs(dev, ABS_TOOL_WIDTH, state->width);
 		}
 	}
-	input_mt_report_pointer_emulation(dev, true);
-
+	input_mt_report_finger_count(dev, state->count);
+	input_mt_report_pointer_emulation(dev, false);
 	input_report_key(psmouse->dev, BTN_LEFT, state->pressed);
 	input_sync(psmouse->dev);
 }
@@ -152,13 +162,17 @@ static void focaltech_process_touch_packet(struct psmouse *psmouse,
 	struct focaltech_hw_state *state = &priv->state;
 	unsigned char fingers = packet[1];
 	int i;
+	int count = 0;
 
 	state->pressed = (packet[0] >> 4) & 1;
 
 	/* the second byte contains a bitmap of all fingers touching the pad */
 	for (i = 0; i < FOC_MAX_FINGERS; i++) {
-		state->fingers[i].active = fingers & 0x1;
-		if (!state->fingers[i].active) {
+
+		if (fingers & 0x1) {
+			state->fingers[i].active = true;
+			count++;
+		} else {
 			/*
 			 * Even when the finger becomes active again, we still
 			 * will have to wait for the first valid position.
@@ -167,6 +181,8 @@ static void focaltech_process_touch_packet(struct psmouse *psmouse,
 		}
 		fingers >>= 1;
 	}
+	state->width = packet[5] >> 4;
+	state->count = count;
 }
 
 static void focaltech_process_abs_packet(struct psmouse *psmouse,
@@ -187,6 +203,7 @@ static void focaltech_process_abs_packet(struct psmouse *psmouse,
 
 	state->fingers[finger].x = ((packet[1] & 0xf) << 8) | packet[2];
 	state->fingers[finger].y = (packet[3] << 8) | packet[4];
+	state->width = packet[5] >> 4;
 	state->fingers[finger].valid = true;
 }
 
@@ -331,6 +348,7 @@ static void focaltech_set_input_params(struct psmouse *psmouse)
 	__set_bit(EV_ABS, dev->evbit);
 	input_set_abs_params(dev, ABS_MT_POSITION_X, 0, priv->x_max, 0, 0);
 	input_set_abs_params(dev, ABS_MT_POSITION_Y, 0, priv->y_max, 0, 0);
+	input_set_abs_params(dev, ABS_TOOL_WIDTH, 0, 15, 0, 0);
 	input_mt_init_slots(dev, 5, INPUT_MT_POINTER);
 	__set_bit(INPUT_PROP_BUTTONPAD, dev->propbit);
 }
@@ -428,9 +446,8 @@ int focaltech_init(struct psmouse *psmouse)
 	/* resync is not supported yet */
 	psmouse->resync_time = 0;
 	/*
-	 * rate/resolution/scale changes are not supported yet, and
-	 * the generic implementations of these functions seem to
-	 * confuse some touchpads
+	 * rate/resolution/scale changes are not supported yet, and the generic
+	 * implementations of these functions seem to confuse some touchpads
 	 */
 	psmouse->set_resolution = focaltech_set_resolution;
 	psmouse->set_rate = focaltech_set_rate;
@@ -444,13 +461,7 @@ fail:
 	return error;
 }
 
-#else /* CONFIG_MOUSE_PS2_FOCALTECH */
-
-int focaltech_init(struct psmouse *psmouse)
+bool focaltech_supported(void)
 {
-	focaltech_reset(psmouse);
-
-	return 0;
+	return true;
 }
-
-#endif /* CONFIG_MOUSE_PS2_FOCALTECH */
-- 
1.9.1

