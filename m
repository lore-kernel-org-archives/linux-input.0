From: Cameron Gutman <aicommander@gmail.com>
Subject: [PATCH 4/5] Input: xpad - restore LED state after device resume
Date: Sat,  4 Feb 2017 16:30:01 -0800
Message-ID: <20170205003002.28160-5-aicommander@gmail.com>
References: <20170205003002.28160-1-aicommander@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f66.google.com ([74.125.83.66]:35875 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751893AbdBEAbk (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Sat, 4 Feb 2017 19:31:40 -0500
In-Reply-To: <20170205003002.28160-1-aicommander@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, rojtberg@gmail.com
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Cameron Gutman <aicommander@gmail.com>

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
index 13f298d..1179266 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -1683,11 +1683,23 @@ static int xpad_resume(struct usb_interface *intf)
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
2.9.3

