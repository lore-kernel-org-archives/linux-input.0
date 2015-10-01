From: Pavel Rojtberg <rojtberg@gmail.com>
Subject: [PATCH 08/15] Input: xpad: query Wireless controller state at init
Date: Thu,  1 Oct 2015 22:57:19 +0200
Message-ID: <1443733046-29610-9-git-send-email-rojtberg@gmail.com>
References: <1443733046-29610-1-git-send-email-rojtberg@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f173.google.com ([209.85.212.173]:34982 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757196AbbJAU5q (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 1 Oct 2015 16:57:46 -0400
Received: by wicge5 with SMTP id ge5so6801877wic.0
        for <linux-input@vger.kernel.org>; Thu, 01 Oct 2015 13:57:45 -0700 (PDT)
In-Reply-To: <1443733046-29610-1-git-send-email-rojtberg@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, pgriffais@valvesoftware.com, dmitry.torokhov@gmail.com, gregkh@linuxfoundation.org
Cc: Pavel Rojtberg <rojtberg@gmail.com>

From: Pavel Rojtberg <rojtberg@gmail.com>

When we initialize the driver/device, we really don't know how many
controllers are connected.  So send a "query presence" command to the
base-station. (Command discovered by Zachary Lund)

presence packet taken from:
https://github.com/computerquip/xpad5

Signed-off-by: Pavel Rojtberg <rojtberg@gmail.com>
---
 drivers/input/joystick/xpad.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index 43490ea..7d66d77 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -1236,6 +1236,30 @@ static int xpad_probe(struct usb_interface *intf, const struct usb_device_id *id
 			usb_kill_urb(xpad->irq_in);
 			goto fail4;
 		}
+
+		/*
+		 * send presence packet
+		 * This will force the controller to resend connection packets.
+		 * This is useful in the case we activate the module after the
+		 * adapter has been plugged in, as it won't automatically
+		 * send us info about the controllers.
+		 */
+		mutex_lock(&xpad->odata_mutex);
+		xpad->odata[0] = 0x08;
+		xpad->odata[1] = 0x00;
+		xpad->odata[2] = 0x0F;
+		xpad->odata[3] = 0xC0;
+		xpad->odata[4] = 0x00;
+		xpad->odata[5] = 0x00;
+		xpad->odata[6] = 0x00;
+		xpad->odata[7] = 0x00;
+		xpad->odata[8] = 0x00;
+		xpad->odata[9] = 0x00;
+		xpad->odata[10] = 0x00;
+		xpad->odata[11] = 0x00;
+		xpad->irq_out->transfer_buffer_length = 12;
+		usb_submit_urb(xpad->irq_out, GFP_KERNEL);
+		mutex_unlock(&xpad->odata_mutex);
 	}
 	xpad->pad_present = 1;
 	error = xpad_init_input(xpad);
-- 
1.9.1

