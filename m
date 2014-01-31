From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 2/7] Input: xpad: set the LEDs properly on XBox Wireless controllers
Date: Fri, 31 Jan 2014 14:03:29 +0100
Message-ID: <1391173414-6199-3-git-send-email-gregkh@linuxfoundation.org>
References: <1391173414-6199-1-git-send-email-gregkh@linuxfoundation.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:47819 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932241AbaAaNCy (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 31 Jan 2014 08:02:54 -0500
In-Reply-To: <1391173414-6199-1-git-send-email-gregkh@linuxfoundation.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, "Pierre-Loup A. Griffais" <pgriffais@valvesoftware.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>

From: "Pierre-Loup A. Griffais" <pgriffais@valvesoftware.com>

Add the logic to set the LEDs on XBox Wireless controllers.  Command
sequence found by sniffing the Windows data stream when plugging the
device in.

Signed-off-by: "Pierre-Loup A. Griffais" <pgriffais@valvesoftware.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/input/joystick/xpad.c | 32 +++++++++++++++++++++++++++-----
 1 file changed, 27 insertions(+), 5 deletions(-)

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index 517829f6a58b..aabff9140aaa 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -715,15 +715,37 @@ struct xpad_led {
 
 static void xpad_send_led_command(struct usb_xpad *xpad, int command)
 {
-	if (command >= 0 && command < 14) {
-		mutex_lock(&xpad->odata_mutex);
+	if (command > 15)
+		return;
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
+		xpad->odata[3] = 0x40 + (command % 0x0e);
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
@@ -743,7 +765,7 @@ static int xpad_led_probe(struct usb_xpad *xpad)
 	struct led_classdev *led_cdev;
 	int error;
 
-	if (xpad->xtype != XTYPE_XBOX360)
+	if (xpad->xtype != XTYPE_XBOX360 && xpad->xtype != XTYPE_XBOX360W)
 		return 0;
 
 	xpad->led = led = kzalloc(sizeof(struct xpad_led), GFP_KERNEL);
-- 
1.8.5.3

