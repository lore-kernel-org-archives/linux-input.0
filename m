From: Pavel Rojtberg <rojtberg@gmail.com>
Subject: [PATCH 10/15] Input: xpad: use ida() for finding the pad_nr
Date: Thu,  1 Oct 2015 22:57:21 +0200
Message-ID: <1443733046-29610-11-git-send-email-rojtberg@gmail.com>
References: <1443733046-29610-1-git-send-email-rojtberg@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f175.google.com ([209.85.212.175]:32877 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757148AbbJAU5s (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 1 Oct 2015 16:57:48 -0400
Received: by wiclk2 with SMTP id lk2so8097177wic.0
        for <linux-input@vger.kernel.org>; Thu, 01 Oct 2015 13:57:47 -0700 (PDT)
In-Reply-To: <1443733046-29610-1-git-send-email-rojtberg@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, pgriffais@valvesoftware.com, dmitry.torokhov@gmail.com, gregkh@linuxfoundation.org
Cc: Pavel Rojtberg <rojtberg@gmail.com>

From: Pavel Rojtberg <rojtberg@gmail.com>

The pad_nr corresponds to the lit up LED on the controller. Therefore
there should be no gaps when enumerating. Currently a LED is only
re-assigned after a controller is re-connected 4 times.

This patch uses ida to track connected pads - this way we can re-assign
freed up pad number immediately.

Consider the following case:
1. pad A is connected and gets pad_nr = 0
2. pad B is connected and gets pad_nr = 1
3. pad A is disconnected
4. pad A is connected again

using ida() controller A now correctly gets pad_nr = 0 again.

Signed-off-by: Pavel Rojtberg <rojtberg@gmail.com>
---
 drivers/input/joystick/xpad.c | 37 ++++++++++++++++++++++++++++++-------
 1 file changed, 30 insertions(+), 7 deletions(-)

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index 31bcd78..7d53e8e 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -342,11 +342,14 @@ struct usb_xpad {
 
 	int mapping;			/* map d-pad to buttons or to axes */
 	int xtype;			/* type of xbox device */
-	unsigned long pad_nr;		/* the order x360 pads were attached */
+	int pad_nr;			/* the order x360 pads were attached */
 	const char *name;		/* name of the device */
 	struct work_struct work;	/* init/remove device from callback */
 };
 
+static DEFINE_SPINLOCK(xpad_pad_seq_lock);
+static DEFINE_IDA(xpad_pad_seq);
+
 static int xpad_init_input(struct usb_xpad *xpad);
 static void xpad_deinit_input(struct usb_xpad *xpad);
 
@@ -946,6 +949,24 @@ static void xpad_send_led_command(struct usb_xpad *xpad, int command)
  */
 static void xpad_identify_controller(struct usb_xpad *xpad)
 {
+	int res = 0;
+
+	if (xpad->xtype != XTYPE_XBOX360 && xpad->xtype != XTYPE_XBOX360W)
+		return;
+
+	while(res == -EAGAIN) {
+		if(!ida_pre_get(&xpad_pad_seq, GFP_KERNEL)) {
+			dev_dbg(&xpad->dev->dev,
+				"%s - ida_pre_get failed. giving up\n",
+				__func__);
+			return;
+		}
+
+		spin_lock(&xpad_pad_seq_lock);
+		res = ida_get_new(&xpad_pad_seq, &xpad->pad_nr);
+		spin_unlock(&xpad_pad_seq_lock);
+	}
+
 	xpad_send_led_command(xpad, (xpad->pad_nr % 4) + 2);
 }
 
@@ -960,7 +981,6 @@ static void xpad_led_set(struct led_classdev *led_cdev,
 
 static int xpad_led_probe(struct usb_xpad *xpad)
 {
-	static atomic_t led_seq = ATOMIC_INIT(-1);
 	struct xpad_led *led;
 	struct led_classdev *led_cdev;
 	int error;
@@ -972,9 +992,7 @@ static int xpad_led_probe(struct usb_xpad *xpad)
 	if (!led)
 		return -ENOMEM;
 
-	xpad->pad_nr = atomic_inc_return(&led_seq);
-
-	snprintf(led->name, sizeof(led->name), "xpad%lu", xpad->pad_nr);
+	snprintf(led->name, sizeof(led->name), "xpad%d", xpad->pad_nr);
 	led->xpad = xpad;
 
 	led_cdev = &led->led_cdev;
@@ -1132,6 +1150,8 @@ static int xpad_init_input(struct usb_xpad *xpad)
 			xpad_set_up_abs(input_dev, xpad_abs_triggers[i]);
 	}
 
+	xpad_identify_controller(xpad);
+
 	error = xpad_init_ff(xpad);
 	if (error)
 		goto fail_init_ff;
@@ -1144,8 +1164,6 @@ static int xpad_init_input(struct usb_xpad *xpad)
 	if (error)
 		goto fail_input_register;
 
-	xpad_identify_controller(xpad);
-
 	return 0;
 
 fail_input_register:
@@ -1305,6 +1323,11 @@ static void xpad_deinit_input(struct usb_xpad *xpad)
 {
 	xpad_led_disconnect(xpad);
 	input_unregister_device(xpad->dev);
+
+	if (xpad->xtype != XTYPE_XBOX360 && xpad->xtype != XTYPE_XBOX360W)
+		return;
+
+	ida_remove(&xpad_pad_seq, xpad->pad_nr);
 }
 
 static void xpad_disconnect(struct usb_interface *intf)
-- 
1.9.1

