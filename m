From: Pavel Rojtberg <rojtberg@gmail.com>
Subject: [PATCH] Input: xpad - use correct product id for x360w controllers
Date: Tue, 27 Dec 2016 17:01:58 +0100
Message-ID: <1482854518-9298-1-git-send-email-rojtberg@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34806 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756065AbcL0QDG (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 27 Dec 2016 11:03:06 -0500
Received: by mail-wm0-f67.google.com with SMTP id c85so19634881wmi.1
        for <linux-input@vger.kernel.org>; Tue, 27 Dec 2016 08:02:10 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, pgriffais@valvesoftware.com, dmitry.torokhov@gmail.com, gregkh@linuxfoundation.org
Cc: Pavel Rojtberg <rojtberg@gmail.com>

From: Pavel Rojtberg <rojtberg@gmail.com>

currently the controllers get the same product id as the wireless
receiver. However the controllers actually have their own product id.

The patch makes the driver expose the same product id as the windows
driver.

This improves compatibility when running applications with WINE.

see https://github.com/paroj/xpad/issues/54

Signed-off-by: Pavel Rojtberg <rojtberg@gmail.com>
---
 drivers/input/joystick/xpad.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index 098d8ec..34a2409 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -1412,6 +1412,12 @@ static int xpad_init_input(struct usb_xpad *xpad)
 	input_dev->name = xpad->name;
 	input_dev->phys = xpad->phys;
 	usb_to_input_id(xpad->udev, &input_dev->id);
+
+	if(xpad->xtype == XTYPE_XBOX360W) {
+		/* x360w controllers and the receiver have different ids */
+		input_dev->id.product = 0x02a1;
+	}
+
 	input_dev->dev.parent = &xpad->intf->dev;
 
 	input_set_drvdata(input_dev, xpad);
-- 
2.7.4

