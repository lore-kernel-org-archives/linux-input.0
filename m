From: Pavel Rojtberg <rojtberg@gmail.com>
Subject: [PATCH 4/8] Input: xpad: query Wireless controller state at init
Date: Sat, 11 Jul 2015 01:47:44 +0200
Message-ID: <1436572068-10661-5-git-send-email-rojtberg@gmail.com>
References: <1436572068-10661-1-git-send-email-rojtberg@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f179.google.com ([209.85.212.179]:35176 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751892AbbGKGuR (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 11 Jul 2015 02:50:17 -0400
Received: by wiga1 with SMTP id a1so30770596wig.0
        for <linux-input@vger.kernel.org>; Fri, 10 Jul 2015 23:50:16 -0700 (PDT)
In-Reply-To: <1436572068-10661-1-git-send-email-rojtberg@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, pgriffais@valvesoftware.com, dmitry.torokhov@gmail.com, gregkh@linuxfoundation.org
Cc: Pavel Rojtberg <rojtberg@gmail.com>

From: Pavel Rojtberg <rojtberg@gmail.com>

We initializing the driver/device, we really don't know how many
controllers are connected.  So send a "query presence" command to the
base-station. (Command discovered by Zachary Lund)

Note, this means we now do not "preallocate" all 4 devices when a single
wireless base station is seen, but require the device to be properly
connected to the base station before that can happen.  The allocation of
the device happens in the next patch, not here, so in a way, this patch
breaks all wireless devices...

based on patch by
"Pierre-Loup A. Griffais" <pgriffais@valvesoftware.com>

presence packet taken from:
https://github.com/computerquip/xpad5

Signed-off-by: Pavel Rojtberg <rojtberg@gmail.com>
---
 drivers/input/joystick/xpad.c | 33 +++++++++++++++++++++++++++++----
 1 file changed, 29 insertions(+), 4 deletions(-)

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index ed17e5d..3349861 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -1223,11 +1223,36 @@ static int xpad_probe(struct usb_interface *intf, const struct usb_device_id *id
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
+	} else {
+		xpad->pad_present = 1;
+		error = xpad_init_input(xpad);
+		if (error)
+			goto fail4;
 	}
-	xpad->pad_present = 1;
-	error = xpad_init_input(xpad);
-	if (error)
-		goto fail4;
 
 	return 0;
 
-- 
1.9.1

