From: Pavel Rojtberg <rojtberg@gmail.com>
Subject: [PATCH v2 2/2] Input: xpad: re-send LED command on present event
Date: Wed, 10 Jun 2015 00:56:19 +0200
Message-ID: <1433890579-2124-3-git-send-email-rojtberg@gmail.com>
References: <1433890579-2124-1-git-send-email-rojtberg@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wg0-f50.google.com ([74.125.82.50]:36060 "EHLO
	mail-wg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753110AbbFIW4c (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 9 Jun 2015 18:56:32 -0400
Received: by wgbgq6 with SMTP id gq6so22964269wgb.3
        for <linux-input@vger.kernel.org>; Tue, 09 Jun 2015 15:56:31 -0700 (PDT)
In-Reply-To: <1433890579-2124-1-git-send-email-rojtberg@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, pgriffais@valvesoftware.com, dmitry.torokhov@gmail.com, gregkh@linuxfoundation.org
Cc: Pavel Rojtberg <rojtberg@gmail.com>

From: Pavel Rojtberg <rojtberg@gmail.com>

the controller only receives commands when its present. So for the
correct LED to be lit the LED command has to be sent on the present
event. move led_no to xpad struct to remember the pad number.

Signed-off-by: Pavel Rojtberg <rojtberg@gmail.com>
---
 drivers/input/joystick/xpad.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index 6f8755e..f8969a9 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -344,6 +344,7 @@ struct usb_xpad {
 
 	int mapping;			/* map d-pad to buttons or to axes */
 	int xtype;			/* type of xbox device */
+	unsigned long led_no;		/* led to lit on xbox360 controllers */
 };
 
 /*
@@ -488,6 +489,8 @@ static void xpad360_process_packet(struct usb_xpad *xpad,
 	input_sync(dev);
 }
 
+static void xpad_send_led_command(struct usb_xpad *xpad, int command);
+
 /*
  * xpad360w_process_packet
  *
@@ -510,6 +513,8 @@ static void xpad360w_process_packet(struct usb_xpad *xpad, u16 cmd, unsigned cha
 		if (data[1] & 0x80) {
 			xpad->pad_present = 1;
 			usb_submit_urb(xpad->bulk_out, GFP_ATOMIC);
+			/* Light up the segment corresponding to controller number */
+			xpad_send_led_command(xpad, (xpad->led_no % 4) + 2);
 		} else
 			xpad->pad_present = 0;
 	}
@@ -946,7 +951,6 @@ static void xpad_led_set(struct led_classdev *led_cdev,
 static int xpad_led_probe(struct usb_xpad *xpad)
 {
 	static atomic_t led_seq	= ATOMIC_INIT(-1);
-	unsigned long led_no;
 	struct xpad_led *led;
 	struct led_classdev *led_cdev;
 	int error;
@@ -958,9 +962,9 @@ static int xpad_led_probe(struct usb_xpad *xpad)
 	if (!led)
 		return -ENOMEM;
 
-	led_no = atomic_inc_return(&led_seq);
+	xpad->led_no = atomic_inc_return(&led_seq);
 
-	snprintf(led->name, sizeof(led->name), "xpad%lu", led_no);
+	snprintf(led->name, sizeof(led->name), "xpad%lu", xpad->led_no);
 	led->xpad = xpad;
 
 	led_cdev = &led->led_cdev;
@@ -974,10 +978,8 @@ static int xpad_led_probe(struct usb_xpad *xpad)
 		return error;
 	}
 
-	/*
-	 * Light up the segment corresponding to controller number
-	 */
-	xpad_send_led_command(xpad, (led_no % 4) + 2);
+	/* Light up the segment corresponding to controller number */
+	xpad_send_led_command(xpad, (xpad->led_no % 4) + 2);
 
 	return 0;
 }
@@ -994,6 +996,7 @@ static void xpad_led_disconnect(struct usb_xpad *xpad)
 #else
 static int xpad_led_probe(struct usb_xpad *xpad) { return 0; }
 static void xpad_led_disconnect(struct usb_xpad *xpad) { }
+static void xpad_send_led_command(struct usb_xpad *xpad, int command) { }
 #endif
 
 
-- 
1.9.1

