From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 7/7] Input: xpad: properly name the LED class devices
Date: Fri, 31 Jan 2014 14:03:34 +0100
Message-ID: <1391173414-6199-8-git-send-email-gregkh@linuxfoundation.org>
References: <1391173414-6199-1-git-send-email-gregkh@linuxfoundation.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:47839 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932241AbaAaNDI (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 31 Jan 2014 08:03:08 -0500
In-Reply-To: <1391173414-6199-1-git-send-email-gregkh@linuxfoundation.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Pierre-Loup A. Griffais" <pgriffais@valvesoftware.com>

Don't just increment the LED device number, but use the joystick id so
that you have a chance to associate the LED device to the correct xpad
device by the name, instead of having to use the sysfs tree, which
really doesn't work.

Cc: "Pierre-Loup A. Griffais" <pgriffais@valvesoftware.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/input/joystick/xpad.c | 40 +++++++++++++++++-----------------------
 1 file changed, 17 insertions(+), 23 deletions(-)

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index d342d41a7a0d..ae156de46a12 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -781,8 +781,6 @@ static void xpad_led_set(struct led_classdev *led_cdev,
 
 static int xpad_led_probe(struct usb_xpad *xpad)
 {
-	static atomic_t led_seq	= ATOMIC_INIT(0);
-	long led_no;
 	struct xpad_led *led;
 	struct led_classdev *led_cdev;
 	int error;
@@ -794,9 +792,7 @@ static int xpad_led_probe(struct usb_xpad *xpad)
 	if (!led)
 		return -ENOMEM;
 
-	led_no = (long)atomic_inc_return(&led_seq) - 1;
-
-	snprintf(led->name, sizeof(led->name), "xpad%ld", led_no);
+	snprintf(led->name, sizeof(led->name), "xpad%d", xpad->joydev_id);
 	led->xpad = xpad;
 
 	led_cdev = &led->led_cdev;
@@ -944,16 +940,17 @@ static int xpad_init_input(struct usb_xpad *xpad)
 	}
 
 	error = xpad_init_ff(xpad);
-	if (error)
-		goto fail_init_ff;
-
-	error = xpad_led_probe(xpad);
-	if (error)
-		goto fail_init_led;
+	if (error) {
+		input_free_device(input_dev);
+		return error;
+	}
 
 	error = input_register_device(xpad->dev);
-	if (error)
-		goto fail_input_register;
+	if (error) {
+		input_ff_destroy(input_dev);
+		input_free_device(input_dev);
+		return error;
+	}
 
 	joydev_dev = device_find_child(&xpad->dev->dev, NULL,
 				       xpad_find_joydev);
@@ -966,17 +963,14 @@ static int xpad_init_input(struct usb_xpad *xpad)
 		xpad_send_led_command(xpad, (xpad->joydev_id % 4) + 2);
 	}
 
-	return 0;
-
-fail_input_register:
-	xpad_led_disconnect(xpad);
-
-fail_init_led:
-	input_ff_destroy(input_dev);
+	error = xpad_led_probe(xpad);
+	if (error) {
+		input_ff_destroy(input_dev);
+		input_unregister_device(input_dev);
+		return error;
+	}
 
-fail_init_ff:
-	input_free_device(input_dev);
-	return error;
+	return 0;
 }
 
 static int xpad_probe(struct usb_interface *intf, const struct usb_device_id *id)
-- 
1.8.5.3

