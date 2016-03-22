From: Oliver Neukum <oneukum@suse.com>
Subject: [PATCH 4/4] kbtab: stop saving struct usb_device
Date: Tue, 22 Mar 2016 16:04:57 +0100
Message-ID: <1458659097-8213-5-git-send-email-oneukum@suse.com>
References: <1458659097-8213-1-git-send-email-oneukum@suse.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:56299 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751377AbcCVPHv (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 22 Mar 2016 11:07:51 -0400
In-Reply-To: <1458659097-8213-1-git-send-email-oneukum@suse.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-usb@vger.kernel.org, linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
Cc: Oliver Neukum <oneukum@suse.com>, Oliver Neukum <ONeukum@suse.com>

The device can now easily be derived from the interface.
Stop leaving a private copy.

Signed-off-by: Oliver Neukum <ONeukum@suse.com>
---
 drivers/input/tablet/kbtab.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/input/tablet/kbtab.c b/drivers/input/tablet/kbtab.c
index d2ac7c2..e850d7e 100644
--- a/drivers/input/tablet/kbtab.c
+++ b/drivers/input/tablet/kbtab.c
@@ -31,7 +31,6 @@ struct kbtab {
 	unsigned char *data;
 	dma_addr_t data_dma;
 	struct input_dev *dev;
-	struct usb_device *usbdev;
 	struct usb_interface *intf;
 	struct urb *irq;
 	char phys[32];
@@ -99,8 +98,9 @@ MODULE_DEVICE_TABLE(usb, kbtab_ids);
 static int kbtab_open(struct input_dev *dev)
 {
 	struct kbtab *kbtab = input_get_drvdata(dev);
+	struct usb_device *udev = interface_to_usbdev(kbtab->intf);
 
-	kbtab->irq->dev = kbtab->usbdev;
+	kbtab->irq->dev = udev;
 	if (usb_submit_urb(kbtab->irq, GFP_KERNEL))
 		return -EIO;
 
@@ -135,7 +135,6 @@ static int kbtab_probe(struct usb_interface *intf, const struct usb_device_id *i
 	if (!kbtab->irq)
 		goto fail2;
 
-	kbtab->usbdev = dev;
 	kbtab->intf = intf;
 	kbtab->dev = input_dev;
 
@@ -188,12 +187,13 @@ static int kbtab_probe(struct usb_interface *intf, const struct usb_device_id *i
 static void kbtab_disconnect(struct usb_interface *intf)
 {
 	struct kbtab *kbtab = usb_get_intfdata(intf);
+	struct usb_device *udev = interface_to_usbdev(intf);
 
 	usb_set_intfdata(intf, NULL);
 
 	input_unregister_device(kbtab->dev);
 	usb_free_urb(kbtab->irq);
-	usb_free_coherent(kbtab->usbdev, 8, kbtab->data, kbtab->data_dma);
+	usb_free_coherent(udev, 8, kbtab->data, kbtab->data_dma);
 	kfree(kbtab);
 }
 
-- 
2.1.4

