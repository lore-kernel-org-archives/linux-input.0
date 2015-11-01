From: Pavel Rojtberg <rojtberg@gmail.com>
Subject: [PATCH 5/5] Input: xpad: update Xbox One Force Feedback Support
Date: Sun,  1 Nov 2015 16:31:39 +0100
Message-ID: <1446391899-24250-6-git-send-email-rojtberg@gmail.com>
References: <1446391899-24250-1-git-send-email-rojtberg@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f54.google.com ([74.125.82.54]:37569 "EHLO
	mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751123AbbKAPb7 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 1 Nov 2015 10:31:59 -0500
Received: by wmff134 with SMTP id f134so42640133wmf.0
        for <linux-input@vger.kernel.org>; Sun, 01 Nov 2015 07:31:58 -0800 (PST)
In-Reply-To: <1446391899-24250-1-git-send-email-rojtberg@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, pgriffais@valvesoftware.com, dmitry.torokhov@gmail.com, gregkh@linuxfoundation.org
Cc: "Pierre-Loup A. Griffais" <githubpublic@plagman.net>, Pavel Rojtberg <rojtberg@gmail.com>

From: "Pierre-Loup A. Griffais" <githubpublic@plagman.net>

There's apparently a serial number woven into both input and output
packets; neglecting to specify a valid serial number causes the
controller to ignore the rumble packets.

The scale of the rumble was also apparently halved in the packets.

The initialization packet had to be changed to allow force feedback to
work.

see https://github.com/paroj/xpad/issues/7 for details.

Signed-off-by: Pavel Rojtberg <rojtberg@gmail.com>
---
 drivers/input/joystick/xpad.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index e8dcc80..c1107c1 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -351,6 +351,7 @@ struct usb_xpad {
 	int pad_nr;			/* the order x360 pads were attached */
 	const char *name;		/* name of the device */
 	struct work_struct work;	/* init/remove device from callback */
+	unsigned char odata_serial; /* serial number for xbox one protocol */
 };
 
 static int xpad_init_input(struct usb_xpad *xpad);
@@ -917,17 +918,18 @@ static int xpad_play_effect(struct input_dev *dev, void *data, struct ff_effect
 	case XTYPE_XBOXONE:
 		xpad->odata[0] = 0x09; /* activate rumble */
 		xpad->odata[1] = 0x08;
-		xpad->odata[2] = 0x00;
+		xpad->odata[2] = xpad->odata_serial++;
 		xpad->odata[3] = 0x08; /* continuous effect */
 		xpad->odata[4] = 0x00; /* simple rumble mode */
 		xpad->odata[5] = 0x03; /* L and R actuator only */
 		xpad->odata[6] = 0x00; /* TODO: LT actuator */
 		xpad->odata[7] = 0x00; /* TODO: RT actuator */
-		xpad->odata[8] = strong / 256;	/* left actuator */
-		xpad->odata[9] = weak / 256;	/* right actuator */
+		xpad->odata[8] = strong / 512;	/* left actuator */
+		xpad->odata[9] = weak / 512;	/* right actuator */
 		xpad->odata[10] = 0x80;	/* length of pulse */
 		xpad->odata[11] = 0x00;	/* stop period of pulse */
-		xpad->irq_out->transfer_buffer_length = 12;
+		xpad->odata[12] = 0x00;
+		xpad->irq_out->transfer_buffer_length = 13;
 		break;
 
 	default:
@@ -1150,7 +1152,10 @@ static int xpad_open(struct input_dev *dev)
 		/* Xbox one controller needs to be initialized. */
 		xpad->odata[0] = 0x05;
 		xpad->odata[1] = 0x20;
-		xpad->irq_out->transfer_buffer_length = 2;
+		xpad->odata[2] = xpad->odata_serial++; /* packet serial */
+		xpad->odata[3] = 0x01; /* rumble bit enable?  */
+		xpad->odata[4] = 0x00;
+		xpad->irq_out->transfer_buffer_length = 5;
 		retval = usb_submit_urb(xpad->irq_out, GFP_KERNEL);
 		spin_unlock_irqrestore(&xpad->odata_lock, flags);
 		return retval;
-- 
1.9.1

