From: Oliver Neukum <oliver@neukum.org>
Subject: [RFC/RFT 1/5] USB: usbtouch: implement suspend/resume
Date: Fri, 12 Mar 2010 15:41:31 +0100
Message-ID: <201003121541.31876.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp-out002.kontent.com ([81.88.40.216]:48147 "EHLO
	smtp-out002.kontent.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756373Ab0CLOlh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 12 Mar 2010 09:41:37 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Daniel Ritz <daniel.ritz@gmx.ch>
Cc: linux-input@vger.kernel.org, USB list <linux-usb@vger.kernel.org>

>From fd33bdb2357c439c8e4b1435bfd8c7dc77ac4da8 Mon Sep 17 00:00:00 2001
From: Oliver Neukum <oliver@neukum.org>
Date: Thu, 11 Mar 2010 14:45:18 +0100
Subject: [PATCH 1/5] USB: usbtouch: implement suspend/resume

A standard implementation of suspend/resume.
Cease IO on suspend(). Restart on resume() if necessary.

Signed-off-by: Oliver Neukum <neukum@b1-systems.de>
---
 drivers/input/touchscreen/usbtouchscreen.c |   24 ++++++++++++++++++++++++
 1 files changed, 24 insertions(+), 0 deletions(-)

diff --git a/drivers/input/touchscreen/usbtouchscreen.c b/drivers/input/touchscreen/usbtouchscreen.c
index 99330bb..6db0a03 100644
--- a/drivers/input/touchscreen/usbtouchscreen.c
+++ b/drivers/input/touchscreen/usbtouchscreen.c
@@ -115,6 +115,7 @@ struct usbtouch_usb {
 
 	int x, y;
 	int touch, press;
+	bool submitted;
 };
 
 
@@ -1274,6 +1275,7 @@ static int usbtouch_open(struct input_dev *input)
 	if (!usbtouch->type->irq_always) {
 		if (usb_submit_urb(usbtouch->irq, GFP_KERNEL))
 		  return -EIO;
+		usbtouch->submitted = true;
 	}
 
 	return 0;
@@ -1283,10 +1285,30 @@ static void usbtouch_close(struct input_dev *input)
 {
 	struct usbtouch_usb *usbtouch = input_get_drvdata(input);
 
+	usbtouch->submitted = false;
 	if (!usbtouch->type->irq_always)
 		usb_kill_urb(usbtouch->irq);
 }
 
+static int usbtouch_suspend(struct usb_interface *intf, pm_message_t message)
+{
+	struct usbtouch_usb *usbtouch = usb_get_intfdata(intf);
+
+	usb_kill_urb(usbtouch->irq);
+	
+	return 0;
+}
+
+static int usbtouch_resume(struct usb_interface *intf)
+{
+	struct usbtouch_usb *usbtouch = usb_get_intfdata(intf);
+	int rv = 0;
+	
+	if (usbtouch->submitted || usbtouch->type->irq_always)
+		rv = usb_submit_urb(usbtouch->irq, GFP_NOIO);
+	
+	return rv;
+}
 
 static void usbtouch_free_buffers(struct usb_device *udev,
 				  struct usbtouch_usb *usbtouch)
@@ -1477,6 +1499,8 @@ static struct usb_driver usbtouch_driver = {
 	.name		= "usbtouchscreen",
 	.probe		= usbtouch_probe,
 	.disconnect	= usbtouch_disconnect,
+	.suspend	= usbtouch_suspend,
+	.resume		= usbtouch_resume,
 	.id_table	= usbtouch_devices,
 };
 
-- 
1.6.4.2

