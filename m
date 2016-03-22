From: Oliver Neukum <oneukum@suse.com>
Subject: [PATCH 1/4] acecad: stop saving struct usb_device
Date: Tue, 22 Mar 2016 16:04:54 +0100
Message-ID: <1458659097-8213-2-git-send-email-oneukum@suse.com>
References: <1458659097-8213-1-git-send-email-oneukum@suse.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:56298 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751005AbcCVPHu (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 22 Mar 2016 11:07:50 -0400
In-Reply-To: <1458659097-8213-1-git-send-email-oneukum@suse.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-usb@vger.kernel.org, linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
Cc: Oliver Neukum <oneukum@suse.com>, Oliver Neukum <ONeukum@suse.com>

The device can now easily be derived from the interface.
Stop leaving a private copy.

Signed-off-by: Oliver Neukum <ONeukum@suse.com>
---
 drivers/input/tablet/acecad.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/input/tablet/acecad.c b/drivers/input/tablet/acecad.c
index 889f6b7..e86e377 100644
--- a/drivers/input/tablet/acecad.c
+++ b/drivers/input/tablet/acecad.c
@@ -49,7 +49,6 @@ MODULE_LICENSE(DRIVER_LICENSE);
 struct usb_acecad {
 	char name[128];
 	char phys[64];
-	struct usb_device *usbdev;
 	struct usb_interface *intf;
 	struct input_dev *input;
 	struct urb *irq;
@@ -64,6 +63,7 @@ static void usb_acecad_irq(struct urb *urb)
 	unsigned char *data = acecad->data;
 	struct input_dev *dev = acecad->input;
 	struct usb_interface *intf = acecad->intf;
+	struct usb_device *udev = interface_to_usbdev(intf);
 	int prox, status;
 
 	switch (urb->status) {
@@ -110,15 +110,15 @@ resubmit:
 	if (status)
 		dev_err(&intf->dev,
 			"can't resubmit intr, %s-%s/input0, status %d\n",
-			acecad->usbdev->bus->bus_name,
-			acecad->usbdev->devpath, status);
+			udev->bus->bus_name,
+			udev->devpath, status);
 }
 
 static int usb_acecad_open(struct input_dev *dev)
 {
 	struct usb_acecad *acecad = input_get_drvdata(dev);
 
-	acecad->irq->dev = acecad->usbdev;
+	acecad->irq->dev = interface_to_usbdev(acecad->intf);
 	if (usb_submit_urb(acecad->irq, GFP_KERNEL))
 		return -EIO;
 
@@ -172,7 +172,6 @@ static int usb_acecad_probe(struct usb_interface *intf, const struct usb_device_
 		goto fail2;
 	}
 
-	acecad->usbdev = dev;
 	acecad->intf = intf;
 	acecad->input = input_dev;
 
@@ -251,12 +250,13 @@ static int usb_acecad_probe(struct usb_interface *intf, const struct usb_device_
 static void usb_acecad_disconnect(struct usb_interface *intf)
 {
 	struct usb_acecad *acecad = usb_get_intfdata(intf);
+	struct usb_device *udev = interface_to_usbdev(intf);
 
 	usb_set_intfdata(intf, NULL);
 
 	input_unregister_device(acecad->input);
 	usb_free_urb(acecad->irq);
-	usb_free_coherent(acecad->usbdev, 8, acecad->data, acecad->data_dma);
+	usb_free_coherent(udev, 8, acecad->data, acecad->data_dma);
 	kfree(acecad);
 }
 
-- 
2.1.4

