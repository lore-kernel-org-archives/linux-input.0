From: Benjamin Franzke <benjaminfranzke@googlemail.com>
Subject: [PATCH 2/2] joystick/xpad: Advertise the triggers as throttle/break
Date: Wed, 11 Dec 2013 09:15:31 +0100
Message-ID: <1386749731-6500-2-git-send-email-benjaminfranzke@googlemail.com>
References: <1386749731-6500-1-git-send-email-benjaminfranzke@googlemail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ee0-f48.google.com ([74.125.83.48]:45190 "EHLO
	mail-ee0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750743Ab3LKIQz (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 11 Dec 2013 03:16:55 -0500
Received: by mail-ee0-f48.google.com with SMTP id e49so2663899eek.21
        for <linux-input@vger.kernel.org>; Wed, 11 Dec 2013 00:16:52 -0800 (PST)
In-Reply-To: <1386749731-6500-1-git-send-email-benjaminfranzke@googlemail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Benjamin Franzke <benjaminfranzke@googlemail.com>

They are considered positive only axes, so userspace and joydev can
handle them correctly.
It also fits semantically better, since these triggers are really intended
for throttle/break.

Signed-off-by: Benjamin Franzke <benjaminfranzke@googlemail.com>
---
 drivers/input/joystick/xpad.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index 75e3b10..4e9de34 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -226,7 +226,7 @@ static const signed short xpad_abs_pad[] = {
 
 /* used when triggers are mapped to axes */
 static const signed short xpad_abs_triggers[] = {
-	ABS_Z, ABS_RZ,		/* triggers left/right */
+	ABS_BRAKE, ABS_THROTTLE, /* triggers left/right */
 	-1
 };
 
@@ -327,8 +327,8 @@ static void xpad_process_packet(struct usb_xpad *xpad, u16 cmd, unsigned char *d
 		input_report_key(dev, BTN_TL2, data[10]);
 		input_report_key(dev, BTN_TR2, data[11]);
 	} else {
-		input_report_abs(dev, ABS_Z, data[10]);
-		input_report_abs(dev, ABS_RZ, data[11]);
+		input_report_abs(dev, ABS_BRAKE, data[10]);
+		input_report_abs(dev, ABS_THROTTLE, data[11]);
 	}
 
 	/* digital pad */
@@ -429,8 +429,8 @@ static void xpad360_process_packet(struct usb_xpad *xpad,
 		input_report_key(dev, BTN_TL2, data[4]);
 		input_report_key(dev, BTN_TR2, data[5]);
 	} else {
-		input_report_abs(dev, ABS_Z, data[4]);
-		input_report_abs(dev, ABS_RZ, data[5]);
+		input_report_abs(dev, ABS_BRAKE, data[4]);
+		input_report_abs(dev, ABS_THROTTLE, data[5]);
 	}
 
 	input_sync(dev);
@@ -824,8 +824,8 @@ static void xpad_set_up_abs(struct input_dev *input_dev, signed short abs)
 	case ABS_RY:	/* the two sticks */
 		input_set_abs_params(input_dev, abs, -32768, 32767, 16, 128);
 		break;
-	case ABS_Z:
-	case ABS_RZ:	/* the triggers (if mapped to axes) */
+	case ABS_BRAKE:
+	case ABS_THROTTLE: /* the triggers (if mapped to axes) */
 		input_set_abs_params(input_dev, abs, 0, 255, 0, 0);
 		break;
 	case ABS_HAT0X:
-- 
1.8.1.5

