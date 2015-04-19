From: Dmitry Tunin <hanipouspilot@gmail.com>
Subject: [PATCH v5] psmouse - focaltech pass finger width to userspace
Date: Sun, 19 Apr 2015 15:49:46 +0300
Message-ID: <1429447786-12197-1-git-send-email-hanipouspilot@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-lb0-f181.google.com ([209.85.217.181]:35494 "EHLO
	mail-lb0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751648AbbDSMt5 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 19 Apr 2015 08:49:57 -0400
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
 drivers/input/mouse/focaltech.c | 26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/drivers/input/mouse/focaltech.c b/drivers/input/mouse/focaltech.c
index 23d2594..32f810c 100644
--- a/drivers/input/mouse/focaltech.c
+++ b/drivers/input/mouse/focaltech.c
@@ -105,6 +105,16 @@ struct focaltech_hw_state {
 
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
@@ -137,10 +147,12 @@ static void focaltech_report_state(struct psmouse *psmouse)
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
@@ -152,13 +164,16 @@ static void focaltech_process_touch_packet(struct psmouse *psmouse,
 	struct focaltech_hw_state *state = &priv->state;
 	unsigned char fingers = packet[1];
 	int i;
+	int count = 0;
 
 	state->pressed = (packet[0] >> 4) & 1;
 
 	/* the second byte contains a bitmap of all fingers touching the pad */
 	for (i = 0; i < FOC_MAX_FINGERS; i++) {
-		state->fingers[i].active = fingers & 0x1;
-		if (!state->fingers[i].active) {
+		if (fingers & 0x1) {
+			state->fingers[i].active = true;
+			count++;
+		} else {
 			/*
 			 * Even when the finger becomes active again, we still
 			 * will have to wait for the first valid position.
@@ -167,6 +182,7 @@ static void focaltech_process_touch_packet(struct psmouse *psmouse,
 		}
 		fingers >>= 1;
 	}
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
-- 
1.9.1

