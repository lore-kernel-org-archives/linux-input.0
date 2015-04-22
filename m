From: Yang Zhao <yang@yangman.ca>
Subject: [PATCH] Input: xpad - correctly set LED for wireless controller
Date: Tue, 21 Apr 2015 23:03:33 -0700
Message-ID: <1429682613-15715-1-git-send-email-yang@yangman.ca>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41]:35573 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756531AbbDVGDj (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 22 Apr 2015 02:03:39 -0400
Received: by pabtp1 with SMTP id tp1so263406801pab.2
        for <linux-input@vger.kernel.org>; Tue, 21 Apr 2015 23:03:39 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org

The payload sent to wireless controllers to set its LED state via
interrupt is correct but using the wrong control parameters, causing the
packet to apparently be ignored.  Sending this correctly fixes the
"always blinking LED" problem on Xbox 360 wireless controllers.

Signed-off-by: Yang Zhao <yang@yangman.ca>
---
 drivers/input/joystick/xpad.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index 61c7611..7a0ae65 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -1208,8 +1208,8 @@ static int xpad_probe(struct usb_interface *intf, const struct usb_device_id *id
 			usb_fill_int_urb(xpad->bulk_out, udev,
 					 usb_sndintpipe(udev,
 							ep_irq_in->bEndpointAddress),
-					 xpad->bdata, XPAD_PKT_LEN,
-					 xpad_bulk_out, xpad, 0);
+					 xpad->bdata, 12,
+					 xpad_irq_out, xpad, ep_irq_in->bInterval);
 		}
 
 		/*
-- 
2.0.5

