From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 4/7] Input: xpad: Set the correct LED number
Date: Fri, 31 Jan 2014 14:03:31 +0100
Message-ID: <1391173414-6199-5-git-send-email-gregkh@linuxfoundation.org>
References: <1391173414-6199-1-git-send-email-gregkh@linuxfoundation.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:47829 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932241AbaAaNDA (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 31 Jan 2014 08:03:00 -0500
In-Reply-To: <1391173414-6199-1-git-send-email-gregkh@linuxfoundation.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, "Pierre-Loup A. Griffais" <pgriffais@valvesoftware.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>

From: "Pierre-Loup A. Griffais" <pgriffais@valvesoftware.com>

The LED number should not just be incremented every time, that doesn't
work, set the number based on the number it actually is.

Note, the joydev subsystem doesn't allow us to easily find out the minor
number, so we have to walk all devices in order to find a joystick
device by looking at the name of the device.  Odds are, this isn't the
best way to do it, but I don't know of any other way at the moment.

Signed-off-by: "Pierre-Loup A. Griffais" <pgriffais@valvesoftware.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/input/joystick/xpad.c | 26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index 5b5a84dae54a..7997ae89a877 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -293,6 +293,7 @@ struct usb_xpad {
 
 	int mapping;			/* map d-pad to buttons or to axes */
 	int xtype;			/* type of xbox device */
+	int joydev_id;			/* the minor of the device */
 	const char *name;		/* name of the device */
 };
 
@@ -789,11 +790,6 @@ static int xpad_led_probe(struct usb_xpad *xpad)
 		return error;
 	}
 
-	/*
-	 * Light up the segment corresponding to controller number
-	 */
-	xpad_send_led_command(xpad, (led_no % 4) + 2);
-
 	return 0;
 }
 
@@ -809,6 +805,7 @@ static void xpad_led_disconnect(struct usb_xpad *xpad)
 #else
 static int xpad_led_probe(struct usb_xpad *xpad) { return 0; }
 static void xpad_led_disconnect(struct usb_xpad *xpad) { }
+static void xpad_send_led_command(struct usb_xpad *xpad, int command) { }
 #endif
 
 
@@ -859,9 +856,17 @@ static void xpad_set_up_abs(struct input_dev *input_dev, signed short abs)
 	}
 }
 
+static int xpad_find_joydev(struct device *dev, void *data)
+{
+	if (strstr(dev_name(dev), "js"))
+		return 1;
+	return 0;
+}
+
 static int xpad_init_input(struct usb_xpad *xpad)
 {
 	struct input_dev *input_dev;
+	struct device *joydev_dev;
 	int i, error;
 
 	input_dev = input_allocate_device();
@@ -930,6 +935,17 @@ static int xpad_init_input(struct usb_xpad *xpad)
 	if (error)
 		goto fail_input_register;
 
+	joydev_dev = device_find_child(&xpad->dev->dev, NULL,
+				       xpad_find_joydev);
+	if (joydev_dev) {
+		dev_dbg(&xpad->dev->dev, "Found xpad with minor %i\n",
+			MINOR(joydev_dev->devt));
+		xpad->joydev_id = MINOR(joydev_dev->devt);
+
+		/* Light up the segment corresponding to controller number */
+		xpad_send_led_command(xpad, (xpad->joydev_id % 4) + 2);
+	}
+
 	return 0;
 
 fail_input_register:
-- 
1.8.5.3

