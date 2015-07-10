From: Pavel Rojtberg <rojtberg@gmail.com>
Subject: [PATCH 6/8] Input: xpad: use bitmask for finding the pad_nr
Date: Sat, 11 Jul 2015 01:47:46 +0200
Message-ID: <1436572068-10661-7-git-send-email-rojtberg@gmail.com>
References: <1436572068-10661-1-git-send-email-rojtberg@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f182.google.com ([209.85.212.182]:34630 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753231AbbGKHMA (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 11 Jul 2015 03:12:00 -0400
Received: by wifm2 with SMTP id m2so62833424wif.1
        for <linux-input@vger.kernel.org>; Sat, 11 Jul 2015 00:11:59 -0700 (PDT)
In-Reply-To: <1436572068-10661-1-git-send-email-rojtberg@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, pgriffais@valvesoftware.com, dmitry.torokhov@gmail.com, gregkh@linuxfoundation.org
Cc: Pavel Rojtberg <rojtberg@gmail.com>

From: Pavel Rojtberg <rojtberg@gmail.com>

The pad_nr should be consistent after disconnecting/ reconnecting a
xbox360 controllers.
Use a bitmask to track connected pads - this way we can re-assign freed
up pad numbers.

Consider the following case:
1. pad A is connected and gets pad_nr = 0
2. pad B is connected and gets pad_nr = 1
3. pad A is disconnected
4. pad A is connected again

using the bitmask controller A now correctly gets pad_nr = 0 again.

Note: this sets a limit of 32 simultaneous connected xbox360
controllers. However this should be tolerable.

Signed-off-by: Pavel Rojtberg <rojtberg@gmail.com>
---
 drivers/input/joystick/xpad.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index a9ff4c2..e28a9c1 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -346,6 +346,8 @@ struct usb_xpad {
 	struct work_struct work;	/* init/remove device from callback */
 };
 
+static unsigned long xpad_pad_seq;
+
 static int xpad_init_input(struct usb_xpad *xpad);
 static void xpad_deinit_input(struct usb_xpad *xpad);
 
@@ -940,6 +942,12 @@ static void xpad_send_led_command(struct usb_xpad *xpad, int command)
  */
 static void xpad_identify_controller(struct usb_xpad *xpad)
 {
+	if (xpad->xtype != XTYPE_XBOX360 && xpad->xtype != XTYPE_XBOX360W)
+		return;
+
+	xpad->pad_nr = find_first_zero_bit(&xpad_pad_seq, 32);
+	set_bit(xpad->pad_nr, &xpad_pad_seq);
+
 	xpad_send_led_command(xpad, (xpad->pad_nr % 4) + 2);
 }
 
@@ -954,7 +962,6 @@ static void xpad_led_set(struct led_classdev *led_cdev,
 
 static int xpad_led_probe(struct usb_xpad *xpad)
 {
-	static atomic_t led_seq = ATOMIC_INIT(-1);
 	struct xpad_led *led;
 	struct led_classdev *led_cdev;
 	int error;
@@ -966,8 +973,6 @@ static int xpad_led_probe(struct usb_xpad *xpad)
 	if (!led)
 		return -ENOMEM;
 
-	xpad->pad_nr = atomic_inc_return(&led_seq);
-
 	snprintf(led->name, sizeof(led->name), "xpad%lu", xpad->pad_nr);
 	led->xpad = xpad;
 
@@ -1119,6 +1124,8 @@ static int xpad_init_input(struct usb_xpad *xpad)
 			xpad_set_up_abs(input_dev, xpad_abs_triggers[i]);
 	}
 
+	xpad_identify_controller(xpad);
+
 	error = xpad_init_ff(xpad);
 	if (error)
 		goto fail_init_ff;
@@ -1131,8 +1138,6 @@ static int xpad_init_input(struct usb_xpad *xpad)
 	if (error)
 		goto fail_input_register;
 
-	xpad_identify_controller(xpad);
-
 	return 0;
 
 fail_input_register:
@@ -1292,6 +1297,11 @@ static void xpad_deinit_input(struct usb_xpad *xpad)
 {
 	xpad_led_disconnect(xpad);
 	input_unregister_device(xpad->dev);
+
+	if (xpad->xtype != XTYPE_XBOX360 && xpad->xtype != XTYPE_XBOX360W)
+		return;
+
+	clear_bit(xpad->pad_nr, &xpad_pad_seq);
 }
 
 static void xpad_disconnect(struct usb_interface *intf)
-- 
1.9.1

