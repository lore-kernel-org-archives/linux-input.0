From: Pavel Rojtberg <rojtberg@gmail.com>
Subject: [PATCH] Xbox 360 wireless controller light continues blinking after sync with receiver.
Date: Fri,  5 Jun 2015 14:54:01 +0200
Message-ID: <1433508841-11002-1-git-send-email-rojtberg@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wg0-f41.google.com ([74.125.82.41]:33653 "EHLO
	mail-wg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753218AbbFEMy0 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 5 Jun 2015 08:54:26 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, gregkh@linuxfoundation.org
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Pavel Rojtberg <rojtberg@gmail.com>

From: Pavel Rojtberg <rojtberg@gmail.com>

Launchpad Bug:
https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1272765

based on fix in steamos kernel:
https://github.com/ValveSoftware/steamos_kernel/commit/d92cfaac03183c01382bde7e817d22e4ea9078d5

tested on a xbox360 wireless gamepad. does not touch other codepaths.

outline:
- xpad_send_led_command() sends different odata for the wireless gamepad
- the call to xpad_send_led_command() is delayed to after the controller becomes present
- on xpad_probe() controllers are turned off to enforce a consistent state

Signed-off-by: Pavel Rojtberg <rojtberg@gmail.com>
---
 drivers/input/joystick/xpad.c | 73 +++++++++++++++++++++++++++++++++++++------
 1 file changed, 64 insertions(+), 9 deletions(-)

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index 61c7611..8cf688e 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -344,6 +344,7 @@ struct usb_xpad {
 
 	int mapping;			/* map d-pad to buttons or to axes */
 	int xtype;			/* type of xbox device */
+	unsigned long led_no;		/* led to lit on xbox360 controllers */
 };
 
 /*
@@ -502,6 +503,7 @@ static void xpad360_process_packet(struct usb_xpad *xpad,
  * 01.1 - Pad state (Bytes 4+) valid
  *
  */
+static void xpad_send_led_command(struct usb_xpad *xpad, int command);
 
 static void xpad360w_process_packet(struct usb_xpad *xpad, u16 cmd, unsigned char *data)
 {
@@ -510,6 +512,8 @@ static void xpad360w_process_packet(struct usb_xpad *xpad, u16 cmd, unsigned cha
 		if (data[1] & 0x80) {
 			xpad->pad_present = 1;
 			usb_submit_urb(xpad->bulk_out, GFP_ATOMIC);
+			/* send led command after the pad becomes present */
+			xpad_send_led_command(xpad, (xpad->led_no % 4) + 2);
 		} else
 			xpad->pad_present = 0;
 	}
@@ -883,15 +887,37 @@ struct xpad_led {
 
 static void xpad_send_led_command(struct usb_xpad *xpad, int command)
 {
-	if (command >= 0 && command < 14) {
-		mutex_lock(&xpad->odata_mutex);
+	if ((unsigned)command >= 14)
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
@@ -906,21 +932,20 @@ static void xpad_led_set(struct led_classdev *led_cdev,
 static int xpad_led_probe(struct usb_xpad *xpad)
 {
 	static atomic_t led_seq	= ATOMIC_INIT(-1);
-	unsigned long led_no;
 	struct xpad_led *led;
 	struct led_classdev *led_cdev;
 	int error;
 
-	if (xpad->xtype != XTYPE_XBOX360)
+	if (xpad->xtype != XTYPE_XBOX360 && xpad->xtype != XTYPE_XBOX360W)
 		return 0;
 
 	xpad->led = led = kzalloc(sizeof(struct xpad_led), GFP_KERNEL);
 	if (!led)
 		return -ENOMEM;
 
-	led_no = atomic_inc_return(&led_seq);
+	xpad->led_no = atomic_inc_return(&led_seq);
 
-	snprintf(led->name, sizeof(led->name), "xpad%lu", led_no);
+	snprintf(led->name, sizeof(led->name), "xpad%lu", xpad->led_no);
 	led->xpad = xpad;
 
 	led_cdev = &led->led_cdev;
@@ -936,8 +961,12 @@ static int xpad_led_probe(struct usb_xpad *xpad)
 
 	/*
 	 * Light up the segment corresponding to controller number
+	 *
+	 * for the wireless controller
+	 * we send the command just after it becomes present
 	 */
-	xpad_send_led_command(xpad, (led_no % 4) + 2);
+	if (xpad->xtype != XTYPE_XBOX360W)
+		xpad_send_led_command(xpad, (xpad->led_no % 4) + 2);
 
 	return 0;
 }
@@ -954,6 +983,7 @@ static void xpad_led_disconnect(struct usb_xpad *xpad)
 #else
 static int xpad_led_probe(struct usb_xpad *xpad) { return 0; }
 static void xpad_led_disconnect(struct usb_xpad *xpad) { }
+static void xpad_send_led_command(struct usb_xpad *xpad, int command) { }
 #endif
 
 
@@ -1223,6 +1253,31 @@ static int xpad_probe(struct usb_interface *intf, const struct usb_device_id *id
 		error = usb_submit_urb(xpad->irq_in, GFP_KERNEL);
 		if (error)
 			goto fail9;
+
+		/*
+		 * we do not know the controller state on driver load
+		 * or how to check it so just turn them off so that
+		 * people have to turn them on, triggering a state update
+		 *
+		 * power off packet from an OSX reverse-engineered driver:
+		 * http://tattiebogle.net/index.php/ProjectRoot/Xbox360Controller/OsxDriver#toc1
+		 */
+		mutex_lock(&xpad->odata_mutex);
+		xpad->odata[0] = 0x00;
+		xpad->odata[1] = 0x00;
+		xpad->odata[2] = 0x08;
+		xpad->odata[3] = 0xC0;
+		xpad->odata[4] = 0x00;
+		xpad->odata[5] = 0x00;
+		xpad->odata[6] = 0x00;
+		xpad->odata[7] = 0x00;
+		xpad->odata[8] = 0x00;
+		xpad->odata[9] = 0x00;
+		xpad->odata[10] = 0x00;
+		xpad->odata[11] = 0x00;
+		xpad->irq_out->transfer_buffer_length = 12;
+		usb_submit_urb(xpad->irq_out, GFP_KERNEL);
+		mutex_unlock(&xpad->odata_mutex);
 	}
 
 	return 0;
-- 
1.9.1

