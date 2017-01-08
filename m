From: Cameron Gutman <aicommander@gmail.com>
Subject: [PATCH] Input: xpad - restore LED state after device resume
Date: Sun,  8 Jan 2017 03:14:18 -0500
Message-ID: <1483863258-12005-1-git-send-email-aicommander@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-it0-f67.google.com ([209.85.214.67]:34809 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750747AbdAHIOW (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Sun, 8 Jan 2017 03:14:22 -0500
Received: by mail-it0-f67.google.com with SMTP id q186so6296998itb.1
        for <linux-input@vger.kernel.org>; Sun, 08 Jan 2017 00:14:21 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, rojtberg@gmail.com
Cc: linux-input@vger.kernel.org, Cameron Gutman <aicommander@gmail.com>

The state of pad LEDs can be inconsistent when the system is
woken up after sleep. Rather than leaving the controllers blinking,
let's resend the last LED command to Xbox 360 pads on resume.

Since Xbox One pads stop flashing only when reinitialized, we'll
send them the initialization packet so they calm down too.

Signed-off-by: Cameron Gutman <aicommander@gmail.com>
---
 drivers/input/joystick/xpad.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index c06b717..f18274a 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -1648,11 +1648,23 @@ static int xpad_resume(struct usb_interface *intf)
 		retval = xpad360w_start_input(xpad);
 	} else {
 		mutex_lock(&input->mutex);
-		if (input->users)
+		if (input->users) {
 			retval = xpad_start_input(xpad);
+		} else if (xpad->xtype == XTYPE_XBOXONE) {
+			/*
+			 * Even if there are no users, we'll send Xbox One pads
+			 * the startup sequence so they don't sit there and
+			 * blink until somebody opens the input device again.
+			 */
+			retval = xpad_start_xbox_one(xpad);
+		}
 		mutex_unlock(&input->mutex);
 	}
 
+	/* LED state is lost across resume, so resend the last command */
+	if (xpad->led)
+		xpad_send_led_command(xpad, xpad->led->led_cdev.brightness);
+
 	return retval;
 }
 
-- 
2.7.4

