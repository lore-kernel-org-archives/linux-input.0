From: Dmitry Tunin <hanipouspilot@gmail.com>
Subject: [PATCH] psmouse - pass finger width to userspace
Date: Sat, 18 Apr 2015 15:37:18 +0300
Message-ID: <1429360638-12742-1-git-send-email-hanipouspilot@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-la0-f43.google.com ([209.85.215.43]:36540 "EHLO
	mail-la0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752033AbbDRMhx (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 18 Apr 2015 08:37:53 -0400
Received: by lagv1 with SMTP id v1so97870377lag.3
        for <linux-input@vger.kernel.org>; Sat, 18 Apr 2015 05:37:52 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Mathias Gottschlag <mgottschlag@gmail.com>, Dmitry Tunin <hanipouspilot@gmail.com>

Focaltech touchpads report finger width in packet[5].
Range for width in raw format is 0x10 - 0x70. Second byte is always 0.
0xff is reported, when a large contact area is detected.
This can be handled in userspace.

Signed-off-by: Dmitry Tunin <hanipouspilot@gmail.com>
---
 drivers/input/mouse/focaltech.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/input/mouse/focaltech.c b/drivers/input/mouse/focaltech.c
index 23d2594..42f73cd 100644
--- a/drivers/input/mouse/focaltech.c
+++ b/drivers/input/mouse/focaltech.c
@@ -90,6 +90,11 @@ struct focaltech_finger_state {
 	 */
 	unsigned int x;
 	unsigned int y;
+
+	/*
+	* Finger width 0-7 and 15 for 'latching'
+	*/
+	unsigned int width;
 };
 
 /*
@@ -137,6 +142,7 @@ static void focaltech_report_state(struct psmouse *psmouse)
 			input_report_abs(dev, ABS_MT_POSITION_X, clamped_x);
 			input_report_abs(dev, ABS_MT_POSITION_Y,
 					 priv->y_max - clamped_y);
+			input_report_abs(dev, ABS_TOOL_WIDTH, finger->width);
 		}
 	}
 	input_mt_report_pointer_emulation(dev, true);
@@ -187,6 +193,7 @@ static void focaltech_process_abs_packet(struct psmouse *psmouse,
 
 	state->fingers[finger].x = ((packet[1] & 0xf) << 8) | packet[2];
 	state->fingers[finger].y = (packet[3] << 8) | packet[4];
+	state->fingers[finger].width = packet[5] >> 4;
 	state->fingers[finger].valid = true;
 }
 
@@ -331,6 +338,7 @@ static void focaltech_set_input_params(struct psmouse *psmouse)
 	__set_bit(EV_ABS, dev->evbit);
 	input_set_abs_params(dev, ABS_MT_POSITION_X, 0, priv->x_max, 0, 0);
 	input_set_abs_params(dev, ABS_MT_POSITION_Y, 0, priv->y_max, 0, 0);
+	input_set_abs_params(dev, ABS_TOOL_WIDTH, 0, 15, 0, 0);
 	input_mt_init_slots(dev, 5, INPUT_MT_POINTER);
 	__set_bit(INPUT_PROP_BUTTONPAD, dev->propbit);
 }
-- 
1.9.1

