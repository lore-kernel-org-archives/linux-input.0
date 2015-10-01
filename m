From: Pavel Rojtberg <rojtberg@gmail.com>
Subject: [PATCH 15/15] Input: xpad: update Xbox One Force Feedback Support
Date: Thu,  1 Oct 2015 22:57:26 +0200
Message-ID: <1443733046-29610-16-git-send-email-rojtberg@gmail.com>
References: <1443733046-29610-1-git-send-email-rojtberg@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f176.google.com ([209.85.212.176]:38479 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932966AbbJAU5x (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 1 Oct 2015 16:57:53 -0400
Received: by wiclk2 with SMTP id lk2so6355697wic.1
        for <linux-input@vger.kernel.org>; Thu, 01 Oct 2015 13:57:52 -0700 (PDT)
In-Reply-To: <1443733046-29610-1-git-send-email-rojtberg@gmail.com>
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
index 9490d96..8d2d4b5 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -352,6 +352,7 @@ struct usb_xpad {
 	int pad_nr;			/* the order x360 pads were attached */
 	const char *name;		/* name of the device */
 	struct work_struct work;	/* init/remove device from callback */
+	unsigned char odata_serial; /* serial number for xbox one protocol */
 };
 
 static DEFINE_SPINLOCK(xpad_pad_seq_lock);
@@ -884,17 +885,18 @@ static int xpad_play_effect(struct input_dev *dev, void *data, struct ff_effect
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
@@ -1119,7 +1121,10 @@ static int xpad_open(struct input_dev *dev)
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

