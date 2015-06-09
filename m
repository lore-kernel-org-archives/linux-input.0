From: Pavel Rojtberg <rojtberg@gmail.com>
Subject: [PATCH v2 1/2] Input: xpad: set the LEDs properly on XBox Wireless controllers
Date: Wed, 10 Jun 2015 00:56:18 +0200
Message-ID: <1433890579-2124-2-git-send-email-rojtberg@gmail.com>
References: <1433890579-2124-1-git-send-email-rojtberg@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f176.google.com ([209.85.212.176]:38418 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753110AbbFIW4b (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 9 Jun 2015 18:56:31 -0400
Received: by wibdq8 with SMTP id dq8so29674844wib.1
        for <linux-input@vger.kernel.org>; Tue, 09 Jun 2015 15:56:30 -0700 (PDT)
In-Reply-To: <1433890579-2124-1-git-send-email-rojtberg@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, pgriffais@valvesoftware.com, dmitry.torokhov@gmail.com, gregkh@linuxfoundation.org
Cc: Pavel Rojtberg <rojtberg@gmail.com>

From: "Pierre-Loup A. Griffais" <pgriffais@valvesoftware.com>

Based on Patch by Pierre-Loup A. Griffais <pgriffais@valvesoftware.com>:
Add the logic to set the LEDs on XBox Wireless controllers.  Command
sequence found by sniffing the Windows data stream when plugging the
device in.

Updated based on comments on linux-input:
unify codepaths in xpad_send_led_command for wired/ wireless controller.
Also document command values for clarification.
All values tested on Xbox 360 Wireless Controller.

Signed-off-by: Pavel Rojtberg <rojtberg@gmail.com>
---
 drivers/input/joystick/xpad.c | 50 +++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 45 insertions(+), 5 deletions(-)

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index 61c7611..6f8755e 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -881,17 +881,57 @@ struct xpad_led {
 	struct usb_xpad *xpad;
 };
 
+/**
+ * @param command
+ *  0: off
+ *  1: all blink, then previous setting
+ *  2: 1/top-left blink, then on
+ *  3: 2/top-right blink, then on
+ *  4: 3/bottom-left blink, then on
+ *  5: 4/bottom-right blink, then on
+ *  6: 1/top-left on
+ *  7: 2/top-right on
+ *  8: 3/bottom-left on
+ *  9: 4/bottom-right on
+ * 10: rotate
+ * 11: blink, based on previous setting
+ * 12: slow blink, based on previous setting
+ * 13: rotate with two lights
+ * 14: persistent slow all blink
+ * 15: blink once, then previous setting
+ */
 static void xpad_send_led_command(struct usb_xpad *xpad, int command)
 {
-	if (command >= 0 && command < 14) {
-		mutex_lock(&xpad->odata_mutex);
+	command %= 16;
+
+	mutex_lock(&xpad->odata_mutex);
+
+	switch (xpad->xtype) {
+	case XTYPE_XBOX360:
 		xpad->odata[0] = 0x01;
 		xpad->odata[1] = 0x03;
 		xpad->odata[2] = command;
 		xpad->irq_out->transfer_buffer_length = 3;
-		usb_submit_urb(xpad->irq_out, GFP_KERNEL);
-		mutex_unlock(&xpad->odata_mutex);
+		break;
+	case XTYPE_XBOX360W:
+		xpad->odata[0] = 0x00;
+		xpad->odata[1] = 0x00;
+		xpad->odata[2] = 0x08;
+		xpad->odata[3] = 0x40 + command;
+		xpad->odata[4] = 0x00;
+		xpad->odata[5] = 0x00;
+		xpad->odata[6] = 0x00;
+		xpad->odata[7] = 0x00;
+		xpad->odata[8] = 0x00;
+		xpad->odata[9] = 0x00;
+		xpad->odata[10] = 0x00;
+		xpad->odata[11] = 0x00;
+		xpad->irq_out->transfer_buffer_length = 12;
+		break;
 	}
+
+	usb_submit_urb(xpad->irq_out, GFP_KERNEL);
+	mutex_unlock(&xpad->odata_mutex);
 }
 
 static void xpad_led_set(struct led_classdev *led_cdev,
@@ -911,7 +951,7 @@ static int xpad_led_probe(struct usb_xpad *xpad)
 	struct led_classdev *led_cdev;
 	int error;
 
-	if (xpad->xtype != XTYPE_XBOX360)
+	if (xpad->xtype != XTYPE_XBOX360 && xpad->xtype != XTYPE_XBOX360W)
 		return 0;
 
 	xpad->led = led = kzalloc(sizeof(struct xpad_led), GFP_KERNEL);
-- 
1.9.1

