From: Oliver Neukum <oliver@neukum.org>
Subject: [RFC/RFT 4/5] USB: usbtouch: Autosuspend for the USB touchscreen driver
Date: Fri, 12 Mar 2010 15:43:35 +0100
Message-ID: <201003121543.35853.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp-out003.kontent.com ([81.88.40.217]:34022 "EHLO
	smtp-out003.kontent.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756632Ab0CLOnk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 12 Mar 2010 09:43:40 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Daniel Ritz <daniel.ritz@gmx.ch>
Cc: linux-input@vger.kernel.org, USB list <linux-usb@vger.kernel.org>

>From 0cbb098d3b43787f6f559faaa9d8b93a0ae2123e Mon Sep 17 00:00:00 2001
From: Oliver Neukum <oliver@neukum.org>
Date: Thu, 11 Mar 2010 15:25:26 +0100
Subject: [PATCH 4/5] USB: usbtouch: Autosuspend for the USB touchscreen driver

A primitive resume on open/ suspend on close implementation
of USB autosuspend. Enable remote wakeup for devices that
must be constantly polled.

Signed-off-by: Oliver Neukum <neukum@b1-systems.de>
---
 drivers/input/touchscreen/usbtouchscreen.c |   22 +++++++++++++++++++++-
 1 files changed, 21 insertions(+), 1 deletions(-)

diff --git a/drivers/input/touchscreen/usbtouchscreen.c b/drivers/input/touchscreen/usbtouchscreen.c
index f15aa2e..cc0eb7c 100644
--- a/drivers/input/touchscreen/usbtouchscreen.c
+++ b/drivers/input/touchscreen/usbtouchscreen.c
@@ -1269,16 +1269,26 @@ exit:
 static int usbtouch_open(struct input_dev *input)
 {
 	struct usbtouch_usb *usbtouch = input_get_drvdata(input);
+	int r;
 
 	usbtouch->irq->dev = interface_to_usbdev(usbtouch->interface);
+	
+	r = usb_autopm_get_interface(usbtouch->interface);
+	if (r < 0)
+		goto err_out;
 
 	if (!usbtouch->type->irq_always) {
 		if (usb_submit_urb(usbtouch->irq, GFP_KERNEL))
-		  return -EIO;
+		  goto err_out_revert;
 		usbtouch->submitted = true;
 	}
 
 	return 0;
+
+err_out_revert:
+	usb_autopm_put_interface(usbtouch->interface);
+err_out:
+	return -EIO;
 }
 
 static void usbtouch_close(struct input_dev *input)
@@ -1288,6 +1298,7 @@ static void usbtouch_close(struct input_dev *input)
 	usbtouch->submitted = false;
 	if (!usbtouch->type->irq_always)
 		usb_kill_urb(usbtouch->irq);
+	usb_autopm_put_interface(usbtouch->interface);
 }
 
 static int usbtouch_suspend(struct usb_interface *intf, pm_message_t message)
@@ -1475,6 +1486,14 @@ static int usbtouch_probe(struct usb_interface *intf,
 		}
 	}
 
+	/*
+	 * if the interrupt URB must be kept running
+	 * we assume the device asserts remote wakeup
+	 * if it has data to be retrieved through
+	 * the interrupt endpoint
+	 */
+	intf->needs_remote_wakeup = usbtouch->type->irq_always;
+
 	return 0;
 
 out_unregister_input:
@@ -1523,6 +1542,7 @@ static struct usb_driver usbtouch_driver = {
 	.resume		= usbtouch_resume,
 	.reset_resume	= usbtouch_reset_resume,
 	.id_table	= usbtouch_devices,
+	.supports_autosuspend = 1,
 };
 
 static int __init usbtouch_init(void)
-- 
1.6.4.2

