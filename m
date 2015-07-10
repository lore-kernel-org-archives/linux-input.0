From: Pavel Rojtberg <rojtberg@gmail.com>
Subject: [PATCH 1/8] Input: xpad: clarify LED enumeration
Date: Sat, 11 Jul 2015 01:47:41 +0200
Message-ID: <1436572068-10661-2-git-send-email-rojtberg@gmail.com>
References: <1436572068-10661-1-git-send-email-rojtberg@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wg0-f48.google.com ([74.125.82.48]:33878 "EHLO
	mail-wg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752117AbbGKHGb (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 11 Jul 2015 03:06:31 -0400
Received: by wgov12 with SMTP id v12so79227667wgo.1
        for <linux-input@vger.kernel.org>; Sat, 11 Jul 2015 00:06:30 -0700 (PDT)
In-Reply-To: <1436572068-10661-1-git-send-email-rojtberg@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, pgriffais@valvesoftware.com, dmitry.torokhov@gmail.com, gregkh@linuxfoundation.org
Cc: Pavel Rojtberg <rojtberg@gmail.com>

From: Pavel Rojtberg <rojtberg@gmail.com>

this one is pure cosmetic, however it helps understanding the code.
1. rename led_no -> pad_nr as the number stored there just gets
translated to a LED nr in xpad_identify_controller
2. move all comments regarding xpad_identify_controller to the function
definition to prevent inconsistent docs.

Signed-off-by: Pavel Rojtberg <rojtberg@gmail.com>
---
 drivers/input/joystick/xpad.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index f8850f9..8892daf 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -344,7 +344,7 @@ struct usb_xpad {
 
 	int mapping;			/* map d-pad to buttons or to axes */
 	int xtype;			/* type of xbox device */
-	unsigned long led_no;		/* led to lit on xbox360 controllers */
+	unsigned long pad_nr;		/* the order x360 pads were attached */
 };
 
 /*
@@ -356,7 +356,6 @@ struct usb_xpad {
  *	The used report descriptor was taken from ITO Takayukis website:
  *	 http://euc.jp/periphs/xbox-controller.ja.html
  */
-
 static void xpad_process_packet(struct usb_xpad *xpad, u16 cmd, unsigned char *data)
 {
 	struct input_dev *dev = xpad->dev;
@@ -505,7 +504,6 @@ static void xpad_identify_controller(struct usb_xpad *xpad);
  * 01.1 - Pad state (Bytes 4+) valid
  *
  */
-
 static void xpad360w_process_packet(struct usb_xpad *xpad, u16 cmd, unsigned char *data)
 {
 	/* Presence change */
@@ -513,10 +511,6 @@ static void xpad360w_process_packet(struct usb_xpad *xpad, u16 cmd, unsigned cha
 		if (data[1] & 0x80) {
 			xpad->pad_present = 1;
 			usb_submit_urb(xpad->bulk_out, GFP_ATOMIC);
-			/*
-			 * Light up the segment corresponding to
-			 * controller number.
-			 */
 			xpad_identify_controller(xpad);
 		} else
 			xpad->pad_present = 0;
@@ -890,6 +884,7 @@ struct xpad_led {
 };
 
 /**
+ * set the LEDs on Xbox360 / Wireless Controllers
  * @param command
  *  0: off
  *  1: all blink, then previous setting
@@ -942,10 +937,12 @@ static void xpad_send_led_command(struct usb_xpad *xpad, int command)
 	mutex_unlock(&xpad->odata_mutex);
 }
 
+/*
+ * Light up the segment corresponding to the pad number on Xbox 360 Controllers
+ */
 static void xpad_identify_controller(struct usb_xpad *xpad)
 {
-	/* Light up the segment corresponding to controller number */
-	xpad_send_led_command(xpad, (xpad->led_no % 4) + 2);
+	xpad_send_led_command(xpad, (xpad->pad_nr % 4) + 2);
 }
 
 static void xpad_led_set(struct led_classdev *led_cdev,
@@ -971,9 +968,9 @@ static int xpad_led_probe(struct usb_xpad *xpad)
 	if (!led)
 		return -ENOMEM;
 
-	xpad->led_no = atomic_inc_return(&led_seq);
+	xpad->pad_nr = atomic_inc_return(&led_seq);
 
-	snprintf(led->name, sizeof(led->name), "xpad%lu", xpad->led_no);
+	snprintf(led->name, sizeof(led->name), "xpad%lu", xpad->pad_nr);
 	led->xpad = xpad;
 
 	led_cdev = &led->led_cdev;
@@ -987,7 +984,6 @@ static int xpad_led_probe(struct usb_xpad *xpad)
 		return error;
 	}
 
-	/* Light up the segment corresponding to controller number */
 	xpad_identify_controller(xpad);
 
 	return 0;
-- 
1.9.1

