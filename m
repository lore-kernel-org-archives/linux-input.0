From: Dmitry Tunin <hanipouspilot@gmail.com>
Subject: [PATCH] psmouse - focaltech pass finger width to userspace
Date: Fri, 24 Apr 2015 02:13:41 +0300
Message-ID: <1429830821-4081-1-git-send-email-hanipouspilot@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Mathias Gottschlag <mgottschlag@gmail.com>, Dmitry Tunin <hanipouspilot@gmail.com>
List-Id: linux-input@vger.kernel.org

Focaltech touchpads report finger width in packet[5] of absolute packet.
Range for width in raw format is 0x10 - 0x70. Second half-byte is always 0.
0xff is reported, when a large contact area is detected.
This can be handled in userspace.
---
 drivers/input/mouse/focaltech.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/input/mouse/focaltech.c b/drivers/input/mouse/focaltech.c
index 23d2594..ea53f8b 100644
--- a/drivers/input/mouse/focaltech.c
+++ b/drivers/input/mouse/focaltech.c
@@ -90,6 +90,13 @@ struct focaltech_finger_state {
 	 */
 	unsigned int x;
 	unsigned int y;
+
+	/*
+	* Finger width 0-7 and 15 for 'latching'
+	* 15 value stays until the finger is released
+	* Width is reported only in absolute packets
+	*/
+	unsigned int width;
 };
 
 /*
@@ -112,7 +119,7 @@ struct focaltech_data {
 	struct focaltech_hw_state state;
 };
 
-static void focaltech_report_state(struct psmouse *psmouse)
+static void focaltech_report_state(struct psmouse *psmouse, bool abs)
 {
 	struct focaltech_data *priv = psmouse->private;
 	struct focaltech_hw_state *state = &priv->state;
@@ -137,6 +144,7 @@ static void focaltech_report_state(struct psmouse *psmouse)
 			input_report_abs(dev, ABS_MT_POSITION_X, clamped_x);
 			input_report_abs(dev, ABS_MT_POSITION_Y,
 					 priv->y_max - clamped_y);
+			if (abs) input_report_abs(dev, ABS_TOOL_WIDTH, state->width);
 		}
 	}
 	input_mt_report_pointer_emulation(dev, true);
@@ -187,6 +195,7 @@ static void focaltech_process_abs_packet(struct psmouse *psmouse,
 
 	state->fingers[finger].x = ((packet[1] & 0xf) << 8) | packet[2];
 	state->fingers[finger].y = (packet[3] << 8) | packet[4];
+	state->fingers[finger].width = packet[5] >> 4;
 	state->fingers[finger].valid = true;
 }
 
@@ -228,14 +237,17 @@ static void focaltech_process_packet(struct psmouse *psmouse)
 	switch (packet[0] & 0xf) {
 	case FOC_TOUCH:
 		focaltech_process_touch_packet(psmouse, packet);
+		focaltech_report_state(psmouse, false);
 		break;
 
 	case FOC_ABS:
 		focaltech_process_abs_packet(psmouse, packet);
+		focaltech_report_state(psmouse, true);
 		break;
 
 	case FOC_REL:
 		focaltech_process_rel_packet(psmouse, packet);
+		focaltech_report_state(psmouse, false);
 		break;
 
 	default:
@@ -243,7 +255,6 @@ static void focaltech_process_packet(struct psmouse *psmouse)
 		break;
 	}
 
-	focaltech_report_state(psmouse);
 }
 
 static psmouse_ret_t focaltech_process_byte(struct psmouse *psmouse)
@@ -331,6 +342,7 @@ static void focaltech_set_input_params(struct psmouse *psmouse)
 	__set_bit(EV_ABS, dev->evbit);
 	input_set_abs_params(dev, ABS_MT_POSITION_X, 0, priv->x_max, 0, 0);
 	input_set_abs_params(dev, ABS_MT_POSITION_Y, 0, priv->y_max, 0, 0);
+	input_set_abs_params(dev, ABS_TOOL_WIDTH, 0, 15, 0, 0);
 	input_mt_init_slots(dev, 5, INPUT_MT_POINTER);
 	__set_bit(INPUT_PROP_BUTTONPAD, dev->propbit);
 }
-- 
1.9.1
