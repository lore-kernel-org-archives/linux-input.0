From: Oliver Neukum <oliver@neukum.org>
Subject: [RFT 1/2] USB: acecad: Implement suspend/resume
Date: Fri, 12 Mar 2010 11:39:39 +0100
Message-ID: <201003121139.39631.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp-out003.kontent.com ([81.88.40.217]:46660 "EHLO
	smtp-out003.kontent.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757270Ab0CLKjp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 12 Mar 2010 05:39:45 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: edouard.tisserant@wanadoo.fr
Cc: svoltz@numericable.fr, linux-input@vger.kernel.org, USB list <linux-usb@vger.kernel.org>

>From 394321d171b76d54b017ac260c947f6494502b23 Mon Sep 17 00:00:00 2001
From: Oliver Neukum <oliver@neukum.org>
Date: Thu, 11 Mar 2010 19:02:39 +0100
Subject: [PATCH 1/2] USB: acecad: Implement suspend/resume

A vanilla implementation

Signed-off-by: Oliver Neukum <neukum@b1-systems.de>
---
 drivers/input/tablet/acecad.c |   24 ++++++++++++++++++++++++
 1 files changed, 24 insertions(+), 0 deletions(-)

diff --git a/drivers/input/tablet/acecad.c b/drivers/input/tablet/acecad.c
index 670c61c..bf5bffb 100644
--- a/drivers/input/tablet/acecad.c
+++ b/drivers/input/tablet/acecad.c
@@ -56,6 +56,7 @@ struct usb_acecad {
 
 	unsigned char *data;
 	dma_addr_t data_dma;
+	bool submitted;
 };
 
 static void usb_acecad_irq(struct urb *urb)
@@ -116,6 +117,7 @@ static int usb_acecad_open(struct input_dev *dev)
 	acecad->irq->dev = acecad->usbdev;
 	if (usb_submit_urb(acecad->irq, GFP_KERNEL))
 		return -EIO;
+	acecad->submitted = true;
 
 	return 0;
 }
@@ -124,6 +126,7 @@ static void usb_acecad_close(struct input_dev *dev)
 {
 	struct usb_acecad *acecad = input_get_drvdata(dev);
 
+	acecad->submitted = false;
 	usb_kill_urb(acecad->irq);
 }
 
@@ -261,6 +264,25 @@ static void usb_acecad_disconnect(struct usb_interface *intf)
 	}
 }
 
+static int usb_acecad_suspend(struct usb_interface *intf, pm_message_t message)
+{
+	struct usb_acecad *acecad = usb_get_intfdata(intf);
+	
+	usb_kill_urb(acecad->irq);
+	return 0;
+}
+
+static int usb_acecad_resume(struct usb_interface *intf)
+{
+	struct usb_acecad *acecad = usb_get_intfdata(intf);
+	int rv = 0;
+
+	if (acecad->submitted)
+		rv = usb_submit_urb(acecad->irq, GFP_NOIO);
+	
+	return rv;
+}
+
 static struct usb_device_id usb_acecad_id_table [] = {
 	{ USB_DEVICE(USB_VENDOR_ID_ACECAD, USB_DEVICE_ID_FLAIR), .driver_info = 0 },
 	{ USB_DEVICE(USB_VENDOR_ID_ACECAD, USB_DEVICE_ID_302),	 .driver_info = 1 },
@@ -273,6 +295,8 @@ static struct usb_driver usb_acecad_driver = {
 	.name =		"usb_acecad",
 	.probe =	usb_acecad_probe,
 	.disconnect =	usb_acecad_disconnect,
+	.suspend =	usb_acecad_suspend,
+	.resume =	usb_acecad_resume,
 	.id_table =	usb_acecad_id_table,
 };
 
-- 
1.6.4.2


