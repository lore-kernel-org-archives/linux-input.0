From: Pavel Rojtberg <rojtberg@gmail.com>
Subject: [PATCH 5/6] Input: xpad: x360w: report dpad as buttons and axes
Date: Sat,  5 Sep 2015 22:58:06 +0200
Message-ID: <1441486687-4836-6-git-send-email-rojtberg@gmail.com>
References: <1441486687-4836-1-git-send-email-rojtberg@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f173.google.com ([209.85.212.173]:38525 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753031AbbIEU61 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sat, 5 Sep 2015 16:58:27 -0400
Received: by wiclk2 with SMTP id lk2so48033497wic.1
        for <linux-input@vger.kernel.org>; Sat, 05 Sep 2015 13:58:26 -0700 (PDT)
In-Reply-To: <1441486687-4836-1-git-send-email-rojtberg@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, pgriffais@valvesoftware.com, dmitry.torokhov@gmail.com, gregkh@linuxfoundation.org
Cc: Pavel Rojtberg <rojtberg@gmail.com>

From: Pavel Rojtberg <rojtberg@gmail.com>

as discussed here[0], x360w is the only pad that maps dpad_to_button.
This is bad for downstream developers as they have to differ between
x360 and x360w which is not intuitive.

This patch implements the suggested solution of exposing the dpad both
as axes and as buttons. This retains backward compability with software
already dealing with the difference while makes new software work as
expected across x360/ x360w pads.

[0] http://www.spinics.net/lists/linux-input/msg34421.html

Signed-off-by: Pavel Rojtberg <rojtberg@gmail.com>
---
 drivers/input/joystick/xpad.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index 3fe8500..ae441a2 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -436,7 +436,14 @@ static void xpad360_process_packet(struct usb_xpad *xpad,
 		input_report_key(dev, BTN_TRIGGER_HAPPY2, data[2] & 0x08);
 		input_report_key(dev, BTN_TRIGGER_HAPPY3, data[2] & 0x01);
 		input_report_key(dev, BTN_TRIGGER_HAPPY4, data[2] & 0x02);
-	} else {
+	}
+	/* this should be a simple else block. However historically xbox360w
+	 * has mapped DPAD to buttons while xbox360 did not.
+	 * This made no sense, but now we can not just switch back and have to
+	 * support both behaviors.
+	 */
+	if (!(xpad->mapping & MAP_DPAD_TO_BUTTONS) ||
+			xpad->xtype == XTYPE_XBOX360W) {
 		input_report_abs(dev, ABS_HAT0X,
 				 !!(data[2] & 0x08) - !!(data[2] & 0x04));
 		input_report_abs(dev, ABS_HAT0Y,
@@ -1144,7 +1151,14 @@ static int xpad_probe(struct usb_interface *intf, const struct usb_device_id *id
 	if (xpad->mapping & MAP_DPAD_TO_BUTTONS) {
 		for (i = 0; xpad_btn_pad[i] >= 0; i++)
 			__set_bit(xpad_btn_pad[i], input_dev->keybit);
-	} else {
+	}
+	/* this should be a simple else block. However historically xbox360w
+	 * has mapped DPAD to buttons while xbox360 did not.
+	 * This made no sense, but now we can not just switch back and have to
+	 * support both behaviors.
+	 */
+	if(!(xpad->mapping & MAP_DPAD_TO_BUTTONS) ||
+			xpad->xtype == XTYPE_XBOX360W) {
 		for (i = 0; xpad_abs_pad[i] >= 0; i++)
 			xpad_set_up_abs(input_dev, xpad_abs_pad[i]);
 	}
-- 
1.9.1

